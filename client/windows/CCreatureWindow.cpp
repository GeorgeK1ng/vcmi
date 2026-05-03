/*
 * CCreatureWindow.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "CCreatureWindow.h"
#include "CStackExperienceDetailsWindow.h"

#include <vcmi/spells/Spell.h>
#include <vcmi/spells/Service.h>

#include "../CPlayerInterface.h"
#include "../render/Canvas.h"
#include "../render/CanvasImage.h"
#include "../render/CAnimation.h"
#include "../render/IImage.h"
#include "../render/IRenderHandler.h"
#include "../render/ImageLocator.h"
#include "../widgets/Buttons.h"
#include "../widgets/CComponent.h"
#include "../widgets/CComponentHolder.h"
#include "../widgets/GraphicalPrimitiveCanvas.h"
#include "../widgets/Images.h"
#include "../widgets/TextControls.h"
#include "../widgets/ObjectLists.h"
#include "../widgets/Slider.h"
#include "../widgets/GraphicalPrimitiveCanvas.h"
#include "../windows/GUIClasses.h"
#include "../windows/InfoWindows.h"
#include "../gui/WindowHandler.h"
#include "../GameEngine.h"
#include "../GameInstance.h"
#include "../gui/Shortcut.h"
#include "../battle/BattleInterface.h"

#include "../../lib/CBonusTypeHandler.h"
#include "../../lib/CStack.h"
#include "../../lib/GameLibrary.h"
#include "../../lib/IGameSettings.h"
#include "../../lib/bonuses/Propagators.h"
#include "../../lib/callback/CCallback.h"
#include "../../lib/entities/artifact/ArtifactUtils.h"
#include "../../lib/entities/hero/CHeroHandler.h"
#include "../../lib/gameState/CGameState.h"
#include "../../lib/gameState/UpgradeInfo.h"
#include "../../lib/networkPacks/ArtifactLocation.h"
#include "../../lib/texts/CGeneralTextHandler.h"
#include "../../lib/texts/TextOperations.h"
#include "../../lib/texts/Languages.h"

CStackWindow::MainSection::MainSection(CStackWindow * owner, int yOffset, bool showExp, bool showArt)
	: CWindowSection(owner, getBackgroundName(showExp, showArt), yOffset)
{
	OBJECT_CONSTRUCTION;

	statNames =
	{
		LIBRARY->generaltexth->primarySkillNames[0], //ATTACK
		LIBRARY->generaltexth->primarySkillNames[1],//DEFENCE
		LIBRARY->generaltexth->allTexts[198],//SHOTS
		LIBRARY->generaltexth->allTexts[199],//DAMAGE

		LIBRARY->generaltexth->allTexts[388],//HEALTH
		LIBRARY->generaltexth->allTexts[200],//HEALTH_LEFT
		LIBRARY->generaltexth->zelp[441].first,//SPEED
		LIBRARY->generaltexth->allTexts[399]//MANA
	};

	statFormats =
	{
		"%d (%d)",
		"%d (%d)",
		"%d (%d)",
		"%d - %d",

		"%d (%d)",
		"%d (%d)",
		"%d (%d)",
		"%d (%d)"
	};

	animation = std::make_shared<CCreaturePic>(5, 41, parent->info->creature);
	animationArea = std::make_shared<LRClickableArea>(Rect(5, 41, 100, 130), nullptr, [&]{
		if(!parent->info->creature->getDescriptionTranslated().empty())
			CRClickPopup::createAndPush(parent->info->creature->getDescriptionTranslated());
	});


	if(parent->info->stackNode != nullptr && parent->info->commander == nullptr)
	{
		//normal stack, not a commander and not non-existing stack (e.g. recruitment dialog)
		animation->setAmount(parent->info->creatureCount);
	}

	name = std::make_shared<CLabel>(215, 13, FONT_SMALL, ETextAlignment::CENTER, Colors::YELLOW,
		parent->info->getName() + (parent->info->commander && !parent->info->commander->alive ? (" {red|(" + LIBRARY->generaltexth->translate("vcmi.battleWindow.killed") + ")}") : "")
	);

	const CStack* battleStack = parent->info->stack;

	int dmgMultiply = 1;
	if (battleStack != nullptr && battleStack->hasBonusOfType(BonusType::SIEGE_WEAPON))
	{
		static const auto bonusSelector =
			Selector::sourceTypeSel(BonusSource::ARTIFACT).Or(
			Selector::sourceTypeSel(BonusSource::HERO_BASE_SKILL)).And(
			Selector::typeSubtype(BonusType::PRIMARY_SKILL, BonusSubtypeID(PrimarySkill::ATTACK)));

		dmgMultiply += battleStack->valOfBonuses(bonusSelector);
	}
		
	icons = std::make_shared<CPicture>(ImagePath::builtin("stackWindow/icons"), 117, 32);

	morale = std::make_shared<MoraleLuckBox>(true, Rect(Point(321, 32), Point(42, 42) ));
	luck = std::make_shared<MoraleLuckBox>(false,  Rect(Point(375, 32), Point(42, 42) ));

	if(battleStack != nullptr) // in battle
	{
		addStatLabel(EStat::ATTACK, parent->info->creature->getAttack(battleStack->isShooter()), battleStack->getAttack(battleStack->isShooter()));
		addStatLabel(EStat::DEFENCE, parent->info->creature->getDefense(battleStack->isShooter()), battleStack->getDefense(battleStack->isShooter()));
		addStatLabel(EStat::DAMAGE, parent->info->stackNode->getMinDamage(battleStack->isShooter()) * dmgMultiply, battleStack->getMaxDamage(battleStack->isShooter()) * dmgMultiply);
		addStatLabel(EStat::HEALTH, parent->info->creature->getMaxHealth(), battleStack->getMaxHealth());
		addStatLabel(EStat::SPEED, parent->info->creature->getMovementRange(), battleStack->getMovementRange());

		if(battleStack->isShooter())
			addStatLabel(EStat::SHOTS, battleStack->shots.total(), battleStack->shots.available());
		if(battleStack->isCaster())
			addStatLabel(EStat::MANA, battleStack->casts.total(), battleStack->casts.available());
		addStatLabel(EStat::HEALTH_LEFT, battleStack->getFirstHPleft());

		morale->set(battleStack);
		luck->set(battleStack);
	}
	else
	{
		const bool shooter = parent->info->stackNode->hasBonusOfType(BonusType::SHOOTER) && parent->info->stackNode->valOfBonuses(BonusType::SHOTS);
		const bool caster = parent->info->stackNode->valOfBonuses(BonusType::CASTS);

		addStatLabel(EStat::ATTACK, parent->info->creature->getAttack(shooter), parent->info->stackNode->getAttack(shooter));
		addStatLabel(EStat::DEFENCE, parent->info->creature->getDefense(shooter), parent->info->stackNode->getDefense(shooter));
		addStatLabel(EStat::DAMAGE, parent->info->stackNode->getMinDamage(shooter), parent->info->stackNode->getMaxDamage(shooter));
		addStatLabel(EStat::HEALTH, parent->info->creature->getMaxHealth(), parent->info->stackNode->getMaxHealth());
		addStatLabel(EStat::SPEED, parent->info->creature->getMovementRange(), parent->info->stackNode->getMovementRange());

		if(shooter)
			addStatLabel(EStat::SHOTS, parent->info->stackNode->valOfBonuses(BonusType::SHOTS));
		if(caster)
			addStatLabel(EStat::MANA, parent->info->stackNode->valOfBonuses(BonusType::CASTS));

		morale->set(parent->info->stackNode);
		luck->set(parent->info->stackNode);
	}

	if(showExp)
	{
		const CStackInstance * stack = parent->info->stackNode;
		Point pos = showArt ? Point(321, 111) : Point(349, 111);
		if(parent->info->commander)
		{
			const CCommanderInstance * commander = parent->info->commander;
			expRankIcon = std::make_shared<CAnimImage>(AnimationPath::builtin("PSKIL42"), 4, 0, pos.x, pos.y);

			auto area = std::make_shared<LRClickableAreaWTextComp>(Rect(pos.x, pos.y, 44, 44), ComponentType::EXPERIENCE);
			expArea = area;
			area->text = LIBRARY->generaltexth->allTexts[2];
			area->component.value = commander->getExpRank();
			boost::replace_first(area->text, "%d", std::to_string(commander->getExpRank()));
			boost::replace_first(area->text, "%d", std::to_string(LIBRARY->heroh->reqExp(commander->getExpRank() + 1)));
			boost::replace_first(area->text, "%d", std::to_string(commander->getAverageExperience()));
		}
		else
		{
			expRankIcon = std::make_shared<CAnimImage>(AnimationPath::builtin("stackWindow/levels"), stack->getExpRank(), 0, pos.x, pos.y - 2);
			expArea = std::make_shared<LRClickableArea>(Rect(pos.x, pos.y, 44, 44),
				[this]()
				{
					parent->showStackExperienceDetailsWindow();
				},
				[this]()
				{
					parent->showStackExperienceDetailsWindow();
				});
		}
		expLabel = std::make_shared<CLabel>(
				pos.x + 21, pos.y + 55, FONT_SMALL, ETextAlignment::CENTER, Colors::WHITE,
				TextOperations::formatMetric(stack->getAverageExperience(), 6));
	}

	if(showArt)
	{
		Point pos = showExp ? Point(373, 109) : Point(347, 109);
		// ALARMA: do not refactor this into a separate function
		// otherwise, artifact icon is drawn near the hero's portrait
		// this is really strange
		auto art = parent->info->stackNode->getArt(ArtifactPosition::CREATURE_SLOT);
		if(art)
		{
			parent->stackArtifact = std::make_shared<CArtPlace>(pos, art->getTypeId());
			parent->stackArtifact->setShowPopupCallback([](CComponentHolder & artPlace, const Point & cursorPosition)
				{
					artPlace.LRClickableAreaWTextComp::showPopupWindow(cursorPosition);
				});
			if(parent->info->owner)
			{
				parent->stackArtifactButton = std::make_shared<CButton>(
						Point(pos.x , pos.y + 47), AnimationPath::builtin("stackWindow/cancelButton"),
						CButton::tooltipLocalized("vcmi.creatureWindow.returnArtifact"),	[this]()
				{
					parent->removeStackArtifact(ArtifactPosition::CREATURE_SLOT);
				});
			}
		}
	}
}


ImagePath CStackWindow::MainSection::getBackgroundName(bool showExp, bool showArt)
{
	if(showExp && showArt)
		return ImagePath::builtin("stackWindow/info-panel-2");
	else if(showExp || showArt)
		return ImagePath::builtin("stackWindow/info-panel-1");
	else
		return ImagePath::builtin("stackWindow/info-panel-0");
}


void CStackWindow::MainSection::addStatLabel(EStat index, int64_t value1, int64_t value2)
{
	const auto title = statNames.at(static_cast<size_t>(index));
	stats.push_back(std::make_shared<CLabel>(145, 32 + (int)index*19, FONT_SMALL, ETextAlignment::TOPLEFT, Colors::WHITE, title));

	const bool useRange = value1 != value2;
	std::string formatStr = useRange ? statFormats.at(static_cast<size_t>(index)) : "%d";

	boost::format fmt(formatStr);
	fmt % value1;
	if(useRange)
		fmt % value2;

	stats.push_back(std::make_shared<CLabel>(307, 48 + (int)index*19, FONT_SMALL, ETextAlignment::BOTTOMRIGHT, Colors::WHITE, fmt.str()));
}

void CStackWindow::MainSection::addStatLabel(EStat index, int64_t value)
{
	addStatLabel(index, value, value);
}

CStackWindow::CStackWindow(const CStack * stack, bool popup)
	: CWindowObject(BORDERED | (popup ? RCLICK_POPUP : 0)),
	info(std::make_unique<UnitView>())
{
	info->stack = stack;
	info->stackNode = stack->base;
	info->commander = dynamic_cast<const CCommanderInstance*>(stack->base);
	info->creature = stack->unitType();
	info->creatureCount = stack->getCount();
	info->popupWindow = popup;
	init();
}

CStackWindow::CStackWindow(const CCreature * creature, bool popup)
	: CWindowObject(BORDERED | (popup ? RCLICK_POPUP : 0)),
	info(std::make_unique<UnitView>())
{
	info->creature = creature;
	info->popupWindow = popup;
	init();
}

CStackWindow::CStackWindow(const CStackInstance * stack, bool popup)
	: CWindowObject(BORDERED | (popup ? RCLICK_POPUP : 0)),
	info(std::make_unique<UnitView>())
{
	info->stackNode = stack;
	info->creature = stack->getCreature();
	info->creatureCount = stack->getCount();
	info->popupWindow = popup;
	info->owner = dynamic_cast<const CGHeroInstance *> (stack->getArmy());
	init();
}

CStackWindow::CStackWindow(const CStackInstance * stack, std::function<void()> dismiss, const UpgradeInfo & upgradeInfo, std::function<void(CreatureID)> callback)
	: CWindowObject(BORDERED),
	info(std::make_unique<UnitView>())
{
	info->stackNode = stack;
	info->creature = stack->getCreature();
	info->creatureCount = stack->getCount();

	if(upgradeInfo.canUpgrade())
	{
		info->upgradeInfo = std::make_optional(UnitView::StackUpgradeInfo(upgradeInfo));
		info->upgradeInfo->callback = callback;
	}
	
	info->dismissInfo = std::make_optional(UnitView::StackDismissInfo());
	info->dismissInfo->callback = dismiss;
	info->owner = dynamic_cast<const CGHeroInstance *> (stack->getArmy());
	init();
}

CStackWindow::CStackWindow(const CCommanderInstance * commander, bool popup)
	: CWindowObject(BORDERED | (popup ? RCLICK_POPUP : 0)),
	info(std::make_unique<UnitView>())
{
	info->stackNode = commander;
	info->creature = commander->getCreature();
	info->commander = commander;
	info->creatureCount = 1;
	info->popupWindow = popup;
	info->owner = dynamic_cast<const CGHeroInstance *> (commander->getArmy());
	init();
}

CStackWindow::CStackWindow(const CCommanderInstance * commander, std::vector<ui32> &skills, std::function<void(ui32)> callback)
	: CWindowObject(BORDERED),
	info(std::make_unique<UnitView>())
{
	info->stackNode = commander;
	info->creature = commander->getCreature();
	info->commander = commander;
	info->creatureCount = 1;
	info->levelupInfo = std::make_optional(UnitView::CommanderLevelInfo());
	info->levelupInfo->skills = skills;
	info->levelupInfo->callback = callback;
	info->owner = dynamic_cast<const CGHeroInstance *> (commander->getArmy());
	init();
}

CStackWindow::~CStackWindow() = default;

void CStackWindow::close()
{
	if(info->levelupInfo && !info->levelupInfo->skills.empty())
		info->levelupInfo->callback(vstd::find_pos(info->levelupInfo->skills, selectedSkill));

	CWindowObject::close();
}

void CStackWindow::init()
{
	OBJECT_CONSTRUCTION;

	background = std::make_shared<CFilledTexture>(ImagePath::builtin("DIBOXBCK"), pos);

	if(!info->stackNode)
	{
		//does not contain any propagated bonuses
		fakeNode = std::make_unique<CStackInstance>(nullptr, info->creature->getId(), 1, true);
		info->stackNode = fakeNode.get();
	}

	selectedIcon = nullptr;
	selectedSkill = -1;
	if(info->levelupInfo && !info->levelupInfo->skills.empty())
		selectedSkill = info->levelupInfo->skills.front();

	activeTab = 0;

	initBonusesList();
	initSections();

	background->pos = pos;
}

void CStackWindow::initBonusesList()
{
	const IBonusBearer * bonusSource = info->stack
	? static_cast<const IBonusBearer*>(info->stack)  // Use CStack in battle
	: static_cast<const IBonusBearer*>(info->stackNode);  // Use CStackInstance outside of battle

	auto bonusToString = [bonusSource](const std::shared_ptr<Bonus> & bonus) -> std::string
	{
		if(!bonus->description.empty())
			return bonus->description.toString();
		else
			return LIBRARY->getBth()->bonusToString(bonus, bonusSource);
	};

	BonusList receivedBonuses = *bonusSource->getBonuses(Selector::all);
	BonusList abilities = info->creature->getExportedBonusList();

	// remove all bonuses that are not propagated away
	// such bonuses should be present in received bonuses, and if not - this means that they are behind inactive limiter, such as inactive stack experience bonuses
	abilities.remove_if([](const Bonus* b){ return b->propagator == nullptr;});

	const auto & bonusSortingPredicate = [bonusToString](const std::shared_ptr<Bonus> & v1, const std::shared_ptr<Bonus> & v2){
		if (v1->source != v2->source)
		{
			int priorityV1 = v1->source == BonusSource::CREATURE_ABILITY ? -1 : static_cast<int>(v1->source);
			int priorityV2 = v2->source == BonusSource::CREATURE_ABILITY ? -1 : static_cast<int>(v2->source);
			return priorityV1 < priorityV2;
		}
		else
			return bonusToString(v1) < bonusToString(v2);
	};

	receivedBonuses.remove_if([](const Bonus* b)
	{
		return !LIBRARY->bth->shouldPropagateDescription(b->type);
	});

	std::vector<BonusList> groupedBonuses;
	while (!receivedBonuses.empty())
	{
		auto currentBonus = receivedBonuses.front();

		const auto & sameBonusPredicate = [currentBonus](const std::shared_ptr<Bonus> & b)
		{
			return currentBonus->type == b->type && currentBonus->subtype == b->subtype;
		};

		groupedBonuses.emplace_back();

		std::copy_if(receivedBonuses.begin(), receivedBonuses.end(), std::back_inserter(groupedBonuses.back()), sameBonusPredicate);
		receivedBonuses.remove_if(Selector::typeSubtype(currentBonus->type, currentBonus->subtype));
		// FIXME: potential edge case: unit has ability that is propagated away (and needs to be displayed), but also receives same bonus from someplace else
		abilities.remove_if(Selector::typeSubtype(currentBonus->type, currentBonus->subtype));
	}

	// Add any remaining abilities of this unit that don't affect it at the moment, such as abilities that are propagated away, e.g. to other side in combat
	BonusList visibleBonuses = abilities;

	for (auto & group : groupedBonuses)
	{
		// Try to find the bonus in the group that represents the final effect in the best way.
		std::sort(group.begin(), group.end(), bonusSortingPredicate);

		BonusList groupIndepMin = group;
		BonusList groupIndepMax = group;
		BonusList groupNoMinMax = group;
		BonusList groupBaseOnly = group;

		groupIndepMin.remove_if([](const Bonus * b) { return b->valType != BonusValueType::INDEPENDENT_MIN; });
		groupIndepMax.remove_if([](const Bonus * b) { return b->valType != BonusValueType::INDEPENDENT_MAX; });
		groupNoMinMax.remove_if([](const Bonus * b) { return b->valType == BonusValueType::INDEPENDENT_MAX || b->valType == BonusValueType::INDEPENDENT_MIN; });
		groupBaseOnly.remove_if([](const Bonus * b) { return b->valType != BonusValueType::ADDITIVE_VALUE && b->valType != BonusValueType::BASE_NUMBER; });

		int valIndepMin = groupIndepMin.totalValue();
		int valIndepMax = groupIndepMax.totalValue();
		int valNoMinMax = groupNoMinMax.totalValue();

		BonusList usedGroup;

		if (!groupIndepMin.empty() && valNoMinMax != valIndepMin)
			usedGroup = groupIndepMin; // bonus value was limited due to INDEPENDENT_MIN bonus -> show this bonus
		else if (!groupIndepMax.empty() && valNoMinMax != valIndepMax)
			usedGroup = groupIndepMax; // bonus value was limited due to INDEPENDENT_MAX bonus -> show this bonus
		else if (!groupBaseOnly.empty())
			usedGroup = groupNoMinMax; // bonus value is not limited and has bonuses other than percent to base / percent to all - show first non-independent bonus

		// It is possible that empty group was selected. For example, there is only INDEPENDENT effect with value of 0, which does not actually has any effect on this unit
		// For example, orb of vulnerability on unit without any resistances
		if (!usedGroup.empty())
			visibleBonuses.push_back(usedGroup.front());
	}

	std::sort(visibleBonuses.begin(), visibleBonuses.end(), bonusSortingPredicate);

	BonusInfo bonusInfo;
	for(auto b : visibleBonuses)
	{
		bonusInfo.description = bonusToString(b);
		//FIXME: we possibly use fakeNode, which does not have the correct bonus value
		bonusInfo.imagePath = info->stackNode->bonusToGraphics(b);
		bonusInfo.bonusSource = b->source;

		//if it's possible to give any description or image for this kind of bonus
		if(!bonusInfo.description.empty() && !b->hidden)
			activeBonuses.push_back(bonusInfo);
	}
}

void CStackWindow::initSections()
{
	OBJECT_CONSTRUCTION;

	bool showArt = GAME->interface() && GAME->interface()->cb->getSettings().getBoolean(EGameSettings::MODULE_STACK_ARTIFACT) && info->commander == nullptr && info->stackNode;
	bool showExp = ((GAME->interface() && GAME->interface()->cb->getSettings().getBoolean(EGameSettings::MODULE_STACK_EXPERIENCE)) || info->commander != nullptr) && info->stackNode;

	mainSection = std::make_shared<MainSection>(this, pos.h, showExp, showArt);

	pos.w = mainSection->pos.w;
	pos.h += mainSection->pos.h;

	if(info->stack) // in battle
	{
		activeSpellsSection = std::make_shared<ActiveSpellsSection>(this, pos.h);
		pos.h += activeSpellsSection->pos.h;
	}

	if(info->commander)
	{
		auto onCreate = [this](size_t index) -> std::shared_ptr<CIntObject>
		{
			auto obj = switchTab(index);

			if(obj)
				obj->enable();
			return obj;
		};

		auto deactivateObj = [=](std::shared_ptr<CIntObject> obj)
		{
			obj->disable();
		};

		commanderMainSection = std::make_shared<CommanderMainSection>(this, 0);

		auto size = std::make_optional<size_t>((info->levelupInfo) ? 4 : 3);
		commanderBonusesSection = std::make_shared<BonusesSection>(this, 0, size);
		deactivateObj(commanderBonusesSection);

		commanderTab = std::make_shared<CTabbedInt>(onCreate, Point(0, pos.h), 0);

		pos.h += commanderMainSection->pos.h;
	}

	if(!info->commander && !activeBonuses.empty())
	{
		bonusesSection = std::make_shared<BonusesSection>(this, pos.h);
		pos.h += bonusesSection->pos.h;
	}

	if(!info->popupWindow)
	{
		buttonsSection = std::make_shared<ButtonsSection>(this, pos.h);
		pos.h += buttonsSection->pos.h;
		//FIXME: add status bar to image?
	}
	updateShadow();
	pos = center(pos);
}

void CStackWindow::showStackExperienceDetailsWindow()
{
	// Requires a real stack and an active interface/callback for preview calculations.
	if(!info->stackNode || !GAME->interface())
		return;

	auto detailsWindow = std::make_shared<StackExperienceDetailsWindow>(info->stackNode, info->creature);
	ENGINE->windows().pushWindow(std::static_pointer_cast<IShowActivatable>(detailsWindow));
}

std::string CStackWindow::getCommanderSkillDescription(int skillIndex, int skillLevel)
{
	constexpr std::array skillNames = {
		"attack",
		"defence",
		"health",
		"damage",
		"speed",
		"magic"
	};

	std::string textID = TextIdentifier("vcmi", "commander", "skill", skillNames.at(skillIndex), skillLevel).get();

	return LIBRARY->generaltexth->translate(textID);
}

void CStackWindow::setSelection(si32 newSkill, std::shared_ptr<CCommanderSkillIcon> newIcon)
{
	auto getSkillDescription = [this](int skillIndex, bool selected) -> std::string
	{
		if(selected)
			return getCommanderSkillDescription(skillIndex, info->commander->secondarySkills[skillIndex] + 1); //upgrade description
		else
			return getCommanderSkillDescription(skillIndex, info->commander->secondarySkills[skillIndex]);
	};

	auto getSkillImage = [this](int skillIndex)
	{
		bool selected = ((selectedSkill == skillIndex) && info->levelupInfo );
		return skillToFile(skillIndex, info->commander->secondarySkills[skillIndex], selected);
	};

	OBJECT_CONSTRUCTION;
	int oldSelection = selectedSkill; // update selection
	selectedSkill = newSkill;

	if(selectedIcon && oldSelection < 100) // recreate image on old selection, only for skills
		selectedIcon->setObject(std::make_shared<CPicture>(getSkillImage(oldSelection)));

	if(selectedIcon)
	{
		if(!selectedIcon->getIsMasterAbility()) //unlike WoG, in VCMI master skill descriptions are taken from bonus descriptions
		{
			selectedIcon->text = getSkillDescription(oldSelection, false); //update previously selected icon's message to existing skill level
		}
		selectedIcon->deselect();
	}

	selectedIcon = newIcon; // update new selection
	if(newSkill < 100)
	{
		newIcon->setObject(std::make_shared<CPicture>(getSkillImage(newSkill)));
		if(!newIcon->getIsMasterAbility())
		{
			newIcon->text = getSkillDescription(newSkill, true); //update currently selected icon's message to show upgrade description
		}
	}
}

std::shared_ptr<CIntObject> CStackWindow::switchTab(size_t index)
{
	std::shared_ptr<CIntObject> ret;
	switch(index)
	{
	case 0:
		{
			activeTab = 0;
			ret = commanderMainSection;
		}
		break;
	case 1:
		{
			activeTab = 1;
			ret = commanderBonusesSection;
		}
		break;
	default:
		break;
	}

	return ret;
}

void CStackWindow::removeStackArtifact(ArtifactPosition pos)
{
	auto art = info->stackNode->getArt(ArtifactPosition::CREATURE_SLOT);
	if(!art)
	{
		logGlobal->error("Attempt to remove missing artifact");
		return;
	}
	const auto slot = ArtifactUtils::getArtBackpackPosition(info->owner, art->getTypeId());
	if(slot != ArtifactPosition::PRE_FIRST)
	{
		auto artLoc = ArtifactLocation(info->owner->id, pos);
		artLoc.creature = info->stackNode->getArmy()->findStack(info->stackNode);
		GAME->interface()->cb->swapArtifacts(artLoc, ArtifactLocation(info->owner->id, slot));
		stackArtifactButton.reset();
		stackArtifact.reset();
		redraw();
	}
}
