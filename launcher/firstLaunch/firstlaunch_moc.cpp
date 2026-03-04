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
#include "../../lib/filesystem/CZipLoader.h"
#include "../../vcmiqt/MessageBox.h"
#include "../helper.h"
#include "../languages.h"
#include "../innoextract.h"
#include "progressoverlay.h"

#include <algorithm>
#include <cmath>

// Create and show overlay immediately
static ProgressOverlay* createOverlay(QWidget *parent, const QString &title, bool indeterminate = true)
{
	auto *overlay = new ProgressOverlay(parent, 50);
	overlay->setTitle(title);
	overlay->setIndeterminate(indeterminate);
	overlay->show();
	qApp->processEvents(); // paint before heavy work
	return overlay;
}

namespace
{
constexpr int TAB_LANGUAGE = 0;
constexpr int TAB_DATA = 1;
constexpr int TAB_MOD_PRESET = 2;
constexpr int TAB_INFO = 3;
constexpr int TAB_COUNT = 4;
}

FirstLaunchView::FirstLaunchView(QWidget * parent)
	: QWidget(parent)
	, ui(std::make_unique<Ui::FirstLaunchView>())
{
	ui->setupUi(this);
	applyResponsiveUiScale();

	enterSetup();
	activateTab(TAB_LANGUAGE);

	ui->lineEditDataSystem->setText(pathToQString(boost::filesystem::absolute(VCMIDirs::get().dataPaths().front())));
	ui->lineEditDataUser->setText(pathToQString(boost::filesystem::absolute(VCMIDirs::get().userDataPath())));

	Helper::enableScrollBySwiping(ui->listWidgetLanguage);

#ifdef VCMI_MOBILE
	// This directory is not accessible to players without rooting of their device
	ui->lineEditDataSystem->hide();
#endif

#ifndef ENABLE_INNOEXTRACT
	ui->commandLinkButtonDataGog->hide();
	if(ui->commandLinkButtonDataGog->isChecked())
		ui->commandLinkButtonDataManual->setChecked(true);
#endif
	updateDataOptionState(false);
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

void FirstLaunchView::resizeEvent(QResizeEvent * event)
{
	QWidget::resizeEvent(event);
	applyResponsiveUiScale();
}

void FirstLaunchView::applyResponsiveUiScale()
{
	const int baseHeight = 520;
	const int minHeight = 400;
	const int clampedHeight = std::max(minHeight, height());
	const qreal scale = std::clamp(static_cast<qreal>(clampedHeight) / static_cast<qreal>(baseHeight), 0.85, 1.45);

	const QList<QWidget *> allWidgets = findChildren<QWidget *>();
	for(QWidget * widget : allWidgets)
	{
		QFont f = widget->font();
		const QVariant baseSize = widget->property("_vcmiBasePointSize");
		qreal basePointSize = baseSize.isValid() ? baseSize.toReal() : f.pointSizeF();
		if(basePointSize <= 0)
			continue;
		if(!baseSize.isValid())
			widget->setProperty("_vcmiBasePointSize", basePointSize);

		qreal multiplier = 1.0;
		if(qobject_cast<QCommandLinkButton *>(widget))
			multiplier = 1.20;
		else if(qobject_cast<QTextBrowser *>(widget))
			multiplier = 1.10;
		else if(qobject_cast<QPushButton *>(widget))
			multiplier = 1.05;
		else if(qobject_cast<QToolButton *>(widget))
			multiplier = 1.05;

		f.setPointSizeF(basePointSize * scale * multiplier);
		widget->setFont(f);
	}

	auto applyNavigationButtonScale = [scale](QPushButton * button)
	{
		if(!button)
			return;

		const int minHeightPx = std::max(28, static_cast<int>(std::round(30 * scale)));
		const int minWidthPx = std::max(92, static_cast<int>(std::round(112 * scale)));
		button->setMinimumSize(minWidthPx, minHeightPx);
		button->setMaximumHeight(static_cast<int>(std::round(44 * scale)));
	};

	auto applyActionButtonScale = [scale](QPushButton * button)
	{
		if(!button)
			return;
		const int minHeightPx = std::max(28, static_cast<int>(std::round(30 * scale)));
		button->setMinimumHeight(minHeightPx);
		button->setMaximumHeight(static_cast<int>(std::round(44 * scale)));
	};


	auto applyDataOptionButtonScale = [scale](QCommandLinkButton * button)
	{
		if(!button)
			return;
		const int minHeightPx = std::max(76, static_cast<int>(std::round(92 * scale)));
		button->setMinimumHeight(minHeightPx);
	};

	applyDataOptionButtonScale(ui->commandLinkButtonDataDetected);
	applyDataOptionButtonScale(ui->commandLinkButtonDataGog);
	applyDataOptionButtonScale(ui->commandLinkButtonDataCopy);
	applyDataOptionButtonScale(ui->commandLinkButtonDataManual);

	applyNavigationButtonScale(ui->pushButtonLanguageNext);
	applyNavigationButtonScale(ui->pushButtonDataBack);
	applyNavigationButtonScale(ui->pushButtonDataNext);
	applyActionButtonScale(ui->pushButtonSelect);
	applyNavigationButtonScale(ui->pushButtonPresetBack);
	applyNavigationButtonScale(ui->pushButtonPresetNext);
	applyNavigationButtonScale(ui->pushButtonInfoBack);
	applyNavigationButtonScale(ui->pushButtonFinish);
}

void FirstLaunchView::on_pushButtonLanguageNext_clicked()
{
	activateNextTab();
}

void FirstLaunchView::on_pushButtonDataNext_clicked()
{
	activateNextTab();
}

void FirstLaunchView::on_pushButtonDataBack_clicked()
{
	activatePreviousTab();
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
			if(!picked.isEmpty())
				copyHeroesData(picked, false);
		});
	});
}

void FirstLaunchView::on_pushButtonSelect_clicked()
{
	if(ui->commandLinkButtonDataDetected->isChecked() && ui->commandLinkButtonDataDetected->isEnabled())
		return;

	if(ui->commandLinkButtonDataManual->isChecked())
	{
		heroesDataUpdate();
		return;
	}

	if(ui->commandLinkButtonDataCopy->isChecked())
	{
		// iOS can't display modal dialogs when called directly on button press
		// https://bugreports.qt.io/browse/QTBUG-98651
		MessageBoxCustom::showDialog(this, [this]{
			Helper::nativeFolderPicker(this, [this](const QString &picked){
				if(!picked.isEmpty())
					copyHeroesData(picked, false);
			});
		});
		return;
	}

	// iOS can't display modal dialogs when called directly on button press
	// https://bugreports.qt.io/browse/QTBUG-98651
	MessageBoxCustom::showDialog(this, [this]{extractGogData();});
}

void FirstLaunchView::on_commandLinkButtonDataDetected_toggled(bool checked)
{
	if(checked)
		updateDataOptionDetails();
}

void FirstLaunchView::on_commandLinkButtonDataGog_toggled(bool checked)
{
	if(checked)
		updateDataOptionDetails();
}

void FirstLaunchView::on_commandLinkButtonDataCopy_toggled(bool checked)
{
	if(checked)
		updateDataOptionDetails();
}

void FirstLaunchView::on_commandLinkButtonDataManual_toggled(bool checked)
{
	if(checked)
		updateDataOptionDetails();
}


void FirstLaunchView::enterSetup()
{
	Languages::fillLanguages(ui->listWidgetLanguage, false);
}

void FirstLaunchView::setSetupProgress(int progress)
{
	Q_UNUSED(progress);
}

bool FirstLaunchView::isDemoDataDetected() const
{
	QDir userRoot = pathToQString(VCMIDirs::get().userDataPath());
	QDir dataDir(userRoot.filePath(QStringLiteral("Data")));
	QDir mapsDir(userRoot.filePath(QStringLiteral("Maps")));

	bool hasDemoMap = false;
	const QStringList mapFiles = mapsDir.entryList(QDir::Files | QDir::Readable);
	for(const QString &name : mapFiles)
	{
		if(name.compare(QStringLiteral("h3demo.h3m"), Qt::CaseInsensitive) == 0)
		{
			hasDemoMap = true;
			break;
		}
	}

	if(!hasDemoMap)
		return false;

	const QStringList files = dataDir.entryList(QDir::Files | QDir::Readable);
	for(const QString &name : files)
	{
		if(name.compare(QStringLiteral("H3ab_spr.lod"), Qt::CaseInsensitive) == 0)
		{
			QFileInfo lodInfo(dataDir.filePath(name));
			const quint64 fileSize = static_cast<quint64>(lodInfo.size());
			logGlobal->trace("H3ab_spr.lod size: %llu", fileSize);
			if(fileSize < 8000000) // 8 MB + Demo map = Merged Windows and MacOS Demo
				return true;
		}
	}

	return false;
}

bool FirstLaunchView::shouldShowTab(int tabIndex) const
{
	if(tabIndex == TAB_DATA)
		return !heroesDataDetect() || isDemoDataDetected();

	return tabIndex >= TAB_LANGUAGE && tabIndex < TAB_COUNT;
}

void FirstLaunchView::activateTab(int tabIndex)
{
	if(tabIndex < TAB_LANGUAGE || tabIndex >= TAB_COUNT)
		return;

	if(!shouldShowTab(tabIndex))
	{
		activateNextTab();
		return;
	}

	setSetupProgress(tabIndex + 1);
	ui->installerTabs->setCurrentIndex(tabIndex);

	if(tabIndex == TAB_DATA)
		heroesDataUpdate();

	if(tabIndex == TAB_MOD_PRESET)
		modPresetUpdate();
}

void FirstLaunchView::activateNextTab()
{
	int nextTab = ui->installerTabs->currentIndex() + 1;
	while(nextTab < TAB_COUNT && !shouldShowTab(nextTab))
		++nextTab;

	if(nextTab < TAB_COUNT)
		activateTab(nextTab);
}

void FirstLaunchView::activatePreviousTab()
{
	int previousTab = ui->installerTabs->currentIndex() - 1;
	while(previousTab >= TAB_LANGUAGE && !shouldShowTab(previousTab))
		--previousTab;

	if(previousTab >= TAB_LANGUAGE)
		activateTab(previousTab);
}

void FirstLaunchView::activateTabLanguage()
{
	activateTab(TAB_LANGUAGE);
}

void FirstLaunchView::activateTabHeroesData()
{
	activateTab(TAB_DATA);
}

void FirstLaunchView::activateTabModPreset()
{
	activateTab(TAB_MOD_PRESET);
}

void FirstLaunchView::activateTabInfo()
{
	activateTab(TAB_INFO);
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
	const bool demoDetected = isDemoDataDetected();
	QPalette newPalette = palette();
	newPalette.setColor(QPalette::Base, demoDetected ? QColor(220, 170, 50) : QColor(200, 50, 50));
	ui->lineEditDataSystem->setPalette(newPalette);
	ui->lineEditDataUser->setPalette(newPalette);

	ui->labelDataFound->setVisible(false);
	ui->labelDataDemoInfo->setVisible(demoDetected);
	ui->pushButtonDataNext->setEnabled(demoDetected);

	updateDataOptionState(false);
}

void FirstLaunchView::heroesDataDetected()
{
	QPalette newPalette = palette();
	newPalette.setColor(QPalette::Base, QColor(50, 200, 50));
	ui->lineEditDataSystem->setPalette(newPalette);
	ui->lineEditDataUser->setPalette(newPalette);

	ui->labelDataFound->setVisible(true);
	ui->labelDataDemoInfo->setVisible(false);
	ui->pushButtonDataNext->setEnabled(true);

	updateDataOptionState(true);

	CGeneralTextHandler::detectInstallParameters();
}

void FirstLaunchView::updateDataOptionState(bool dataDetected)
{
	const QString installPath = getHeroesInstallDir();
	const bool hasDetectedInstall = !installPath.isEmpty();

	ui->commandLinkButtonDataDetected->setEnabled(hasDetectedInstall);

	ui->commandLinkButtonDataDetected->setText(hasDetectedInstall ? tr("Detected Heroes III installation") : QStringLiteral(" "));
	ui->commandLinkButtonDataDetected->setDescription(hasDetectedInstall
		? tr("Use the installation detected automatically on this device.")
		: QStringLiteral(" "));
	if(!hasDetectedInstall && ui->commandLinkButtonDataDetected->isChecked())
		ui->commandLinkButtonDataGog->setChecked(true);

	const bool canUseDataCopy = Helper::canUseFolderPicker();
	ui->commandLinkButtonDataCopy->setEnabled(canUseDataCopy);

	ui->commandLinkButtonDataCopy->setText(canUseDataCopy ? tr("Copy existing files") : QStringLiteral(" "));
	ui->commandLinkButtonDataCopy->setDescription(canUseDataCopy
		? tr("Choose an existing Heroes III folder and copy required files.")
		: QStringLiteral(" "));
	if(!canUseDataCopy && ui->commandLinkButtonDataCopy->isChecked())
		ui->commandLinkButtonDataGog->setChecked(true);

	if(dataDetected && hasDetectedInstall)
		ui->commandLinkButtonDataDetected->setChecked(true);
	else if(!ui->commandLinkButtonDataGog->isChecked() && !ui->commandLinkButtonDataCopy->isChecked() && !ui->commandLinkButtonDataManual->isChecked() && !ui->commandLinkButtonDataDetected->isChecked())
		ui->commandLinkButtonDataGog->setChecked(true);

	updateDataOptionDetails();
}

void FirstLaunchView::updateDataOptionDetails()
{
	const bool manualSelected = ui->commandLinkButtonDataManual->isChecked();
	ui->labelDataFiles->setVisible(manualSelected);
	ui->lineEditDataUser->setVisible(manualSelected);
	ui->lineEditDataSystem->setVisible(manualSelected);

	if(ui->commandLinkButtonDataDetected->isChecked() && ui->commandLinkButtonDataDetected->isEnabled())
	{
		ui->textBrowserDataOptionDetails->setPlainText(tr("VCMI found an existing Heroes III installation on this system. No additional action is required."));
		ui->pushButtonSelect->setVisible(false);
	}
	else if(ui->commandLinkButtonDataCopy->isChecked())
	{
		ui->textBrowserDataOptionDetails->setPlainText(tr("Pick the folder with your existing Heroes III files and VCMI will copy all required data automatically."));
		ui->pushButtonSelect->setText(tr("Select folder"));
		ui->pushButtonSelect->setVisible(true);
	}
	else if(manualSelected)
	{
		ui->textBrowserDataOptionDetails->setPlainText(tr("Copy Heroes III files manually into the folders shown below, then press Scan again to verify installation."));
		ui->pushButtonSelect->setText(tr("Scan again"));
		ui->pushButtonSelect->setVisible(true);
	}
	else
	{
		ui->textBrowserDataOptionDetails->setHtml(tr(R"(
<p>If you already know this flow and have the Heroes III Complete offline backup installer from gog.com, continue by pressing <b>Select installer</b> and selecting the files.</p>
<p>If you do not own the game yet, buy it on gog.com: <a href="https://www.gog.com/en/game/heroes_of_might_and_magic_3_complete_edition">Heroes of Might and Magic 3 Complete Edition</a>.</p>
<p>If you already own it and only need to download it, sign in to your account and download the offline backup game installer EXE: <a href="https://www.gog.com/downloads/heroes_of_might_and_magic_3_complete_edition/en1installer0">en1installer0</a> and BIN: <a href="https://www.gog.com/downloads/heroes_of_might_and_magic_3_complete_edition/en1installer1">en1installer1</a>.</p>
)"));
		ui->pushButtonSelect->setText(tr("Select installer"));
#ifdef ENABLE_INNOEXTRACT
		ui->pushButtonSelect->setVisible(true);
#else
		ui->pushButtonSelect->setVisible(false);
#endif
	}
}

// Tab Heroes III Data
bool FirstLaunchView::heroesDataDetect() const
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
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\GOG.com\\Games\\1207658787",											 "path"	   }, // Gog on x86 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\GOG.com\\Games\\1207658787",							     "path"	   }, // Gog on x64 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\New World Computing\\Heroes of Might and Magic® III\\1.0",			     "AppPath" }, // H3 Complete on x86 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\New World Computing\\Heroes of Might and Magic® III\\1.0", "AppPath" }, // H3 Complete on x64 system
		{ "HKEY_LOCAL_MACHINE\\SOFTWARE\\New World Computing\\Heroes of Might and Magic III\\1.0",			     "AppPath" }, // some localized H3 on x86 system
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
	
static QString defaultStartDirForOpen()
{
#if defined(VCMI_MOBILE)
	const QStandardPaths::StandardLocation mobilePrefs[] = {
		QStandardPaths::DocumentsLocation,
		QStandardPaths::HomeLocation
	};
	for(auto location : mobilePrefs)
	{
		for(const QString &path : QStandardPaths::standardLocations(location))
			if(QDir(path).exists() && !path.isEmpty())
				return path;
	}
	return QDir::homePath();
#else
	// Desktop: prefer Downloads, then Home, then Desktop
	const QStandardPaths::StandardLocation desktopPrefs[] = {
		QStandardPaths::DownloadLocation,
		QStandardPaths::HomeLocation,
		QStandardPaths::DesktopLocation
	};
	for(auto location : desktopPrefs)
	{
		for(const QString &path : QStandardPaths::standardLocations(location))
			if(QDir(path).exists() && !path.isEmpty())
				return path;
	}
	return QDir::homePath();
#endif
}


QString FirstLaunchView::checkFileMagic(const QString &filename, const QString &filter, const QByteArray &magic, const QString &ext, bool &openFailed) const
{
	QFile file(filename);
	if(!file.open(QIODevice::ReadOnly))
	{
		if(openFailed)
		{
			return tr("Failed to open file: %1").arg(file.errorString());
		}
		else
		{
			// Some systems can't access selected file for read, but can copy it, postpone fail fast for next run
			logGlobal->warn("checkMagic: open failed for '%s': %s", filename.toStdString(), file.errorString().toStdString());
			openFailed = true;
			return {};
		}
	}

	QFileInfo fileInfo(filename);
	quint64 fileSize = fileInfo.size();

	QString realFilename = Helper::getRealPath(filename);

	logGlobal->info("Checking %s with size: %llu", realFilename.toStdString(), fileSize);

#if defined(VCMI_MOBILE)
	if(!realFilename.endsWith(ext, Qt::CaseInsensitive))
		return tr("You need to select a %1 file!", "param is file extension").arg(ext);
#endif

	if(realFilename.endsWith(".exe", Qt::CaseInsensitive))
	{
		if(fileSize > 1500000) // 1.5MB
		{
			logGlobal->info("Unknown installer selected: %s", filename.toStdString());
			return tr("Unknown installer selected.\nYou need to select the offline GOG installer.");
		}

		const QByteArray data = file.peek(fileSize);

		constexpr std::u16string_view galaxyID = u"GOG Galaxy";
		const auto galaxyIDBytes = reinterpret_cast<const char*>(galaxyID.data());
		const auto magicId = QByteArray::fromRawData(galaxyIDBytes, galaxyID.size() * sizeof(decltype(galaxyID)::value_type));

		if(data.contains(magicId))
		{
			logGlobal->info("GOG Galaxy detected! Aborting...");
			return tr("You selected a GOG Galaxy installer. This file does not contain the game. Please download the offline backup game installer instead.");
		}
	}

	const QByteArray magicFile = file.peek(magic.length());
	if(!magicFile.startsWith(magic))
		return tr("You need to select a %1 file!", "param is file extension").arg(filter);

	return {};
}

void FirstLaunchView::extractGogData()
{
#ifdef ENABLE_INNOEXTRACT
	auto fileSelection = [this](const QString &title,  QString filter, const QString &startPath = {}) {
#if defined(VCMI_MOBILE)
		filter = tr("GOG file (*.*)");
		QMessageBox::information(this, tr("File selection"), title);
#endif
		QString file = QFileDialog::getOpenFileName(this, title, startPath.isEmpty() ? defaultStartDirForOpen() : startPath, filter);
		if(file.isEmpty())
			return QString{};
		return file;
	};

	needPostCopyCheckExe = false;
	needPostCopyCheckBin = false;

	QString filterExe = tr("GOG installer") + " (*.exe)";
	QString titleExe  = tr("Select the offline GOG installer (.exe)");

	QString fileExe = fileSelection(titleExe, filterExe);
	if(fileExe.isEmpty())
		return;

	QString errorText = checkFileMagic(fileExe, filterExe, QByteArray{"MZP"}, "EXE", needPostCopyCheckExe);
	if(!errorText.isEmpty())
	{
		QMessageBox::critical(this, tr("Invalid file selected"), errorText);
		return;
	}

	QFileInfo exeInfo(fileExe);
	QString expectedBinName = exeInfo.completeBaseName() + "-1.bin";
	QString filterBin = tr("GOG data") + " (*.bin)";
	QString titleBin = tr("Select the offline GOG installer data file: %1", "param is file name").arg(expectedBinName);

	// Try to access BIN based on selected EXE
	QString fileBinCandidate = exeInfo.absoluteDir().filePath(expectedBinName);
	bool haveCandidate = false;

	QFile file(fileBinCandidate);
	if(file.open(QIODevice::ReadOnly))
	{
		haveCandidate = true;
		file.close();
	}

	QString fileBin = haveCandidate ? fileBinCandidate : fileSelection(titleBin, filterBin, exeInfo.absolutePath());
	if(fileBin.isEmpty())
		return;

	errorText = checkFileMagic(fileBin, filterBin, QByteArray{"idska32"}, "BIN", needPostCopyCheckBin);
	if(!errorText.isEmpty())
	{
		QMessageBox::critical(this, tr("Invalid data file"), errorText);
		return;
	}

	QTimer::singleShot(100, this, [this, fileBin, fileExe](){ // background to make sure FileDialog is closed...
		extractGogDataAsync(fileBin, fileExe);
		setEnabled(true);
		heroesDataUpdate();
	});
#endif
}

bool FirstLaunchView::performCopyFlow(const QString& path, ProgressOverlay* overlay, bool removeSource)
{
	// 1) Scan -> "Source \t Target \t Name"
	overlay->setIndeterminate(true);

	const QStringList items = Helper::findFilesForCopy(path);
	if(items.isEmpty())
	{
		QMessageBox::critical(this, tr("Heroes III data not found!"), tr("Failed to detect valid Heroes III data in chosen directory.\nPlease select the directory with installed Heroes III data."));
		return false;
	}

	// 2) Validate signature
	// TODO: Find proper way for pure SoD check in import or way to block pure RoE / AB
	//	     Or prepare RoE / AB Ban mod and allow VCMI to go with any H3 version
	auto validate = [](const QStringList &items)->QString {
		bool anyLOD=false;
		bool anySOD=false;
		bool anyHD=false;

		for(const QString &line : items)
		{
			const auto part = line.split('\t');
			if(part[1].compare("Data", Qt::CaseInsensitive) != 0)
				continue;

			const QString &name = part[2];
			if(name.endsWith(".lod", Qt::CaseInsensitive))
			{
				anyLOD = true;
				if(name.startsWith("H3ab", Qt::CaseInsensitive))
					anySOD = true;
			}

			if(name.endsWith(".pak", Qt::CaseInsensitive))
				anyHD = true;
		}

		if(anySOD) return {};

		if(!anyLOD)
			return tr("Failed to detect valid Heroes III data in chosen directory.\nPlease select the directory with installed Heroes III data.");

		if(anyHD)
			return tr("Heroes III: HD Edition files are not supported by VCMI.\nPlease select the directory with Heroes III: Complete Edition or Heroes III: Shadow of Death.");

		return tr("Unknown or unsupported Heroes III version found.\nPlease select the directory with Heroes III: Complete Edition or Heroes III: Shadow of Death.");
	};

	const QString err = validate(items);
	if(!err.isEmpty())
	{
		QMessageBox::critical(this, tr("Heroes III data not found!"), err);
		return false;
	}

	// 3) Plan destination, create target dirs on demand
	QDir targetRoot = pathToQString(VCMIDirs::get().userDataPath());
	QSet<QString> created;

	struct CopyItem { QString source, destination; };
	QVector<CopyItem> plan;
	plan.reserve(items.size());

	for(const QString &line : items)
	{
		const auto part = line.split('\t');

		const QString &source = part[0];
		const QString &target = part[1]; // Data / Maps / Mp3
		const QString &file   = part[2];

		if(!created.contains(target))
		{
			QDir{}.mkpath(targetRoot.filePath(target));
			created.insert(target);
		}

		const QDir destinationDir = targetRoot.filePath(target);
		plan.push_back({ source, destinationDir.filePath(file) });
	}

	// 4) Copy with progress
	overlay->setTitle(tr("Importing Heroes III data..."));
	overlay->setIndeterminate(false);
	overlay->setRange(plan.size());

	for(int i = 0; i < plan.size(); ++i)
	{
		overlay->setFileName(QFileInfo(plan[i].destination).fileName());
		overlay->setValue(i + 1);
		qApp->processEvents();

		if(QFile::exists(plan[i].destination))
			QFile::remove(plan[i].destination);

		Helper::performNativeCopy(plan[i].source, plan[i].destination);

		logGlobal->info("Copying '%s' -> '%s'", plan[i].source.toStdString(), plan[i].destination.toStdString());
	}

	// 5) Optional cleanup
	if(removeSource)
		QDir(path).removeRecursively();

	return true;
}

void FirstLaunchView::extractGogDataAsync(QString filePathBin, QString filePathExe)
{
	logGlobal->info("Extracting gog data from '%s' and '%s'", filePathBin.toStdString(), filePathExe.toStdString());

#ifdef ENABLE_INNOEXTRACT
	// Defer heavy work to next event-loop tick to ensure overlay is painted
	QTimer::singleShot(0, this, [this, filePathBin, filePathExe]()
	{
		QScopedPointer<ProgressOverlay> overlay(createOverlay(this, tr("Preparing installer..."), true));
		overlay->setFileName(QFileInfo(filePathExe).fileName());
		overlay->raise();
		qApp->processEvents();

		// "Goole TV Tick" without this was never displayed "Preparing installer" on screen
		QEventLoop ev;
		QTimer::singleShot(0, &ev, &QEventLoop::quit);
		ev.exec();

		// 1) Prepare temp dir
		QDir tempDir(pathToQString(VCMIDirs::get().userDataPath()));
		if(tempDir.cd("tmp"))
		{
			logGlobal->info("Cleaning up old temp data");
			tempDir.removeRecursively(); // remove if already exists (e.g. previous crash)
			tempDir.cdUp();
		}
		tempDir.mkdir("tmp");
		if(!tempDir.cd("tmp"))
		{
			return; // should not happen - but avoid deleting wrong folder in any case
		}

		logGlobal->info("Using '%s' as temporary directory", tempDir.path().toStdString());

		const QString tmpFileExe = tempDir.filePath("h3_gog.exe");
		const QString tmpFileBin = tempDir.filePath("h3_gog-1.bin");

		// 2) Copy selected files into tmp
		logGlobal->info("Performing native copy...");
		Helper::performNativeCopy(filePathExe, tmpFileExe);

		if(needPostCopyCheckExe)
		{
			const QString err = checkFileMagic(tmpFileExe, tr("GOG installer") + " (*.exe)", QByteArray{"MZP"}, "EXE", needPostCopyCheckExe);
			if(!err.isEmpty())
			{
				QMessageBox::critical(this, tr("Invalid file selected"), err);
				tempDir.removeRecursively();
				return;
			}
		}

		Helper::performNativeCopy(filePathBin, tmpFileBin);

		if(needPostCopyCheckBin)
		{
			const QString err = checkFileMagic(tmpFileBin, tr("GOG data") + " (*.bin)", QByteArray{"idska32"}, "BIN", needPostCopyCheckBin);
			if(!err.isEmpty())
			{
				QMessageBox::critical(this, tr("Invalid data file"), err);
				tempDir.removeRecursively();
				return;
			}
		}

		logGlobal->info("Native copy completed");

		// 3) Extract
		overlay->setTitle(tr("Extracting installer..."));
		overlay->setIndeterminate(false);
		overlay->setRange(100);
		overlay->setValue(0);

		logGlobal->info("Performing extraction using innoextract...");

		QString errorText;

		errorText = Innoextract::extract(tmpFileExe, tempDir.path(), [overlayPtr = overlay.data()](float progress) {
			overlayPtr->setValue(static_cast<int>(progress * 100));
			qApp->processEvents();
		});

		logGlobal->info("Extraction done!");

		// 4) Post-extract verification and error reporting
		QString hashError;
		if(!errorText.isEmpty())
			hashError = Innoextract::getHashError(tmpFileExe, tmpFileBin, filePathExe, filePathBin);

		QStringList dirData = tempDir.entryList({"data"}, QDir::Filter::Dirs);
		if(!errorText.isEmpty() || dirData.empty() || QDir(tempDir.filePath(dirData.front())).entryList({"*.lod"}, QDir::Filter::Files).empty())
		{
			if(!errorText.isEmpty())
			{
				logGlobal->error("GOG installer extraction failure! Reason: %s", errorText.toStdString());
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

		logGlobal->info("Importing Heroes III data...");

		// 5) Reuse overlay for copy phase
		overlay->setTitle(tr("Importing Heroes III data..."));
		overlay->setFileName({});
		overlay->setRange(100); // performCopyFlow will reset to plan size internally
		overlay->setValue(0);

		if(performCopyFlow(tempDir.path(), overlay.data(), true))
			if(heroesDataUpdate())
				activateTabModPreset();
	});
#endif
}

void FirstLaunchView::copyHeroesDataFromArchive(const QString &archivePath)
{
	QTemporaryDir tempDir;
	if(!tempDir.isValid())
	{
		QMessageBox::critical(this, tr("Extraction error"), tr("Failed to create temporary directory for ZIP extraction."));
		return;
	}

	bool extracted = false;
	try
	{
		ZipArchive archive(qstringToPath(archivePath));
		const auto files = archive.listFiles();
		extracted = archive.extract(qstringToPath(tempDir.path()), files);
	}
	catch(const std::exception &e)
	{
		QMessageBox::critical(this, tr("Extraction error"), tr("Failed to read ZIP archive: %1").arg(QString::fromUtf8(e.what())));
		return;
	}

	if(!extracted)
	{
		QMessageBox::critical(this, tr("Extraction error"), tr("Failed to extract ZIP archive."));
		return;
	}

	QPointer<ProgressOverlay> overlay = createOverlay(this, tr("Scanning selected folder..."), true);
	overlay->raise();
	if(performCopyFlow(tempDir.path(), overlay, false))
		if(heroesDataUpdate())
			activateTabModPreset();
	overlay->deleteLater();
}

void FirstLaunchView::copyHeroesData(const QString &path, bool removeSource)
{
	QPointer<ProgressOverlay> overlay = createOverlay(this, tr("Scanning selected folder..."), true);
	overlay->raise();
	auto work = [this, path, removeSource, overlay]() {
		if(performCopyFlow(path, overlay, removeSource))
			if(heroesDataUpdate())
				activateTabModPreset();

		overlay->deleteLater();
	};

#ifdef VCMI_IOS
	// iOS needs to make synchronous call for the SelectDirectory object to be still alive
	// as it calls stopAccessingSecurityScopedResource on the user selected directory URL upon destruction
	qApp->processEvents();
	work();
#else
	QTimer::singleShot(0, this, work);
#endif
}

// Tab Mod Preset
void FirstLaunchView::modPresetUpdate()
{
	bool translationExists = !findTranslationModName().isEmpty();

	ui->labelPresetLanguageDescr->setVisible(translationExists);
	ui->buttonPresetLanguage->setVisible(translationExists);

	bool canTrans  = checkCanInstallTranslation();
	bool canExtras = checkCanInstallExtras();
	bool canDemo   = checkCanInstallDemo();
	bool canHota   = checkCanInstallHota();
	bool canWog	= checkCanInstallWog();
	bool canTow	= checkCanInstallTow();
	bool canFod	= checkCanInstallFod();

	ui->buttonPresetLanguage->setVisible(canTrans);
	ui->buttonPresetExtras->setVisible(canExtras);
	ui->buttonPresetDemo->setVisible(canDemo);
	ui->buttonPresetHota->setVisible(canHota);
	ui->buttonPresetWog->setVisible(canWog);
	ui->buttonPresetTow->setVisible(canTow);
	ui->buttonPresetFod->setVisible(canFod);

	ui->labelPresetLanguageDescr->setVisible(canTrans);
	ui->labelPresetExtrasDescr->setVisible(canExtras);
	ui->labelPresetDemoDescr->setVisible(canDemo);
	ui->labelPresetHotaDescr->setVisible(canHota);
	ui->labelPresetWogDescr->setVisible(canWog);
	ui->labelPresetTowDescr->setVisible(canTow);
	ui->labelPresetFodDescr->setVisible(canFod);

	// we can't install anything - either repository checkout is off or all recommended mods are already installed
	if(!canTrans && !canExtras && !canDemo && !canHota && !canWog && !canTow && !canFod)
		exitSetup(false);
}

QString FirstLaunchView::findTranslationModName()
{
	auto * mainWindow = dynamic_cast<MainWindow *>(QApplication::activeWindow());
	auto status = mainWindow->getTranslationStatus();

	if(status == ETranslationStatus::ACTIVE || status == ETranslationStatus::NOT_AVAILABLE)
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

bool FirstLaunchView::checkCanInstallExtras()
{
	return checkCanInstallMod("vcmi-extras");
}

bool FirstLaunchView::checkCanInstallDemo()
{
	if(!checkCanInstallMod("demo-support"))
		return false;

	return isDemoDataDetected();
}

bool FirstLaunchView::checkCanInstallHota()
{
	return checkCanInstallMod("hota");
}

bool FirstLaunchView::checkCanInstallWog()
{
	return checkCanInstallMod("wake-of-gods");
}

bool FirstLaunchView::checkCanInstallTow()
{
	return checkCanInstallMod("tides-of-war");
}

bool FirstLaunchView::checkCanInstallFod()
{
	return checkCanInstallMod("fallen-of-the-depth");
}

CModListView * FirstLaunchView::getModView()
{
	auto * mainWindow = dynamic_cast<MainWindow *>(QApplication::activeWindow());

	assert(mainWindow);
	if(!mainWindow)
		return nullptr;

	return mainWindow->getModView();
}

bool FirstLaunchView::checkCanInstallMod(const QString & modID)
{
	return getModView() && getModView()->isModAvailable(modID);
}

void FirstLaunchView::on_pushButtonPresetBack_clicked()
{
	activatePreviousTab();
}

void FirstLaunchView::on_pushButtonPresetNext_clicked()
{
	activateNextTab();
}

void FirstLaunchView::on_pushButtonInfoBack_clicked()
{
	activatePreviousTab();
}

void FirstLaunchView::on_pushButtonFinish_clicked()
{
	QStringList modsToInstall;

	if(ui->buttonPresetLanguage->isChecked() && checkCanInstallTranslation())
		modsToInstall.push_back(findTranslationModName());

	if(ui->buttonPresetExtras->isChecked() && checkCanInstallExtras())
		modsToInstall.push_back("vcmi-extras");

	if(ui->buttonPresetDemo->isChecked() && checkCanInstallDemo())
		modsToInstall.push_back("demo-support");

	if(ui->buttonPresetWog->isChecked() && checkCanInstallWog())
		modsToInstall.push_back("wake-of-gods");

	if(ui->buttonPresetHota->isChecked() && checkCanInstallHota())
		modsToInstall.push_back("hota");

	if(ui->buttonPresetTow->isChecked() && checkCanInstallTow())
		modsToInstall.push_back("tides-of-war");

	if(ui->buttonPresetFod->isChecked() && checkCanInstallFod())
		modsToInstall.push_back("fallen-of-the-depth");

	bool goToMods = !modsToInstall.empty();
	exitSetup(goToMods);

	for(auto const & modName : modsToInstall)
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
