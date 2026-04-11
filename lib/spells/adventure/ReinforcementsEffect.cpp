/*
 * ReinforcementsEffect.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */

#include "StdInc.h"
#include "ReinforcementsEffect.h"

#include "AdventureSpellMechanics.h"

#include "../CSpellHandler.h"

#include "../../CPlayerState.h"
#include "../../callback/IGameInfoCallback.h"
#include "../../mapObjects/CGHeroInstance.h"
#include "../../mapObjects/CGTownInstance.h"
#include "../../mapping/CMap.h"
#include "../../networkPacks/PacksForClient.h"

VCMI_LIB_NAMESPACE_BEGIN

ReinforcementsEffect::ReinforcementsEffect(const CSpell * s, const JsonNode & config)
	: owner(s)
	, allowTownSelection(config["allowTownSelection"].Bool())
{
}

ESpellCastResult ReinforcementsEffect::beginCast(SpellCastEnvironment * env, const AdventureSpellCastParameters & parameters, const AdventureSpellMechanics & mechanics) const
{
	std::vector<const CGTownInstance *> towns = getPossibleTowns(env, parameters);

	if(!parameters.caster->getHeroCaster())
	{
		env->complain("Not a hero caster!");
		return ESpellCastResult::ERROR;
	}

	if(towns.empty())
	{
		InfoWindow iw;
		iw.player = parameters.caster->getCasterOwner();
		iw.text.appendLocalString(EMetaText::GENERAL_TXT, 124);
		env->apply(iw);
		return ESpellCastResult::CANCEL;
	}

	if(!parameters.pos.isValid() && allowTownSelection)
	{
		auto queryCallback = [&mechanics, env, parameters](std::optional<int32_t> reply) -> void
		{
			if(reply.has_value())
			{
				ObjectInstanceID townId(*reply);

				const CGObjectInstance * object = env->getCb()->getObj(townId, true);
				if(object == nullptr)
				{
					env->complain("Invalid object instance selected");
					return;
				}

				if(!dynamic_cast<const CGTownInstance *>(object))
				{
					env->complain("Object instance is not town");
					return;
				}

				AdventureSpellCastParameters nextCast;
				nextCast.caster = parameters.caster;
				nextCast.pos = object->visitablePos();
				mechanics.performCast(env, nextCast);
			}
		};

		MapObjectSelectDialog request;
		request.player = parameters.caster->getCasterOwner();
		request.title.appendLocalString(EMetaText::JK_TXT, 40);
		request.description.appendLocalString(EMetaText::JK_TXT, 41);
		request.icon = Component(ComponentType::SPELL, owner->id);

		for(const auto * town : towns)
			request.objects.push_back(town->id);

		env->genericQuery(&request, request.player, queryCallback);
		return ESpellCastResult::PENDING;
	}

	return ESpellCastResult::OK;
}

ESpellCastResult ReinforcementsEffect::applyAdventureEffects(SpellCastEnvironment * env, const AdventureSpellCastParameters & parameters) const
{
	const CGTownInstance * destination = nullptr;
	std::vector<const CGTownInstance *> towns = getPossibleTowns(env, parameters);

	if(!parameters.caster->getHeroCaster())
	{
		env->complain("Not a hero caster!");
		return ESpellCastResult::ERROR;
	}

	if(!allowTownSelection)
	{
		destination = findNearestTown(parameters, towns);
	}
	else if(env->getMap()->isInTheMap(parameters.pos))
	{
		const TerrainTile & tile = env->getMap()->getTile(parameters.pos);
		ObjectInstanceID topObjID = tile.topVisitableObj(false);
		const CGObjectInstance * topObj = env->getMap()->getObject(topObjID);
		destination = dynamic_cast<const CGTownInstance *>(topObj);
	}

	if(destination == nullptr)
	{
		env->complain("Failed to find destination town for reinforcements");
		return ESpellCastResult::ERROR;
	}

	env->showGarrisonDialog(destination->id, ObjectInstanceID(parameters.caster->getCasterUnitId()), true);
	return ESpellCastResult::OK;
}

const CGTownInstance * ReinforcementsEffect::findNearestTown(const AdventureSpellCastParameters & parameters, const std::vector<const CGTownInstance *> & pool) const
{
	if(pool.empty() || !parameters.caster->getHeroCaster())
		return nullptr;

	auto nearest = pool.cbegin();
	si32 distance = (*nearest)->visitablePos().dist2dSQ(parameters.caster->getHeroCaster()->visitablePos());

	for(auto iter = nearest + 1; iter != pool.cend(); ++iter)
	{
		si32 currentDistance = (*iter)->visitablePos().dist2dSQ(parameters.caster->getHeroCaster()->visitablePos());

		if(currentDistance < distance)
		{
			nearest = iter;
			distance = currentDistance;
		}
	}

	return *nearest;
}

std::vector<const CGTownInstance *> ReinforcementsEffect::getPossibleTowns(SpellCastEnvironment * env, const AdventureSpellCastParameters & parameters) const
{
	std::vector<const CGTownInstance *> result;

	const TeamState * team = env->getCb()->getPlayerTeam(parameters.caster->getCasterOwner());
	for(const auto & color : team->players)
	{
		for(const auto * town : env->getCb()->getPlayerState(color)->getTowns())
			result.push_back(town);
	}

	return result;
}

VCMI_LIB_NAMESPACE_END
