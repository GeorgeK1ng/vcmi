# Dwelling upgrades (external map dwellings)

This document describes how external dwelling upgrades are configured and how fallback behavior works.

## Overview

External dwellings can define upgrade levels in object config (`levels` section).  
If `levels` are not defined for a dwelling, VCMI generates generic levels using `config/dwellingsLevels.json`.

Upgrade level effects currently support:

- upgrade cost (`cost`)
- available creature variants (`creatures`)
- applied bonus list (`bonuses`)
- recruit price modifier (`recruitCostPercent`)

## Per-dwelling configuration

Use object config, for example in `config/objects/dwellings.json`:

```json
"centaurStables": {
  "levels": {
    "1": {
      "name": "Centaur stables",
      "description": "Centaur stables",
      "cost": { "gold": 10000 },
      "creatures": [["centaur", "centaurCaptain"]],
      "recruitCostPercent": 90,
      "bonuses": [
        { "type": "CREATURE_GROWTH_PERCENT", "val": 10 }
      ]
    }
  }
}
```

### Notes

- `cost` is a full resource map (gold/wood/ore/mercury/sulfur/crystal/gems).
- `recruitCostPercent` uses `100` as base (e.g. `80` = 20% cheaper recruitment).
- `bonuses` are parsed through standard bonus JSON parsing.

## Generic fallback configuration

When a dwelling has no `levels`, generic levels are generated from:

- `config/dwellingsLevels.json`

Supported fields:

- `maxLevel`
- `baseUpgradeCostGold`
- `costStepGold`
- `recruitCostStepPercent`
- `minRecruitCostPercent`
- `growthPercentPerLevel`

This gives all dwellings (including unknown modded ones) a baseline upgrade path.

## Level semantics

- Starting state is level **0**.
- First upgrade changes dwelling to level **1**.
- UI should display current level and next level using this numbering directly.
