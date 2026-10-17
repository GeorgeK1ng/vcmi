;
; Swedish.isl, part of VCMI engine
;
; Authors: listed in file AUTHORS in main folder
;
; License: GNU General Public License v2.0 or later
; Full text of license available in license.txt file, in main folder
;
; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.
; Translation maintenance: docs/translators/Maintenance.md#translating-the-installer

[Messages]
HelpTextNote=Installationsparametrar för VCMI:%n  /USERDATADIR=<path>  Anger mappen för VCMI:s användardata. Prefixet expand: expanderar Inno Setup-konstanter.%n  /ALLOWCLOUDTARGET=1  Tillåter en molnsynkroniserad installations- eller användardatamapp vid tyst installation.%n  /PORTABLE=1  Installerar programmet och data tillsammans utan avinstallerare, registerändringar, genvägar, filassociationer eller brandväggsregler.%n  /LAUNCH  Startar VCMI efter installationen, även vid tyst installation.%n  /COPYH3DATA=0|1  Aktiverar eller inaktiverar automatisk kopiering av hittade Heroes III-data.%n%nUppgiftsnamn för /TASKS och /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (endast installation för alla användare med administratörsbehörighet)%n%nAvinstallationsparameter för VCMI:%n  /DELETEUSERDATA=1  Tar bort alla konfigurerade VCMI-användarmappar. Fungerar endast tillsammans med /SILENT eller /VERYSILENT. Åtgärden kan inte ångras.%n%nStandardparametrarna beskrivs ovan: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Det här programmet kan inte köras på din version av Windows. Se till att du använder rätt Windows-arkitektur (x86 / x64 / ARM64) och rätt version av programmet.
PrivilegesRequiredOverrideTitle=Installationstyp – Behörigheter
PrivilegesRequiredOverrideInstruction=Välj hur installationsprogrammet ska köras
PrivilegesRequiredOverrideText1=%1 kräver administratörsbehörighet för att installeras för alla användare. Du kan också installera det endast för ditt eget konto utan administratörsbehörighet.
PrivilegesRequiredOverrideText2=%1 kan installeras endast för ditt eget konto (utan administratörsbehörighet) eller för alla användare (kräver administratörsbehörighet).
PrivilegesRequiredOverrideAllUsers=Kör som &Administratör (installera för alla användare)
PrivilegesRequiredOverrideAllUsersRecommended=Kör som &Administratör (rekommenderas)
PrivilegesRequiredOverrideCurrentUser=Kör som &Standardanvändare (installera endast för mig)
PrivilegesRequiredOverrideCurrentUserRecommended=Kör som &Standardanvändare (rekommenderas)
ConfirmUninstall=Är du säker på att du vill köra avinstallationsguiden för %1?

[CustomMessages]
DesktopShortcuts=Skrivbordsgenvägar
StartMenuShortcuts=Genvägar på Start-menyn
WelcomeDescription=VCMI är en spelmotor med öppen källkod för Heroes III med nya och utökade möjligheter. För att använda VCMI måste du äga datafilerna från originalspelet.%n%nDen här guiden installerar VCMI - Open Heroes 3 på din enhet.%n%nDu rekommenderas att stänga alla andra program innan du fortsätter.%n%nKlicka på Nästa för att fortsätta eller Avbryt för att avsluta installationen.
WelcomeHighlightsTitle=Om VCMI
WelcomeHighlights=VCMI är en gemenskapsutvecklad återimplementering av Heroes of Might and Magic III-motorn. Projektet bevarar originalets anda, övervinner den klassiska motorns tekniska begränsningar och ger en öppen grund för moddar och fortsatt utveckling.
RequirementImportSpaceHelp=Gå tillbaka och välj en annan mapp för användardata, eller avmarkera automatisk kopiering av Heroes III-data.
RequirementDisableImportQuestion=Vill du fortsätta utan att kopiera Heroes III-data?
RequirementFirewall=Brandvägg
RequirementMultiplayerGames=Flerspelarspel
RequirementSelected=Valt
RequirementNotSelected=Inte valt — spel på samma dator fungerar fortfarande
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Lägg till brandväggsregler för flerspelarspel
AssociateH3MFiles=Associera .h3m-filer med VCMI Kartredigeraren
AssociateVCMIMapFiles=Associera .vmap- och .vcmp-filer med VCMI Kartredigeraren
CacheDirectory=Cache
CloudDataNotice=Den här katalogen för användardata verkar synkroniseras av en molnlagringstjänst.
CloudDataWarning=Den valda katalogen för användardata verkar synkroniseras av en molnlagringstjänst. Synkroniseringen kan tillfälligt låsa filer och orsaka fel vid installation av moddar, spelstart eller sparning.%n%nVill du använda katalogen ändå?
CloudInstallNotice=Den här installationskatalogen verkar synkroniseras av en molnlagringstjänst.
CloudInstallWarning=Den valda installationskatalogen verkar synkroniseras av en molnlagringstjänst. En portabel eller synkroniserad installation kan misslyckas om tjänsten tillfälligt låser programfiler.%n%nVill du använda katalogen ändå?
CloudTargetSilentError=Tyst installation kan inte använda en molnsynkroniserad målmapp utan /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Det gick inte att kopiera Heroes III-filerna (%s). Vissa filer kan redan ha kopierats; du kan köra importen igen utan risk.
CopyingHeroes3Data=Kopierar Heroes III-data...
ConfigDirectory=Konfiguration
CopyH3Files=Kopiera automatiskt nödvändiga Heroes III-filer till VCMI
CreateDesktopShortcuts=Skapa genvägar på skrivbordet
CreateStartMenuShortcuts=Skapa genvägar i Start-menyn
DataFolderDescription=Innehåller en kopia av tillhandahållna Heroes III-data, modifieringar, kartor, sparade spel och andra användarfiler.
DataFolderTitle=Mapp för användardata
DeleteUserData=Radera användardata
DeleteUserDataDescription=Välj mappar som ska tas bort permanent. Omarkerade mappar behålls. Åtgärden kan inte ångras.
DeletingUserData=Tar bort användardata...
DirectoryConfigWriteError=Det gick inte att spara inställningarna för användarmappar i %s. Installationen kan inte fortsätta säkert.
DirectoryNotWritable=Det går inte att skriva till den valda mappen (%s). Välj en annan mapp eller kör installationen med nödvändiga behörigheter.%n%n%s
DirectoryRootNotAllowed=Den valda mappen (%s) får inte vara roten på en enhet eller nätverksresurs. Välj en separat mapp.%n%n%s
DirectoryOverlapError=Installations- och användardatamapparna får inte vara samma eller överlappa på ett osäkert sätt. Endast en portabel installation får lagra användardata i installationsmappen.
ReadyUserDataLocation=Plats för användardata:
RequirementPassed=GODKÄNT
RequirementFailed=UNDERKÄNT
RequirementWarning=VARNING
RequirementInfo=INFORMATION
RequirementOperatingSystem=Operationssystem
RequirementOperatingSystemValue=Windows 7 SP1 eller nyare; kompatibilitetsarbete inkluderat när det krävs
RequirementArchitecture=Arkitektur
RequirementInstallWritable=Installationsmappen är skrivbar
RequirementDataWritable=Användardatamappen är skrivbar
RequirementDirectoryLayout=Layout för katalog
RequirementDirectoryLayoutValue=Installations- och användardatasökvägarna är säkert åtskilda
RequirementApplicationSpace=Applikationsdiskutrymme
RequirementFreeSpaceValue=%s MB ledigt; installationsprogrammet kontrollerar även paketets slutliga storlek
RequirementHeroesDataSpace=Heroes III-import
RequirementInsufficientSpace=Otillräckligt ledigt utrymme för den valda Heroes III-importen
RequirementRequiredSpaceValue=Cirka %s MB krävs för den valda importen
RequirementNotRequested=Heroes III-import har inte valts
RequirementCloudStorage=Lagringssynkronisering
RequirementCloudStorageValue=En vald väg verkar använda molnsynkronisering
RequirementLocalStorageValue=Väljade vägar verkar använda lokal lagring
RequirementInstallationMode=Installationsläge
RequirementModePortable=Portabelt, utan avinstallationsprogram, register eller systemintegration
RequirementModeAllUsers=Alla användare
RequirementModeCurrentUser=Nuvarande användare
RequirementUpgrade=befintlig installation uppgraderas
RequirementsCheckTitle=Kontroll av systemkrav
RequirementsCheckDescription=Installation kontrollerade den valda konfigurationen innan installationen.
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
ScanningFiles=Söker efter filer...
SelectSetupInstallModeDesc=VCMI kan installeras för alla användare, bara för dig eller i portabelt läge.
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
FileAssociations=Filassociationer
AssociateH3CFiles=Öppna Heroes III-kampanjer (.h3c) i VCMI-kartredigeraren
H3CDescription=Heroes III-kampanj
Uninstall=Avinstallera
UserDataDirectory=Användardata (Heroes III-data, modifieringar, kartor och andra filer)
VCMISettings=Systemkonfiguration
VCMPDescription=VCMI Kampanjfil
VMAPDescription=VCMI Kartfil
Warning=Varning
X86On64BitWarning=Du installerar 32-bitarsversionen (x86) av VCMI på 64-bitars Windows. Detta stöds, men den inbyggda 64-bitarsversionen rekommenderas när den är tillgänglig.
Heroes3ImportReparsePoint=Heroes III-data kan inte importeras säkert eftersom en befintlig målmapp innehåller en kopplingspunkt eller symbolisk länk. Ta bort länken eller välj en annan mapp.
OpenSetupLog=Öppna inställningslogg
OpenSetupLogError=Installationslogget kunde inte öppnas.
LegacyUninstallStartFailed=Det gick inte att starta det tidigare avinstallationsprogrammet för VCMI:%n%s
LegacyUninstallExitFailed=Det tidigare avinstallationsprogrammet för VCMI misslyckades med felkod %s.
LegacyUninstallFailureChoice=Avbryt stoppar installationen. Försök igen kör det gamla avinstallationsprogrammet på nytt. Ignorera fortsätter på egen risk.
LegacyUninstallRequired=Den tidigare VCMI-installationen kunde inte tas bort. Inga nya installationsfiler kopierades.
InstallDirectoryUsedByOtherInstallation=Installationsförteckningen överlappar en annan registrerad VCMI Installation:%n%s%n%nVälj en annan katalog.
X86OnARM64Warning=Du installerar 32-bit (x86) version av VCMI på ARM64 Windows. Detta stöds, men den inhemska ARM64 Om det finns en version rekommenderas.
RequirementsColumnComponent=Komponent
RequirementsColumnDetails=Förbehåll
RequirementsColumnStatus=Status
RequirementsColumnDetected=Ditt system
RequirementDetectedWindows=Kompatibel Windows-installation
RequirementWritableValue=Skrivbar mapp
RequirementEnoughSpace=Tillräckligt ledigt utrymme
RequirementProcessor=Processor
RequirementProcessorValue=1 GHz eller snabbare
RequirementMemory=Arbetsminne
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11-körmiljö tillgänglig
RequirementDirectXMissing=DirectX 11-körmiljö hittades inte
RequirementDetectionUnavailable=Kunde inte identifieras
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Installationsmapp
RequirementUserDataFolder=Användardatamapp
RequirementDiskSpace=Fri diskutrymme
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Rekommenderad
RequirementInternetAvailable=Tillgänglig
RequirementInternetUnavailable=Inte upptäckt
RequirementHeroesData=Heroes III-data
RequirementRequiredToPlay=Krävs för att spela
RequirementHeroesDataAvailable=Finns i användardata
RequirementHeroesDataMissing=Fanns inte, kan importeras senare
RequirementWritableAndSynced=Skrivbara och synkroniserade
RequirementNotWritable=Inte skrivbar
TasksCheckboxesTooltip=Välj valfria integrationer och åtgärder. Genvägar ger snabb åtkomst, filassociationer öppnar stödda kartor i editorn, brandväggsregler tillåter flerspelarläge och importen kopierar hittade Heroes III-data.
UninstallCheckboxesTooltip=Markera endast de användardatamappar som du vill ta bort permanent. Inaktiverade delade poster används av en annan VCMI-installation.
InstallModeTooltip=Alla användare: installerar VCMI för alla Windows-konton, normalt i Program Files. Kräver administratörens godkännande. Skapar systemomfattande avinstallationsinformation, registerposter, genvägar, filassociationer och en valfri brandväggsregel. Användardata ligger kvar i den valda mappen.%n%nAktuell användare: installerar VCMI endast för det inloggade Windows-kontot, normalt i Local AppData, utan administratörens godkännande. Skapar en avinstallerare och integrationer för användaren. Andra konton ser inte installationen. Windows-brandväggen kan be om tillstånd när flerspelarläget används första gången.%n%nPortabel: lagrar programmet och användardata tillsammans i den valda mappen. Skapar ingen avinstallerare, registerposter, genvägar, filassociationer eller brandväggsregler. Mappen måste förbli skrivbar. Flytta eller kopiera den för att överföra installationen; ta bort den för att avinstallera.
CopyH3FilesTooltip=Kopierar de hittade Heroes III-mapparna Data, Maps och Mp3 till den valda VCMI-användardatamappen. Originalfilerna ändras inte.
ReadyHeroes3Import=Import av Heroes III-data:
