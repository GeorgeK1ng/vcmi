#pragma once

#include "CCreatureWindow.h"

class CStackWindow::StackExperienceDetailsWindow : public CWindowObject
{
	struct NumericRow
	{
		std::string title;
		std::function<int(const CStackInstance &)> valueGetter;
		ImagePath icon;
		bool hasIcon = false;
		int iconFrame = -1;
		std::string tooltipText;
		std::string popupText;
		bool percent = false;
		bool binary = false;
		bool showSign = true;
	};

	const CStackInstance * sourceStack;
	const CCreature * creature;

	std::shared_ptr<CLabel> title;
	std::shared_ptr<CLabel> stackSummary;
	std::shared_ptr<CCreaturePic> creatureAnimation;
	std::shared_ptr<CButton> closeButton;
	std::shared_ptr<CGStatusBar> statusbar;
	std::shared_ptr<GraphicalPrimitiveCanvas> currentRankFrame;
	std::vector<std::shared_ptr<CIntObject>> labels;
	std::shared_ptr<CSlider> tableSlider;

	static constexpr int MAX_RANKS = 11;

	struct PreparedRow
	{
		std::string title;
		ImagePath icon;
		bool hasIcon = false;
		int iconFrame = -1;
		std::string tooltipText;
		std::string popupText;
		bool percent = false;
		bool binary = false;
		bool showSign = true;
		std::array<int, MAX_RANKS> values{};
	};
	std::vector<PreparedRow> preparedRows;
	std::vector<std::shared_ptr<CIntObject>> tableBackgroundWidgets;
	std::vector<std::shared_ptr<CIntObject>> tableRowWidgets;
	int tableTop = 0;
	int tableRowHeight = 0;
	int tableSideMargin = 0;
	int tableRowNameWidth = 0;
	int tableColWidth = 0;
	int visibleBonusRows = 0;

	void rebuildTableRows();

public:
	static int getStackExperienceTierFromCreatureLevel(int creatureLevel);
	static int calculateDynamicTableRowCount(const CStackInstance * stack, const CCreature * creature);
	static ImagePath getDialogBackground(int rowCount);
	StackExperienceDetailsWindow(const CStackInstance * stack, const CCreature * creature);
};
