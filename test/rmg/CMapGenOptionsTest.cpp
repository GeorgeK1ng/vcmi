/*
 * CMapGenOptionsTest.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */

#include "StdInc.h"

#include "../../lib/rmg/CMapGenOptions.h"

namespace test
{
using namespace ::testing;

TEST(CMapGenOptionsTest, CountsAllComputerControlledPlayers)
{
	CMapGenOptions options;
	options.setHumanOrCpuPlayerCount(2);
	options.setCompOnlyPlayerCount(1);
	options.setPlayerTypeForStandardPlayer(PlayerColor(0), EPlayerType::HUMAN);
	options.setPlayerTypeForStandardPlayer(PlayerColor(1), EPlayerType::AI);

	EXPECT_EQ(options.getComputerPlayerCount(), 2);
}

TEST(CMapGenOptionsTest, DoesNotCountHumanControlledPlayers)
{
	CMapGenOptions options;
	options.setHumanOrCpuPlayerCount(2);
	options.setCompOnlyPlayerCount(0);
	options.setPlayerTypeForStandardPlayer(PlayerColor(0), EPlayerType::HUMAN);
	options.setPlayerTypeForStandardPlayer(PlayerColor(1), EPlayerType::HUMAN);

	EXPECT_EQ(options.getComputerPlayerCount(), 0);
}

}
