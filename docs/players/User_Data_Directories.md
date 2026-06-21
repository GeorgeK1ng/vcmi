# User data directories

VCMI stores player-specific files separately from the program installation. This includes imported Heroes III data, maps, mods, saves, settings, logs, cache files and exported resources.

Open **VCMI Launcher** and go to **About project** to see the paths used by your current installation. Command-line tools also print the resolved paths in their help output, for example `vcmiclient --help` or `vcmiserver --help`.

## What VCMI stores there

| Directory | Typical contents |
| --- | --- |
| User data | Heroes III `Data`, `Maps` and `Mp3` folders, user maps, downloaded or installed mods, generated files |
| User saves | Saved games, normally the `Saves` subdirectory of user data |
| User config | Launcher and game settings |
| User logs | Log files useful for troubleshooting |
| User cache | Temporary downloads, extracted resources and other cache files |

## Default locations

| Platform | User data location |
| --- | --- |
| Windows | `%USERPROFILE%\Documents\My Games\vcmi` |
| macOS | `~/Library/Application Support/vcmi` |
| Linux and other XDG platforms | `$XDG_DATA_HOME/vcmi`, or `~/.local/share/vcmi` when `XDG_DATA_HOME` is not set |
| Flatpak | `~/.var/app/eu.vcmi.VCMI/data/vcmi` |
| Android | The app-private `vcmi-data` directory managed by the launcher |
| iOS | The VCMI app Documents directory |

On Windows, the cache, config, logs and saves directories are subdirectories of the user data directory by default. On macOS, config and cache are also kept under the user data directory, while logs are stored in `~/Library/Logs/vcmi`. On Linux, cache and config follow the XDG variables (`XDG_CACHE_HOME` and `XDG_CONFIG_HOME`) and fall back to `~/.cache/vcmi` and `~/.config/vcmi`.

## Changing locations on Windows

Windows builds can override the user data, cache, config, logs and saves directories with a JSON file named `dirs.json` in the `config` directory next to the VCMI executables.

For an installed copy this is typically:

```text
<VCMI installation directory>\config\dirs.json
```

Example:

```json
{
  "userDataPath": "D:\\Games\\VCMI-data",
  "userCachePath": "D:\\Games\\VCMI-data\\cache",
  "userConfigPath": "D:\\Games\\VCMI-data\\config",
  "userLogsPath": "D:\\Games\\VCMI-data\\logs",
  "userSavePath": "D:\\Games\\VCMI-data\\Saves"
}
```

All keys are optional. If a key is missing, VCMI uses the default for that directory. Environment variables in paths are expanded, so you can also use values such as `%LOCALAPPDATA%\\VCMI\\cache`.

After editing `dirs.json`, restart VCMI and check **About project** in the launcher to verify the resolved paths. Move existing `Data`, `Maps`, `Mp3`, `Mods`, `Saves` and configuration files to the new directories if you want to keep using them.

## Changing locations on Linux

Linux builds follow the XDG base directory variables. Set them before launching VCMI to redirect user data, cache and configuration:

```sh
#!/bin/sh

BASE_DIR="$HOME/Games/vcmi-profile"

export XDG_DATA_HOME="$BASE_DIR/data"
export XDG_CACHE_HOME="$BASE_DIR/cache"
export XDG_CONFIG_HOME="$BASE_DIR/config"

vcmiclient
```

This makes VCMI use `$BASE_DIR/data/vcmi`, `$BASE_DIR/cache/vcmi` and `$BASE_DIR/config/vcmi`. The same approach works for AppImage builds; launch the AppImage from the script instead of `vcmiclient`.

## macOS, Android and iOS

Changing VCMI user data directories is currently supported only on Windows and Linux/XDG builds. macOS, Android and iOS builds do not support a `dirs.json` file or any other dedicated user-facing override for these paths.

On Android specifically, the data directory is app-private and managed by the launcher. It cannot be relocated from VCMI settings or by creating a config file; use the launcher import/export flows and Android system storage tools instead.

On macOS and iOS, keep VCMI data in the default application directories shown above. Filesystem-level tricks such as symlinks or changing process environment variables are outside the supported configuration and may break launcher, sandboxing, backups or updates.

## Portable or multi-profile setups

To keep multiple independent VCMI setups, create one data directory per profile and point VCMI to the desired profile before launching it:

- On Windows, use a separate installation copy or launcher shortcut with its own `config\dirs.json`.
- On Linux, use a small wrapper script that sets `XDG_DATA_HOME`, `XDG_CACHE_HOME` and `XDG_CONFIG_HOME` to profile-specific directories.

Portable or multi-profile relocation is not supported on macOS, Android or iOS.

Each profile should contain its own imported Heroes III files and mods. Saves are not guaranteed to be compatible between different VCMI versions, so keep this in mind when sharing one data directory between stable and daily builds.
