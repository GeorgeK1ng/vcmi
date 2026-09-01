/*
 * CSpellTest.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"

#include "../../lib/spells/CSpell.h"

namespace test
{
using namespace ::spells;
using namespace ::testing;

class CSpellTest : public Test
{
public:
	MOCK_METHOD4(registarCb, void(int32_t, int32_t, const std::string &, const std::string &));
	std::shared_ptr<CSpell> subject;

	std::string configureAndFormatDescription(const std::string & source)
	{
		subject->level = 4;
		subject->power = 12;
		subject->levels[1].power = 20;
		subject->levels[2].power = 30;
		subject->levels[2].cost = 15;
		subject->levels[2].textValues["speedPenalty"] = "25";
		subject->levels[2].textValues["healthDuration"] = "3";
		return subject->formatDescriptionText(source, 2);
	}
protected:
	void SetUp() override
	{
		subject = std::make_shared<CSpell>();
		subject->iconBook = "Test1";
		subject->iconEffect = "Test2";
		subject->iconScenarioBonus = "Test3";
		subject->iconScroll = "Test4";
	}
};

TEST_F(CSpellTest, RegistersIcons)
{
	subject->id = SpellID(42);

	auto cb = std::bind(&CSpellTest::registarCb, this, _1, _2, _3, _4);

	EXPECT_CALL(*this, registarCb(Eq(42), Eq(0), "SPELLS", "Test1"));
	EXPECT_CALL(*this, registarCb(Eq(43), Eq(0), "SPELLINT", "Test2"));
	EXPECT_CALL(*this, registarCb(Eq(42), Eq(0), "SPELLBON", "Test3"));
	EXPECT_CALL(*this, registarCb(Eq(42), Eq(0), "SPELLSCR", "Test4"));

	subject->registerIcons(cb);
}

TEST_F(CSpellTest, FormatsDescriptionPlaceholders)
{
	const std::string source = "%spellLevel%/%basePower%/%basicPower%/%levelPower%/%power%/%powerDifference%/%spellPoints%/%cost%/%schoolLevel%/%speedPenalty%/%healthDuration%";
	EXPECT_EQ("4/12/20/30/30/10/15/15/2/25/3", configureAndFormatDescription(source));
}

}
