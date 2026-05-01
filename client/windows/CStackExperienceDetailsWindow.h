#pragma once

#include "CWindowObject.h"

#include <functional>
#include <vector>

VCMI_LIB_NAMESPACE_BEGIN
class CStackInstance;
class CCreature;
VCMI_LIB_NAMESPACE_END

class CCreaturePic;
class CLabel;
class CButton;
class GraphicalPrimitiveCanvas;

class CStackExperienceDetailsWindow : public CWindowObject
{
	using StackInstance = VCMI_LIB_NAMESPACE::CStackInstance;
	using Creature = VCMI_LIB_NAMESPACE::CCreature;

	struct NumericRow
	{
		std::string title;
		std::function<int(const StackInstance &)> valueGetter;
		bool percent = false;
		bool binary = false;
		bool showSign = true;
	};

	const StackInstance * sourceStack;
	const Creature * creature;

	std::shared_ptr<CLabel> title;
	std::shared_ptr<CLabel> stackSummary;
	std::shared_ptr<CCreaturePic> creatureAnimation;
	std::shared_ptr<CButton> closeButton;
	std::shared_ptr<GraphicalPrimitiveCanvas> currentRankFrame;
	std::vector<std::shared_ptr<CIntObject>> labels;

	static constexpr int MAX_RANKS = 11;

public:
	static int getStackExperienceTierFromCreatureLevel(int creatureLevel);
	static int calculateDynamicTableRowCount(const StackInstance * stack, const Creature * creature);
	static ImagePath getDialogBackground(int rowCount);
	CStackExperienceDetailsWindow(const StackInstance * stack, const Creature * creature);
};
