/*
 * CStackExperienceDetailsWindow.cpp, part of VCMI engine
 */
#include "StdInc.h"
#include "CStackExperienceDetailsWindow.h"

int CStackWindow::StackExperienceDetailsWindow::getStackExperienceTierFromCreatureLevel(int creatureLevel)
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

int CStackWindow::StackExperienceDetailsWindow::calculateDynamicTableRowCount(const CStackInstance * stack, const CCreature * creature)
{
	if(!stack || !creature || !GAME->interface())
		return 8;

	struct BonusKey
	{
		BonusType type;
		int subtype;
		bool operator<(const BonusKey & other) const
		{
			return std::tie(type, subtype) < std::tie(other.type, other.subtype);
		}
	};

	int tier = StackExperienceDetailsWindow::getStackExperienceTierFromCreatureLevel(creature->getLevel());
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

	const int minBonusRows = 6;
	const int maxDataRows = 12; // keep dialog within 800x600
	const int dataRows = std::clamp(1 + std::max(minBonusRows, static_cast<int>(uniqueBonuses.size())), minBonusRows + 1, maxDataRows); // Experience + bonus rows
	return dataRows; // table data rows (header handled by background template)
}

ImagePath CStackWindow::StackExperienceDetailsWindow::getDialogBackground(int rowCount)
{
	(void)rowCount;
	// Use base template only - lower table body is now rendered dynamically in scroll area.
	return ImagePath::builtin("stackExperienceDialogRows8");
}

CStackWindow::StackExperienceDetailsWindow::StackExperienceDetailsWindow(const CStackInstance * stack, const CCreature * creatureType)
	: CWindowObject(PLAYER_COLORED_BORDERED_STATUSBAR, getDialogBackground(calculateDynamicTableRowCount(stack, creatureType)))
	, sourceStack(stack)
	, creature(creatureType)
{
	OBJECT_CONSTRUCTION;
	statusbar = CGStatusBar::create(std::make_shared<CPicture>(background->getSurface(), Rect(8, pos.h - 26, pos.w - 16, 19), 8, pos.h - 26));

	const int sideMargin = 10;
	const int yOffset = 16;
	const int headerTop = 1 + yOffset;
	const int detailsTop = 68 + yOffset;
	const int tableTop = 218 + yOffset;
	constexpr int tableBaseRowHeight = 36;

	title = std::make_shared<CLabel>(pos.w / 2, headerTop, FONT_BIG, ETextAlignment::TOPCENTER, Colors::YELLOW, LIBRARY->generaltexth->translate("vcmi.stackExperience.windowTitle"));

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
			}, ImagePath(), true, -105, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.experience"), LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.experience"), false, false, false},
	};

	struct BonusKey
	{
		BonusType type;
		BonusSubtypeID subtype;

		bool operator<(const BonusKey & other) const
		{
			if(type != other.type)
				return type < other.type;
			return subtype.getNum() < other.subtype.getNum();
		}
	};

	auto getBonusKey = [](const std::shared_ptr<const Bonus> & bonus)
	{
		return BonusKey{bonus->type, bonus->subtype};
	};

	auto makeStackExpSelector = [](const BonusKey & key)
	{
		return Selector::sourceTypeSel(BonusSource::STACK_EXPERIENCE).And(Selector::typeSubtype(key.type, key.subtype));
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

	auto addBonusRow = [&](const BonusKey & key, const std::shared_ptr<const Bonus> & bonus, const std::string & label, const std::string & descriptionText, int iconFrame = -1, std::optional<ImagePath> iconOverride = std::nullopt, bool percent = false, bool binary = false, bool showSign = true)
	{
		const auto selector = makeStackExpSelector(key);
		const ImagePath iconPath = iconOverride.value_or(sourceStack->bonusToGraphics(std::const_pointer_cast<Bonus>(bonus)));
		std::string tooltip = descriptionText;
		std::string popup = descriptionText;
		boost::replace_all(tooltip, "\n\n", ": ");
		boost::replace_all(tooltip, "\n", ": ");
		boost::replace_all(popup, "\n", "\n\n");
		rows.push_back({label, [selector, binary](const CStackInstance & stackInst)
				{
					if(binary)
						return stackInst.hasBonus(selector) ? 1 : 0;

					return stackInst.valOfBonuses(selector);
				}, iconPath, true, iconFrame, tooltip, popup, percent, binary, showSign});
	};

	auto getBonusDisplayName = [&](const std::shared_ptr<const Bonus> & bonus)
	{
		std::string rowLabel;
		if(!bonus->description.empty())
			rowLabel = bonus->description.toString();
		else
		{
			auto mutableBonus = std::const_pointer_cast<Bonus>(bonus);
			rowLabel = sourceStack->bonusToString(mutableBonus);
		}

		const auto lineBreak = rowLabel.find('\n');
		if(lineBreak != std::string::npos)
			rowLabel = rowLabel.substr(0, lineBreak);

		if(rowLabel.empty())
		{
			if(const auto * bonusTypeHandler = dynamic_cast<const CBonusTypeHandler *>(LIBRARY->getBth()))
				rowLabel = bonusTypeHandler->bonusToString(bonus->type);
			else
				rowLabel = "Bonus";
		}

		if(bonus->type == BonusType::SPELL_IMMUNITY)
		{
			const auto spell = SpellID(bonus->subtype.getNum());
			if(spell != SpellID::NONE)
			{
				const auto spellName = spell.toEntity(LIBRARY)->getNameTranslated();
				const auto pattern = LIBRARY->generaltexth->translate("vcmi.stackExperience.table.spellImmunityShort");
				rowLabel = boost::str(boost::format(pattern) % spellName);
			}
		}
		else if(bonus->type == BonusType::SPELL_AFTER_ATTACK)
		{
			const auto spell = SpellID(bonus->subtype.getNum());
			if(spell != SpellID::NONE)
			{
				const auto spellName = spell.toEntity(LIBRARY)->getNameTranslated();
				const auto pattern = LIBRARY->generaltexth->translate("vcmi.stackExperience.table.spellAfterAttackShort");
				rowLabel = boost::str(boost::format(pattern) % spellName);
			}
		}

		return rowLabel;
	};
	auto getBonusTooltipText = [&](const std::shared_ptr<const Bonus> & bonus)
	{
		if(!bonus->description.empty())
			return bonus->description.toString();

		auto tooltip = sourceStack->bonusToString(std::const_pointer_cast<Bonus>(bonus));
		if(!tooltip.empty())
			return tooltip;

		if(const auto * bonusTypeHandler = dynamic_cast<const CBonusTypeHandler *>(LIBRARY->getBth()))
			return bonusTypeHandler->bonusToString(bonus->type);

		return tooltip;
	};

	
	auto isPercentBonus = [](const std::shared_ptr<const Bonus> & bonus)
	{
		return bonus->valType == BonusValueType::PERCENT_TO_BASE
			|| bonus->valType == BonusValueType::PERCENT_TO_ALL
			|| bonus->type == BonusType::MAGIC_RESISTANCE;
	};

	auto addPreferredRow = [&](BonusType type, std::optional<BonusSubtypeID> subtype, const std::string & label, int iconFrame = -1, std::optional<ImagePath> iconOverride = std::nullopt, std::optional<std::string> tooltipOverride = std::nullopt)
	{
		auto it = std::find_if(dynamicBonuses.begin(), dynamicBonuses.end(), [&](const auto & entry)
		{
			if(entry.first.type != type)
				return false;
			return !subtype.has_value() || entry.first.subtype == *subtype;
		});
		if(it == dynamicBonuses.end())
			return;

		const auto & bonus = it->second;
		const bool percentValue = isPercentBonus(bonus);
		const bool binaryValue = !percentValue && bonus->val == 0;
		addBonusRow(it->first, bonus, label, tooltipOverride.value_or(getBonusTooltipText(bonus)), iconFrame, iconOverride, percentValue, binaryValue);
		dynamicBonuses.erase(it);
	};

	addPreferredRow(BonusType::PRIMARY_SKILL, BonusSubtypeID(PrimarySkill::ATTACK), LIBRARY->generaltexth->translate("vcmi.stackExperience.table.attack"), -106, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.attack"));
	addPreferredRow(BonusType::PRIMARY_SKILL, BonusSubtypeID(PrimarySkill::DEFENSE), LIBRARY->generaltexth->translate("vcmi.stackExperience.table.defense"), 1, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.defense"));
	addPreferredRow(BonusType::CREATURE_DAMAGE, BonusSubtypeID(BonusCustomSubtype::creatureDamageMin), LIBRARY->generaltexth->translate("vcmi.stackExperience.table.minDamage"), -102, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.minDamage"));
	addPreferredRow(BonusType::CREATURE_DAMAGE, BonusSubtypeID(BonusCustomSubtype::creatureDamageMax), LIBRARY->generaltexth->translate("vcmi.stackExperience.table.maxDamage"), -103, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.maxDamage"));
	addPreferredRow(BonusType::STACK_HEALTH, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.health"), -104, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.health"));
	addPreferredRow(BonusType::STACKS_SPEED, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.speed"), -100, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.speed"));
	addPreferredRow(BonusType::SHOTS, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.table.shots"), -101, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.shots"));
	addPreferredRow(BonusType::CASTS, std::nullopt, LIBRARY->generaltexth->allTexts[399], 2, std::nullopt, LIBRARY->generaltexth->translate("vcmi.stackExperience.desc.casts"));

	for(const auto & [key, bonus] : dynamicBonuses)
	{
		const bool percentValue = isPercentBonus(bonus);
		const bool binaryValue = !percentValue && bonus->val == 0;
		addBonusRow(key, bonus, getBonusDisplayName(bonus), getBonusTooltipText(bonus), -1, std::nullopt, percentValue, binaryValue);
	}

	preparedRows.reserve(rows.size());
	for(const auto & row : rows)
	{
		PreparedRow prepared;
		prepared.title = row.title;
		prepared.icon = row.icon;
		prepared.hasIcon = row.hasIcon;
		prepared.iconFrame = row.iconFrame;
		prepared.tooltipText = row.tooltipText;
		prepared.popupText = row.popupText;
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

	const int rowNameWidth = 60;
	const int colWidth = (pos.w - 2 * sideMargin - rowNameWidth) / MAX_RANKS;
	const int rowHeight = tableBaseRowHeight;
	const int tableWidth = rowNameWidth + colWidth * MAX_RANKS;
	this->tableTop = tableTop;
	this->tableRowHeight = rowHeight;
	this->tableSideMargin = sideMargin;
	this->tableRowNameWidth = rowNameWidth;
	this->tableColWidth = colWidth;

	for(int rank = 0; rank < MAX_RANKS; ++rank)
	{
		const int iconX = sideMargin + rowNameWidth + rank * colWidth + (colWidth - 32) / 2;
		const int iconY = tableTop + (rowHeight - 32) / 2;
		auto rankIcon = std::make_shared<CAnimImage>(AnimationPath::builtin("stackWindow/levels"), rank, 0, iconX, iconY);
		rankIcon->setScale(Point(32, 32));
		labels.push_back(rankIcon);
	}

	constexpr int maxVisibleBonusRows = 7;
	const int totalBonusRows = static_cast<int>(preparedRows.size());
	visibleBonusRows = std::min(maxVisibleBonusRows, totalBonusRows);
	const int tableRowsVisible = visibleBonusRows + 1; // header + visible bonus rows
	currentRankFrame = std::make_shared<GraphicalPrimitiveCanvas>(Rect(sideMargin, tableTop, tableWidth, rowHeight * tableRowsVisible));
	currentRankFrame->addRectangle(Point(rowNameWidth + currentRank * colWidth, 0), Point(colWidth, rowHeight * tableRowsVisible), Colors::METALLIC_GOLD);
	currentRankFrame->addRectangle(Point(rowNameWidth + currentRank * colWidth + 1, 1), Point(colWidth - 2, rowHeight * tableRowsVisible - 2), Colors::METALLIC_GOLD);

	if(totalBonusRows > maxVisibleBonusRows)
	{
		tableSlider = std::make_shared<CSlider>(Point(pos.w - sideMargin - 16, tableTop + rowHeight), rowHeight * visibleBonusRows, [this](int){ rebuildTableRows(); setRedrawParent(true); redraw(); }, visibleBonusRows, totalBonusRows, 0, Orientation::VERTICAL, CSlider::BROWN);
		tableSlider->setPanningStep(rowHeight);
		tableSlider->setScrollBounds(Rect(-pos.w + tableSlider->pos.w, 0, pos.w, pos.h));
	}
	else
	{
		tableSlider.reset();
	}
	rebuildTableRows();

	const int centerX = pos.w / 2;
	constexpr int closeButtonBottomMargin = 40;
	constexpr int closeButtonWidth = 64;
	constexpr int closeButtonHeight = 32;
	closeButton = std::make_shared<CButton>(Point(centerX - closeButtonWidth / 2, pos.h - closeButtonBottomMargin - closeButtonHeight), AnimationPath::builtin("IOKAY.DEF"), LIBRARY->generaltexth->zelp[632], [this](){ close(); }, EShortcut::GLOBAL_ACCEPT);
	closeButton->setBorderColor(Colors::METALLIC_GOLD);
}

void CStackWindow::StackExperienceDetailsWindow::rebuildTableRows()
{
	for(const auto & widget : tableBackgroundWidgets)
		removeChild(widget.get());
	for(const auto & widget : tableRowWidgets)
		removeChild(widget.get());

	tableBackgroundWidgets.clear();
	tableRowWidgets.clear();
	const int firstRow = tableSlider ? tableSlider->getValue() : 0;
	for(int localRow = 0; localRow < visibleBonusRows; ++localRow)
	{
		const int rowIndex = firstRow + localRow;
		if(rowIndex >= static_cast<int>(preparedRows.size()))
			break;
		const int rowY = tableTop + (localRow + 1) * tableRowHeight + tableRowHeight / 2;

			if(preparedRows[rowIndex].hasIcon)
			{
				const int x = tableSideMargin + (tableRowNameWidth - 32) / 2;
				const int y = tableTop + (localRow + 1) * tableRowHeight + (tableRowHeight - 32) / 2;
				if(preparedRows[rowIndex].iconFrame >= 0)
				{
					auto iconImage = ENGINE->renderHandler().loadAnimation(AnimationPath::builtin("PSKIL42"), EImageBlitMode::COLORKEY)->getImage(preparedRows[rowIndex].iconFrame);
					iconImage->scaleTo(Point(32, 32), EScalingAlgorithm::BILINEAR);
					auto rowIcon = std::make_shared<CPicture>(iconImage, Point(x, y));
					tableRowWidgets.push_back(rowIcon);
					addChild(rowIcon.get(), true);
				}
				else if(preparedRows[rowIndex].iconFrame <= -100)
				{
					if(preparedRows[rowIndex].iconFrame == -102 || preparedRows[rowIndex].iconFrame == -103)
					{
						const int frame = preparedRows[rowIndex].iconFrame == -102 ? 69 : 71;
						auto iconImage = ENGINE->renderHandler().loadAnimation(AnimationPath::builtin("SECSK82"), EImageBlitMode::COLORKEY)->getImage(frame);
						iconImage->scaleTo(Point(32, 32), EScalingAlgorithm::BILINEAR);
						auto rowIcon = std::make_shared<CPicture>(iconImage, Point(x, y));
						tableRowWidgets.push_back(rowIcon);
						addChild(rowIcon.get(), true);
					}
					else
					{
						int overlayFrame = 0;
						bool customComposedIcon = false;
						switch(preparedRows[rowIndex].iconFrame)
						{
							case -100:
							{
								auto composed = ENGINE->renderHandler().createImage(Point(32, 32), CanvasScalingPolicy::IGNORE);
								auto baseIcon = ENGINE->renderHandler().loadAnimation(AnimationPath::builtin("SECSK82"), EImageBlitMode::COLORKEY)->getImage(0);
								baseIcon->scaleTo(Point(32, 32), EScalingAlgorithm::BILINEAR);
								auto overlayLocator = ImageLocator(AnimationPath::builtin("artifact"), 98, 0, EImageBlitMode::COLORKEY);
								overlayLocator.verticalFlip = true;
								auto overlayIcon = ENGINE->renderHandler().loadImage(overlayLocator);
								overlayIcon->scaleTo(Point(32, 32), EScalingAlgorithm::BILINEAR);
								auto iconCanvas = composed->getCanvas();
								iconCanvas.draw(baseIcon, Point(0, 0));
								iconCanvas.draw(overlayIcon, Point(0, 0));
								auto rowIcon = std::make_shared<CPicture>(std::static_pointer_cast<IImage>(composed), Point(x, y));
								tableRowWidgets.push_back(rowIcon);
								addChild(rowIcon.get(), true);
								customComposedIcon = true;
								break;
							}
							case -101: overlayFrame = 91; break;
							case -104: overlayFrame = 84; break;
							case -105:
							{
								auto base = ENGINE->renderHandler().loadImage(ImageLocator(ImagePath::builtin("LVLUPBKG.bmp"), EImageBlitMode::COLORKEY));
								auto cropped = ENGINE->renderHandler().createImage(Point(82, 82), CanvasScalingPolicy::IGNORE);
								cropped->getCanvas().draw(base, Point(0, 0), Rect(51, 56, 82, 82));
								cropped->scaleTo(Point(32, 32), EScalingAlgorithm::BILINEAR);
								auto rowIcon = std::make_shared<CPicture>(std::static_pointer_cast<IImage>(cropped), Point(x, y));
								tableRowWidgets.push_back(rowIcon);
								addChild(rowIcon.get(), true);
								customComposedIcon = true;
								break;
							}
							case -106:
							{
								auto composed = ENGINE->renderHandler().createImage(Point(32, 32), CanvasScalingPolicy::IGNORE);
								auto baseIcon = ENGINE->renderHandler().loadAnimation(AnimationPath::builtin("SECSK82"), EImageBlitMode::COLORKEY)->getImage(0);
								baseIcon->scaleTo(Point(32, 32), EScalingAlgorithm::BILINEAR);
								auto overlayIcon = ENGINE->renderHandler().loadImage(ImageLocator(ImagePath::builtin("CampSwrd"), EImageBlitMode::COLORKEY));
								overlayIcon->scaleTo(Point(28, 27), EScalingAlgorithm::BILINEAR);
								auto iconCanvas = composed->getCanvas();
								iconCanvas.draw(baseIcon, Point(0, 0));
								iconCanvas.draw(overlayIcon, Point(2, 2));
								auto rowIcon = std::make_shared<CPicture>(std::static_pointer_cast<IImage>(composed), Point(x, y));
								tableRowWidgets.push_back(rowIcon);
								addChild(rowIcon.get(), true);
								customComposedIcon = true;
								break;
							}
							default: overlayFrame = 0; break;
						}
						if(!customComposedIcon)
						{
							auto baseIcon = std::make_shared<CAnimImage>(AnimationPath::builtin("SECSK82"), 0, 0, x, y);
							baseIcon->setScale(Point(32, 32));
							tableRowWidgets.push_back(baseIcon);
							addChild(baseIcon.get(), true);
							auto overlayIcon = std::make_shared<CAnimImage>(AnimationPath::builtin("artifact"), overlayFrame, 0, x, y);
							overlayIcon->setScale(Point(32, 32));
							tableRowWidgets.push_back(overlayIcon);
							addChild(overlayIcon.get(), true);
						}
					}
				}
				else
				{
					auto rowIcon = std::make_shared<CPicture>(preparedRows[rowIndex].icon, x, y);
					rowIcon->scaleTo(Point(32, 32));
					tableRowWidgets.push_back(rowIcon);
					addChild(rowIcon.get(), true);
				}
			}
			if(preparedRows[rowIndex].hasIcon)
			{
				std::string hoverText = preparedRows[rowIndex].tooltipText;
				std::string popupText = preparedRows[rowIndex].popupText;
				if(hoverText.empty())
					hoverText = !popupText.empty() ? popupText : preparedRows[rowIndex].title;
				if(popupText.empty())
					popupText = hoverText;

				auto iconRClick = std::make_shared<LRClickableAreaWText>(
					Rect(tableSideMargin + (tableRowNameWidth - 32) / 2, tableTop + (localRow + 1) * tableRowHeight + (tableRowHeight - 32) / 2, 32, 32),
					hoverText,
					popupText);
				tableRowWidgets.push_back(iconRClick);
				addChild(iconRClick.get(), true);
			}
		else
		{
			auto rowTitle = std::make_shared<CLabel>(tableSideMargin + 6, rowY, FONT_SMALL, ETextAlignment::CENTERLEFT, Colors::WHITE, preparedRows[rowIndex].title);
			tableRowWidgets.push_back(rowTitle);
			addChild(rowTitle.get(), true);
		}
		for(int rank = 0; rank < MAX_RANKS; ++rank)
		{
			const int value = preparedRows[rowIndex].values[rank];
			std::string valueText;
			if(preparedRows[rowIndex].binary)
				valueText = value != 0 ? LIBRARY->generaltexth->translate("vcmi.stackExperience.table.yes") : LIBRARY->generaltexth->translate("vcmi.stackExperience.table.no");
			else
				valueText = (preparedRows[rowIndex].showSign && value > 0 ? "+" : "") + std::to_string(value) + (preparedRows[rowIndex].percent ? "%" : "");
			auto valueLabel = std::make_shared<CLabel>(tableSideMargin + tableRowNameWidth + rank * tableColWidth + tableColWidth / 2, rowY, FONT_SMALL, ETextAlignment::CENTER, Colors::WHITE, valueText);
			tableRowWidgets.push_back(valueLabel);
			addChild(valueLabel.get(), true);
		}
	}
}

class CCreatureArtifactInstance;
class CSelectableSkill;

class UnitView
{
public:
	// helper structs
	struct CommanderLevelInfo
	{
		std::vector<ui32> skills;
		std::function<void(ui32)> callback;
	};
	struct StackDismissInfo
	{
		std::function<void()> callback;
	};
	struct StackUpgradeInfo
	{
		StackUpgradeInfo() = delete;
		StackUpgradeInfo(const UpgradeInfo & upgradeInfo)
			: info(upgradeInfo)
		{ }
		UpgradeInfo info;
		std::function<void(CreatureID)> callback;
	};

	// pointers to permanent objects in game state
	const CCreature * creature;
	const CCommanderInstance * commander;
	const CStackInstance * stackNode;
	const CStack * stack;
	const CGHeroInstance * owner;

	// temporary objects which should be kept as copy if needed
	std::optional<CommanderLevelInfo> levelupInfo;
	std::optional<StackDismissInfo> dismissInfo;
	std::optional<StackUpgradeInfo> upgradeInfo;

	// misc fields
	unsigned int creatureCount;
	bool popupWindow;

	UnitView()
		: creature(nullptr),
		commander(nullptr),
		stackNode(nullptr),
		stack(nullptr),
		owner(nullptr),
		creatureCount(0),
		popupWindow(false)
	{
	}

	std::string getName() const
	{
		if(commander)
			return commander->getType()->getNameSingularTranslated();
		else
			return creature->getNamePluralTranslated();
	}
private:

};

CCommanderSkillIcon::CCommanderSkillIcon(std::shared_ptr<CIntObject> object_, bool isMasterAbility_, std::function<void()> callback)
	: object(),
	  isMasterAbility(isMasterAbility_),
	  isSelected(false),
	  callback(callback)
{
	pos = object_->pos;
	this->isMasterAbility = isMasterAbility_;
	setObject(object_);
}

void CCommanderSkillIcon::setObject(std::shared_ptr<CIntObject> newObject)
{
	if(object)
		removeChild(object.get());
	object = newObject;
	addChild(object.get());
	object->moveTo(pos.topLeft());
	redraw();
}

void CCommanderSkillIcon::clickPressed(const Point & cursorPosition)
{
	callback();
	isSelected = true;
	redraw();
}

void CCommanderSkillIcon::deselect()
{
	isSelected = false;
	redraw();
}

bool CCommanderSkillIcon::getIsMasterAbility()
{
	return isMasterAbility;
}

void CCommanderSkillIcon::show(Canvas &to)
{
	CIntObject::show(to);

	if(isMasterAbility && isSelected)
		to.drawBorder(pos, Colors::YELLOW, 2);
}

static ImagePath skillToFile(int skill, int level, bool selected)
{
	// FIXME: is this a correct handling?
	// level 0 = skill not present, use image with "no" suffix
	// level 1-5 = skill available, mapped to images indexed as 0-4
	// selecting skill means that it will appear one level higher (as if already upgraded)
	std::string file = "zvs/Lib1.res/_";
	switch (skill)
	{
		case ECommander::ATTACK:
			file += "AT";
			break;
		case ECommander::DEFENSE:
			file += "DF";
			break;
		case ECommander::HEALTH:
			file += "HP";
			break;
		case ECommander::DAMAGE:
			file += "DM";
			break;
		case ECommander::SPEED:
			file += "SP";
			break;
		case ECommander::SPELL_POWER:
			file += "MP";
			break;
	}
	std::string suffix;
	if (selected)
		level++; // UI will display resulting level
	if (level == 0)
		suffix = "no"; //not available - no number
	else
		suffix = std::to_string(level-1);
	if (selected)
		suffix += "="; //level-up highlight

	return ImagePath::builtin(file + suffix + ".bmp");
}

CStackWindow::CWindowSection::CWindowSection(CStackWindow * parent, const ImagePath & backgroundPath, int yOffset)
	: parent(parent)
{
	pos.y += yOffset;
	OBJECT_CONSTRUCTION;
	if(!backgroundPath.empty())
	{
		background = std::make_shared<CPicture>(backgroundPath);
		pos.w = background->pos.w;
		pos.h = background->pos.h;
	}
}

CStackWindow::ActiveSpellsSection::ActiveSpellsSection(CStackWindow * owner, int yOffset)
	: CWindowSection(owner, ImagePath::builtin("stackWindow/spell-effects"), yOffset)
{
	static const Point firstPos(6, 2); // position of 1st spell box
	static const Point offset(54, 0);  // offset of each spell box from previous

	OBJECT_CONSTRUCTION;

	const CStack * battleStack = parent->info->stack;

	assert(battleStack); // Section should be created only for battles

	//spell effects
	int printed=0; //how many effect pics have been printed
	std::vector<SpellID> spells = battleStack->activeSpells();
	for(SpellID effect : spells)
	{
		const spells::Spell * spell = LIBRARY->spells()->getById(effect);

		//not all effects have graphics (for eg. Acid Breath)
		//for modded spells iconEffect is added to SpellInt.def
		const bool hasGraphics = (effect < SpellID::THUNDERBOLT) || (effect >= SpellID::AFTER_LAST);

		if (hasGraphics)
		{
			auto spellBonuses = battleStack->getBonuses(Selector::source(BonusSource::SPELL_EFFECT, BonusSourceID(effect)));
			if (spellBonuses->empty())
				throw std::runtime_error("Failed to find effects for spell " + effect.toSpell()->getJsonKey());

			int duration = spellBonuses->front()->turnsRemain;
			std::string preferredLanguage = LIBRARY->generaltexth->getPreferredLanguage();

			MetaString spellText;
			spellText.appendTextID(spell->getDescriptionTextID(0)); // TODO: select correct mastery level?
			spellText.appendRawString("\n");
			spellText.appendTextID(Languages::getPluralFormTextID( preferredLanguage, duration, "vcmi.battleResultsWindow.spellDurationRemaining"));
			spellText.replaceNumber(duration);
			std::string spellDescription = spellText.toString();

			spellIcons.push_back(std::make_shared<CAnimImage>(AnimationPath::builtin("SpellInt"), effect + 1, 0, firstPos.x + offset.x * printed, firstPos.y + offset.y * printed));
			labels.push_back(std::make_shared<CLabel>(firstPos.x + offset.x * printed + 46, firstPos.y + offset.y * printed + 36, EFonts::FONT_TINY, ETextAlignment::BOTTOMRIGHT, Colors::WHITE, std::to_string(duration)));
			clickableAreas.push_back(std::make_shared<LRClickableAreaWText>(Rect(firstPos + offset * printed, Point(50, 38)), spellDescription, spellDescription));
			if(++printed >= 8) // interface limit reached
				break;
		}
	}
}

CStackWindow::BonusLineSection::BonusLineSection(CStackWindow * owner, size_t lineIndex)
	: CWindowSection(owner, ImagePath::builtin("stackWindow/bonus-effects"), 0)
{
	OBJECT_CONSTRUCTION;

	static const std::array<Point, 2> offset =
	{
		Point(6, 2),
		Point(214, 2)
	};

	auto drawBonusSource = [this](int leftRight, Point p, BonusInfo & bi)
	{
		std::map<BonusSource, ColorRGBA> bonusColors = {
			{BonusSource::ARTIFACT,          Colors::GREEN},
			{BonusSource::ARTIFACT_INSTANCE, Colors::GREEN},
			{BonusSource::CREATURE_ABILITY,  Colors::YELLOW},
			{BonusSource::SPELL_EFFECT,      Colors::ORANGE},
			{BonusSource::SECONDARY_SKILL,   Colors::PURPLE},
			{BonusSource::HERO_SPECIAL,      Colors::PURPLE},
			{BonusSource::STACK_EXPERIENCE,  Colors::CYAN},
			{BonusSource::COMMANDER,         Colors::CYAN},
		};

		std::map<BonusSource, std::string> bonusNames = {
			{BonusSource::ARTIFACT,          LIBRARY->generaltexth->translate("vcmi.bonusSource.artifact")},
			{BonusSource::ARTIFACT_INSTANCE, LIBRARY->generaltexth->translate("vcmi.bonusSource.artifact")},
			{BonusSource::CREATURE_ABILITY,  LIBRARY->generaltexth->translate("vcmi.bonusSource.creature")},
			{BonusSource::SPELL_EFFECT,      LIBRARY->generaltexth->translate("vcmi.bonusSource.spell")},
			{BonusSource::SECONDARY_SKILL,   LIBRARY->generaltexth->translate("vcmi.bonusSource.hero")},
			{BonusSource::HERO_SPECIAL,      LIBRARY->generaltexth->translate("vcmi.bonusSource.hero")},
			{BonusSource::STACK_EXPERIENCE,  LIBRARY->generaltexth->translate("vcmi.bonusSource.commander")},
			{BonusSource::COMMANDER,         LIBRARY->generaltexth->translate("vcmi.bonusSource.commander")},
		};

		auto c = bonusColors.count(bi.bonusSource) ? bonusColors[bi.bonusSource] : ColorRGBA(192, 192, 192);
		std::string t = bonusNames.count(bi.bonusSource) ? bonusNames[bi.bonusSource] : LIBRARY->generaltexth->translate("vcmi.bonusSource.other");
		int maxLen = 50;
		EFonts f = FONT_TINY;
		Point pText = p + Point(4, 38);

		// 1px Black border
		bonusSource[leftRight].push_back(std::make_shared<CLabel>(pText.x - 1, pText.y, f, ETextAlignment::TOPLEFT, Colors::BLACK, t, maxLen));
		bonusSource[leftRight].push_back(std::make_shared<CLabel>(pText.x + 1, pText.y, f, ETextAlignment::TOPLEFT, Colors::BLACK, t, maxLen));
		bonusSource[leftRight].push_back(std::make_shared<CLabel>(pText.x, pText.y - 1, f, ETextAlignment::TOPLEFT, Colors::BLACK, t, maxLen));
		bonusSource[leftRight].push_back(std::make_shared<CLabel>(pText.x, pText.y + 1, f, ETextAlignment::TOPLEFT, Colors::BLACK, t, maxLen));
		bonusSource[leftRight].push_back(std::make_shared<CLabel>(pText.x, pText.y, f, ETextAlignment::TOPLEFT, c, t, maxLen));

		frame[leftRight] = std::make_shared<GraphicalPrimitiveCanvas>(Rect(p.x, p.y, 52, 52));
		frame[leftRight]->addRectangle(Point(0, 0), Point(52, 52), c);
	};

	for(size_t leftRight : {0, 1})
	{
		auto position = offset[leftRight];
		size_t bonusIndex = lineIndex * 2 + leftRight;

		if(parent->activeBonuses.size() > bonusIndex)
		{
			BonusInfo & bi = parent->activeBonuses[bonusIndex];
			if (!bi.imagePath.empty())
				icon[leftRight] = std::make_shared<CPicture>(bi.imagePath, position.x, position.y);

			description[leftRight] = std::make_shared<CMultiLineLabel>(Rect(position.x + 60, position.y, 137, 50), FONT_TINY, ETextAlignment::TOPLEFT, Colors::WHITE, bi.description);
			drawBonusSource(leftRight, Point(position.x - 1, position.y - 1), bi);
		}
	}
}

CStackWindow::BonusesSection::BonusesSection(CStackWindow * owner, int yOffset, std::optional<size_t> preferredSize):
	CWindowSection(owner, {}, yOffset)
{
	OBJECT_CONSTRUCTION;

	// size of single image for an item
	static const int itemHeight = 59;

	size_t totalSize = (owner->activeBonuses.size() + 1) / 2;
	size_t visibleSize = preferredSize.value_or(std::min<size_t>(3, totalSize));

	pos.w = owner->pos.w;
	pos.h = itemHeight * (int)visibleSize;

	auto onCreate = [=](size_t index) -> std::shared_ptr<CIntObject>
	{
		return std::make_shared<BonusLineSection>(owner, index);
	};

	lines = std::make_shared<CListBox>(onCreate, Point(0, 0), Point(0, itemHeight), visibleSize, totalSize, 0, totalSize > 3 ? 1 : 0, Rect(pos.w - 15, 0, pos.h, pos.h));
	lines->onScroll = [owner](){ owner->redraw(); };
}

CStackWindow::ButtonsSection::ButtonsSection(CStackWindow * owner, int yOffset)
	: CWindowSection(owner, ImagePath::builtin("stackWindow/button-panel"), yOffset)
{
	OBJECT_CONSTRUCTION;

	if(parent->info->dismissInfo && parent->info->dismissInfo->callback)
	{
		auto onDismiss = [this]()
		{
			parent->info->dismissInfo->callback();
			parent->close();
		};
		auto onClick = [=] ()
		{
			GAME->interface()->showYesNoDialog(LIBRARY->generaltexth->allTexts[12], onDismiss, nullptr);
		};
		dismiss = std::make_shared<CButton>(Point(5, 5),AnimationPath::builtin("IVIEWCR2.DEF"), LIBRARY->generaltexth->zelp[445], onClick, EShortcut::HERO_DISMISS);
	}

	if(parent->info->upgradeInfo && !parent->info->commander)
	{
		// used space overlaps with commander switch button
		// besides - should commander really be upgradeable?

		auto & upgradeInfo = parent->info->upgradeInfo.value();
		const size_t buttonsToCreate = std::min<size_t>(upgradeInfo.info.size(), upgrade.size());

		for(size_t buttonIndex = 0; buttonIndex < buttonsToCreate; buttonIndex++)
		{
			TResources totalCost = upgradeInfo.info.getAvailableUpgradeCosts().at(buttonIndex) * parent->info->creatureCount;

			auto onUpgrade = [this, upgradeInfo, buttonIndex]()
			{
				upgradeInfo.callback(upgradeInfo.info.getAvailableUpgrades().at(buttonIndex));
				parent->close();
			};
			auto onClick = [totalCost, onUpgrade]()
			{
				std::vector<std::shared_ptr<CComponent>> resComps;
				for(TResources::nziterator i(totalCost); i.valid(); i++)
				{
					resComps.push_back(std::make_shared<CComponent>(ComponentType::RESOURCE, i->resType, i->resVal));
				}

				if(GAME->interface()->cb->getResourceAmount().canAfford(totalCost))
				{
					GAME->interface()->showYesNoDialog(LIBRARY->generaltexth->allTexts[207], onUpgrade, nullptr, resComps);
				}
					else
					{
						GAME->interface()->showInfoDialog(LIBRARY->generaltexth->allTexts[314], resComps);
					}
			};
			auto upgradeBtn = std::make_shared<CButton>(Point(221 + (int)buttonIndex * 40, 5), AnimationPath::builtin("stackWindow/upgradeButton"), LIBRARY->generaltexth->zelp[446], onClick);

			upgradeBtn->setOverlay(std::make_shared<CAnimImage>(AnimationPath::builtin("CPRSMALL"), LIBRARY->creh->objects[upgradeInfo.info.getAvailableUpgrades()[buttonIndex]]->getIconIndex()));

			if(buttonsToCreate == 1) // single upgrade available
				upgradeBtn->assignedKey = EShortcut::RECRUITMENT_UPGRADE;

			upgrade[buttonIndex] = upgradeBtn;
		}
	}

	if(parent->info->commander)
	{
		for(size_t buttonIndex = 0; buttonIndex < 2; buttonIndex++)
		{
			std::string btnIDs[2] = { "showSkills", "showBonuses" };
			auto onSwitch = [buttonIndex, this]()
			{
				logAnim->debug("Switch %d->%d", parent->activeTab, buttonIndex);

				parent->switchButtons[parent->activeTab]->enable();
				parent->commanderTab->setActive(buttonIndex);
				parent->switchButtons[buttonIndex]->disable();
				parent->redraw(); // FIXME: enable/disable don't redraw screen themselves
			};

			std::string tooltipText = "vcmi.creatureWindow." + btnIDs[buttonIndex];
			parent->switchButtons[buttonIndex] = std::make_shared<CButton>(Point(342, 5), AnimationPath::builtin("stackWindow/upgradeButton"), CButton::tooltipLocalized(tooltipText), onSwitch);
			parent->switchButtons[buttonIndex]->setOverlay(std::make_shared<CAnimImage>(AnimationPath::builtin("stackWindow/switchModeIcons"), buttonIndex));
		}
		parent->switchButtons[parent->activeTab]->disable();
	}

	exit = std::make_shared<CButton>(Point(382, 5), AnimationPath::builtin("hsbtns.def"), LIBRARY->generaltexth->zelp[447], [this](){ parent->close(); }, EShortcut::GLOBAL_RETURN);
}

CStackWindow::CommanderMainSection::CommanderMainSection(CStackWindow * owner, int yOffset)
	: CWindowSection(owner, ImagePath::builtin("stackWindow/commander-bg"), yOffset)
{
	OBJECT_CONSTRUCTION;

	auto getSkillPos = [](int index)
	{
		return Point(10 + 80 * (index%3), 20 + 80 * (index/3));
	};

	auto getSkillImage = [this](int skillIndex)
	{
		bool selected = ((parent->selectedSkill == skillIndex) && parent->info->levelupInfo );
		return skillToFile(skillIndex, parent->info->commander->secondarySkills[skillIndex], selected);
	};

	auto getSkillDescription = [this](int skillIndex) -> std::string
	{
		return parent->getCommanderSkillDescription(skillIndex, parent->info->commander->secondarySkills[skillIndex]);
	};

	for(int index = ECommander::ATTACK; index <= ECommander::SPELL_POWER; ++index)
	{
		Point skillPos = getSkillPos(index);

		auto icon = std::make_shared<CCommanderSkillIcon>(std::make_shared<CPicture>(getSkillImage(index), skillPos.x, skillPos.y), false, [=]()
		{
			GAME->interface()->showInfoDialog(getSkillDescription(index));
		});

		icon->text = getSkillDescription(index); //used to handle right click description via LRClickableAreaWText::ClickRight()

		if(parent->selectedSkill == index)
			parent->selectedIcon = icon;

		if(parent->info->levelupInfo && vstd::contains(parent->info->levelupInfo->skills, index)) // can be upgraded - enable selection switch
		{
			if(parent->selectedSkill == index)
				parent->setSelection(index, icon);

			icon->callback = [this, index, icon]()
			{
				parent->setSelection(index, icon);
			};
		}

		skillIcons.push_back(icon);
	}

	auto getArtifactPos = [](int index)
	{
		return Point(269 + 52 * (index % 3), 22 + 52 * (index / 3));
	};

	for(auto equippedArtifact : parent->info->commander->artifactsWorn)
	{
		Point artPos = getArtifactPos(equippedArtifact.first);
		const auto commanderArt = equippedArtifact.second.getArt();
		assert(commanderArt);
		auto artPlace = std::make_shared<CCommanderArtPlace>(artPos, parent->info->owner, equippedArtifact.first, commanderArt->getTypeId());
		artifacts.push_back(artPlace);
	}

	if(parent->info->levelupInfo)
	{
		static constexpr ui32 commanderAbilitySkillOffset = 100;

		abilitiesBackground = std::make_shared<CPicture>(ImagePath::builtin("stackWindow/commander-abilities.png"));
		abilitiesBackground->moveBy(Point(0, pos.h));

		std::vector<ui32> abilitySkills;
		abilitySkills.reserve(parent->info->levelupInfo->skills.size());
		for(ui32 skillID : parent->info->levelupInfo->skills)
		{
			if(skillID >= commanderAbilitySkillOffset)
				abilitySkills.push_back(skillID);
		}
		size_t abilitiesCount = abilitySkills.size();

		auto onCreate = [this, abilitySkills](size_t index)->std::shared_ptr<CIntObject>
		{
			if(index >= abilitySkills.size())
				return nullptr;

			const ui32 skillID = abilitySkills[index];
			const auto bonuses = LIBRARY->creh->skillRequirements[skillID - commanderAbilitySkillOffset].first;
			const CStackInstance * stack = parent->info->commander;
			auto icon = std::make_shared<CCommanderSkillIcon>(std::make_shared<CPicture>(stack->bonusToGraphics(bonuses[0])), true, [](){});
			icon->callback = [this, skillID, icon]()
			{
				parent->setSelection(skillID, icon);
			};
			std::string abilityDescription;
			for(size_t i = 0; i < bonuses.size(); i++)
			{
				if(!abilityDescription.empty())
					abilityDescription += "\n";

				abilityDescription += LIBRARY->bth->bonusToString(bonuses[i]);
			}

			icon->hoverText = abilityDescription;
			icon->text = abilityDescription;

			return icon;
		};

		abilities = std::make_shared<CListBox>(onCreate, Point(38, 3+pos.h), Point(63, 0), 6, abilitiesCount);
		abilities->onScroll = [owner](){ owner->redraw(); };

		leftBtn = std::make_shared<CButton>(Point(10,  pos.h + 6), AnimationPath::builtin("hsbtns3.def"), CButton::tooltip(), [this](){ abilities->moveToPrev(); }, EShortcut::MOVE_LEFT);
		rightBtn = std::make_shared<CButton>(Point(411, pos.h + 6), AnimationPath::builtin("hsbtns5.def"), CButton::tooltip(), [this](){ abilities->moveToNext(); }, EShortcut::MOVE_RIGHT);

		if(abilitiesCount <= 6)
		{
			leftBtn->block(true);
			rightBtn->block(true);
		}

		pos.h += abilitiesBackground->pos.h;
	}
}
