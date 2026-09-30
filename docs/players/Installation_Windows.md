# Installing VCMI on Windows

This guide installs VCMI and imports the original Heroes III files it needs.

## Requirements

- Windows 7 SP1 or newer. Windows XP and Vista are not supported.
- Game data from **Heroes of Might and Magic III: Shadow of Death** or
  **Heroes III Complete**. The GOG Complete release is recommended.

> [!IMPORTANT]
> The Ubisoft *Heroes III HD Edition* is not compatible because it does not
> include the expansion data. VCMI is an engine and does not include copyrighted
> Heroes III game files.

## 1. Install VCMI

1. Download the [latest stable Windows release](https://github.com/vcmi/vcmi/releases/latest).
   Development builds are also available from
   [builds.vcmi.download](https://builds.vcmi.download/branch/develop/),
   but may be unstable.
2. Run the installer and follow its instructions.
3. Open **VCMI Launcher**.

## 2. Import Heroes III data

Choose whichever source you have available.

### From the GOG offline installer (recommended)

1. In your GOG library, download the **offline backup game installer** for
   Heroes III Complete. Download both its `.exe` and `.bin` files and keep them
   in the same directory.
2. In VCMI Launcher, choose the GOG installer import option.
3. Select the `.exe` file. The launcher finds the matching `.bin` file and
   extracts the required data automatically.

![GOG offline installer download page](images/gog_offline_installer.png)

### From an existing installation

The launcher may detect an existing Shadow of Death or Complete installation
and offer to import it. If it does not:

1. Find the existing Heroes III installation directory.
2. Copy its `Data`, `Maps`, and `Mp3` directories into:

   ```text
   %USERPROFILE%\Documents\My Games\vcmi
   ```

3. Return to VCMI Launcher and select **Scan again**.

## 3. Finish setup and play

Follow the remaining launcher prompts. You may install recommended content from
its **Mods** page, then select **Start game**.

## Troubleshooting and updates

- If the launcher cannot find GOG data, confirm that the `.exe` and `.bin` belong
  to the same offline installer and are in the same directory.
- Stable releases are recommended for normal play. Save compatibility between
  different major VCMI versions is not guaranteed.
- For further help, see the [FAQ](https://vcmi.eu/faq/) or follow the
  [bug-reporting guide](Bug_Reporting_Guidelines.md).
