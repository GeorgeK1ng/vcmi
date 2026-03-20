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
#include <QDesktopServices>
#include <QUrlQuery>

// Create and show overlay immediately
static ProgressOverlay* createOverlay(QWidget *parent, const QString &title, bool indeterminate = true)
{
	auto *overlay = new ProgressOverlay(parent, 0);
	overlay->setTitle(title);
	overlay->setIndeterminate(indeterminate);
	overlay->show();
	qApp->processEvents(); // paint before heavy work
	return overlay;
}

namespace
{
constexpr int TAB_LANGUAGE = 0;
constexpr int TAB_DATA = 2;
constexpr int TAB_MOD_PRESET = 3;
constexpr int TAB_INFO = 4;
constexpr int TAB_COUNT = 5;
}

FirstLaunchView::FirstLaunchView(QWidget * parent)
	: QWidget(parent)
	, ui(std::make_unique<Ui::FirstLaunchView>())
{
	ui->setupUi(this);
	applyResponsiveUiScale();

	ui->textBrowserDataDetectedInfo->setOpenLinks(false);
	ui->textBrowserDataGogInfo->setOpenLinks(false);
	ui->textBrowserDataCopyInfo->setOpenLinks(false);
	ui->textBrowserDataManualInfo->setOpenLinks(false);
	connect(ui->textBrowserDataDetectedInfo, &QTextBrowser::anchorClicked, this, &FirstLaunchView::handleDataInfoLink);
	connect(ui->textBrowserDataGogInfo, &QTextBrowser::anchorClicked, this, &FirstLaunchView::handleDataInfoLink);
	connect(ui->textBrowserDataCopyInfo, &QTextBrowser::anchorClicked, this, &FirstLaunchView::handleDataInfoLink);
	connect(ui->textBrowserDataManualInfo, &QTextBrowser::anchorClicked, this, &FirstLaunchView::handleDataInfoLink);

	enterSetup();
	activateTab(TAB_LANGUAGE);

	ui->lineEditDataSystem->setText(pathToQString(boost::filesystem::absolute(VCMIDirs::get().dataPaths().front())));
	ui->lineEditDataUser->setText(pathToQString(boost::filesystem::absolute(VCMIDirs::get().userDataPath())));
	if(ui->verticalSpacer)
		ui->verticalSpacer->changeSize(0, 0, QSizePolicy::Minimum, QSizePolicy::Fixed);
	if(ui->verticalSpacer_2)
		ui->verticalSpacer_2->changeSize(0, 0, QSizePolicy::Minimum, QSizePolicy::Fixed);
	if(ui->verticalSpacer_3)
		ui->verticalSpacer_3->changeSize(0, 0, QSizePolicy::Minimum, QSizePolicy::Fixed);
	if(ui->verticalSpacer_4)
		ui->verticalSpacer_4->changeSize(0, 0, QSizePolicy::Minimum, QSizePolicy::Fixed);
	if(ui->verticalLayout_4)
		ui->verticalLayout_4->invalidate();

	Helper::enableScrollBySwiping(ui->listWidgetLanguage);

#ifdef VCMI_MOBILE
	// This directory is not accessible to players without rooting of their device
	ui->lineEditDataSystem->hide();
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

bool FirstLaunchView::eventFilter(QObject * watched, QEvent * event)
{
	auto getTileContainer = [this](QObject * obj) -> QWidget *
	{
		if(!obj)
			return nullptr;
		const QString containerName = obj->property("tileContainerName").toString();
		if(containerName.isEmpty())
			return nullptr;
		return findChild<QWidget *>(containerName);
	};
	auto getTileButton = [this](QObject * obj) -> QCommandLinkButton *
	{
		if(!obj)
			return nullptr;
		const QString buttonName = obj->property("tileButtonName").toString();
		if(buttonName.isEmpty())
			return nullptr;
		return findChild<QCommandLinkButton *>(buttonName);
	};

	QWidget * container = getTileContainer(watched);
	QCommandLinkButton * button = getTileButton(watched);
	if(!container || !button)
		return QWidget::eventFilter(watched, event);

	if(event->type() == QEvent::Enter)
	{
		container->setProperty("tileHovered", true);
		updateDataOptionTileVisuals();
	}
	else if(event->type() == QEvent::Leave)
	{
		container->setProperty("tileHovered", false);
		updateDataOptionTileVisuals();
	}
	else if(event->type() == QEvent::MouseButtonPress)
	{
		QTextBrowser * info = qobject_cast<QTextBrowser *>(watched);
		if(!info)
		{
			if(auto * viewport = qobject_cast<QWidget *>(watched))
				info = qobject_cast<QTextBrowser *>(viewport->parentWidget());
		}
		if(info)
		{
			auto * mouseEvent = static_cast<QMouseEvent *>(event);
			const QPoint pos = info->mapFromGlobal(static_cast<QWidget *>(watched)->mapToGlobal(mouseEvent->pos()));
			if(!info->anchorAt(pos).isEmpty())
				return QWidget::eventFilter(watched, event);
		}

		if(button->isEnabled())
		{
			button->setChecked(true);
			updateDataOptionDetails();
			updateDataOptionTileVisuals();

			// Keep tile selection on click, but let text browser process the event for scrolling/focus.
			if(info)
				return QWidget::eventFilter(watched, event);
			return true;
		}
	}

	return QWidget::eventFilter(watched, event);
}

void FirstLaunchView::applyResponsiveUiScale()
{
	const int baseHeight = 520;
	const int minHeight = 1;
	const int clampedHeight = std::max(minHeight, height());
	#ifdef VCMI_MOBILE
	const bool compactScreen = true;
#else
	const bool compactScreen = (width() < 900 || height() < 620);
#endif
	const qreal maxScale = compactScreen ? 1.20 : 1.45;
	const qreal minScale = compactScreen ? 1.00 : 0.85;
	const qreal scale = std::clamp(static_cast<qreal>(clampedHeight) / static_cast<qreal>(baseHeight), minScale, maxScale);

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
			multiplier = compactScreen ? 1.16 : 1.20;
		else if(qobject_cast<QTextBrowser *>(widget))
			multiplier = compactScreen ? 1.14 : 1.10;
		else if(qobject_cast<QPushButton *>(widget))
			multiplier = compactScreen ? 1.14 : 1.05;
		else if(qobject_cast<QToolButton *>(widget))
			multiplier = compactScreen ? 1.12 : 1.05;

		f.setPointSizeF(basePointSize * scale * multiplier);
		widget->setFont(f);
	}

	ui->listWidgetLanguage->setMinimumHeight(0);

	const int pageMargin = compactScreen ? 6 : 12;
	if(ui->verticalLayoutLanguagePage)
	{
		ui->verticalLayoutLanguagePage->setContentsMargins(pageMargin, pageMargin, pageMargin, pageMargin);
		ui->verticalLayoutLanguagePage->setSpacing(compactScreen ? 4 : 6);
	}
	if(ui->verticalLayoutWelcomePage)
	{
		ui->verticalLayoutWelcomePage->setContentsMargins(pageMargin, pageMargin, pageMargin, pageMargin);
		ui->verticalLayoutWelcomePage->setSpacing(compactScreen ? 4 : 6);
	}
	if(ui->verticalLayout_4)
	{
		ui->verticalLayout_4->setContentsMargins(pageMargin, pageMargin, pageMargin, pageMargin);
		ui->verticalLayout_4->setSpacing(compactScreen ? 4 : 6);
	}
	if(ui->verticalLayout_3)
	{
		ui->verticalLayout_3->setContentsMargins(pageMargin, pageMargin, pageMargin, pageMargin);
		ui->verticalLayout_3->setSpacing(compactScreen ? 4 : 6);
	}
	if(ui->verticalLayoutInfoPage)
	{
		ui->verticalLayoutInfoPage->setContentsMargins(pageMargin, pageMargin, pageMargin, pageMargin);
		ui->verticalLayoutInfoPage->setSpacing(compactScreen ? 4 : 6);
	}

	const int titleHeight = ui->labelLanguageTitle->sizeHint().height();
	const int navHeight = ui->pushButtonLanguageNext->sizeHint().height();
	const int chromePadding = pageMargin * 2 + (compactScreen ? 24 : 36);
	const int availableListHeight = std::max(compactScreen ? 36 : 60, ui->installerTabs->height() - titleHeight - navHeight - chromePadding);
	ui->listWidgetLanguage->setMaximumHeight(availableListHeight);
	const int navMinHeightPx = compactScreen ? std::max(34, static_cast<int>(std::round(40 * scale))) : std::max(28, static_cast<int>(std::round(30 * scale)));
	const int navButtonWidthPx = compactScreen ? std::max(120, static_cast<int>(std::round(156 * scale))) : std::max(92, static_cast<int>(std::round(112 * scale)));
	const int navMaxHeightPx = compactScreen ? std::max(navMinHeightPx, static_cast<int>(std::round(56 * scale))) : static_cast<int>(std::round(44 * scale));

	auto applyNavigationButtonScale = [&](QPushButton * button)
	{
		if(!button)
			return;

		button->setMinimumHeight(navMinHeightPx);
		button->setMinimumWidth(navButtonWidthPx);
		button->setMaximumWidth(navButtonWidthPx);
		button->setMaximumHeight(navMaxHeightPx);
	};

	auto applyActionButtonScale = [&](QPushButton * button)
	{
		if(!button)
			return;
		button->setMinimumHeight(navMinHeightPx);
		button->setMaximumHeight(navMaxHeightPx);
	};


	const int dataRows = 2;
	const int dataGridSpacing = ui->gridLayout ? std::max(0, ui->gridLayout->verticalSpacing()) : 6;
	const int dataChromePadding = pageMargin * 2 + titleHeight + navHeight + (compactScreen ? 20 : 16);
	const int availableDataHeight = std::max(compactScreen ? 260 : 220, ui->installerTabs->height() - dataChromePadding);
	const int dataTileTotalHeightPx = std::max(compactScreen ? 120 : 100, (availableDataHeight - dataGridSpacing * (dataRows - 1)) / dataRows);
	const int dataTileButtonHeightPx = std::clamp(static_cast<int>(std::round(dataTileTotalHeightPx * 0.12)), 22, 40);
	const int dataTileInfoHeightPx = std::max(56, dataTileTotalHeightPx - dataTileButtonHeightPx);

	auto applyDataOptionButtonScale = [dataTileButtonHeightPx](QCommandLinkButton * button)
	{
		if(!button)
			return;
		button->setMinimumHeight(dataTileButtonHeightPx);
		button->setMaximumHeight(dataTileButtonHeightPx);
		const int iconSide = std::max(16, static_cast<int>(std::round(dataTileButtonHeightPx * 0.72)));
		button->setIconSize(QSize(iconSide, iconSide));
	};

	auto applyDataInfoScale = [dataTileInfoHeightPx](QTextBrowser * text)
	{
		if(!text)
			return;
		text->setMinimumHeight(dataTileInfoHeightPx);
		text->setMaximumHeight(dataTileInfoHeightPx);
	};

	if(ui->installerTabs->currentIndex() == TAB_DATA)
	{
		applyDataOptionButtonScale(ui->commandLinkButtonDataDetected);
		applyDataOptionButtonScale(ui->commandLinkButtonDataGog);
		applyDataOptionButtonScale(ui->commandLinkButtonDataCopy);
		applyDataOptionButtonScale(ui->commandLinkButtonDataManual);
		applyDataInfoScale(ui->textBrowserDataDetectedInfo);
		applyDataInfoScale(ui->textBrowserDataGogInfo);
		applyDataInfoScale(ui->textBrowserDataCopyInfo);
		applyDataInfoScale(ui->textBrowserDataManualInfo);
	}

	applyNavigationButtonScale(ui->pushButtonLanguageNext);
	applyNavigationButtonScale(ui->pushButtonWelcomeBack);
	applyNavigationButtonScale(ui->pushButtonWelcomeNext);
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

void FirstLaunchView::on_pushButtonWelcomeBack_clicked()
{
	activatePreviousTab();
}

void FirstLaunchView::on_pushButtonWelcomeNext_clicked()
{
	activateNextTab();
}

void FirstLaunchView::on_pushButtonDataNext_clicked()
{
	if(ui->commandLinkButtonDataManual->isChecked())
	{
		if(heroesDataUpdate() || isDemoDataDetected())
			activateNextTab();
		return;
	}

	// For detected/copy/GOG modes, Next triggers import/select action directly on this page.
	on_pushButtonSelect_clicked();
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
	selectCopyDataSource();
}

void FirstLaunchView::on_pushButtonSelect_clicked()
{
	if(ui->commandLinkButtonDataDetected->isChecked() && ui->commandLinkButtonDataDetected->isEnabled())
	{
		const QString installPath = getHeroesInstallDir();
		if(!installPath.isEmpty())
			copyHeroesData(installPath, false);
		return;
	}

	if(ui->commandLinkButtonDataManual->isChecked())
	{
		heroesDataUpdate();
		return;
	}

	if(ui->commandLinkButtonDataCopy->isChecked())
	{
		selectCopyDataSource();
		return;
	}

	// iOS can't display modal dialogs when called directly on button press
	// https://bugreports.qt.io/browse/QTBUG-98651
	MessageBoxCustom::showDialog(this, [this]{extractGogData();});
}

void FirstLaunchView::selectCopyDataSource()
{
	const bool canUseFolderImport = Helper::canUseFolderPicker();

	if(!canUseFolderImport)
	{
		MessageBoxCustom::information(this,
			tr("ZIP selection"),
			tr("Folder picker is unavailable on this platform. Please select a ZIP archive that contains Heroes III data files."));
		const QString archivePath = QFileDialog::getOpenFileName(this, tr("Select ZIP archive with Heroes III data"), QString{}, tr("ZIP archives (*.zip)"));
		if(!archivePath.isEmpty())
			copyHeroesDataFromArchive(archivePath);
		return;
	}

	MessageBoxCustom::showDialog(this, [this]{
		QMessageBox msgBox(this);
		msgBox.setWindowTitle(tr("Import source"));
		msgBox.setText(tr("How do you want to import Heroes III data?"));
		QAbstractButton * folderButton = msgBox.addButton(tr("Folder"), QMessageBox::AcceptRole);
		QAbstractButton * zipButton = msgBox.addButton(tr("ZIP archive"), QMessageBox::AcceptRole);
		msgBox.addButton(QMessageBox::Cancel);
		msgBox.exec();

		if(msgBox.clickedButton() == folderButton)
		{
			MessageBoxCustom::information(this,
				tr("Folder selection"),
				tr("Please select the Heroes III installation folder.\nAfter confirmation, folder selection will open."));
			MessageBoxCustom::showDialog(this, [this]{
				Helper::nativeFolderPicker(this, [this](const QString &picked){
					if(!picked.isEmpty())
						copyHeroesData(picked, false);
				});
			});
			return;
		}

		if(msgBox.clickedButton() == zipButton)
		{
			MessageBoxCustom::information(this,
				tr("ZIP selection"),
				tr("Please select a ZIP archive that contains Heroes III data files."));
			const QString archivePath = QFileDialog::getOpenFileName(this, tr("Select ZIP archive with Heroes III data"), QString{}, tr("ZIP archives (*.zip)"));
			if(!archivePath.isEmpty())
				copyHeroesDataFromArchive(archivePath);
		}
	});
}

void FirstLaunchView::on_commandLinkButtonDataDetected_toggled(bool checked)
{
	if(checked)
		updateDataOptionDetails();
	updateDataOptionTileVisuals();
}

void FirstLaunchView::on_commandLinkButtonDataGog_toggled(bool checked)
{
	if(checked)
		updateDataOptionDetails();
	updateDataOptionTileVisuals();
}

void FirstLaunchView::on_commandLinkButtonDataCopy_toggled(bool checked)
{
	if(checked)
		updateDataOptionDetails();
	updateDataOptionTileVisuals();
}

void FirstLaunchView::on_commandLinkButtonDataManual_toggled(bool checked)
{
	if(checked)
		updateDataOptionDetails();
	updateDataOptionTileVisuals();
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
	applyResponsiveUiScale();

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


void FirstLaunchView::layoutDataOptionWidgets(bool hasDetectedInstall, bool canUseGogInstall, bool canUseDataCopy)
{
	QGridLayout * grid = ui->gridLayout;
	if(!grid)
		return;

	auto ensureTileContainer = [this](const QString & objectName, QCommandLinkButton * button, QTextBrowser * info)
	{
		QWidget * container = findChild<QWidget *>(objectName);
		if(container)
			return container;

		container = new QWidget(this);
		container->setObjectName(objectName);
		container->setProperty("tileHovered", false);
		container->setProperty("tileChecked", false);
		container->setProperty("tileEnabled", true);
		container->setProperty("tileContainerName", objectName);
		container->setProperty("tileButtonName", button->objectName());

		button->setProperty("tileContainerName", objectName);
		button->setProperty("tileButtonName", button->objectName());
		button->setCursor(Qt::PointingHandCursor);
		button->setStyleSheet(QStringLiteral("QCommandLinkButton{border:none;background:transparent;padding:0px 2px;}"));

		info->setProperty("tileContainerName", objectName);
		info->setProperty("tileButtonName", button->objectName());
		info->setFrameShape(QFrame::NoFrame);
		info->setCursor(Qt::PointingHandCursor);
		info->setStyleSheet(QStringLiteral("QTextBrowser{border:none;background:transparent;}"));
		info->setOpenExternalLinks(false);
		if(info->viewport())
		{
			info->viewport()->setProperty("tileContainerName", objectName);
			info->viewport()->setProperty("tileButtonName", button->objectName());
			info->viewport()->setCursor(Qt::PointingHandCursor);
		}

		container->installEventFilter(this);
		button->installEventFilter(this);
		info->installEventFilter(this);
		if(info->viewport())
			info->viewport()->installEventFilter(this);

		auto * containerLayout = new QVBoxLayout(container);
		containerLayout->setContentsMargins(8, 6, 8, 6);
		containerLayout->setSpacing(2);
		containerLayout->addWidget(button);
		containerLayout->addWidget(info);
		return container;
	};

	struct OptionWidgets
	{
		QWidget * container;
		QCommandLinkButton * button;
		QTextBrowser * info;
		bool available;
	};

	const QVector<OptionWidgets> options = {
		{ ensureTileContainer(QStringLiteral("dataOptionTileDetected"), ui->commandLinkButtonDataDetected, ui->textBrowserDataDetectedInfo), ui->commandLinkButtonDataDetected, ui->textBrowserDataDetectedInfo, hasDetectedInstall },
		{ ensureTileContainer(QStringLiteral("dataOptionTileGog"), ui->commandLinkButtonDataGog, ui->textBrowserDataGogInfo), ui->commandLinkButtonDataGog, ui->textBrowserDataGogInfo, canUseGogInstall },
		{ ensureTileContainer(QStringLiteral("dataOptionTileCopy"), ui->commandLinkButtonDataCopy, ui->textBrowserDataCopyInfo), ui->commandLinkButtonDataCopy, ui->textBrowserDataCopyInfo, canUseDataCopy },
		{ ensureTileContainer(QStringLiteral("dataOptionTileManual"), ui->commandLinkButtonDataManual, ui->textBrowserDataManualInfo), ui->commandLinkButtonDataManual, ui->textBrowserDataManualInfo, true }
	};

	QVector<OptionWidgets> availableOptions;
	for(const OptionWidgets & option : options)
	{
		grid->removeWidget(option.container);
		option.container->setVisible(false);
		option.button->setEnabled(option.available);
		if(option.available)
			availableOptions.push_back(option);
	}

	for(int i = 0; i < availableOptions.size(); ++i)
	{
		const OptionWidgets & option = availableOptions[i];
		const int tileRow = 2 + i / 2;
		const int col = (i % 2 == 0) ? 0 : 2;
		grid->addWidget(option.container, tileRow, col, 1, 2);
		option.container->setVisible(true);
	}

	updateDataOptionTileVisuals();
}

void FirstLaunchView::updateDataOptionTileVisuals()
{
	updateDataOptionIcons();

	const QVector<QPair<QString, QCommandLinkButton *>> tiles = {
		{ QStringLiteral("dataOptionTileDetected"), ui->commandLinkButtonDataDetected },
		{ QStringLiteral("dataOptionTileGog"), ui->commandLinkButtonDataGog },
		{ QStringLiteral("dataOptionTileCopy"), ui->commandLinkButtonDataCopy },
		{ QStringLiteral("dataOptionTileManual"), ui->commandLinkButtonDataManual }
	};

	for(const auto & tile : tiles)
	{
		QWidget * container = findChild<QWidget *>(tile.first);
		if(!container)
			continue;

		container->setProperty("tileChecked", tile.second->isChecked());
		container->setProperty("tileEnabled", tile.second->isEnabled());
		container->style()->unpolish(container);
		container->style()->polish(container);
		container->setStyleSheet(QStringLiteral(R"(
			QWidget[tileEnabled="true"] { border: 1px solid palette(mid); border-radius: 8px; background: palette(base); }
			QWidget[tileEnabled="true"][tileHovered="true"] { border: 1px solid palette(highlight); background: palette(alternate-base); }
			QWidget[tileEnabled="true"][tileChecked="true"] { border: 2px solid palette(highlight); background: palette(alternate-base); }
			QWidget[tileEnabled="false"] { border: 1px solid palette(dark); border-radius: 8px; background: palette(window); }
		)"));
	}
}

void FirstLaunchView::updateDataOptionIcons()
{
	auto makeStateIcon = [this](QStyle::StandardPixmap normal, QStyle::StandardPixmap checked, QStyle::StandardPixmap disabled)
	{
		QIcon icon;
		icon.addPixmap(style()->standardPixmap(normal), QIcon::Normal, QIcon::Off);
		icon.addPixmap(style()->standardPixmap(checked), QIcon::Normal, QIcon::On);
		icon.addPixmap(style()->standardPixmap(checked), QIcon::Active, QIcon::On);
		icon.addPixmap(style()->standardPixmap(disabled), QIcon::Disabled, QIcon::Off);
		icon.addPixmap(style()->standardPixmap(disabled), QIcon::Disabled, QIcon::On);
		return icon;
	};

	ui->commandLinkButtonDataDetected->setIcon(makeStateIcon(QStyle::SP_DirOpenIcon, QStyle::SP_DialogApplyButton, QStyle::SP_MessageBoxWarning));
	ui->commandLinkButtonDataGog->setIcon(makeStateIcon(QStyle::SP_DriveNetIcon, QStyle::SP_DialogApplyButton, QStyle::SP_MessageBoxWarning));
	ui->commandLinkButtonDataCopy->setIcon(makeStateIcon(QStyle::SP_FileDialogStart, QStyle::SP_DialogApplyButton, QStyle::SP_MessageBoxWarning));
	ui->commandLinkButtonDataManual->setIcon(makeStateIcon(QStyle::SP_FileDialogDetailedView, QStyle::SP_DialogApplyButton, QStyle::SP_BrowserReload));
}

void FirstLaunchView::updateDataOptionState(bool dataDetected)
{
	const QString installPath = getHeroesInstallDir();
	const bool hasDetectedInstall = !installPath.isEmpty();
	auto folderLink = [](const QString & path)
	{
		const QString encodedPath = QString::fromUtf8(QUrl::toPercentEncoding(path));
#ifdef Q_OS_WIN
		const QString label = tr("Open in Explorer");
#else
		const QString label = tr("Open location");
#endif
		return QStringLiteral("<a href=\"vcmi-open-folder://open?path=%1\">%2</a>").arg(encodedPath, label.toHtmlEscaped());
	};

#ifdef ENABLE_INNOEXTRACT
	const bool canUseGogInstall = true;
#else
	const bool canUseGogInstall = false;
#endif
	// Copy option supports folder import and ZIP import; ZIP works even where folder picker is unavailable.
	const bool canUseDataCopy = true;

	layoutDataOptionWidgets(hasDetectedInstall, canUseGogInstall, canUseDataCopy);

	ui->commandLinkButtonDataDetected->setDescription(QStringLiteral(" "));
	ui->commandLinkButtonDataGog->setDescription(QStringLiteral(" "));
	ui->commandLinkButtonDataCopy->setDescription(QStringLiteral(" "));
	ui->commandLinkButtonDataManual->setDescription(QStringLiteral(" "));
	ui->labelDataFiles->setVisible(false);
	ui->lineEditDataUser->setVisible(false);
	ui->lineEditDataSystem->setVisible(false);

	ui->textBrowserDataDetectedInfo->setHtml(hasDetectedInstall
		? tr("<p>Use the Heroes III installation detected on this device.</p>"
			"<p>VCMI will copy the required data into its own folders.</p>"
			"<p><b>Source folder:</b> %1</p>").arg(folderLink(installPath))
		: tr("<p><i>Not available: no compatible Heroes III installation was detected.</i></p>"));

	ui->textBrowserDataGogInfo->setHtml(canUseGogInstall
		? tr(R"(<p>Import data from the offline GOG installer for <a href="https://www.gog.com/en/game/heroes_of_might_and_magic_3_complete_edition">Heroes III Complete Edition on GOG.com</a> (<code>.exe</code> + <code>.bin</code>).</p>
<p>Direct links:</p>
<ul>
<li><a href="https://www.gog.com/downloads/heroes_of_might_and_magic_3_complete_edition/en1installer0">Installer EXE (en1installer0)</a></li>
<li><a href="https://www.gog.com/downloads/heroes_of_might_and_magic_3_complete_edition/en1installer1">Installer BIN (en1installer1)</a></li>
</ul>)")
		: tr("<p><i>Not available on this platform/build.</i></p>"));

	const bool canUseFolderImport = Helper::canUseFolderPicker();
	ui->textBrowserDataCopyInfo->setHtml(canUseFolderImport
		? tr("<p>Import from a Heroes III backup in a folder or ZIP archive.</p>"
			"<p>You can use Heroes III Complete or older Shadow of Death data.</p>"
			"<p>VCMI will verify the source and copy the required files automatically.</p>")
		: tr("<p>Folder import is unavailable on this platform.</p>"
			"<p>Please select a ZIP archive with Heroes III data files.</p>"
			"<p>VCMI will verify the source and copy the required files automatically.</p>"));

	const QString manualUserPath = ui->lineEditDataUser->text();
	const QString manualSystemPath = ui->lineEditDataSystem->text();
	ui->textBrowserDataManualInfo->setHtml(tr(R"(
	<p>Copy Heroes III game files manually, then press <b>Scan again</b>.</p>
	<p>Target folders:</p>
	<p><b>User folder:</b> %1</p>
	<p><b>System folder:</b> %2</p>
	<p>Setup guide: <a href="https://wiki.vcmi.eu/Installation">VCMI Installation</a>.</p>
	)").arg(folderLink(manualUserPath), folderLink(manualSystemPath)));

	const bool hasAnySelection = ui->commandLinkButtonDataDetected->isChecked()
		|| ui->commandLinkButtonDataGog->isChecked()
		|| ui->commandLinkButtonDataCopy->isChecked()
		|| ui->commandLinkButtonDataManual->isChecked();

	const bool selectedOptionUnavailable = (ui->commandLinkButtonDataDetected->isChecked() && !hasDetectedInstall)
		|| (ui->commandLinkButtonDataGog->isChecked() && !canUseGogInstall)
		|| (ui->commandLinkButtonDataCopy->isChecked() && !canUseDataCopy);

	if(dataDetected && hasDetectedInstall)
	{
		ui->commandLinkButtonDataDetected->setChecked(true);
	}
	else if(!hasAnySelection || selectedOptionUnavailable)
	{
		if(hasDetectedInstall)
			ui->commandLinkButtonDataDetected->setChecked(true);
		else if(canUseGogInstall)
			ui->commandLinkButtonDataGog->setChecked(true);
		else if(canUseDataCopy)
			ui->commandLinkButtonDataCopy->setChecked(true);
		else
			ui->commandLinkButtonDataManual->setChecked(true);
	}

	updateDataOptionDetails();
}

void FirstLaunchView::updateDataOptionDetails()
{
	ui->pushButtonSelect->setVisible(false);

	const bool detectedSelectedAndAvailable = ui->commandLinkButtonDataDetected->isChecked() && ui->commandLinkButtonDataDetected->isEnabled();
	const bool gogSelectedAndAvailable = ui->commandLinkButtonDataGog->isChecked() && ui->commandLinkButtonDataGog->isEnabled();
	const bool copySelectedAndAvailable = ui->commandLinkButtonDataCopy->isChecked() && ui->commandLinkButtonDataCopy->isEnabled();
	const bool manualSelected = ui->commandLinkButtonDataManual->isChecked();

	ui->pushButtonDataNext->setText(manualSelected ? tr("Scan again") : tr("Next"));
	ui->pushButtonDataNext->setEnabled(detectedSelectedAndAvailable || gogSelectedAndAvailable || copySelectedAndAvailable || manualSelected || isDemoDataDetected());

	updateDataOptionTileVisuals();
}

void FirstLaunchView::handleDataInfoLink(const QUrl & url)
{
	if(url.scheme() != QLatin1String("vcmi-open-folder"))
	{
		QDesktopServices::openUrl(url);
		return;
	}

	QUrlQuery query(url);
	const QString path = QUrl::fromPercentEncoding(query.queryItemValue(QStringLiteral("path")).toUtf8());
	if(path.isEmpty())
		return;

	const QUrl localUrl = QUrl::fromLocalFile(path);
	if(QDesktopServices::openUrl(localUrl))
		return;

	QMessageBox::warning(
		this,
		tr("Cannot open folder"),
		tr("Could not open this location in the system file manager:\n%1").arg(path));
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
		QScopedPointer<ProgressOverlay> overlay(createOverlay(this, tr("Preparing installer..."), false));
		overlay->setRange(2);
		overlay->setValue(0);
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
		overlay->setValue(1);

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
		overlay->setValue(2);

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

	QPointer<ProgressOverlay> overlay = createOverlay(this, tr("Preparing ZIP archive..."), false);
	overlay->setFileName(Helper::getRealPath(archivePath));
	overlay->setRange(1);
	overlay->setValue(0);
	overlay->raise();
	qApp->processEvents();

	// Ensure overlay is painted before potentially slow native copy from URI/content provider.
	QEventLoop ev;
	QTimer::singleShot(0, &ev, &QEventLoop::quit);
	ev.exec();

	const QString tempArchivePath = tempDir.filePath("import_data.zip");
	if(!Helper::performNativeCopy(archivePath, tempArchivePath))
	{
		overlay->deleteLater();
		QMessageBox::critical(this, tr("Extraction error"), tr("Failed to access selected ZIP archive. Please copy ZIP to accessible storage and try again."));
		return;
	}
	overlay->setValue(1);

	overlay->setTitle(tr("Extracting ZIP archive..."));
	overlay->setFileName({});
	overlay->setIndeterminate(true);

	bool extracted = false;
	try
	{
		ZipArchive archive(qstringToPath(tempArchivePath));
		const auto files = archive.listFiles();
		extracted = archive.extract(qstringToPath(tempDir.path()), files);
	}
	catch(const std::exception &e)
	{
		overlay->deleteLater();
		QMessageBox::critical(this, tr("Extraction error"), tr("Failed to read ZIP archive: %1").arg(QString::fromUtf8(e.what())));
		return;
	}

	if(!extracted)
	{
		overlay->deleteLater();
		QMessageBox::critical(this, tr("Extraction error"), tr("Failed to extract ZIP archive."));
		return;
	}

	overlay->setTitle(tr("Scanning selected folder..."));
	overlay->setFileName({});
	overlay->setIndeterminate(true);

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
