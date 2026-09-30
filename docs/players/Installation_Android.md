# Installing VCMI on Android

This guide installs VCMI and imports the original Heroes III files it needs.

## Requirements

- Android 5.0 or newer.
- Game data from **Heroes of Might and Magic III: Shadow of Death** or
  **Heroes III Complete**. The GOG Complete release is recommended.
- Enough free storage for both the installer files and extracted game data
  during import.

> [!IMPORTANT]
> The Ubisoft *Heroes III HD Edition* is not compatible because it does not
> include the expansion data. VCMI is an engine and does not include copyrighted
> Heroes III game files.

## 1. Install VCMI

Choose one source:

- [Google Play](https://play.google.com/store/apps/details?id=is.xyz.vcmi)
  (recommended for most users)
- [F-Droid](https://f-droid.org/en/packages/is.xyz.vcmi/) (arm64 and x86_64)
- APK from the [latest GitHub release](https://github.com/vcmi/vcmi/releases/latest)
- [Development builds](https://builds.vcmi.download/branch/develop/Android/)
  (unstable and intended for testing)

After installation, open **VCMI** to start the launcher.

## 2. Import Heroes III data

Choose whichever source you have available.

### From the GOG offline installer (recommended)

1. In your GOG library, download the **offline backup game installer** for
   Heroes III Complete. You need both its `.exe` and `.bin` files.
2. In VCMI Launcher, choose the GOG installer import option.
3. Select the `.exe` file and then the matching `.bin` file when prompted.
4. Keep VCMI open while it extracts the required data.

![GOG offline installer download page](images/gog_offline_installer.png)

### From an existing installation on a computer

1. Copy the installation's `Data`, `Maps`, and `Mp3` directories to a location
   accessible on the Android device, such as `Downloads/Heroes3`. A USB file
   transfer is usually the fastest method.
2. Open VCMI Launcher and choose the existing-files import option.
3. Select the directory that contains `Data`, `Maps`, and `Mp3`.

## 3. Finish setup and play

Follow the remaining launcher prompts. You may install recommended content from
its **Mods** page, then select **Start game**.

## Troubleshooting and updates

- If Android's file picker does not show the copied files, move them to the
  device's `Download` directory and try again.
- If extraction fails, check available storage and verify that the `.exe` and
  `.bin` files are from the same GOG offline installer.
- Stable releases are recommended for normal play. Save compatibility between
  different major VCMI versions is not guaranteed.
- For further help, see the [FAQ](https://vcmi.eu/faq/) or follow the
  [bug-reporting guide](Bug_Reporting_Guidelines.md).
