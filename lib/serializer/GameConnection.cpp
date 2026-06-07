/*
 * GameConnection.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "GameConnection.h"

#include "BinaryDeserializer.h"
#include "BinarySerializer.h"

#include "../gameState/CGameState.h"
#include "../networkPacks/NetPacksBase.h"
#include "../network/NetworkInterface.h"

VCMI_LIB_NAMESPACE_BEGIN

class GameConnectionPackWriter final : public IBinaryWriter
{
public:
	std::vector<std::byte> buffer;

	int write(const std::byte * data, unsigned size) final;
};

class GameConnectionPackReader final : public IBinaryReader
{
public:
	const std::vector<std::byte> * buffer;
	size_t position;

	int read(std::byte * data, unsigned size) final;
};

int GameConnectionPackWriter::write(const std::byte * data, unsigned size)
{
	buffer.insert(buffer.end(), data, data + size);
	return size;
}

int GameConnectionPackReader::read(std::byte * data, unsigned size)
{
	if (position + size > buffer->size())
		throw std::runtime_error("End of file reached when reading received network pack!");

	std::copy_n(buffer->begin() + position, size, data);
	position += size;
	return size;
}

GameConnection::GameConnection(std::weak_ptr<INetworkConnection> networkConnection)
	: networkConnection(networkConnection)
	, packReader(std::make_unique<GameConnectionPackReader>())
	, packWriter(std::make_unique<GameConnectionPackWriter>())
	, deserializer(std::make_unique<BinaryDeserializer>(packReader.get()))
	, serializer(std::make_unique<BinarySerializer>(packWriter.get()))
{
	assert(networkConnection.lock() != nullptr);

	enterLobbyConnectionMode();
	setSerializationVersion(ESerializationVersion::CURRENT);
}

GameConnection::~GameConnection() = default;

void GameConnection::sendPack(const CPack & pack)
{
	std::scoped_lock lock(writeMutex);

	auto connectionPtr = networkConnection.lock();

	if (!connectionPtr)
		throw std::runtime_error("Attempt to send packet on a closed connection!");

	packWriter->buffer.clear();
	try
	{
		*serializer & &pack;
		logNetwork->trace("Sending a pack of type %s", typeid(pack).name());
		connectionPtr->sendPacket(packWriter->buffer);
	}
	catch(const std::exception & e)
	{
		logNetwork->error("Failed to send network pack of type %s: %s", typeid(pack).name(), e.what());
		packWriter->buffer.clear();
		serializer->clear();
		throw;
	}
	packWriter->buffer.clear();
	serializer->clear();
}

std::unique_ptr<CPack> GameConnection::retrievePack(const std::vector<std::byte> & data)
{
	std::scoped_lock lock(readMutex);
	std::unique_ptr<CPack> result;

	packReader->buffer = &data;
	packReader->position = 0;

	try
	{
		*deserializer & result;

		if (result == nullptr)
			throw std::runtime_error("deserializer returned a null pack");

		if (packReader->position != data.size())
			throw std::runtime_error("not all pack data has been read");
	}
	catch(const std::exception & e)
	{
		deserializer->clear();
		packReader->buffer = nullptr;
		throw std::runtime_error("Failed to retrieve network pack: " + std::string(e.what()));
	}

	auto packRawPtr = result.get();
	logNetwork->trace("Received CPack of type %s", typeid(*packRawPtr).name());
	deserializer->clear();
	packReader->buffer = nullptr;
	return result;
}

bool GameConnection::isMyConnection(const std::shared_ptr<INetworkConnection> & otherConnection) const
{
	return otherConnection != nullptr && networkConnection.lock() == otherConnection;
}

std::shared_ptr<INetworkConnection> GameConnection::getConnection()
{
	return networkConnection.lock();
}

void GameConnection::enterLobbyConnectionMode()
{
	std::scoped_lock lock(readMutex, writeMutex);
	deserializer->clear();
	serializer->clear();
}

void GameConnection::setCallback(IGameInfoCallback & cb)
{
	std::scoped_lock lock(readMutex);
	deserializer->cb = &cb;
}

void GameConnection::setSerializationVersion(ESerializationVersion version)
{
	std::scoped_lock lock(readMutex, writeMutex);
	deserializer->version = version;
	serializer->version = version;
}

VCMI_LIB_NAMESPACE_END
