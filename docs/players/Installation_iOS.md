# Installing VCMI on iOS and iPadOS

This guide installs VCMI and imports the original Heroes III files it needs.

## Requirements

- iOS or iPadOS 12.0 or newer. Builds for iOS 10 and 11 must be compiled from
  source using the [iOS build guide](../developers/Building_iOS.md).
- Game data from **Heroes of Might and Magic III: Shadow of Death** or
  **Heroes III Complete**. The GOG Complete release is recommended.
- Enough free storage for both the installer files and extracted game data
  during import.

> [!IMPORTANT]
> The Ubisoft *Heroes III HD Edition* is not compatible because it does not
> include the expansion data. VCMI is an engine and does not include copyrighted
> Heroes III game files.

## 1. Install VCMI

### TestFlight (recommended)

Join the [VCMI TestFlight](https://testflight.apple.com/join/pJWHSbmu) and install
VCMI through Apple's TestFlight app. TestFlight availability can be limited by
Apple's tester and build-expiration rules.

### Sideload the IPA

If TestFlight is unavailable:

1. Download `VCMI-iOS.ipa` from the
   [latest GitHub release](https://github.com/vcmi/vcmi/releases/latest).
2. Install [AltStore Classic](https://altstore.io/) or
   [Sideloadly](https://sideloadly.io/) on a computer and follow that project's
   instructions to connect the device.
3. In AltStore, open **My Apps**, select **+**, and choose `VCMI-iOS.ipa`.

Free Apple ID signing normally requires periodically refreshing the application.
Follow the sideloading tool's instructions for the exact interval and process.
Unstable development IPAs are available from
[builds.vcmi.download](https://builds.vcmi.download/branch/develop/iOS/).

Advanced users can also install a properly signed IPA with Xcode or Apple
Configurator:

```sh
/Applications/Apple\ Configurator.app/Contents/MacOS/cfgutil install-app ~/Desktop/VCMI-iOS.ipa
```

## 2. Import Heroes III data

### From the GOG offline installer (recommended)

1. In your GOG library, download the **offline backup game installer** for
   Heroes III Complete. You need both its `.exe` and `.bin` files.
2. Open VCMI. When prompted, choose the `.exe` file and then its matching `.bin`
   file in the system file picker.
3. Keep VCMI open while the launcher extracts the data. This may take several
   minutes on older devices.

![GOG offline installer download page](images/gog_offline_installer.png)

### From existing game files

1. Prepare the `Data`, `Maps`, and `Mp3` directories from a Shadow of Death or
   Complete installation. `Mp3` is optional if you do not need music.
2. Connect the device to a computer.
3. Use Finder on modern macOS, Apple Devices or iTunes on Windows, or iTunes on
   macOS 10.14 and earlier to open **File Sharing → VCMI**.
4. Copy the directories into VCMI's Documents area and wait for the transfer to
   finish. You can copy a `Mods` directory in the same way.

See [Apple's file-sharing guide](https://support.apple.com/en-us/HT210598) for
platform-specific steps. You may alternatively copy the directories into the
VCMI folder using the iOS **Files** app.

> [!WARNING]
> The Google Drive iOS app may rename `.snd` files to `.au`. If you use Google
> Drive, restore every affected file's `.snd` extension before starting VCMI.

### Advanced transfer with Xcode

1. Connect the device and open **Window → Devices and Simulators** in Xcode.
2. Select the device and VCMI, open the actions menu, and choose
   **Download Container**.
3. Add `Data`, `Maps`, and `Mp3` under `AppData/Documents` in the downloaded
   container.
4. Choose **Replace Container** in Xcode and wait for the upload to finish.

## 3. Configure and play

Open the launcher's **Settings** page and adjust the display for your device:

- Set **Reserved screen area** to `0%` if the device does not need an inset.
- Increase **Interface scaling** until controls are comfortable to use.
- Try **xBRZ x2** for smoother upscaling. Higher xBRZ settings can significantly
  reduce performance without a visible benefit on smaller screens.

Then select **Start game**. You can enable direct game startup in the iOS
**Settings** app under **VCMI**.

## Touch controls

- **Tap:** left click
- **Touch and hold:** right click
- **Tap the bottom status area:** open the in-game chat or console

## Troubleshooting and updates

- If import fails, verify that the `.exe` and `.bin` belong to the same GOG
  offline installer and that the device has enough free space.
- If AltStore cannot refresh VCMI, reconnect the device to the computer, confirm
  that Wi-Fi sync is enabled, and follow the current AltStore troubleshooting
  instructions. Do not delete VCMI unless instructed; doing so may remove its
  local data.
- Stable releases are recommended for normal play. Save compatibility between
  different major VCMI versions is not guaranteed.
- For gameplay help, use the [Help & Bugs forum](https://forum.vcmi.eu/c/international-board/help-bugs).
  Report reproducible VCMI or iOS issues through
  [GitHub Issues](https://github.com/vcmi/vcmi/issues) after reading the
  [bug-reporting guide](Bug_Reporting_Guidelines.md).
