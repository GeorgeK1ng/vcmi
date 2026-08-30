# VCMI — Open-source Heroes of Might and Magic III engine

[![Build status](https://github.com/vcmi/vcmi/actions/workflows/github.yml/badge.svg?branch=develop&event=push)](https://github.com/vcmi/vcmi/actions/workflows/github.yml?query=branch%3Adevelop+event%3Apush)
[![Latest release](https://img.shields.io/github/v/release/vcmi/vcmi?label=latest%20release)](https://github.com/vcmi/vcmi/releases/latest)
[![Total downloads](https://img.shields.io/github/downloads/vcmi/vcmi/total)](https://github.com/vcmi/vcmi/releases)
[![License: GPL v2+](https://img.shields.io/badge/license-GPL%20v2%2B-blue)](#license)

VCMI is a free, open-source engine that brings **Heroes of Might and Magic III**
to modern platforms. It recreates the original engine from scratch while keeping
the familiar adventure, combat, campaigns and multiplayer experience—and makes
it possible to extend the game far beyond the limits of the original executable.

> [!IMPORTANT]
> VCMI is an engine, not a standalone game. You need the original game data from
> **Heroes III: Shadow of Death** or **Heroes III Complete** (the GOG release is
> recommended). The Ubisoft *HD Edition* is not sufficient because it does not
> contain the expansions and their assets.

<p align="center">
  <img src="https://github.com/vcmi/VCMI.eu/blob/master/static/img/screenshots/1.3.0/Castle%20Siege.jpg?raw=true" alt="A castle siege in VCMI" width="48%">
  <img src="https://github.com/vcmi/VCMI.eu/blob/master/static/img/screenshots/1.4.0/Quick%20Hero%20Select%20Bastion.jpg?raw=true" alt="VCMI adventure map with a custom town" width="48%">
</p>

## Why VCMI?

VCMI aims to preserve the classic game while providing a modern foundation for
playing, creating and experimenting:

- **Play on modern devices** — native builds for desktop and mobile platforms,
  with high resolutions, scalable interfaces and touchscreen support.
- **Install mods without replacing game files** — use the built-in launcher to
  discover and manage new towns, creatures, artifacts, spells, campaigns,
  graphics and gameplay rules.
- **Play online more easily** — create or join rooms, chat with other players and
  start internet games through the global lobby; direct connections and local
  multiplayer remain available too.
- **Create your own adventures** — use the cross-platform map editor and random
  map generator, with support for VCMI's expanded content.
- **Enjoy engine improvements** — improved AI, optional quality-of-life features,
  configurable rules, many bug fixes and active support for community
  translations.
- **Build on an open engine** — VCMI is actively developed, portable and designed
  around a powerful, data-driven modding system.

VCMI intentionally does not try to be a pixel-for-pixel replacement for every
quirk of the original executable. Its goal is a faithful and compatible game
experience with room for fixes, accessibility improvements and new content.

## Supported platforms

Click a platform to open its installation guide. The minimum versions below
apply to official VCMI packages; availability may differ between package stores
and Linux distributions.

| Platform | Minimum supported version | Architectures | Installation |
| :---: | :--- | :--- | :--- |
| <img src="https://cdn.simpleicons.org/windows/0078D4" width="26" alt="Windows"><br>**Windows** | Windows 7 SP1 | x86, x86_64; ARM64 on Windows 10+ | [Guide](players/Installation_Windows.md) |
| <img src="https://cdn.simpleicons.org/linux/FCC624" width="26" alt="Linux"><br>**Linux** | Current supported distribution | x86_64 and distribution-dependent | [Guide](players/Installation_Linux.md) |
| <img src="https://cdn.simpleicons.org/apple/999999" width="26" alt="Apple"><br>**macOS** | macOS 10.15 | Intel and Apple silicon | [Guide](players/Installation_macOS.md) |
| <img src="https://cdn.simpleicons.org/android/3DDC84" width="26" alt="Android"><br>**Android** | Android 5.0 | arm64, armv7, x86_64 | [Guide](players/Installation_Android.md) |
| <img src="https://cdn.simpleicons.org/ios/999999" width="26" alt="iOS"><br>**iOS** | iOS 12.0 | All supported devices | [Guide](players/Installation_iOS.md) |

## Get started

1. **Own a compatible copy of Heroes III.** Use *Shadow of Death* or *Complete*;
   the DRM-free GOG offline installer is the easiest option on every platform.
2. **[Download the latest VCMI release](https://github.com/vcmi/vcmi/releases/latest)**
   and follow the [guide for your platform](#supported-platforms).
3. **Import the original game data** in VCMI Launcher or copy it from an existing
   installation as described in the guide.
4. **Launch the game.** Optional mods can then be installed from the Launcher's
   Mods tab.

Heroes Chronicles owners can also follow the dedicated
[Heroes Chronicles guide](players/Heroes_Chronicles.md).

> [!NOTE]
> Development builds are available from
> [builds.vcmi.download](https://builds.vcmi.download/branch/develop/). They contain
> the newest changes but may be unstable. Save games are generally not compatible
> across different major VCMI versions, so finish important games before updating.

## Online multiplayer lobby

The **[VCMI Online Lobby](https://vcmi.eu/lobby/)** is the meeting point for
internet games. The live web view shows currently connected players, open game
rooms and recent matches before you even launch VCMI.

<p align="center">
  <a href="https://vcmi.eu/lobby/"><img src="https://img.shields.io/badge/Open_the_live_VCMI_lobby-available_players_%26_games-6b4b2a?style=for-the-badge&logo=internetcomputer&logoColor=white" alt="Open the live VCMI Online Lobby"></a>
</p>

Sign in from the **Online Lobby** entry in the game, create a public or private
room, invite players and use the built-in chat. All players in a match should use
the same VCMI version and compatible mod configuration.

## Screenshots

<p align="center">
  <img src="https://github.com/vcmi/VCMI.eu/blob/master/static/img/screenshots/1.3.0/Town%20Screen%20with%20Radial%20Menu.jpg?raw=true" alt="Town screen with a touchscreen radial menu" width="32%">
  <img src="https://github.com/vcmi/VCMI.eu/blob/master/static/img/screenshots/1.4.0/Big%20spellbook.jpg?raw=true" alt="Large spellbook with a community translation" width="32%">
  <img src="https://github.com/vcmi/VCMI.eu/blob/master/static/img/screenshots/1.6.0/New%20bonus%20descriptions.png?raw=true" alt="Expanded creature ability descriptions" width="32%">
</p>
<p align="center">
  <img src="https://github.com/vcmi/VCMI.eu/blob/master/static/img/screenshots/1.4.0/Antagarich%20Burning%20Battle.jpg?raw=true" alt="A battle featuring a community-made town" width="32%">
  <img src="https://github.com/vcmi/VCMI.eu/blob/master/static/img/screenshots/1.6.0/Preserve%20siege.jpg?raw=true" alt="A siege featuring the Preserve town mod" width="32%">
  <img src="https://github.com/vcmi/VCMI.eu/blob/master/static/img/screenshots/1.4.0/Editor.jpg?raw=true" alt="VCMI map editor" width="32%">
</p>

## Community and support

| Resource | Where to go |
| --- | --- |
| Website | [vcmi.eu](https://vcmi.eu/) |
| Frequently asked questions | [VCMI FAQ](https://vcmi.eu/faq/) |
| Community | [Discord](https://discord.gg/chBT42V) · [Forum](https://forum.vcmi.eu/) |
| Bugs and feature requests | [GitHub Issues](https://github.com/vcmi/vcmi/issues) |
| Releases | [Stable releases](https://github.com/vcmi/vcmi/releases/latest) · [Development builds](https://builds.vcmi.download/branch/develop/) |
| Translation | [Help translate VCMI on Weblate](https://hosted.weblate.org/engage/vcmi/) |

[![Translation status](https://hosted.weblate.org/widget/vcmi/multi-auto.svg)](https://hosted.weblate.org/engage/vcmi/)

## Documentation

### For players

- [Frequently asked questions](https://vcmi.eu/faq/)
- [Game mechanics](players/Game_Mechanics.md)
- [Bug reporting guidelines](players/Bug_Reporting_Guidelines.md)
- [Cheat codes](players/Cheat_Codes.md)
- [Privacy policy](players/Privacy_Policy.md)

### For modders and map makers

- [Modding guidelines](modders/Readme.md)
- [Mod file format](modders/Mod_File_Format.md)
- [Bonus format](modders/Bonus_Format.md)
- [Map editor](modders/Map_Editor.md)
- [Campaign format](modders/Campaign_Format.md)
- [Configurable widgets](modders/Configurable_Widgets.md)

### For developers and contributors

- Build VCMI: [Windows](developers/Building_Windows.md) ·
  [Linux](developers/Building_Linux.md) ·
  [macOS](developers/Building_macOS.md) ·
  [Android](developers/Building_Android.md) ·
  [iOS](developers/Building_iOS.md)
- [Coding guidelines](developers/Coding_Guidelines.md)
- [Code structure](developers/Code_Structure.md)
- [Contributing translations](translators/Translations.md)
- [Project infrastructure](maintainers/Project_Infrastructure.md)
- [Release process](maintainers/Release_Process.md)

## License

VCMI source code is licensed under the
[GNU General Public License, version 2 or later](../license.txt). VCMI Project
assets are licensed under CC BY-SA 4.0; their sources and contributor information
are available in the [vcmi-assets repository](https://github.com/vcmi/vcmi-assets).

VCMI is an independent open-source project. *Heroes of Might and Magic III* and
related names and assets belong to their respective owners and are not included.

Copyright © 2007–2026 VCMI Team. See the
[contributors list](https://github.com/vcmi/vcmi/graphs/contributors).
