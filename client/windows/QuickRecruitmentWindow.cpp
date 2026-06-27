/*
 * QuickRecruitmentWindow.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "QuickRecruitmentWindow.h"
#include "../../lib/mapObjects/CGTownInstance.h"
#include "../CPlayerInterface.h"
#include "../widgets/Buttons.h"
#include "../widgets/CreatureCostBox.h"
#include "../widgets/CViewport.h"
#include "../widgets/GraphicalPrimitiveCanvas.h"
#include "../widgets/Images.h"
#include "../widgets/TextControls.h"
#include "../GameEngine.h"
#include "../GameInstance.h"
#include "../gui/Shortcut.h"
#include "../../lib/callback/CCallback.h"
#include "../../lib/GameLibrary.h"
#include "../../lib/texts/CGeneralTextHandler.h"
#include "../../lib/CCreatureHandler.h"
#include "CreaturePurchaseCard.h"


void QuickRecruitmentWindow::setButtons()
{
	setCancelButton();
	setBuyButton();
	setMaxButton();
}

void QuickRecruitmentWindow::setCancelButton()
{
	cancelButton = std::make_shared<CButton>(Point((pos.w / 2) + 48, pos.h - 88), AnimationPath::builtin("ICN6432.DEF"), LIBRARY->generaltexth->zelp[555], [&](){ close(); }, EShortcut::GLOBAL_CANCEL);
	cancelButton->setImageOrder(0, 1, 2, 3);
}

void QuickRecruitmentWindow::setBuyButton()
{
	buyButton = std::make_shared<CButton>(Point((pos.w / 2) - 32, pos.h - 88), AnimationPath::builtin("IBY6432.DEF"), LIBRARY->generaltexth->zelp[554], [&](){ purchaseUnits(); }, EShortcut::GLOBAL_ACCEPT);
	buyButton->setImageOrder(0, 1, 2, 3);
}

void QuickRecruitmentWindow::setMaxButton()
{
	maxButton = std::make_shared<CButton>(Point((pos.w/2)-112, pos.h - 88), AnimationPath::builtin("IRCBTNS.DEF"), LIBRARY->generaltexth->zelp[553], [&](){ maxAllCards(cards); }, EShortcut::RECRUITMENT_MAX);
	maxButton->setImageOrder(0, 1, 2, 3);
}

int QuickRecruitmentWindow::getDialogWidthForCards(int cardsCount) const
{
	return 44 + std::max(cardsCount, 4) * 110;
}

int QuickRecruitmentWindow::getVisibleCards(int creaturesAmount) const
{
	int result = std::clamp(creaturesAmount, 1, 8);
	while(result > 4 && getDialogWidthForCards(result) > ENGINE->screenDimensions().x)
		--result;
	return result;
}

int QuickRecruitmentWindow::getTotalCostBoxWidth(const TResources & resources) const
{
	int resourcesCount = 0;
	TResources::nziterator iter(resources);
	while(iter.valid())
	{
		++resourcesCount;
		iter++;
	}

	return resourcesCount <= 2 ? 97 : 226;
}

void QuickRecruitmentWindow::setCreaturePurchaseCards()
{
	const int availableAmount = getAvailableCreatures();
	const int viewportWidth = pos.w - 2 * 22;
	const int contentWidth = availableAmount * 100 + std::max(0, availableAmount - 1) * (108 - 100);
	cardsViewport = std::make_shared<CViewport>(Rect(22, 22, viewportWidth, 340), Point(contentWidth, 340));

	Point position(0, 50);
	{
		OBJECT_CONSTRUCTION_TARGETED(cardsViewport->content());
		for(int i = 0; i < town->getTown()->creatures.size(); i++)
		{
			if(!town->getTown()->creatures.at(i).empty() && !town->creatures.at(i).second.empty() && town->creatures[i].first)
			{
				cards.push_back(std::make_shared<CreaturePurchaseCard>(town->creatures[i].second, position, town->creatures[i].first, this));
				position.x += 108;
			}
		}
	}
	cardsViewport->setContentSize(Point(std::max(viewportWidth, contentWidth), 340));
}

void QuickRecruitmentWindow::updateTotalCostBox(const TResources & resources)
{
	const int totalCostBoxWidth = getTotalCostBoxWidth(resources);
	const Rect totalCostRect(pos.w / 2 - totalCostBoxWidth / 2, 380, totalCostBoxWidth, 74);

	if(totalCost && totalCost->pos.w == totalCostBoxWidth)
	{
		totalCost->createItems(resources);
		totalCost->set(resources);
		return;
	}

	totalCost.reset();
	totalCostBackground.reset();

	OBJECT_CONSTRUCTION_TARGETED(this);
	totalCostBackground = std::make_shared<TransparentFilledRectangle>(totalCostRect, ColorRGBA(0, 0, 0, 75), ColorRGBA(128, 100, 75));
	totalCost = std::make_shared<CreatureCostBox>(totalCostRect, "");
	totalCost->createItems(resources);
	totalCost->set(resources);
}

void QuickRecruitmentWindow::initWindow(Rect /*startupPosition*/)
{
	const int creaturesAmount = getAvailableCreatures();
	visibleCards = getVisibleCards(creaturesAmount);
	pos.w = getDialogWidthForCards(visibleCards);
	pos.h = 540;
	center();

	backgroundTexture = std::make_shared<CFilledTexture>(ImagePath::builtin("DIBOXBCK"), Rect(0, 0, pos.w, pos.h));
	statusbarBackground = std::make_shared<TransparentFilledRectangle>(Rect(8, pos.h - 26, pos.w - 16, 19), ColorRGBA(0, 0, 0, 75), ColorRGBA(128, 100, 75));
	statusbar = CGStatusBar::create(statusbarBackground);
}

void QuickRecruitmentWindow::maxAllCards(std::vector<std::shared_ptr<CreaturePurchaseCard> > cards)
{
	auto allAvailableResources = GAME->interface()->cb->getResourceAmount();
	for(auto i : boost::adaptors::reverse(cards))
	{
		si32 maxAmount = i->creatureOnTheCard->maxAmount(allAvailableResources);
		vstd::amin(maxAmount, i->maxAmount);

		i->slider->setAmount(maxAmount);

		if(i->slider->getValue() != maxAmount)
			i->slider->scrollTo(maxAmount);
		else
			i->sliderMoved(maxAmount);

		i->slider->scrollToMax();
		allAvailableResources -= (i->creatureOnTheCard->getFullRecruitCost() * maxAmount);
	}
	maxButton->block(allAvailableResources == GAME->interface()->cb->getResourceAmount());
}

void QuickRecruitmentWindow::purchaseUnits()
{
	int freeSlotsLeft = town->getUpperArmy()->getFreeSlots().size();

	for(auto selected : boost::adaptors::reverse(cards))
	{
		if(selected->slider->getValue() == 0)
			continue;

		int level = 0;
		int i = 0;
		for(auto c : town->getTown()->creatures)
		{
			for(auto c2 : c)
				if(c2 == selected->creatureOnTheCard->getId())
					level = i;
			i++;
		}

		CreatureID crid = selected->creatureOnTheCard->getId();
		SlotID dstslot = town->getUpperArmy()->getSlotFor(crid);

		if(town->getUpperArmy()->slotEmpty(dstslot))
		{
			if(freeSlotsLeft == 0)
				continue;
			freeSlotsLeft -= 1;
		}

		if(dstslot.validSlot())
			GAME->interface()->cb->recruitCreatures(town, town->getUpperArmy(), crid, selected->slider->getValue(), level);
	}
	close();
}

int QuickRecruitmentWindow::getAvailableCreatures()
{
	int creaturesAmount = 0;
	for(int i=0; i< town->getTown()->creatures.size(); i++)
		if(!town->getTown()->creatures.at(i).empty() && !town->creatures.at(i).second.empty() && town->creatures[i].first)
			creaturesAmount++;
	return creaturesAmount;
}

void QuickRecruitmentWindow::updateAllSliders()
{
	auto allAvailableResources = GAME->interface()->cb->getResourceAmount();
	for(auto i : boost::adaptors::reverse(cards))
		allAvailableResources -= (i->creatureOnTheCard->getFullRecruitCost() * i->slider->getValue());
	for(auto i : cards)
	{
		si32 maxAmount = i->creatureOnTheCard->maxAmount(allAvailableResources);
		vstd::amin(maxAmount, i->maxAmount);
		if(maxAmount < 0)
			continue;
		if(i->slider->getValue() + maxAmount < i->maxAmount)
			i->slider->setAmount(i->slider->getValue() + maxAmount);
		else
			i->slider->setAmount(i->maxAmount);
		i->slider->scrollTo(i->slider->getValue());
	}
	const auto totalResources = GAME->interface()->cb->getResourceAmount() - allAvailableResources;
	updateTotalCostBox(totalResources);
}

QuickRecruitmentWindow::QuickRecruitmentWindow(const CGTownInstance * townd, Rect startupPosition)
	: CWindowObject(PLAYER_COLORED | BORDERED),
	town(townd),
	visibleCards(4)
{
	OBJECT_CONSTRUCTION;

	initWindow(startupPosition);
	setButtons();
	setCreaturePurchaseCards();
	maxAllCards(cards);
}
