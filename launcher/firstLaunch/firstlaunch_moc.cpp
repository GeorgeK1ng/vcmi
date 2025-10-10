/*
 * firstlaunch_moc.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "firstlaunch_moc.h"
#include "ui_firstlaunch_moc.h"

#include "mainwindow_moc.h"
#include "modManager/cmodlistview_moc.h"

#include "../../lib/CConfigHandler.h"
#include "../../lib/texts/CGeneralTextHandler.h"
#include "../../lib/texts/Languages.h"
#include "../../lib/VCMIDirs.h"
#include "../../lib/filesystem/Filesystem.h"
#include "../../vcmiqt/MessageBox.h"
#include "../helper.h"
#include "../languages.h"
#include "../innoextract.h"

#include <QProgressDialog>
#include <QCoreApplication>

FirstLaunchView::FirstLaunchView(QWidget * parent)
	: QWidget(parent)
	, ui(std::make_unique<Ui::FirstLaunchView>())
{
	ui->setupUi(this);

	enterSetup();
	activateTabLanguage();

	ui->lineEditDataSystem->setText(pathToQString(boost::filesystem::absolute(VCMIDirs::get().dataPaths().front())));
	ui->lineEditDataUser->setText(pathToQString(boost::filesystem::absolute(VCMIDirs::get().userDataPath())));

	Helper::enableScrollBySwiping(ui->listWidgetLanguage);

#ifdef VCMI_MOBILE
	// This directory is not accessible to players without rooting of their device
	ui->lineEditDataSystem->hide();
#endif

#ifndef ENABLE_INNOEXTRACT
	ui->pushButtonGogInstall->hide();
	ui->labelDataGogTitle->hide();
	ui->labelDataGogDescr->hide();
#endif
}

FirstLaunchView::~FirstLaunchView() = default;

void FirstLaunchView::on_buttonTabLanguage_clicked()
{
	activateTabLanguage();
}

void FirstLaunchView::on_buttonTabHeroesData_clicked()
{
	activateTabHeroesData();
}

void FirstLaunchView::on_buttonTabModPreset_clicked()
{
	activateTabModPreset();
}

void FirstLaunchView::on_listWidgetLanguage_currentRowChanged(int currentRow)
{
	languageSelected(ui->listWidgetLanguage->item(currentRow)->data(Qt::UserRole).toString());
}

void FirstLaunchView::changeEvent(QEvent * event)
{
	if(event->type() == QEvent::LanguageChange)
	{
		ui->retranslateUi(this);
		Languages::fillLanguages(ui->listWidgetLanguage, false);
	}
	QWidget::changeEvent(event);
}

void FirstLaunchView::on_pushButtonLanguageNext_clicked()
{
	activateTabHeroesData();
}

void FirstLaunchView::on_pushButtonDataNext_clicked()
{
	activateTabModPreset();
}

void FirstLaunchView::on_pushButtonDataBack_clicked()
{
	activateTabLanguage();
}

void FirstLaunchView::on_pushButtonDataSearch_clicked()
{
	heroesDataUpdate();
}

void FirstLaunchView::on_pushButtonDataCopy_clicked()
{
    // iOS can't display modal dialogs when called directly on button press
    // https://bugreports.qt.io/browse/QTBUG-98651
    MessageBoxCustom::showDialog(this, [this]{
        Helper::nativeFolderPicker(this, [this](const QString &picked){
            if (!picked.isEmpty())
                copyHeroesData(Helper::getRealPath(picked));
        });
    });
}

void FirstLaunchView::on_pushButtonGogInstall_clicked()
{
	// iOS can't display modal dialogs when called directly on button press
	// https://bugreports.qt.io/browse/QTBUG-98651
	MessageBoxCustom::showDialog(this, [this]{extractGogData();});
}

void FirstLaunchView::enterSetup()
{
	Languages::fillLanguages(ui->listWidgetLanguage, false);
}

void FirstLaunchView::setSetupProgress(int progress)
{
	ui->buttonTabLanguage->setDisabled(progress < 1);
	ui->buttonTabHeroesData->setDisabled(progress < 2);
	ui->buttonTabModPreset->setDisabled(progress < 3);
}

void FirstLaunchView::activateTabLanguage()
{
	setSetupProgress(1);
	ui->installerTabs->setCurrentIndex(0);
	ui->buttonTabLanguage->setChecked(true);
	ui->buttonTabHeroesData->setChecked(false);
	ui->buttonTabModPreset->setChecked(false);
}

void FirstLaunchView::activateTabHeroesData()
{
	setSetupProgress(2);
	ui->installerTabs->setCurrentIndex(1);
	ui->buttonTabLanguage->setChecked(false);
	ui->buttonTabHeroesData->setChecked(true);
	ui->buttonTabModPreset->setChecked(false);

	if(heroesDataUpdate())
	{
		activateTabModPreset();
		return;
	}

	QString installPath = getHeroesInstallDir();
	if(!installPath.isEmpty())
	{
		auto reply = QMessageBox::question(this, tr("Heroes III installation found!"), tr("Copy data to VCMI folder?"), QMessageBox::Yes | QMessageBox::No);
		if(reply == QMessageBox::Yes)
			copyHeroesData(installPath);
	}
}

void FirstLaunchView::activateTabModPreset()
{
	setSetupProgress(3);
	ui->installerTabs->setCurrentIndex(2);
	ui->buttonTabLanguage->setChecked(false);
	ui->buttonTabHeroesData->setChecked(false);
	ui->buttonTabModPreset->setChecked(true);

	modPresetUpdate();
}

void FirstLaunchView::exitSetup(bool goToMods)
{
	if(auto * mainWindow = dynamic_cast<MainWindow *>(QApplication::activeWindow()))
		mainWindow->exitSetup(goToMods);
}

// Tab Language
void FirstLaunchView::languageSelected(const QString & selectedLanguage)
{
	Settings node = settings.write["general"]["language"];
	node->String() = selectedLanguage.toStdString();

	if(auto * mainWindow = dynamic_cast<MainWindow *>(QApplication::activeWindow()))
		mainWindow->updateTranslation();
}

bool FirstLaunchView::heroesDataUpdate()
{
	bool detected = heroesDataDetect();
	if(detected)
		heroesDataDetected();
	else
		heroesDataMissing();
	return detected;
}

void FirstLaunchView::heroesDataMissing()
{
	QPalette newPalette = palette();
	newPalette.setColor(QPalette::Base, QColor(200, 50, 50));
	ui->lineEditDataSystem->setPalette(newPalette);
	ui->lineEditDataUser->setPalette(newPalette);

	ui->labelDataManualTitle->setVisible(true);
	ui->labelDataManualDescr->setVisible(true);
	ui->pushButtonDataSearch->setVisible(true);

#ifdef VCMI_IOS
	// selecting directory through UIDocumentPickerViewController is available only since iOS 13
	//const bool canUseDataCopy = isOsVersionAtLeast(13);
	const bool canUseDataCopy = true;
#else
	const bool canUseDataCopy = true;
#endif

	

	ui->labelDataCopyTitle->setVisible(canUseDataCopy);
	ui->labelDataCopyDescr->setVisible(canUseDataCopy);
	ui->pushButtonDataCopy->setVisible(canUseDataCopy);

#ifdef ENABLE_INNOEXTRACT
	ui->pushButtonGogInstall->setVisible(true);
	ui->labelDataGogTitle->setVisible(true);
	ui->labelDataGogDescr->setVisible(true);
#endif

	ui->labelDataFound->setVisible(false);
	ui->pushButtonDataNext->setEnabled(false);
}

void FirstLaunchView::heroesDataDetected()
{
	QPalette newPalette = palette();
	newPalette.setColor(QPalette::Base, QColor(50, 200, 50));
	ui->lineEditDataSystem->setPalette(newPalette);
	ui->lineEditDataUser->setPalette(newPalette);

	ui->pushButtonDataSearch->setVisible(false);
	ui->pushButtonDataCopy->setVisible(false);

	ui->labelDataManualTitle->setVisible(false);
	ui->labelDataManualDescr->setVisible(false);
	ui->labelDataCopyTitle->setVisible(false);
	ui->labelDataCopyDescr->setVisible(false);

#ifdef ENABLE_INNOEXTRACT
	ui->pushButtonGogInstall->setVisible(false);
	ui->labelDataGogTitle->setVisible(false);
	ui->labelDataGogDescr->setVisible(false);
#endif

	ui->labelDataFound->setVisible(true);
	ui->pushButtonDataNext->setEnabled(true);

	CGeneralTextHandler::detectInstallParameters();
}

// Tab Heroes III Data
bool FirstLaunchView::heroesDataDetect()
{
	// user might have copied files to one of our data path.
	// perform full reinitialization of virtual filesystem
	CResourceHandler::destroy();
	CResourceHandler::initialize();
	CResourceHandler::load("config/filesystem.json");

	// use file from lod archive to check presence of H3 data. Very rough estimate, but will work in majority of cases
	bool heroesDataFoundROE = CResourceHandler::get()->existsResource(ResourcePath("DATA/GENRLTXT.TXT"));
	bool heroesDataFoundSOD = CResourceHandler::get()->existsResource(ResourcePath("DATA/TENTCOLR.TXT"));

	return heroesDataFoundROE && heroesDataFoundSOD;
}

QString FirstLaunchView::getHeroesInstallDir()
{
#ifdef VCMI_WINDOWS
	QVector<QPair<QString, QString>> regKeys = {
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\GOG.com\\Games\\1207658787",                                            "path"    }, // Gog on x86 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\GOG.com\\Games\\1207658787",                               "path"    }, // Gog on x64 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\New World Computing\\Heroes of Might and Magic® III\\1.0",              "AppPath" }, // H3 Complete on x86 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\New World Computing\\Heroes of Might and Magic® III\\1.0", "AppPath" }, // H3 Complete on x64 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\New World Computing\\Heroes of Might and Magic III\\1.0",               "AppPath" }, // some localized H3 on x86 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\New World Computing\\Heroes of Might and Magic III\\1.0",  "AppPath" }, // some localized H3 on x64 system
	};

	for(auto & regKey : regKeys)
	{
		QString path = QSettings(regKey.first, QSettings::NativeFormat).value(regKey.second).toString();
		if(!path.isEmpty())
			return path;
	}
#endif
	return QString{};
}

void FirstLaunchView::extractGogData()
{
#ifdef ENABLE_INNOEXTRACT
	auto fileSelection = [this](QString filter, QString startPath = {}) {
		QString titleSel = tr("Select %1 file...", "param is file extension").arg(filter);
#if defined(VCMI_MOBILE)
		filter = tr("GOG file (*.*)");
		QMessageBox::information(this, tr("File selection"), titleSel);
#endif
		QString file = QFileDialog::getOpenFileName(this, titleSel, startPath.isEmpty() ? QDir::homePath() : startPath, filter);
		if(file.isEmpty())
			return QString{};
		return file;
	};

	QString filterBin = tr("GOG data") + " (*.bin)";
	QString filterExe = tr("GOG installer") + " (*.exe)";

	QString fileBin = fileSelection(filterBin);
	if(fileBin.isEmpty())
		return;
	QString fileExe = fileSelection(filterExe, QFileInfo(fileBin).absolutePath());
	if(fileExe.isEmpty())
		return;

	ui->progressBarGog->setVisible(true);
	ui->pushButtonGogInstall->setVisible(false);
	setEnabled(false);

	QTimer::singleShot(100, this, [this, fileBin, fileExe](){ // background to make sure FileDialog is closed...
		extractGogDataAsync(fileBin, fileExe);
		ui->progressBarGog->setVisible(false);
		ui->pushButtonGogInstall->setVisible(true);
		setEnabled(true);
		heroesDataUpdate();
	});
#endif
}

void FirstLaunchView::extractGogDataAsync(QString filePathBin, QString filePathExe)
{
	logGlobal->info("Extracting gog data from '%s' and '%s'", filePathBin.toStdString(), filePathExe.toStdString());

#ifdef ENABLE_INNOEXTRACT
	auto checkMagic = [](QString filename, QString filter, QByteArray magic)
	{
		logGlobal->info("Checking file %s", filename.toStdString());

		QFile tmpFile(filename);
		if(!tmpFile.open(QIODevice::ReadOnly))
		{
			logGlobal->info("File cannot be opened: %s", tmpFile.errorString().toStdString());
			return tr("Failed to open file: %1").arg(tmpFile.errorString());
		}

		QByteArray magicFile = tmpFile.read(magic.length());
		if(!magicFile.startsWith(magic))
		{
			logGlobal->info("Invalid file selected: %s", filter.toStdString());
			return tr("You have to select %1 file!", "param is file extension").arg(filter);
		}

		logGlobal->info("Checking file %s", filename.toStdString());
		return QString();
	};

	QString filterBin = tr("GOG data") + " (*.bin)";
	QString filterExe = tr("GOG installer") + " (*.exe)";

	QDir tempDir(pathToQString(VCMIDirs::get().userDataPath()));
	if(tempDir.cd("tmp"))
	{
		logGlobal->info("Cleaning up old data");
		tempDir.removeRecursively(); // remove if already exists (e.g. previous crash)
		tempDir.cdUp();
	}
	tempDir.mkdir("tmp");
	if(!tempDir.cd("tmp"))
		return; // should not happen - but avoid deleting wrong folder in any case

	logGlobal->info("Using '%s' as temporary directory", tempDir.path().toStdString());

	QString tmpFileExe = tempDir.filePath("h3_gog.exe");
	QString tmpFileBin = tempDir.filePath("h3_gog-1.bin");

	logGlobal->info("Performing native copy...");
	Helper::performNativeCopy(filePathExe, tmpFileExe);
	Helper::performNativeCopy(filePathBin, tmpFileBin);
	logGlobal->info("Native copy completed");

	QString errorText{};

	if (errorText.isEmpty())
		errorText = checkMagic(tmpFileBin, filterBin, QByteArray{"idska32"});

	if (errorText.isEmpty())
		errorText = checkMagic(tmpFileExe, filterExe, QByteArray{"MZ"});

	logGlobal->info("Installing exe '%s' ('%s')", tmpFileExe.toStdString(), filePathExe.toStdString());
	logGlobal->info("Installing bin '%s' ('%s')", tmpFileBin.toStdString(), filePathBin.toStdString());

	auto isGogGalaxyExe = [](QString fileToTest) {
		QFile file(fileToTest);
		quint64 fileSize = file.size();

		if(fileSize > 10 * 1024 * 1024)
			return false; // avoid to load big files; galaxy exe is smaller...

		if(!file.open(QIODevice::ReadOnly))
			return false;
		QByteArray data = file.readAll();

		const QByteArray magicId{reinterpret_cast<const char*>(u"GOG Galaxy"), 20};
		return data.contains(magicId);
	};

	if(errorText.isEmpty())
	{
		if(isGogGalaxyExe(tmpFileExe))
		{
			logGlobal->info("Gog Galaxy detected! Aborting...");
			errorText = tr("You've provided a GOG Galaxy installer! This file doesn't contain the game. Please download the offline backup game installer!");
		}
	}

	if(errorText.isEmpty())
	{
		logGlobal->info("Performing extraction using innoextract...");
		Helper::keepScreenOn(true);
		errorText = Innoextract::extract(tmpFileExe, tempDir.path(), [this](float progress) {
			ui->progressBarGog->setValue(progress * 100);
			qApp->processEvents();
		});
		Helper::keepScreenOn(false);
		logGlobal->info("Extraction done!");
	}

	QString hashError;
	if(!errorText.isEmpty())
		hashError = Innoextract::getHashError(tmpFileExe, tmpFileBin, filePathExe, filePathBin);

	QStringList dirData = tempDir.entryList({"data"}, QDir::Filter::Dirs);
	if(!errorText.isEmpty() || dirData.empty() || QDir(tempDir.filePath(dirData.front())).entryList({"*.lod"}, QDir::Filter::Files).empty())
	{
		if(!errorText.isEmpty())
		{
			logGlobal->error("Gog installer extraction failure! Reason: %s", errorText.toStdString());
			QMessageBox::critical(this, tr("Extracting error!"), errorText, QMessageBox::Ok, QMessageBox::Ok);
			if(!hashError.isEmpty())
			{
				logGlobal->error("Hash error: %s", hashError.toStdString());
				QMessageBox::critical(this, tr("Hash error!"), hashError, QMessageBox::Ok, QMessageBox::Ok);
			}
		}
		else
			QMessageBox::critical(this, tr("No Heroes III data!"), tr("Selected files do not contain Heroes III data!"), QMessageBox::Ok, QMessageBox::Ok);
		tempDir.removeRecursively();
		return;
	}

	logGlobal->info("Copying provided game files...");
	copyHeroesData(Helper::getRealPath(tempDir.path()));

	tempDir.removeRecursively();
#endif
}

// Find a subdirectory by name (case-insensitive) and return its real on-disk name
static QString findDirCI(const QDir &root, const QString &name)
{
    const QStringList dirs = root.entryList(QDir::Dirs | QDir::NoDotAndDotDot);
    for (const QString &d : dirs)
        if (d.compare(name, Qt::CaseInsensitive) == 0)
            return d; // real name, e.g. "Data" / "Maps" / "Mp3"
    return {};
}

// List files matching wildcard patterns (case-insensitive), returns file names
static QStringList listFilesCI(const QDir &dir, const QStringList &wildcards)
{
    QStringList out;
    const QStringList all = dir.entryList(QDir::Files);
    for (const QString &fn : all) {
        for (const QString &wc : wildcards) {
            const QRegularExpression rx(
                QRegularExpression::wildcardToRegularExpression(wc),
                QRegularExpression::CaseInsensitiveOption
            );
            if (rx.match(fn).hasMatch()) { out << fn; break; }
        }
    }
    return out;
}

void FirstLaunchView::copyHeroesData(const QString & path)
{
	QDir sourceRoot{ Helper::getRealPath(path) };
	if (!sourceRoot.exists())
	    return;
	
	// If user picked "Data" directly, step one level up if needed
	if (sourceRoot.dirName().compare("data", Qt::CaseInsensitive) == 0)
	{
	    // If there is no "Data" inside, go up to treat current as game root
	    if (findDirCI(sourceRoot, "data").isEmpty())
	        sourceRoot.cdUp();
	}
	
	// Find expected subdirs (case-insensitive)
	const QString dataDirName = findDirCI(sourceRoot, "data");
	const QString mapsDirName = findDirCI(sourceRoot, "maps");
	const QString mp3DirName  = findDirCI(sourceRoot, "mp3");
	
	const auto noDataMessage = tr("Failed to detect valid Heroes III data in chosen directory.\nPlease select the directory with installed Heroes III data.");
	if (dataDirName.isEmpty()) {
	    QMessageBox::critical(this, tr("Heroes III data not found!"), noDataMessage);
	    return;
	}
	
	QDir sourceData = sourceRoot.filePath(dataDirName);
	
	// Case-insensitive file matching
	const QStringList roeFiles = listFilesCI(sourceData, {"*.lod"});
	const QStringList sodFiles = listFilesCI(sourceData, {"H3ab*.lod"});
	const QStringList hdFiles  = listFilesCI(sourceData, {"*.pak"});
	
	if (sodFiles.isEmpty()) {
	    if (roeFiles.isEmpty()) {
	        QMessageBox::critical(this, tr("Heroes III data not found!"), noDataMessage);
	        return;
	    }
	    if (!hdFiles.isEmpty()) {
	        QMessageBox::critical(this, tr("Heroes III data not found!"),
	            tr("Heroes III: HD Edition files are not supported by VCMI.\nPlease select the directory with Heroes III: Complete Edition or Heroes III: Shadow of Death."));
	        return;
	    }
	    QMessageBox::critical(this, tr("Heroes III data not found!"),
	        tr("Unknown or unsupported Heroes III version found.\nPlease select the directory with Heroes III: Complete Edition or Heroes III: Shadow of Death."));
	    return;
	}
	
	// Build list of directories to copy using the real names we found
	QStringList copyDirectories;
	copyDirectories << dataDirName;
	if (!mapsDirName.isEmpty()) copyDirectories << mapsDirName;
	if (!mp3DirName.isEmpty())  copyDirectories << mp3DirName;
	
	QDir targetRoot = pathToQString(VCMIDirs::get().userDataPath());
	
	// Gather files (top-level only) for progress
	struct Item { QString src, dst; };
	QVector<Item> items;
	
	for (const QString & dirName : copyDirectories)
	{
	    QDir sourceDir = sourceRoot.filePath(dirName);
	    QDir targetDir = targetRoot.filePath(dirName);
	
	    QDir{}.mkpath(targetDir.path()); // ensure target dir exists
	
	    const QStringList files = sourceDir.entryList(QDir::Files);
	    for (const QString & filename : files)
	    {
	        const QString src = Helper::getRealPath(sourceDir.filePath(filename));
	        const QString dst = Helper::getRealPath(targetDir.filePath(filename));
	        items.push_back({src, dst});
	    }
	}
	
	QProgressDialog progress(tr("Copying Heroes III data..."), QString(), 0, items.size(), this);
	progress.setCancelButton(nullptr);
	progress.setMinimumDuration(0);
	
	for (int i = 0; i < items.size(); ++i)
	{
	    const auto & it = items[i];
	
	    // Update progress text/value
	    progress.setLabelText(QFileInfo(it.src).fileName());
	    progress.setValue(i);
	    QCoreApplication::processEvents();
	
	    // Overwrite target if exists
	    if (QFile::exists(it.dst))
	        QFile::remove(it.dst);
	
	    // Always copy via helper
	    Helper::performNativeCopy(it.src, it.dst);
	}
	
	progress.setValue(items.size());
	
	heroesDataUpdate();
}

// Tab Mod Preset
void FirstLaunchView::modPresetUpdate()
{
	bool translationExists = !findTranslationModName().isEmpty();

	ui->labelPresetLanguageDescr->setVisible(translationExists);
	ui->buttonPresetLanguage->setVisible(translationExists);

	ui->buttonPresetLanguage->setVisible(checkCanInstallTranslation());
	ui->buttonPresetExtras->setVisible(checkCanInstallExtras());
	ui->buttonPresetHota->setVisible(checkCanInstallHota());
	ui->buttonPresetWog->setVisible(checkCanInstallWog());

	ui->labelPresetLanguageDescr->setVisible(checkCanInstallTranslation());
	ui->labelPresetExtrasDescr->setVisible(checkCanInstallExtras());
	ui->labelPresetHotaDescr->setVisible(checkCanInstallHota());
	ui->labelPresetWogDescr->setVisible(checkCanInstallWog());

	// we can't install anything - either repository checkout is off or all recommended mods are already installed
	if (!checkCanInstallTranslation() && !checkCanInstallExtras() && !checkCanInstallHota() && !checkCanInstallWog())
		exitSetup(false);
}

QString FirstLaunchView::findTranslationModName()
{
	auto * mainWindow = dynamic_cast<MainWindow *>(QApplication::activeWindow());
	auto status = mainWindow->getTranslationStatus();

	if (status == ETranslationStatus::ACTIVE || status == ETranslationStatus::NOT_AVAILABLE)
		return QString();

	QString preferredlanguage = QString::fromStdString(settings["general"]["language"].String());
	return getModView()->getTranslationModName(preferredlanguage);
}

bool FirstLaunchView::checkCanInstallTranslation()
{
	QString modName = findTranslationModName();

	if(modName.isEmpty())
		return false;

	return checkCanInstallMod(modName);
}

bool FirstLaunchView::checkCanInstallWog()
{
	return checkCanInstallMod("wake-of-gods");
}

bool FirstLaunchView::checkCanInstallHota()
{
	return checkCanInstallMod("hota");
}

bool FirstLaunchView::checkCanInstallExtras()
{
	return checkCanInstallMod("vcmi-extras");
}

CModListView * FirstLaunchView::getModView()
{
	auto * mainWindow = dynamic_cast<MainWindow *>(QApplication::activeWindow());

	assert(mainWindow);
	if (!mainWindow)
		return nullptr;

	return mainWindow->getModView();
}

bool FirstLaunchView::checkCanInstallMod(const QString & modID)
{
	return getModView() && getModView()->isModAvailable(modID);
}

void FirstLaunchView::on_pushButtonPresetBack_clicked()
{
	activateTabHeroesData();
}

void FirstLaunchView::on_pushButtonPresetNext_clicked()
{
	QStringList modsToInstall;

	if (ui->buttonPresetLanguage->isChecked() && checkCanInstallTranslation())
		modsToInstall.push_back(findTranslationModName());

	if (ui->buttonPresetExtras->isChecked() && checkCanInstallExtras())
		modsToInstall.push_back("vcmi-extras");

	if (ui->buttonPresetWog->isChecked() && checkCanInstallWog())
		modsToInstall.push_back("wake-of-gods");

	if (ui->buttonPresetHota->isChecked() && checkCanInstallHota())
		modsToInstall.push_back("hota");

	bool goToMods = !modsToInstall.empty();
	exitSetup(goToMods);

	for (auto const & modName : modsToInstall)
		getModView()->doInstallMod(modName);
}

void FirstLaunchView::on_pushButtonDiscord_clicked()
{
	QDesktopServices::openUrl(QUrl("https://discord.gg/chBT42V"));
}

void FirstLaunchView::on_pushButtonGithub_clicked()
{
	QDesktopServices::openUrl(QUrl("https://github.com/vcmi/vcmi"));
}
