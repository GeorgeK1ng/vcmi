; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=VCMI-specifika installationsparametrar:%n  /USERDATADIR=<sökväg>  Anger mappen för VCMI-användardata. Prefixet expand: expanderar Inno Setup-konstanter.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Installerar program och data tillsammans utan avinstallerare, registerändringar, genvägar, filassociationer eller brandväggsregler.%n  /LAUNCH  Startar VCMI efter installationen, även vid tyst installation.%n%nParameter för VCMI-avinstalleraren:%n  /DELETEUSERDATA=1  Tar bort alla konfigurerade VCMI-användarmappar. Godtas endast med /SILENT eller /VERYSILENT. Åtgärden kan inte ångras.%n%nStandardparametrar som /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART och /LOG beskrivs ovan.
WindowsVersionNotSupported=Det här programmet kan inte köras på din version av Windows. Se till att du använder rätt Windows-arkitektur (32-bitars eller 64-bitars) och rätt version av programmet.
PrivilegesRequiredOverrideTitle=Installationstyp – Behörigheter
PrivilegesRequiredOverrideInstruction=Välj hur installationsprogrammet ska köras
PrivilegesRequiredOverrideText1=%1 kräver administratörsbehörighet för att installeras för alla användare.%nDu kan också installera det endast för ditt eget konto utan administratörsbehörighet.
PrivilegesRequiredOverrideText2=%1 kan installeras endast för ditt eget konto (utan administratörsbehörighet) eller för alla användare (kräver administratörsbehörighet).
PrivilegesRequiredOverrideAllUsers=Kör som &Administratör (installera för alla användare)
PrivilegesRequiredOverrideAllUsersRecommended=Kör som &Administratör (rekommenderas)
PrivilegesRequiredOverrideCurrentUser=Kör som &Standardanvändare (installera endast för mig)
PrivilegesRequiredOverrideCurrentUserRecommended=Kör som &Standardanvändare (rekommenderas)
ConfirmUninstall=Är du säker på att du vill köra avinstallationsguiden för %1?

[CustomMessages]
AddFirewallRules=Lägg till brandväggsregler för VCMI
AssociateH3MFiles=Associera .h3m-filer med VCMI Kartredigeraren
AssociateVCMIMapFiles=Associera .vmap- och .vcmp-filer med VCMI Kartredigeraren
CacheDirectory=Cache
CloudDataNotice=Den här katalogen för användardata verkar synkroniseras av en molnlagringstjänst.
CloudDataWarning=Den valda katalogen för användardata verkar synkroniseras av en molnlagringstjänst. Synkroniseringen kan tillfälligt låsa filer och orsaka fel vid installation av moddar, spelstart eller sparning.%n%nVill du använda katalogen ändå?
CloudInstallNotice=Den här installationskatalogen verkar synkroniseras av en molnlagringstjänst.
CloudInstallWarning=Den valda installationskatalogen verkar synkroniseras av en molnlagringstjänst. En portabel eller synkroniserad installation kan misslyckas om tjänsten tillfälligt låser programfiler.%n%nVill du använda katalogen ändå?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Konfiguration
CopyH3Files=Kopiera automatiskt nödvändiga Heroes III-filer till VCMI
CreateDesktopShortcuts=Skapa genvägar på skrivbordet
CreateStartMenuShortcuts=Skapa genvägar i Start-menyn
DataFolderDescription=Innehåller en kopia av tillhandahållna Heroes III-data, modifieringar, kartor, sparade spel och andra användarfiler.
DataFolderTitle=Mapp för användardata
DeleteUserData=Radera användardata
DeleteUserDataDescription=Välj mappar som ska tas bort permanent. Omarkerade mappar behålls. Åtgärden kan inte ångras.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Heroes 3 Kartfil
InstallFolderTitle=Installationsmapp
InstallForAllUsers=Installera för alla användare
InstallForAllUsers1=Kräver administratörsbehörigheter
InstallForMeOnly=Installera endast för mig
InstallForMeOnly1=En brandväggsvarning visas första gången spelet startas
InstallForMeOnly2=LAN-spel fungerar inte om brandväggsregeln inte kan godkännas
InstallPortable=Portabel installation
InstallPortable1=Behåller programmet och användardata tillsammans i en mapp
InstallPortable2=Skapar ingen avinstallerare och ändrar inte registret eller systemintegrationen
LogsDirectory=Loggar
ResetFoldersToDefault=Återställ standard
RunVCMILauncherAfterInstall=Starta VCMI Launcher
SavesDirectory=Sparade spel
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI kan installeras för alla användare eller bara för dig.
SelectSetupInstallModeSubTitle=Välj önskat installationsläge:
SelectSetupInstallModeTitle=Välj installationsläge
SharedUserDataNotice=Användardata kan inte tas bort eftersom en annan VCMI-installation använder samma katalog.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Besök den officiella VCMI Discord
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Starta VCMI Launcher
ShortcutMapEditor=VCMI Kartredigerare
ShortcutMapEditorComment=Öppna VCMI Kartredigerare
ShortcutWebPage=VCMI Webbplats
ShortcutWebPageComment=Besök den officiella VCMI-webbplatsen
SystemIntegration=Systemintegration
Uninstall=Avinstallera
UserDataDirectory=Användardata (Heroes III-data, modifieringar, kartor och andra filer)
VCMISettings=VCMI-konfiguration
VCMPDescription=VCMI Kampanjfil
VMAPDescription=VCMI Kartfil
Warning=Varning
X86On64BitWarning=Du installerar 32-bitarsversionen (x86) av VCMI på 64-bitars Windows. Detta stöds, men den inbyggda 64-bitarsversionen rekommenderas när den är tillgänglig.
