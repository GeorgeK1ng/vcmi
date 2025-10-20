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
#include "../Version.h"

#include <QNetworkReply>
#include <QNetworkRequest>

#include <QSysInfo>
#include <QTemporaryFile>
#include <QProcess>
#include <QDesktopServices>
#include <QDir>
#include <QProgressBar>

UpdateDialog::UpdateDialog(bool calledManually, QWidget *parent):
	QDialog(parent),
	ui(new Ui::UpdateDialog),
	calledManually(calledManually)
{
	ui->setupUi(this);

    // make QLabel emit linkActivated instead of opening the browser itself
    ui->downloadLink->setOpenExternalLinks(false);
    ui->downloadLink->setTextFormat(Qt::RichText);
    ui->downloadLink->setTextInteractionFlags(Qt::TextBrowserInteraction);
	
	if(calledManually)
	{
		setWindowModality(Qt::ApplicationModal);
		show();
	}
	
	connect(ui->closeButton, SIGNAL(clicked()), this, SLOT(close()));
	
	if(settings["launcher"]["updateOnStartup"].Bool())
		ui->checkOnStartup->setCheckState(Qt::CheckState::Checked);
	
	currentVersion = GameConstants::VCMI_VERSION;
	
	setWindowTitle(QString::fromStdString(currentVersion));
	
	QString url = QString::fromStdString(settings["launcher"]["updateConfigUrl"].String());
		
	QNetworkReply *response = networkManager.get(QNetworkRequest(QUrl(url)));
	
	connect(response, &QNetworkReply::finished, [&, response]{
		response->deleteLater();
		
		if(response->error() != QNetworkReply::NoError)
		{
			ui->versionLabel->setStyleSheet("QLabel { background-color : red; color : black; }");
			ui->versionLabel->setText(tr("Network error"));
			ui->plainTextEdit->setPlainText(response->errorString());
			return;
		}
		
		auto byteArray = response->readAll();
		JsonNode node(reinterpret_cast<const std::byte*>(byteArray.constData()), byteArray.size(), "<network packet from server at updateConfigUrl>");
		loadFromJson(node);
	});
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

// Background color for version bump; same version + different commit -> lightblue
static QString bgForChange(const std::string &cur, const std::string &nw)
{
    int M1=0,m1=0,p1=0, M2=0,m2=0,p2=0;
    std::sscanf(cur.c_str(), "%d.%d.%d", &M1,&m1,&p1);
    std::sscanf(nw.c_str(),  "%d.%d.%d", &M2,&m2,&p2);
    if (M2>M1) return "red";
    if (M2==M1 && m2>m1) return "orange";
    if (M2==M1 && m2==m1 && p2>p1) return "gray";
    return "lightblue";
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

void UpdateDialog::loadFromJson(const JsonNode & node)
{
    // Expect ONLY the new schema
    if (node.getType() != JsonNode::JsonType::DATA_STRUCT ||
        node["version"].getType()  != JsonNode::JsonType::DATA_STRING ||
        node["commit"].getType()   != JsonNode::JsonType::DATA_STRING ||
        node["download"].getType() != JsonNode::JsonType::DATA_STRUCT)
    {
        ui->plainTextEdit->setPlainText(tr("Invalid update JSON (expecting new schema)."));
        return;
    }

    const std::string newVersion = node["version"].String();
    const std::string newCommit  = node["commit"].String();
    const std::string buildDate  = node["buildDate"].getType()==JsonNode::JsonType::DATA_STRING ? node["buildDate"].String() : "";
    const std::string changeLog  = node["changeLog"].getType()==JsonNode::JsonType::DATA_STRING ? node["changeLog"].String() : "";

	// Offer update if semver is higher OR (same semver AND 7-char commit differs)
	bool offer = false;
	
	const int vcmp = cmpSemver(currentVersion, newVersion);
	
	const std::string curSha   = std::string(GameConstants::GIT_SHA1);
	const std::string curShaShort  = commitShort(curSha);
	const std::string jsonSha = commitShort(newCommit);
	
	// semver higher -> update; same semver + different 7-char commit -> update
	if (vcmp < 0)
	    offer = true;
	else if (vcmp == 0 && !jsonSha.empty() && !curShaShort.empty() && jsonSha != curShaShort)
	    offer = true;
	
	// If no update, silently close (when auto) and exit
	if (!offer) {
	    if (!calledManually)
	        close();
	    return;
	}
	
	if (!calledManually) {
	    setWindowModality(Qt::ApplicationModal);
	    show();
	}

    const QString bgColor = bgForChange(currentVersion, newVersion);
    ui->versionLabel->setStyleSheet(QString("QLabel { background-color : %1; color : black; }").arg(bgColor));
    ui->versionLabel->setText(QString::fromStdString(newVersion));

	QString logText = QString::fromStdString(changeLog);
	if (!buildDate.empty() || !newCommit.empty())
	    logText = tr("%1\n\nBuild: %2\nCommit: %3")
	                .arg(logText,
	                     QString::fromStdString(buildDate),
	                     QString::fromStdString(commitShort(newCommit)));
    ui->plainTextEdit->setPlainText(logText);

    const QString link = pickDownloadUrl(node);
    if (link.isEmpty()) {
        ui->downloadLink->setText(tr("No download available for this platform."));
        return;
    }
    ui->downloadLink->setText(QString("<a href=\"%1\">%2</a>").arg(link, tr("Download")));

#if defined(Q_OS_WIN)
    // If Install button exists, wire it to auto-download+run; also handle link click
    if (ui->installButton) {
        ui->installButton->setVisible(true);
        ui->installButton->disconnect();
        connect(ui->installButton, &QPushButton::clicked, this, [this, link]{
            this->downloadAndRunInstaller(QUrl(link));
        });
    }
    // Optional: clicking the link also installs directly
    connect(ui->downloadLink, &QLabel::linkActivated, this, [this](const QString &u){
        this->downloadAndRunInstaller(QUrl(u));
    });
#else
    // Non-Windows: open in default browser
    connect(ui->downloadLink, &QLabel::linkActivated, this, [](const QString &u){
        QDesktopServices::openUrl(QUrl(u));
    });
#endif
}


void UpdateDialog::downloadAndRunInstaller(const QUrl &url)
{
#if !defined(Q_OS_WIN)
    // Non-Windows: just open URL
    QDesktopServices::openUrl(url);
    return;
#else
    // Download installer
    QNetworkReply *rep = networkManager.get(QNetworkRequest(url));

	QProgressBar *progress = this->findChild<QProgressBar*>("progressBar");
	
	if (progress) {
	    progress->setVisible(true);
	    progress->setRange(0, 0);
	    connect(rep, &QNetworkReply::downloadProgress, this, [progress](qint64 rec, qint64 tot){
	        if (!progress) return;
	        if (tot > 0) { progress->setRange(0, (int)tot); progress->setValue((int)rec); }
	    });
	}

	connect(rep, &QNetworkReply::finished, this, [this, rep, progress]{
	    rep->deleteLater();
	    if (rep->error() != QNetworkReply::NoError) {
	        ui->plainTextEdit->appendPlainText(tr("\nDownload failed: %1").arg(rep->errorString()));
	        if (progress) progress->setVisible(false);
	        return;
	    }
	
	    // Save to temp .exe
	    QTemporaryFile tmp(QDir::tempPath() + "/VCMI_Update_XXXXXX.exe");
	    tmp.setAutoRemove(false);
	    if (!tmp.open()) {
	        ui->plainTextEdit->appendPlainText(tr("\nCannot create temporary file."));
	        if (progress) progress->setVisible(false);   
	        return;
	    }
	    tmp.write(rep->readAll());
	    tmp.close();
	
	    if (progress) progress->setVisible(false);
	
	    QStringList args; // např.: args << "/VERYSILENT" << "/NORESTART";
	    if (!QProcess::startDetached(tmp.fileName(), args)) {
	        ui->plainTextEdit->appendPlainText(tr("\nCannot start installer."));
	        return;
	    }
        // Optionally close the dialog:
        // close();
    });
#endif
}
