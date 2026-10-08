; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.
; TODO: English fallback values below are ready for translation in Weblate.

[Messages]
HelpTextNote=VCMI-specific setup parameters:%n  /USERDATADIR=<path>  Set the VCMI user data directory. Prefix the path with expand: to expand Inno Setup constants.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Install application and user data together without an uninstaller, registry changes, shortcuts, associations, or firewall rules.%n  /LAUNCH  Launch VCMI after setup, including silent setup.%n%nVCMI uninstaller parameter:%n  /DELETEUSERDATA=1  Delete all configured VCMI user directories. Only honored together with /SILENT or /VERYSILENT. This cannot be undone.%n%nStandard parameters such as /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART and /LOG are described above.
WindowsVersionNotSupported=This program cannot run on your version of Windows. Please ensure you are using the correct Windows architecture (32-bit or 64-bit) and version for this program.
PrivilegesRequiredOverrideTitle=Administrator Privileges Required
PrivilegesRequiredOverrideInstruction=Choose how to run the installer
PrivilegesRequiredOverrideText1=%1 requires administrative rights to install for all users. You can also install just for your account without admin privileges.
PrivilegesRequiredOverrideText2=%1 can be installed only for your account (no administrative rights required) or for all users (requires administrative rights).
PrivilegesRequiredOverrideAllUsers=Run as &Administrator (install for all users)
PrivilegesRequiredOverrideAllUsersRecommended=Run as &Administrator (recommended)
PrivilegesRequiredOverrideCurrentUser=Run as &Standard User (install for me only)
PrivilegesRequiredOverrideCurrentUserRecommended=Run as &Standard User (recommended)
ConfirmUninstall=Are you sure you want to run the %1 uninstall wizard?

[CustomMessages]
AddFirewallRules=Add firewall rules for VCMI
AssociateH3MFiles=Associate .h3m files with the VCMI Map Editor
AssociateVCMIMapFiles=Associate .vmap and .vcmp files with the VCMI Map Editor
CacheDirectory=Cache
CloudDataNotice=This user data directory appears to be synchronized by a cloud storage provider.
CloudDataWarning=The selected user data directory appears to be synchronized by a cloud storage provider. Synchronization may temporarily lock files and cause mod installation, game startup, or save failures.%n%nDo you want to use this directory anyway?
CloudInstallNotice=This installation directory appears to be synchronized by a cloud storage provider.
CloudInstallWarning=The selected installation directory appears to be synchronized by a cloud storage provider. A portable or synchronized installation may fail when the provider temporarily locks application files.%n%nDo you want to use this directory anyway?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Configuration
CopyH3Files=Automatically copy required Heroes III files to VCMI
CreateDesktopShortcuts=Create desktop shortcuts
CreateStartMenuShortcuts=Create Start Menu shortcuts
DataFolderDescription=Stores a copy of the provided Heroes III data, modifications, maps, saved games, and other user files.
DataFolderTitle=User data folder
DeleteUserData=Delete user data
DeleteUserDataDescription=Select folders to delete permanently. Unchecked folders will be kept. This cannot be undone.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Heroes 3 Map File
InstallFolderTitle=Installation folder
InstallForAllUsers=Install for all users
InstallForAllUsers1=Requires administrative privileges
InstallForMeOnly=Install for me only
InstallForMeOnly1=A firewall prompt will appear when launching the game for the first time
InstallForMeOnly2=LAN games will not work if the firewall rule cannot be allowed
InstallPortable=Portable installation
InstallPortable1=Keeps the application and user data together in one folder
InstallPortable2=Does not create an uninstaller or modify the registry and system integration
LogsDirectory=Logs
ResetFoldersToDefault=Reset to default
RunVCMILauncherAfterInstall=Launch the VCMI Launcher
SavesDirectory=Saved games
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI can be installed for all users or only for you.
SelectSetupInstallModeSubTitle=Select your preferred installation mode:
SelectSetupInstallModeTitle=Choose Installation Mode
SharedUserDataNotice=User data cannot be deleted because another VCMI installation uses the same directory.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Visit the official VCMI Discord
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Launch the VCMI Launcher
ShortcutMapEditor=VCMI Map Editor
ShortcutMapEditorComment=Open the VCMI Map Editor
ShortcutWebPage=VCMI Website
ShortcutWebPageComment=Visit the official VCMI website
SystemIntegration=System integration
Uninstall=Uninstall
UserDataDirectory=User data (Heroes III data, modifications, maps, and other files)
VCMISettings=VCMI configuration
VCMPDescription=VCMI Campaign File
VMAPDescription=VCMI Map File
Warning=Warning
X86On64BitWarning=You are installing the 32-bit (x86) version of VCMI on 64-bit Windows. This is supported, but the native 64-bit version is recommended when available.
