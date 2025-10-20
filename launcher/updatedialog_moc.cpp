/*
 * updatedialog_moc.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "updatedialog_moc.h"
#include "ui_updatedialog_moc.h"

#include "../lib/CConfigHandler.h"
#include "../lib/GameConstants.h"
#include "../lib/VCMIDirs.h"

#include <QNetworkReply>
#include <QNetworkRequest>

#include <QSysInfo>
#include <QTemporaryFile>
#include <QProcess>
#include <QDesktopServices>
#include <QDir>
#include <QProgressBar>

 // Helper to normalize channel text to Stable/Beta/Develop
static QString normalizeChannel(const QString& text)
{
	const auto t = text.trimmed().toLower();
	if (t.contains("beta"))    return "Beta";
	if (t.contains("develop")) return "Develop";
	return "Stable";
}

UpdateDialog::UpdateDialog(bool calledManually, QWidget *parent):
	QDialog(parent),
	ui(new Ui::UpdateDialog),
	calledManually(calledManually)
{
	ui->setupUi(this);

	setWindowFlags(Qt::Dialog | Qt::WindowTitleHint | Qt::WindowCloseButtonHint);

    // make QLabel emit linkActivated instead of opening the browser itself
    ui->downloadLink->setOpenExternalLinks(false);
    ui->downloadLink->setTextFormat(Qt::RichText);
    ui->downloadLink->setTextInteractionFlags(Qt::TextBrowserInteraction);

	ui->progressBar->setHidden(true);

	if(calledManually)
	{
		setWindowModality(Qt::ApplicationModal);
		show();
	}
	
	connect(ui->closeButton, SIGNAL(clicked()), this, SLOT(close()));
	
	if(settings["launcher"]["updateOnStartup"].Bool())
		ui->checkOnStartup->setCheckState(Qt::CheckState::Checked);


	if (settings["launcher"]["testingBuilds"].Bool())
		ui->testingBuilds->setCheckState(Qt::CheckState::Checked);

	currentVersion = GameConstants::VCMI_VERSION;
	currentCommit = GameConstants::VCMI_COMMIT;
	
	//setWindowTitle(QString::fromStdString(currentVersion));

	setWindowTitle(tr("VCMI Updates configuration"));


	// Testing build info
	if (ui->testingBuilds->isChecked()) {
		fetchChannel(normalizeChannel(ui->testingBuilds->text()));
		ui->tabWidget->setCurrentIndex(1);
	}

	fetchChannel("Stable");

}

UpdateDialog::~UpdateDialog()
{
	delete ui;
}

void UpdateDialog::showUpdateDialog(bool isManually)
{
	auto * dialog = new UpdateDialog(isManually);
	
	dialog->setAttribute(Qt::WA_DeleteOnClose);
}

void UpdateDialog::on_checkOnStartup_stateChanged(int state)
{
	Settings node = settings.write["launcher"]["updateOnStartup"];
	node->Bool() = ui->checkOnStartup->isChecked();
}

void UpdateDialog::on_testingBuilds_stateChanged(int state)
{
	bool testing = ui->testingBuilds->isChecked();

	Settings node = settings.write["launcher"]["testingBuilds"];
	node->Bool() = testing;

	QLabel* versionLabel = testing ? ui->releaseVersion : ui->testingVersion;
	QTextBrowser* changelogBox = testing ? ui->releaseChangelog : ui->testingChangelog;

	// Additionally load the selected testing channel if enabled
	if(testing)
	{
		const QString channel = ui->buildChannel ? (ui->buildChannel->currentText()) : QString("Develop");
		fetchChannel(channel);

		ui->buildChannel->setEnabled(true);
		ui->titleTesting->setEnabled(true);
		ui->testingChangelogTitle->setEnabled(true);
		//changelogBox->setEnabled(true);
	}
	else
	{
		ui->buildChannel->setDisabled(true);
		ui->titleTesting->setDisabled(true);
		ui->testingChangelogTitle->setDisabled(true);
		versionLabel->setText("");
		changelogBox->setMarkdown("");
		//changelogBox->setDisabled(true);
	}
}

// Build filename for the selected update channel.
static QString filenameForChannel(const QString& channel)
{
	const QString ch = channel.trimmed().toLower();
	if (ch == "stable")  return "vcmi-stable.json";
	if (ch == "beta")    return "vcmi-beta.json";
	return "vcmi-develop.json"; // default
}



void UpdateDialog::on_buildChannel_currentIndexChanged(int)
{
	// Only react when testing builds are enabled
	QCheckBox* testingBox = ui->testingBuilds ? ui->testingBuilds
		: this->findChild<QCheckBox*>("testingBuilds");
	if (!testingBox || !testingBox->isChecked())
		return;

	const QString ch = filenameForChannel(ui->buildChannel->currentText());
	fetchChannel(ch);
}

// Map runtime OS/arch to JSON "download" key, e.g. "windows-x64"
static QString platformKeyFromRuntime()
{
#if defined(Q_OS_WIN)
    const auto arch = QSysInfo::currentCpuArchitecture(); // "x86_64","i386","arm64",…
    if (arch == "x86_64") return "windows-x64";
    if (arch == "i386" || arch == "i686") return "windows-x86";
    if (arch == "arm64" || arch == "aarch64") return "windows-arm64";
    return "windows-x64";
#elif defined(Q_OS_MACOS)
    const auto arch = QSysInfo::currentCpuArchitecture();
    return (arch == "arm64" || arch == "aarch64") ? "macos-arm" : "macos-intel";
#elif defined(Q_OS_ANDROID)
    const auto arch = QSysInfo::currentCpuArchitecture(); // "arm64-v8a","armeabi-v7a",…
    return arch.contains("64") ? "android-arm64-v8a" : "android-armeabi-v7a";
#elif defined(Q_OS_IOS)
    return "ios-ios";
#else
    // placeholder for future linux keys
    const auto arch = QSysInfo::currentCpuArchitecture();
    if (arch == "x86_64") return "linux-x64";
    if (arch == "arm64" || arch == "aarch64") return "linux-arm64";
    return "linux-x64";
#endif
}

// Compare semantic versions M.m.p (suffixes ignored)
static int cmpSemver(const std::string &a, const std::string &b)
{
    int A=0,B=0,C=0, X=0,Y=0,Z=0;
    std::sscanf(a.c_str(), "%d.%d.%d", &A,&B,&C);
    std::sscanf(b.c_str(), "%d.%d.%d", &X,&Y,&Z);
    if (A!=X) return (A<X)?-1:+1;
    if (B!=Y) return (B<Y)?-1:+1;
    if (C!=Z) return (C<Z)?-1:+1;
    return 0;
}

// Join base URL (may or may not end with /) with filename.
static QUrl joinBaseAndFile(const QString& base, const QString& file)
{
	QString b = base.trimmed();
	if (!b.endsWith('/')) b.append('/');
	return QUrl(b + file);
}

// Pick best download URL from "download" object
static QString pickDownloadUrl(const JsonNode &node)
{
    const auto prefer = platformKeyFromRuntime().toStdString();
    if (node["download"][prefer].getType() == JsonNode::JsonType::DATA_STRING)
        return QString::fromStdString(node["download"][prefer].String());

#if defined(Q_OS_WIN)
    const char* candidates[] = {"windows-x64","windows-arm64","windows-x86"};
#elif defined(Q_OS_MACOS)
    const char* candidates[] = {"macos-arm","macos-intel"};
#elif defined(Q_OS_ANDROID)
    const char* candidates[] = {"android-arm64-v8a","android-armeabi-v7a"};
#elif defined(Q_OS_IOS)
    const char* candidates[] = {"ios-ios"};
#else
    const char* candidates[] = {"linux-x64","linux-arm64"};
#endif
    for (auto c : candidates)
        if (node["download"][c].getType() == JsonNode::JsonType::DATA_STRING)
            return QString::fromStdString(node["download"][c].String());

    // last resort: first string in "download"
    for (const auto &kv : node["download"].Struct())
        if (kv.second.getType() == JsonNode::JsonType::DATA_STRING)
            return QString::fromStdString(kv.second.String());
    return {};
}

// Return first 7 characters of a commit-ish; gracefully handles empty/short strings.
static std::string commitShort(const std::string &s)
{
    if (s.size() <= 7) return s;
    return s.substr(0, 7);
}

void UpdateDialog::fetchChannel(const QString& channel)
{
	const QString norm = normalizeChannel(channel);
	const bool isTesting = (norm != "Stable"); // Beta/Develop -> testing area

	const QString base = QString::fromStdString(settings["launcher"]["updateConfigUrl"].String());
	const QUrl url = joinBaseAndFile(base, filenameForChannel(norm));

	// Route the "loading" message to the correct changelog box
	//(isTesting ? ui->testingChangelog : ui->releaseChangelog)->setPlainText(tr("Loading %1 …").arg(url.toString()));

	QNetworkReply* response = networkManager.get(QNetworkRequest(url));

	connect(response, &QNetworkReply::finished, [this, response, isTesting] {
		response->deleteLater();

		if (response->error() != QNetworkReply::NoError)
		{
			(isTesting ? ui->testingChangelog : ui->releaseChangelog)->setMarkdown(tr("Network error: %1").arg(response->errorString()));
			return;
		}

		const auto bytes = response->readAll();
		JsonNode node(reinterpret_cast<const std::byte*>(bytes.constData()), bytes.size(), "<network packet from update url>");
		loadFromJson(node, isTesting);
		});
}


// Optionally enable/disable Install for this payload
static void setInstallEnabled(Ui::UpdateDialog* ui, bool enabled)
{
#if defined(Q_OS_WIN)
	if (ui->installButton) {
		ui->installButton->setVisible(true);
		ui->installButton->setEnabled(enabled);
		ui->installButton->setToolTip(enabled ? QString() : QObject::tr("You already have this build."));
	}
#else
	Q_UNUSED(ui);
	Q_UNUSED(enabled);
#endif
}

void UpdateDialog::loadFromJson(const JsonNode& node, bool testing)
{
	// Validate schema
	if (node.getType() != JsonNode::JsonType::DATA_STRUCT ||
		node["version"].getType() != JsonNode::JsonType::DATA_STRING ||
		node["download"].getType() != JsonNode::JsonType::DATA_STRUCT)
	{
		//(testing ? ui->testingChangelog : ui->releaseChangelog)->setPlainText(tr("Invalid update JSON (missing 'version' or 'download')."));
		return;
	}

	// Choose target widgets based on 'testing'
	QLabel* versionLabel = testing ? ui->testingVersion : ui->releaseVersion;
	QTextBrowser* changelogBox = testing ? ui->testingChangelog : ui->releaseChangelog;
	QString &downloadURL = testing ? testingUrl : releaseUrl;
	QString &version = testing ? testingVersion : releaseVersion;

	const std::string newVersion = node["version"].String();
	const std::string newCommit = node["commit"].getType() == JsonNode::JsonType::DATA_STRING ? node["commit"].String() : "";
	const std::string buildDate = node["buildDate"].getType() == JsonNode::JsonType::DATA_STRING ? node["buildDate"].String() : "";
	const std::string changeLog = node["changeLog"].getType() == JsonNode::JsonType::DATA_STRING ? node["changeLog"].String() : "";

	// Decide if update is offered, but never early-return or close the dialog
	bool offer = false;
	const int vcmp = cmpSemver(currentVersion, newVersion);
	const std::string curSha = "1a2b3c4d5e6f"; // replace with GameConstants::VCMI_COMMIT if available
	//const std::string curSha = commitShort(currentCommit);
	const std::string jsonSha = commitShort(newCommit);

	if (vcmp < 0)
		offer = true;
	else if (vcmp == 0 && !jsonSha.empty() && !curSha.empty() && jsonSha != curSha) offer = true;

	// Populate UI
	if (versionLabel)
		versionLabel->setText(QString::fromStdString(newVersion));

	// Build the header first (Build + Commit), then an empty line, then the changelog body.
	QStringList headerLines;
	if (!buildDate.empty())
		headerLines << tr("Build date: %1").arg(QString::fromStdString(buildDate));
	if (!newCommit.empty())
		headerLines << tr("Commit: %1").arg(QString::fromStdString(commitShort(newCommit)));

	const QString body = QString::fromStdString(changeLog);

	QString logText;
	if (!headerLines.isEmpty())
		logText = headerLines.join("\n\n");

	logText += "<br/><br/>"; // blank line between header and body
	logText += body;

	if (changelogBox)
		changelogBox->setMarkdown(logText);

	// Download link (shared label is OK)
	const QString link = pickDownloadUrl(node);

	downloadURL = link;
	version = QString::fromStdString(newVersion);


	if (!link.isEmpty()) {
		ui->downloadLink->setText(QString("<a href=\"%1\">%2</a>").arg(link, tr("Download")));
#if defined(Q_OS_WIN)
		// Keep only one active connection
		ui->downloadLink->disconnect();
		
#endif
	}
	else {
		changelogBox->setMarkdown(tr("No download available for this platform."));
	}

	// Only enable Install if this payload is newer
	setInstallEnabled(ui, offer);
	}

void UpdateDialog::on_installButton_clicked()
{
	const bool testingOn = ui->testingBuilds && ui->testingBuilds->isChecked();
	const QString url = testingOn && !testingUrl.isEmpty() ? testingUrl : releaseUrl;

	if (url.isEmpty())
	{
		ui->downloadLink->setText(tr("No package to download/install."));
		return;
}
	startDownloadToCacheAndRun(QUrl(url));
}

void UpdateDialog::startDownloadToCacheAndRun(const QUrl& url)
{
	QNetworkReply* rep = networkManager.get(QNetworkRequest(url));

	QProgressBar* progress = this->findChild<QProgressBar*>("progressBar");
	if (progress) {
		progress->setVisible(true);
		progress->setRange(0, 0);
		connect(rep, &QNetworkReply::downloadProgress, this, [progress](qint64 rec, qint64 tot) {
			if (!progress) return;
			if (tot > 0) { progress->setRange(0, int(tot)); progress->setValue(int(rec)); }
			});
	}

	connect(rep, &QNetworkReply::finished, this, [this, rep, progress] {
		rep->deleteLater();
		if (rep->error() != QNetworkReply::NoError) {
			if (progress) progress->setVisible(false);
			ui->downloadLink->setText(tr("Download failed: %1").arg(rep->errorString()));
			return;
		}

		const QString cacheDir = pathToQString(VCMIDirs::get().userCachePath());
		QDir().mkpath(cacheDir);

		QString fileName = QFileInfo(QUrl(rep->url()).path()).fileName();

		const QString fullPath = QDir(cacheDir).filePath(fileName);

		QFile out(fullPath);
		out.write(rep->readAll());
		out.close();

#if !defined(Q_OS_WIN)
		QFile::setPermissions(fullPath, QFile::permissions(fullPath)
			| QFileDevice::ExeOwner | QFileDevice::ExeUser
			| QFileDevice::ExeGroup | QFileDevice::ExeOther);
#endif

		if (progress)
			progress->setVisible(false);

#if defined(Q_OS_WIN)
		const QStringList exeArgs = { "/SILENT", "/NORESTART", "/LAUNCH" };
		if (!QProcess::startDetached(fullPath, exeArgs)) {
			return;
		}
#else
		// macOS default handler, fallback to startDetached
		if (!QDesktopServices::openUrl(QUrl::fromLocalFile(fullPath))) {
			if (!QProcess::startDetached(fullPath, {})) {
				//ui->downloadLink->setText(tr("Package saved to %1 — open it manually.").arg(fullPath));
				return;
			}
		}
		//ui->downloadLink->setText(tr("Package saved to %1").arg(fullPath));
#endif
		});
}
