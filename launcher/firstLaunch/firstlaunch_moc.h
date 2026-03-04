/*
 * firstlaunch_moc.h, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#pragma once
#include "../StdInc.h"

namespace Ui
{
class FirstLaunchView;
}

class CModListView;
class ProgressOverlay;

class FirstLaunchView : public QWidget
{
	Q_OBJECT

	void changeEvent(QEvent *event) override;
	void resizeEvent(QResizeEvent *event) override;
	CModListView * getModView();
	void applyResponsiveUiScale();

	void setSetupProgress(int progress);
	void enterSetup();
	void activateTabLanguage();
	void activateTabHeroesData();
	void activateTabModPreset();
	void activateTabInfo();
	void activateTab(int tabIndex);
	void activateNextTab();
	void activatePreviousTab();
	bool shouldShowTab(int tabIndex) const;
	bool isDemoDataDetected() const;
	void exitSetup(bool goToMods);
	
	// Tab Language
	void languageSelected(const QString & languageCode);

	// Tab Heroes III Data
	bool heroesDataDetect() const;

	void heroesDataMissing();
	void heroesDataDetected();
	void updateDataOptionState(bool dataDetected);
	void updateDataOptionDetails();

	QString getHeroesInstallDir();
	void extractGogData();
	void extractGogDataAsync(QString filePathBin, QString filePathExe);
	bool performCopyFlow(const QString& path, ProgressOverlay* overlay, bool removeSource);
	void copyHeroesData(const QString & path = {}, bool removeSource = false);
	void copyHeroesDataFromArchive(const QString & archivePath);

	// Tab Mod Preset
	void modPresetUpdate();

	QString findTranslationModName();

	bool checkCanInstallTranslation();
	bool checkCanInstallExtras();
	bool checkCanInstallDemo();
	bool checkCanInstallHota();
	bool checkCanInstallWog();
	bool checkCanInstallTow();
	bool checkCanInstallFod();
	bool checkCanInstallMod(const QString & modID);

public:
	explicit FirstLaunchView(QWidget * parent = nullptr);
	~FirstLaunchView() override;

	// Tab Heroes III Data
	bool heroesDataUpdate();

    bool needPostCopyCheckExe;
    bool needPostCopyCheckBin;

    QString checkFileMagic(const QString &filename, const QString &filter, const QByteArray &magic, const QString &ext, bool &openFailed) const;

public slots:

private slots:

	void on_buttonTabLanguage_clicked();
	void on_buttonTabHeroesData_clicked();
	void on_buttonTabModPreset_clicked();
	void on_listWidgetLanguage_currentRowChanged(int currentRow);
	void on_pushButtonLanguageNext_clicked();
	void on_pushButtonDataNext_clicked();
	void on_pushButtonDataBack_clicked();

	void on_pushButtonDataSearch_clicked();

	void on_pushButtonDataCopy_clicked();

	void on_pushButtonSelect_clicked();

	void on_commandLinkButtonDataDetected_toggled(bool checked);
	void on_commandLinkButtonDataGog_toggled(bool checked);
	void on_commandLinkButtonDataCopy_toggled(bool checked);
	void on_commandLinkButtonDataManual_toggled(bool checked);

	void on_pushButtonPresetBack_clicked();

	void on_pushButtonPresetNext_clicked();

	void on_pushButtonInfoBack_clicked();

	void on_pushButtonFinish_clicked();

	void on_pushButtonDiscord_clicked();

	void on_pushButtonGithub_clicked();

private:
	std::unique_ptr<Ui::FirstLaunchView> ui;
};
