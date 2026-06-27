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
#include "../widgets/GraphicalPrimitiveCanvas.h"
#include "../widgets/Slider.h"
#include "../widgets/TextControls.h"
#include "../GameEngine.h"
#include "../GameInstance.h"
#include "../gui/Shortcut.h"
#include "../../lib/callback/CCallback.h"
#include "../../lib/ResourceSet.h"
#include "../../lib/CCreatureHandler.h"
#include "CreaturePurchaseCard.h"


void QuickRecruitmentWindow::setButtons()
{
	setCancelButton();
	setBuyButton();
	setMaxButton();
	setScrollBar();
}

void QuickRecruitmentWindow::setCancelButton()
{
	cancelButton = std::make_shared<CButton>(Point((pos.w / 2) + 48, pos.h - 63), AnimationPath::builtin("ICN6432.DEF"), CButton::tooltip(), [&](){ close(); }, EShortcut::GLOBAL_CANCEL);
	cancelButton->setImageOrder(0, 1, 2, 3);
}

void QuickRecruitmentWindow::setBuyButton()
{
	buyButton = std::make_shared<CButton>(Point((pos.w / 2) - 32, pos.h - 63), AnimationPath::builtin("IBY6432.DEF"), CButton::tooltip(), [&](){ purchaseUnits(); }, EShortcut::GLOBAL_ACCEPT);
	buyButton->setImageOrder(0, 1, 2, 3);
}

void QuickRecruitmentWindow::setMaxButton()
{
	maxButton = std::make_shared<CButton>(Point((pos.w/2)-112, pos.h - 63), AnimationPath::builtin("IRCBTNS.DEF"), CButton::tooltip(), [&](){ maxAllCards(cards); }, EShortcut::RECRUITMENT_MAX);
	maxButton->setImageOrder(0, 1, 2, 3);
}

void QuickRecruitmentWindow::setScrollBar()
{
	if(getAvailableCreatures() <= visibleCards)
		return;

	cardsSlider = std::make_shared<CSlider>(Point(22, 338), pos.w - 44, std::bind(&QuickRecruitmentWindow::scrollCards, this, _1), visibleCards, getAvailableCreatures(), 0, Orientation::HORIZONTAL);
	cardsSlider->setScrollBounds(Rect(0, -276, pos.w - 44, 307));
}

void QuickRecruitmentWindow::scrollCards(int to)
{
	const int newOffset = -to * 108;
	const int delta = newOffset - cardsOffsetX;
	cardsOffsetX = newOffset;
	for(const auto & card : cards)
		card->moveBy(Point(delta, 0));
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

std::string QuickRecruitmentWindow::getBackgroundName(int visibleCards) const
{
	return "TPRCRTQ" + std::to_string(std::clamp(visibleCards, 1, 8));
}

int QuickRecruitmentWindow::getTotalCostBoxWidth() const
{
	return 226;
}

void QuickRecruitmentWindow::setCreaturePurchaseCards()
{
	Point position = Point((pos.w - 100*visibleCards - 8*(visibleCards-1))/2,64);
	for (int i = 0; i < town->getTown()->creatures.size(); i++)
	{
		if(!town->getTown()->creatures.at(i).empty() && !town->creatures.at(i).second.empty() && town->creatures[i].first)
		{
			cards.push_back(std::make_shared<CreaturePurchaseCard>(town->creatures[i].second, position, town->creatures[i].first, this));
			position.x += 108;
		}
	}
	const int totalCostBoxWidth = getTotalCostBoxWidth();
	totalCostBackground = std::make_shared<TransparentFilledRectangle>(Rect(pos.w / 2 - totalCostBoxWidth / 2, position.y + 280, totalCostBoxWidth, 74), ColorRGBA(0, 0, 0, 75), ColorRGBA(128, 100, 75));
	totalCost = std::make_shared<CreatureCostBox>(Rect(pos.w / 2 - totalCostBoxWidth / 2, position.y + 280, totalCostBoxWidth, 74), "");
}

void QuickRecruitmentWindow::initWindow(Rect /*startupPosition*/)
{
	const int creaturesAmount = getAvailableCreatures();
	visibleCards = getVisibleCards(creaturesAmount);
	cardsOffsetX = 0;
	setBackground(ImagePath::builtin(getBackgroundName(visibleCards)));
	center();
	statusbar = CGStatusBar::create(std::make_shared<CPicture>(background->getSurface(), Rect(8, pos.h - 26, pos.w - 16, 19), 8, pos.h - 26));
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
	for (int i=0; i< town->getTown()->creatures.size(); i++)
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
	totalCost->createItems(GAME->interface()->cb->getResourceAmount() - allAvailableResources);
	totalCost->set(GAME->interface()->cb->getResourceAmount() - allAvailableResources);
}

QuickRecruitmentWindow::QuickRecruitmentWindow(const CGTownInstance * townd, Rect startupPosition)
	: CWindowObject(PLAYER_COLORED_BORDERED_STATUSBAR),
	town(townd),
	visibleCards(4),
	cardsOffsetX(0)
{
	OBJECT_CONSTRUCTION;

	initWindow(startupPosition);
	setButtons();
	setCreaturePurchaseCards();
	maxAllCards(cards);

}
