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
#include "helper.h"
#include "mainwindow_moc.h"

#include <QNetworkReply>
#include <QNetworkRequest>

#include <QSysInfo>
#include <QTemporaryFile>
#include <QProcess>
#include <QDesktopServices>
#include <QDir>
#include <QProgressBar>
#include <QVersionNumber>
#include <QFileInfo>
#include <QSaveFile>
#include <QStandardPaths>

#ifdef VCMI_ANDROID
#include <QAndroidJniObject>
#include <QtAndroid>
#endif

// Helper to normalize channel key to stable/beta/develop
static QString normalizeChannel(const QString& text)
{
	const auto str = text.trimmed().toLower();
	if(str.contains("beta"))
		return "beta";

	if(str.contains("develop"))
		return "develop";

	return "stable";
}

UpdateDialog::UpdateDialog(bool calledManually, QWidget *parent):
	QDialog(parent),
	ui(new Ui::UpdateDialog),
	calledManually(calledManually)
{
	ui->setupUi(this);
	ui->buildChannel->setItemData(0, "develop");
	ui->buildChannel->setItemData(1, "beta");

#ifdef VCMI_MOBILE
    setStyleSheet("QDialog { border: 2px solid rgba(0,0,0,160); border-radius: 6px; }");
#endif

	setWindowFlags(Qt::Dialog | Qt::WindowTitleHint | Qt::WindowCloseButtonHint);

	ui->progressBar->setHidden(true);

	if(calledManually)
	{
		#if defined(VCMI_ANDROID) || defined(VCMI_IOS)
		    setWindowModality(Qt::NonModal);
		#else
		    setWindowModality(Qt::ApplicationModal);
		#endif
		show();
	}

	if(settings["launcher"]["updateOnStartup"].Bool())
		ui->checkOnStartup->setCheckState(Qt::CheckState::Checked);

	if(settings["launcher"]["testingBuilds"].Bool())
		ui->testingBuilds->setCheckState(Qt::CheckState::Checked);

	currentVersion = GameConstants::VCMI_VERSION;
	currentCommit = GameConstants::VCMI_COMMIT;

	setWindowTitle(tr("VCMI Updates Center"));
	ui->title->setText(tr("VCMI Updates Center"));

	// Testing build info
	if(ui->testingBuilds->isChecked())
	{
		fetchChannel(ui->buildChannel->currentData().toString());
		ui->tabWidget->setCurrentIndex(1);
	}

	fetchChannel("stable");
}

UpdateDialog::~UpdateDialog()
{
	delete ui;
}

void UpdateDialog::showUpdateDialog(bool isManually)
{
	auto * dialog = new UpdateDialog(isManually, Helper::getMainWindow());
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
		const QString channel = ui->buildChannel ? ui->buildChannel->currentData().toString() : QString("develop");
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
	const QString name = channel.trimmed().toLower();

	if(name == "stable")
		return "vcmi-stable.json";

	if(name == "beta")
		return "vcmi-beta.json";

	return "vcmi-develop.json"; // default
}

void UpdateDialog::on_buildChannel_currentIndexChanged(int)
{
	// Only react when testing builds are enabled
	if(!ui->testingBuilds->isChecked())
		return;

	fetchChannel(ui->buildChannel->currentData().toString());
}

// Map runtime OS/arch to JSON "download" key, e.g. "windows-x64"
static QString platformKeyFromRuntime()
{
#if defined(VCMI_WINDOWS)
	const auto arch = QSysInfo::currentCpuArchitecture(); // "x86_64","i386","arm64"
	if(arch == "x86_64")
		return "windows-x64";
	if(arch == "i386" || arch == "i686")
		return "windows-x86";
	if(arch == "arm64" || arch == "aarch64")
		return "windows-arm64";
	logGlobal->warn("Unknown Windows architecture '%s', falling back to windows-x64", arch.toStdString());
	return "windows-x64";

#elif defined(VCMI_MAC)
	const auto arch = QSysInfo::currentCpuArchitecture();
	if(arch == "arm64" || arch == "aarch64")
		return "macos-arm";
	if(arch == "x86_64")
		return "macos-intel";
	logGlobal->warn("Unknown macOS architecture '%s', falling back to macos-intel", arch.toStdString());
	return "macos-intel";

#elif defined(VCMI_ANDROID)
	const auto arch = QSysInfo::currentCpuArchitecture(); // "x86_64", "arm64-v8a","armeabi-v7a"
	if(arch == "x86_64")
		return "android-x64";
	if(arch == "arm64-v8a" || arch == "arm64" || arch == "aarch64")
		return "android-arm64-v8a";
	if(arch == "armeabi-v7a" || arch == "armv7" || arch == "arm")
		return "android-armeabi-v7a";
	logGlobal->warn("Unknown Android architecture '%s', falling back to android-arm64-v8a", arch.toStdString());
	return "android-arm64-v8a";

#elif defined(VCMI_IOS)
	return "ios-ios";

#elif defined(VCMI_UNIX)
	const auto arch = QSysInfo::currentCpuArchitecture();
	if(arch == "x86_64")
		return "linux-x64";

	if(arch == "arm64" || arch == "aarch64")
		return "linux-arm64";

	logGlobal->warn("Unknown Linux architecture '%s', falling back to linux-x64", arch.toStdString());
	return "linux-x64";

#else
	return {};
#endif
}

static QVersionNumber toVersion(QString version)
{
	return QVersionNumber::fromString(version);
}

inline int cmpSemver(QString a, QString b)
{
	// normalize - remove end zero
	const auto va = toVersion(a).normalized(); // example: 1.2.0 -> 1.2
	const auto vb = toVersion(b).normalized();
	return QVersionNumber::compare(va, vb);
}


// Join base URL (may or may not end with /) with filename.
static QUrl joinBaseAndFile(const QString& base, const QString& file)
{
	QString b = base.trimmed();
	if (!b.endsWith('/'))
		b.append('/');
	return QUrl(b + file);
}

// Pick best download URL from "download" object
static QString pickDownloadUrl(const JsonNode &node)
{
    const auto platform = platformKeyFromRuntime().toStdString();
    if(node["download"][platform].getType() == JsonNode::JsonType::DATA_STRING)
        return QString::fromStdString(node["download"][platform].String());

    // last resort: first string in "download"
    for(const auto &kv : node["download"].Struct())
        if(kv.second.getType() == JsonNode::JsonType::DATA_STRING)
            return QString::fromStdString(kv.second.String());
    return {};
}

// Return first 7 characters of a commit-ish; gracefully handles empty/short strings.
static std::string commitShort(const std::string &str)
{
    if(str.size() <= 7)
		return str;

    return str.substr(0, 7);
}

void UpdateDialog::fetchChannel(const QString& channel)
{
	const QString normalizedChannel = normalizeChannel(channel);
	const bool isTesting = (normalizedChannel != "stable"); // beta/develop -> testing area

	const QString base = QString::fromStdString(settings["launcher"]["updateConfigUrl"].String());
	const QUrl url = joinBaseAndFile(base, filenameForChannel(normalizedChannel));

	// Route the "loading" message to the correct changelog box
	//(isTesting ? ui->testingChangelog : ui->releaseChangelog)->setPlainText(tr("Loading %1 …").arg(url.toString()));

	QNetworkReply* response = networkManager.get(QNetworkRequest(url));

	connect(response, &QNetworkReply::finished, [this, response, isTesting] {
		response->deleteLater();

		if(response->error() != QNetworkReply::NoError)
		{
			(isTesting ? ui->testingChangelog : ui->releaseChangelog)->setMarkdown(tr("Network error: %1").arg(response->errorString()));
			return;
		}

		const auto bytes = response->readAll();
		JsonNode node(reinterpret_cast<const std::byte*>(bytes.constData()), bytes.size(), "<network packet from update url>");
		loadFromJson(node, isTesting);
		}
	);
}

void UpdateDialog::loadFromJson(const JsonNode& node, bool testing)
{
	// Validate schema
	if(node.getType() != JsonNode::JsonType::DATA_STRUCT ||
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
	const std::string curSha = commitShort(currentCommit);
	const std::string jsonSha = commitShort(newCommit);

	bool offer = false;
	const int vcmp = cmpSemver(QString::fromStdString(currentVersion), QString::fromStdString(newVersion));

	if(vcmp < 0)
	{
		offer = true; // New version available
	}
	else if (vcmp == 0)
	{
		// Same version number, decide by different commit
		if(!curSha.empty() && !jsonSha.empty() && curSha != jsonSha)
			offer = true;
	}

	// Populate UI
	if(versionLabel)
		versionLabel->setText(QString::fromStdString(newVersion));

	// Build the header first (Build + Commit), then an empty line, then the changelog body.
	QStringList headerLines;
	if(!buildDate.empty())
		headerLines << tr("Build date: %1").arg(QString::fromStdString(buildDate));
	if(!newCommit.empty())
		headerLines << tr("Commit: %1").arg(QString::fromStdString(commitShort(newCommit)));

	const QString body = QString::fromStdString(changeLog);

	QString logText;
	if(!headerLines.isEmpty())
		logText = headerLines.join("\n\n");

	logText += "<br/><br/>"; // blank line between header and body
	logText += body;

	if(changelogBox)
		changelogBox->setMarkdown(logText);

	// Download link
	const QString link = pickDownloadUrl(node);

	downloadURL = link;
	version = QString::fromStdString(newVersion);

	if(link.isEmpty())
		changelogBox->setMarkdown(tr("No download available for this platform."));

	if(offer && !calledManually)
	{
		this->show();
		this->raise();
		this->activateWindow();
		if(testing)
			ui->tabWidget->setCurrentIndex(1);
	}
}

void UpdateDialog::on_installButton_clicked()
{
	const QString url = ui->testingBuilds->isChecked() && !testingUrl.isEmpty() ? testingUrl : releaseUrl;

	if(url.isEmpty())
	{
	    ui->downloadLink->setText(tr("No package to download."));
	    return;
	}

	#if defined(VCMI_ANDROID)
	if(Helper::isInstalledFromGooglePlay())
	{
		const QUrl playStoreUrl(QStringLiteral("market://details?id=is.xyz.vcmi"));
		if(!QDesktopServices::openUrl(playStoreUrl))
		{
			QDesktopServices::openUrl(QUrl(QStringLiteral("https://play.google.com/store/apps/details?id=is.xyz.vcmi")));
		}
		return;
	}
	#endif

	#if defined(VCMI_MOBILE)
	    // Always ask user where to save on mobile
	    Helper::nativeFolderPicker(this, [this, url](QString picked){
	        if(picked.isEmpty())
	            return; // user cancelled
	        startDownloadToCacheAndRun(QUrl(url), picked);
	    });
	    return;
	#else
	    // Desktop: keep current behaviour (or adjust as you wish)
	    startDownloadToCacheAndRun(QUrl(url));
	#endif
}

void UpdateDialog::on_closeButton_clicked()
{
	close();
}

void UpdateDialog::startDownloadToCacheAndRun(const QUrl& url, const QString& target)
{
    QNetworkReply* rep = networkManager.get(QNetworkRequest(url));

    QProgressBar* progress = this->findChild<QProgressBar*>("progressBar");
    if(progress)
	{
        progress->setVisible(true);
        progress->setRange(0, 0);
        connect(rep, &QNetworkReply::downloadProgress, this, [progress](qint64 received, qint64 total) {
            if(!progress)
                return;

			if(total > 0)
			{
                progress->setRange(0, int(total));
                progress->setValue(int(received));
            }
        });
    }

    connect(rep, &QNetworkReply::finished, this, [this, reply = rep, progress, target] {
        reply->deleteLater();
        if(reply->error() != QNetworkReply::NoError)
		{
            if(progress)
				progress->setVisible(false);

            ui->downloadLink->setText(tr("Download failed: %1").arg(reply->errorString()));
            return;
        }

        const QString cacheDir = pathToQString(VCMIDirs::get().userCachePath());
        const QString fileName = QFileInfo(QUrl(reply->url()).path()).fileName();
        const QString fullPath = QDir(cacheDir).filePath(fileName);

        QSaveFile out(fullPath);
        if(!out.open(QIODevice::WriteOnly))
		{
            if(progress)
				progress->setVisible(false);

            ui->downloadLink->setText(tr("Can't create file: %1").arg(out.errorString()));
            return;
        }

        const QByteArray data = reply->readAll();
        if (out.write(data) != data.size())
		{
            if(progress)
				progress->setVisible(false);

            ui->downloadLink->setText(tr("Write failed: %1").arg(out.errorString()));
            return;
        }

        if(!out.commit())
		{
            if(progress)
				progress->setVisible(false);

            ui->downloadLink->setText(tr("Commit failed: %1").arg(out.errorString()));
            return;
        }

        // Not strictly needed on mobile, harmless elsewhere
        QFile::setPermissions(fullPath, QFile::permissions(fullPath) | QFileDevice::ExeOwner | QFileDevice::ExeUser | QFileDevice::ExeGroup | QFileDevice::ExeOther);

        QFileInfo file(fullPath);
        if(!file.exists() || file.size() == 0)
		{
            if(progress)
				progress->setVisible(false);

            ui->downloadLink->setText(tr("File not saved (path: %1)").arg(fullPath));
            return;
        }

#if defined(VCMI_WINDOWS)
        // Windows: Silent update
        const QStringList exeArgs = { "/SILENT", "/NORESTART", "/LAUNCH" };
        if(QProcess::startDetached(fullPath, exeArgs))
		{
            if(progress)
				progress->setVisible(false);

            QApplication::quit();
        }
        else
		{
            if(progress)
				progress->setVisible(false);

            ui->downloadLink->setText(tr("Failed to start installer."));
        }

#elif defined(VCMI_MAC)
        // macOS: open using default handler (.dmg/.pkg)
        if(progress)
			progress->setVisible(false);

        if(!QDesktopServices::openUrl(QUrl::fromLocalFile(fullPath)))
            ui->downloadLink->setText(tr("Package saved to %1 — open it manually.").arg(fullPath));

#elif defined(VCMI_ANDROID)
        // Android: copy into the picked SAF folder (content:// tree)
        if(target.startsWith("content://", Qt::CaseInsensitive))
		{
            QAndroidJniObject jTree = QAndroidJniObject::fromString(target);
            QAndroidJniObject jName = QAndroidJniObject::fromString(fileName);
            QAndroidJniObject jMime = QAndroidJniObject::fromString("application/octet-stream");
            QAndroidJniObject jDst  = QAndroidJniObject::callStaticObjectMethod(
                "eu/vcmi/vcmi/util/FileUtil",
                "createFileInTree",
                "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;",
                jTree.object<jstring>(),
                jName.object<jstring>(),
                jMime.object<jstring>(),
                QtAndroid::androidContext().object()
            );

            const QString dstUri = jDst.isValid() ? jDst.toString() : QString();
            if(!dstUri.isEmpty())
			{
                Helper::performNativeCopy(fullPath, dstUri); // src=file path, dst=content://
                ui->downloadLink->setText(tr("Saved to selected folder."));
            }
			else
			{
                ui->downloadLink->setText(tr("Saved to cache (failed to create destination file)."));
            }
        }
		else
		{
            // If user returned a filesystem path (rare on Android), copy directly
            const QString dstPath = QDir(target).filePath(fileName);
            Helper::performNativeCopy(fullPath, dstPath);
            ui->downloadLink->setText(tr("Saved to: %1").arg(target));
        }
        if(progress)
			progress->setVisible(false);

#elif defined(VCMI_IOS)
        // iOS: copy into the picked filesystem folder
        {
            const QString dstPath = QDir(target).filePath(fileName);
            Helper::performNativeCopy(fullPath, dstPath);
            Helper::revealDirectoryInFileBrowser(target);
            ui->downloadLink->setText(tr("Saved to: %1").arg(target));
        }
        if(progress)
			progress->setVisible(false);

#else
        // Fallback: just open or inform
        if(progress)
			progress->setVisible(false);

        if(!QDesktopServices::openUrl(QUrl::fromLocalFile(fullPath)))
            ui->downloadLink->setText(tr("Package saved to %1 — open it manually.").arg(fullPath));
#endif
    });
}
