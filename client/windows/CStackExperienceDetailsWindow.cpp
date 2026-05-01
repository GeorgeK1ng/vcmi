#include "StdInc.h"
#include "CStackExperienceDetailsWindow.h"

#include <vcmi/spells/Spell.h>
#include <vcmi/spells/Service.h>

#include "../CPlayerInterface.h"
#include "../widgets/Buttons.h"
#include "../widgets/GraphicalPrimitiveCanvas.h"
#include "../widgets/Images.h"
#include "../widgets/TextControls.h"
#include "../gui/Shortcut.h"
#include "../GameEngine.h"
#include "../GameInstance.h"

#include "../../lib/CBonusTypeHandler.h"
#include "../../lib/GameLibrary.h"
#include "../../lib/bonuses/Propagators.h"
#include "../../lib/callback/CCallback.h"
#include "../../lib/texts/CGeneralTextHandler.h"

int CStackExperienceDetailsWindow::getStackExperienceTierFromCreatureLevel(int creatureLevel)
{
	const int maxTier = static_cast<int>(LIBRARY->creh->expRanks.size()) - 1;
	if(maxTier <= 0)
	{
		static bool warningPrinted = false;
		if(!warningPrinted)
		{
			logGlobal->warn("StackExperienceDetailsWindow: no valid stack experience tiers loaded, defaulting to tier 0");
			warningPrinted = true;
		}
			return 0;
	}

	// Creature level/tier selects which exp-rank threshold table is used.
	// Stack experience rank itself is separate (0..10 columns in the dialog).
	// Keep mapping consistent with CStackInstance::getExpRank():
	// creature levels outside 1..7 use fallback tier 0.
	if(!vstd::iswithin(creatureLevel, 1, 7))
		return 0;

	return std::clamp(creatureLevel, 1, std::min(7, maxTier));
}

int CStackExperienceDetailsWindow::calculateDynamicTableRowCount(const CStackInstance * stack, const CCreature * creature)
{
	if(!stack || !creature || !GAME->interface())
		return 9;

	struct BonusKey
	{
		BonusType type;
		int subtype;
		bool operator<(const BonusKey & other) const
		{
			return std::tie(type, subtype) < std::tie(other.type, other.subtype);
		}
	};

	int tier = CStackExperienceDetailsWindow::getStackExperienceTierFromCreatureLevel(creature->getLevel());
	const auto & rankThresholds = LIBRARY->creh->expRanks[tier];
	auto gameCallback = GAME->interface()->cb.get();

	std::set<BonusKey> uniqueBonuses;
	for(int rank = 0; rank < MAX_RANKS; ++rank)
	{
		const int averageExp = rank == 0 ? 0 : static_cast<int>(rankThresholds[rank - 1]);
		CStackInstance preview(gameCallback, creature->getId(), std::max(1, stack->getCount()), true);
		const TExpType totalExperience = static_cast<TExpType>(averageExp) * static_cast<TExpType>(preview.getCount());
		preview.giveTotalStackExperience(totalExperience);

		auto bonuses = preview.getBonuses(Selector::sourceTypeSel(BonusSource::STACK_EXPERIENCE));
		for(const auto & bonus : *bonuses)
			uniqueBonuses.insert({bonus->type, bonus->subtype.getNum()});
	}

	const int dataRows = std::clamp(2 + static_cast<int>(uniqueBonuses.size()), 8, 19); // 2 fixed rows + dynamic bonuses
	return dataRows + 1; // header + data
}

ImagePath CStackExperienceDetailsWindow::getDialogBackground(int rowCount)
{
	rowCount = std::clamp(rowCount, 9, 20);
	return ImagePath::builtin("stackExperienceDialogRows" + std::to_string(rowCount));
}

CStackExperienceDetailsWindow::StackExperienceDetailsWindow(const CStackInstance * stack, const CCreature * creatureType)
	: CWindowObject(BORDERED | PLAYER_COLORED, getDialogBackground(calculateDynamicTableRowCount(stack, creatureType)))
	, sourceStack(stack)
	, creature(creatureType)
{
	OBJECT_CONSTRUCTION;

	const int sideMargin = 10;
	const int headerTop = 1;
	const int detailsTop = 68;
	const int tableTop = 218;
	constexpr int tableBaseRowHeight = 25;
	const int statusbarHeight = 26; // kept for bottom button offset

	title = std::make_shared<CLabel>(pos.w / 2, headerTop, FONT_BIG, ETextAlignment::TOPCENTER, Colors::YELLOW, LIBRARY->generaltexth->translate("vcmi.stackExperience.windowTitle"));

	std::vector<std::string> rankNames;
	for(int rank = 0; rank < MAX_RANKS; ++rank)
		rankNames.push_back(LIBRARY->generaltexth->translate("vcmi.stackExperience.rank", rank));

	int tier = getStackExperienceTierFromCreatureLevel(this->creature->getLevel());
	const auto & rankThresholds = LIBRARY->creh->expRanks[tier];

	const int expMax = static_cast<int>(rankThresholds.back());
	const int currentRank = std::clamp(sourceStack->getExpRank(), 0, MAX_RANKS - 1);
	const int maxExpPerBattle = static_cast<int>(LIBRARY->creh->maxExpPerBattle[tier]) * expMax / 100;
	const int nextRankExp = (currentRank < MAX_RANKS - 1 && currentRank < static_cast<int>(rankThresholds.size()))
		? std::max(0, static_cast<int>(rankThresholds[currentRank] - sourceStack->getAverageExperience()))
		: 0;
	int expMin = std::max(LIBRARY->creh->expRanks[tier][std::max(currentRank - 1, 0)], static_cast<ui32>(1));
	const int maxNewRecruits = std::max(0, static_cast<int>(sourceStack->getTotalExperience() / expMin - sourceStack->getCount()));
	const int upgradeMultiplier = static_cast<int>(LIBRARY->creh->expAfterUpgrade);
	expMin = LIBRARY->creh->expRanks[tier][9];
	const int expAfterRank10 = static_cast<int>(LIBRARY->creh->expRanks[tier][10] - expMin);
	const int maxRecruitsAtRank10 = std::max(0, static_cast<int>((sourceStack->getCount() * expAfterRank10) / expMin));

	const std::string unitHeader = this->creature->getNamePluralTranslated();

	stackSummary = std::make_shared<CLabel>(pos.w / 2, headerTop + 46, FONT_MEDIUM, ETextAlignment::CENTER, Colors::YELLOW, unitHeader);

	const int creatureFrameX = sideMargin;
	const int creatureFrameY = detailsTop;
	creatureAnimation = std::make_shared<CCreaturePic>(creatureFrameX + 1, creatureFrameY + 1, this->creature, true, true);
	creatureAnimation->setAmount(sourceStack->getCount());

	const int infoLeftX = sideMargin + 126; // shifted 18px left relative to previous layout
	const int infoColumnGap = 14;
	const int infoLabelWidth = 221;
	const int infoValueWidth = 86;
	const int infoSectionGap = 10; // 2px visual gap between split blocks (+/-4px frame padding)
	const int infoColumnWidth = infoLabelWidth + infoSectionGap + infoValueWidth;
	const int infoRightX = infoLeftX + infoColumnWidth + infoColumnGap;
	const int infoTop = detailsTop + 4;
	const int infoFieldHeight = 22;
	const int infoFieldGap = 2;
	const int infoRowStep = infoFieldHeight + infoFieldGap;
	const int infoLongFieldHeight = infoFieldHeight * 2 + infoFieldGap + 8;

	auto addInfo = [&](int row, int column, const std::string & key, const std::string & value)
	{
		const int baseX = column == 0 ? infoLeftX : infoRightX;
		const int rowY = infoTop + row * infoRowStep;
		labels.push_back(std::make_shared<CLabel>(baseX + 2, rowY + infoFieldHeight / 2, FONT_SMALL, ETextAlignment::CENTERLEFT, Colors::WHITE, key + ":"));
		labels.push_back(std::make_shared<CLabel>(baseX + infoLabelWidth + infoSectionGap + 2, rowY + infoFieldHeight / 2, FONT_SMALL, ETextAlignment::CENTERLEFT, Colors::WHITE, value));
	};

	addInfo(0, 0, LIBRARY->generaltexth->translate("vcmi.stackExperience.popup.rank"), boost::str(boost::format("%s (%d)") % LIBRARY->generaltexth->translate("vcmi.stackExperience.rank", currentRank) % currentRank));
	addInfo(0, 1, LIBRARY->generaltexth->translate("vcmi.stackExperience.popup.experiencePoints"), std::to_string(sourceStack->getAverageExperience()));
	addInfo(1, 0, LIBRARY->generaltexth->translate("vcmi.stackExperience.popup.maxPerBattle"), std::to_string(maxExpPerBattle));
	addInfo(1, 1, LIBRARY->generaltexth->translate("vcmi.stackExperience.popup.nextRank"), std::to_string(nextRankExp));
	addInfo(2, 0, LIBRARY->generaltexth->translate("vcmi.stackExperience.popup.upgradeMultiplier"), boost::str(boost::format("%d%%") % upgradeMultiplier));
	addInfo(2, 1, LIBRARY->generaltexth->translate("vcmi.stackExperience.popup.experienceAfterRank10"), std::to_string(expAfterRank10));

	auto addLongInfo = [&](int column, const std::string & key, const std::string & value)
	{
		const int baseX = column == 0 ? infoLeftX : infoRightX;
		const int rowY = infoTop + 3 * infoRowStep;
		labels.push_back(std::make_shared<CMultiLineLabel>(
			Rect(baseX + 2, rowY + 1, infoLabelWidth - 2, infoLongFieldHeight - 2),
			FONT_SMALL, ETextAlignment::CENTERLEFT, Colors::WHITE,
			key + ":"));
		labels.push_back(std::make_shared<CLabel>(
			baseX + infoLabelWidth + infoSectionGap + 2,
			rowY + infoLongFieldHeight / 2,
			FONT_SMALL, ETextAlignment::CENTERLEFT, Colors::WHITE,
			value));
	};

	addLongInfo(0, LIBRARY->generaltexth->translate("vcmi.stackExperience.popup.maxRecruits"), std::to_string(maxNewRecruits));
	addLongInfo(1, LIBRARY->generaltexth->translate("vcmi.stackExperience.popup.maxRecruitsRank10"), std::to_string(maxRecruitsAtRank10));

	std::vector<NumericRow> rows = {
		{LIBRARY->generaltexth->translate("vcmi.stackExperience.table.Experience"), [&rankThresholds](const CStackInstance & stackInst)
			{
				const int rank = std::clamp(stackInst.getExpRank(), 0, MAX_RANKS - 1);
				return rank == 0 ? 0 : static_cast<int>(rankThresholds[rank - 1]);
			}, false, false, false},
	};

	struct BonusKey
	{
		BonusType type;
		BonusSubtypeID subtype;
		BonusValueType valType;
		bool hidden;

		bool operator<(const BonusKey & other) const
		{
			if(type != other.type)
				return type < other.type;
			if(subtype.getNum() != other.subtype.getNum())
				return subtype.getNum() < other.subtype.getNum();
			if(valType != other.valType)
				return valType < other.valType;
			return hidden < other.hidden;
		}
	};

	auto getBonusKey = [](const std::shared_ptr<const Bonus> & bonus)
	{
		return BonusKey{bonus->type, bonus->subtype, bonus->valType, bonus->hidden};
	};

	auto makeStackExpSelector = [](const BonusKey & key)
	{
		return Selector::sourceTypeSel(BonusSource::STACK_EXPERIENCE)
			.And(Selector::typeSubtypeValueType(key.type, key.subtype, key.valType))
			.And([hidden = key.hidden](const Bonus * bonus) { return bonus->hidden == hidden; });
	};

	std::map<BonusKey, std::shared_ptr<const Bonus>> dynamicBonuses;
	for(int rank = 0; rank < MAX_RANKS; ++rank)
	{
		auto gameCallback = GAME->interface() ? GAME->interface()->cb.get() : nullptr;
		const int averageExp = rank == 0 ? 0 : static_cast<int>(rankThresholds[rank - 1]);
		CStackInstance preview(gameCallback, this->creature->getId(), std::max(1, sourceStack->getCount()), true);
		const TExpType totalExperience = static_cast<TExpType>(averageExp) * static_cast<TExpType>(preview.getCount());
		preview.giveTotalStackExperience(totalExperience);
		auto bonuses = preview.getBonuses(Selector::sourceTypeSel(BonusSource::STACK_EXPERIENCE));
		for(const auto & bonus : *bonuses)
		{
			const auto key = getBonusKey(bonus);
			dynamicBonuses.emplace(key, bonus);
		}
	}

	auto addBonusRow = [&](const BonusKey & key, const std::string & label, bool percent = false, bool binary = false, bool showSign = true)
	{
		const auto selector = makeStackExpSelector(key);
		rows.push_back({label, [selector](const CStackInstance & stackInst)
				{
					return stackInst.valOfBonuses(selector);
				}, percent, binary, showSign});
		dynamicBonuses.erase(key);
	};

	const auto keyAttack = BonusKey{BonusType::PRIMARY_SKILL, BonusSubtypeID(PrimarySkill::ATTACK)};
	if(dynamicBonuses.count(keyAttack))
		addBonusRow(keyAttack, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.attack"));

	const auto keyDefense = BonusKey{BonusType::PRIMARY_SKILL, BonusSubtypeID(PrimarySkill::DEFENSE)};
	if(dynamicBonuses.count(keyDefense))
		addBonusRow(keyDefense, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.defense"));

	const auto keyMinDamage = BonusKey{BonusType::CREATURE_DAMAGE, BonusSubtypeID(BonusCustomSubtype::creatureDamageMin)};
	if(dynamicBonuses.count(keyMinDamage))
		addBonusRow(keyMinDamage, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.minDamage"));

	const auto keyMaxDamage = BonusKey{BonusType::CREATURE_DAMAGE, BonusSubtypeID(BonusCustomSubtype::creatureDamageMax)};
	if(dynamicBonuses.count(keyMaxDamage))
		addBonusRow(keyMaxDamage, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.maxDamage"));

	const auto keyHealth = BonusKey{BonusType::STACK_HEALTH, BonusSubtypeID()};
	if(dynamicBonuses.count(keyHealth))
		addBonusRow(keyHealth, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.health"), true);

	const auto keySpeed = BonusKey{BonusType::STACKS_SPEED, BonusSubtypeID()};
	if(dynamicBonuses.count(keySpeed))
		addBonusRow(keySpeed, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.speed"));

	const auto keyShots = BonusKey{BonusType::SHOTS, BonusSubtypeID()};
	if(dynamicBonuses.count(keyShots))
		addBonusRow(keyShots, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.shots"));

	const auto keyMana = BonusKey{BonusType::CASTS, BonusSubtypeID()};
	if(dynamicBonuses.count(keyMana))
		addBonusRow(keyMana, LIBRARY->generaltexth->allTexts[399]);

	for(const auto & [key, bonus] : dynamicBonuses)
	{
		std::string rowLabel = "Bonus";
		if(const auto * bonusTypeHandler = dynamic_cast<const CBonusTypeHandler *>(LIBRARY->getBth()))
			rowLabel = bonusTypeHandler->bonusToString(bonus);

		const bool percentValue = bonus->valType == BonusValueType::PERCENT_TO_BASE || bonus->valType == BonusValueType::PERCENT_TO_ALL;
		const bool binaryValue = true; // confirmed below by checking per-rank values are strictly 0/1
		addBonusRow(key, rowLabel, percentValue, binaryValue);
	}

	struct PreparedRow
	{
		std::string title;
		bool percent = false;
		bool binary = false;
		bool showSign = true;
		std::array<int, MAX_RANKS> values{};
	};

	std::vector<PreparedRow> preparedRows;
	preparedRows.reserve(rows.size());
	for(const auto & row : rows)
	{
		PreparedRow prepared;
		prepared.title = row.title;
		prepared.percent = row.percent;
		prepared.showSign = row.showSign;

		bool anyNonZero = false;
		bool onlyBinary = true;
		for(int rank = 0; rank < MAX_RANKS; ++rank)
		{
			const int averageExp = rank == 0 ? 0 : static_cast<int>(rankThresholds[rank - 1]);
			auto gameCallback = GAME->interface() ? GAME->interface()->cb.get() : nullptr;
			CStackInstance preview(gameCallback, this->creature->getId(), std::max(1, sourceStack->getCount()), true);
			const TExpType totalExperience = static_cast<TExpType>(averageExp) * static_cast<TExpType>(preview.getCount());
			preview.giveTotalStackExperience(totalExperience);

			const int value = row.valueGetter(preview);
			prepared.values[rank] = value;
			anyNonZero = anyNonZero || value != 0;
			onlyBinary = onlyBinary && (value == 0 || value == 1);
		}

		if(anyNonZero)
		{
			prepared.binary = row.binary && onlyBinary;
			preparedRows.push_back(std::move(prepared));
		}
	}

	const int maxDataRows = 19; // 20 total with header
	if(static_cast<int>(preparedRows.size()) > maxDataRows)
		preparedRows.resize(maxDataRows);

	const int rowNameWidth = 140;
	const int colWidth = (pos.w - 2 * sideMargin - rowNameWidth) / MAX_RANKS;
	const int rowHeight = tableBaseRowHeight;
	const int tableWidth = rowNameWidth + colWidth * MAX_RANKS;

	for(int rank = 0; rank < MAX_RANKS; ++rank)
	{
		labels.push_back(std::make_shared<CLabel>(sideMargin + rowNameWidth + rank * colWidth + colWidth / 2, tableTop + rowHeight / 2, FONT_TINY, ETextAlignment::CENTER, Colors::YELLOW, rankNames[rank]));
	}

	constexpr int maxVisibleBonusRows = 12;
	const int totalBonusRows = static_cast<int>(preparedRows.size());
	const int visibleBonusRows = std::min(maxVisibleBonusRows, totalBonusRows);
	const int tableRowsVisible = visibleBonusRows + 1; // header + visible bonus rows
	currentRankFrame = std::make_shared<GraphicalPrimitiveCanvas>(Rect(sideMargin, tableTop, tableWidth, rowHeight * tableRowsVisible));
	currentRankFrame->addRectangle(Point(rowNameWidth + currentRank * colWidth, 1), Point(colWidth + 1, rowHeight * tableRowsVisible - 2), Colors::METALLIC_GOLD);
	currentRankFrame->addRectangle(Point(rowNameWidth + currentRank * colWidth + 1, 2), Point(colWidth - 1, rowHeight * tableRowsVisible - 4), Colors::METALLIC_GOLD);

	for(int localRow = 0; localRow < visibleBonusRows; ++localRow)
	{
		const int rowIndex = localRow;
		const int rowY = tableTop + (localRow + 1) * rowHeight + rowHeight / 2;
		labels.push_back(std::make_shared<CLabel>(sideMargin + 6, rowY, FONT_SMALL, ETextAlignment::CENTERLEFT, Colors::WHITE, preparedRows[rowIndex].title));

		for(int rank = 0; rank < MAX_RANKS; ++rank)
		{
			const int value = preparedRows[rowIndex].values[rank];
				std::string valueText;
				if(preparedRows[rowIndex].binary)
					valueText = value != 0
						? LIBRARY->generaltexth->translate("vcmi.stackExperience.table.yes")
						: LIBRARY->generaltexth->translate("vcmi.stackExperience.table.no");
				else
				{
					const bool showSign = preparedRows[rowIndex].showSign && value > 0;
					valueText = (showSign ? "+" : "") + std::to_string(value) + (preparedRows[rowIndex].percent ? "%" : "");
				}
			labels.push_back(std::make_shared<CLabel>(sideMargin + rowNameWidth + rank * colWidth + colWidth / 2, rowY, FONT_SMALL, ETextAlignment::CENTER, Colors::WHITE, valueText));
		}
	}

	const int centerX = pos.w / 2;
	closeButton = std::make_shared<CButton>(Point(centerX - 32, pos.h - statusbarHeight - 12), AnimationPath::builtin("IOKAY.DEF"), LIBRARY->generaltexth->zelp[632], [this](){ close(); }, EShortcut::GLOBAL_ACCEPT);
	closeButton->setBorderColor(Colors::METALLIC_GOLD);
}

class CCreatureArtifactInstance;
class CSelectableSkill;
