#pragma once

#include "CWindowObject.h"

#include <functional>
#include <vector>

class CStackInstance;
class CCreature;
class CCreaturePic;
class CLabel;
class CButton;
class GraphicalPrimitiveCanvas;

class CStackExperienceDetailsWindow : public CWindowObject
{
	struct NumericRow
	{
		std::string title;
		std::function<int(const CStackInstance &)> valueGetter;
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
	std::shared_ptr<GraphicalPrimitiveCanvas> currentRankFrame;
	std::vector<std::shared_ptr<CIntObject>> labels;

	static constexpr int MAX_RANKS = 11;

public:
	static int getStackExperienceTierFromCreatureLevel(int creatureLevel);
	static int calculateDynamicTableRowCount(const CStackInstance * stack, const CCreature * creature);
	static ImagePath getDialogBackground(int rowCount);
	CStackExperienceDetailsWindow(const CStackInstance * stack, const CCreature * creature);
};
