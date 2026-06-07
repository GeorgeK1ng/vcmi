/*
 * SerializerReflectionTest.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 */

#include "StdInc.h"

#include "../../lib/serializer/SerializerReflection.h"

namespace test
{

TEST(SerializerReflectionTest, lobbyPrepareStartGameHasRegisteredLoader)
{
	auto & registry = CSerializationApplier::getInstance();

	EXPECT_NE(registry.getApplier(223), nullptr);
	EXPECT_NE(registry.getTypeName(223).find("LobbyPrepareStartGame"), std::string::npos);
}

}
