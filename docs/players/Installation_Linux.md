# Installing VCMI on Linux

This guide installs VCMI and imports the original Heroes III files it needs.

## Requirements

- A currently supported Linux distribution. Package-specific requirements are
  listed below.
- Game data from **Heroes of Might and Magic III: Shadow of Death** or
  **Heroes III Complete**. The GOG Complete release is recommended.

> [!IMPORTANT]
> The Ubisoft *Heroes III HD Edition* and the old Loki Linux port are not valid
> data sources. VCMI is an engine and does not include copyrighted Heroes III
> game files.

## 1. Install VCMI

Choose the method that best suits your distribution. Distribution packages may
lag behind the latest VCMI release.

### Ubuntu PPA (recommended on Ubuntu)

Install the latest stable release from the official VCMI PPA:

```sh
sudo add-apt-repository ppa:vcmi/ppa
sudo apt update
sudo apt install vcmi
```

Unstable development builds for testing are available from a separate PPA:

```sh
sudo add-apt-repository ppa:vcmi/vcmi-latest
sudo apt update
sudo apt install vcmi
```

### Flatpak (distribution-independent)

Install VCMI from [Flathub](https://flathub.org/apps/eu.vcmi.VCMI). If Flatpak is
not yet configured, follow the [Flatpak setup guide](https://flatpak.org/setup/).

```sh
flatpak install flathub eu.vcmi.VCMI
```

### AppImage (distribution-independent)

Download a stable AppImage from the
[latest release](https://github.com/vcmi/vcmi/releases/latest), make it executable,
and run it. Current official AppImages require glibc 2.38 or newer.

```sh
chmod +x VCMI-*.AppImage
./VCMI-*.AppImage
```

Development AppImages are available from
[builds.vcmi.download](https://builds.vcmi.download/branch/develop/).

### Distribution packages

- **Ubuntu repository:** enable
  [Multiverse](https://help.ubuntu.com/community/Repositories/Ubuntu), then run
  `sudo apt update && sudo apt install vcmi`. The official PPA is usually newer.
- **Debian:** enable the
  [`contrib` component](https://wiki.debian.org/SourcesList), then run
  `sudo apt update && sudo apt install vcmi`.
- **Fedora 40 or newer:** enable
  [RPM Fusion](https://docs.fedoraproject.org/en-US/quick-docs/rpmfusion-setup/),
  then run `sudo dnf install vcmi`.
- **Arch Linux:** community-maintained
  [`vcmi`](https://aur.archlinux.org/packages/vcmi/) and
  [`vcmi-git`](https://aur.archlinux.org/packages/vcmi-git/) AUR packages.
- **openSUSE:** community-maintained
  [1 Click Install](https://software.opensuse.org/download.html?project=games&package=vcmi).

Community-maintained packages are not supported by the VCMI team and may not be
current. To compile VCMI yourself, use the
[Linux build guide](../developers/Building_Linux.md).

## 2. Import Heroes III data

### With VCMI Launcher (recommended)

1. In your GOG library, download the **offline backup game installer** for
   Heroes III Complete. Download both its `.exe` and `.bin` files and keep them
   in the same directory.
2. Open **VCMI Launcher** and choose the GOG installer import option.
3. Select the `.exe` file. The launcher finds the matching `.bin` file and
   extracts the required data automatically.

![GOG offline installer download page](images/gog_offline_installer.png)

You may instead choose the existing-files import option and select a directory
that contains `Data`, `Maps`, and `Mp3`.

### With `vcmibuilder`

For native packages and AppImages, `vcmibuilder` can import one of the following:

```sh
vcmibuilder --gog /path/to/gog-installer.exe
vcmibuilder --data /path/to/heroes3
vcmibuilder --cd1 /path/to/cd1.iso --cd2 /path/to/cd2.iso
```

Use only the command that matches your data source. For Flatpak, expose an
accessible path and run the bundled utility inside the sandbox:

```sh
flatpak run --command=vcmibuilder eu.vcmi.VCMI --data /path/to/heroes3
```

### Manual copy

Copy `Data`, `Maps`, and `Mp3` into the applicable VCMI data directory:

- Native packages and AppImages: `${XDG_DATA_HOME:-$HOME/.local/share}/vcmi/`
- Flatpak: `$HOME/.var/app/eu.vcmi.VCMI/data/vcmi/`

Directory names and filename case matter on case-sensitive file systems.

## 3. Launch VCMI

Open **VCMI Launcher** from the desktop application menu, or run:

```sh
vcmilauncher
```

To bypass the launcher and start the game directly, run `vcmiclient`. Flatpak
users can start VCMI with `flatpak run eu.vcmi.VCMI`.

## Optional portable AppImage configuration

To keep settings and data beside an AppImage, launch it from a script that sets
XDG directories before starting the application:

```sh
#!/bin/sh
BASE_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
export XDG_DATA_HOME="$BASE_DIR/vcmi_data/data"
export XDG_CACHE_HOME="$BASE_DIR/vcmi_data/cache"
export XDG_CONFIG_HOME="$BASE_DIR/vcmi_data/config"
exec "$BASE_DIR"/VCMI-*.AppImage
```

## Troubleshooting and updates

- If the launcher cannot find GOG data, confirm that the `.exe` and `.bin` belong
  to the same offline installer and are in the same directory.
- With Flatpak, select files through the launcher where possible; sandbox access
  may prevent command-line tools from seeing arbitrary host paths.
- Stable releases are recommended for normal play. Save compatibility between
  different major VCMI versions is not guaranteed.
- For further help, see the [FAQ](https://vcmi.eu/faq/) or follow the
  [bug-reporting guide](Bug_Reporting_Guidelines.md).
