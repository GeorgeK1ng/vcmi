;
; Dutch.isl, part of VCMI engine
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
HelpTextNote=VCMI-installatieparameters:%n  /USERDATADIR=<path>  Stelt de map met VCMI-gebruikersgegevens in. Het voorvoegsel expand: vervangt Inno Setup-constanten door hun waarden.%n  /ALLOWCLOUDTARGET=1  Staat bij een stille installatie een installatie- of gegevensmap toe die met de cloud wordt gesynchroniseerd.%n  /PORTABLE=1  Installeert de toepassing en gebruikersgegevens samen zonder deïnstallatieprogramma, registerwijzigingen, snelkoppelingen, bestandskoppelingen of firewallregels.%n  /LAUNCH  Start VCMI na de installatie, ook bij een stille installatie.%n  /COPYH3DATA=0|1  Schakelt automatisch kopiëren van gevonden Heroes III-gegevens in of uit.%n%nTaaknamen voor /TASKS en /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (alleen installatie voor alle gebruikers met beheerdersrechten)%n%nVCMI-deïnstallatieparameter:%n  /DELETEUSERDATA=1  Verwijdert alle ingestelde VCMI-gebruikersmappen. Werkt alleen samen met /SILENT of /VERYSILENT. Dit kan niet ongedaan worden gemaakt.%n%nDe standaardparameters zijn hierboven beschreven: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Dit programma kan niet worden uitgevoerd op uw versie van Windows.x86 / x64 / ARM64) en versie voor dit programma.
PrivilegesRequiredOverrideTitle=Administratorprivilegio's vereist
PrivilegesRequiredOverrideInstruction=Kies hoe de installateur wordt uitgevoerd
PrivilegesRequiredOverrideText1=%1 U kunt ook alleen voor uw account installeren zonder administratieve privileges.
PrivilegesRequiredOverrideText2=%1 kan alleen worden geïnstalleerd voor uw account (geen administratieve rechten vereist) of voor alle gebruikers (administratieve rechten vereist).
PrivilegesRequiredOverrideAllUsers=Run als &Administrator (installeer voor alle gebruikers)
PrivilegesRequiredOverrideAllUsersRecommended=Uitvoeren als &Administrator (aanbevolen)
PrivilegesRequiredOverrideCurrentUser=Run als &Standard User (installeer alleen voor mij)
PrivilegesRequiredOverrideCurrentUserRecommended=Uitvoeren als &Standard User (aanbevolen)
ConfirmUninstall=Weet je zeker dat je de %1 Uninstall wizard?

[CustomMessages]
DesktopShortcuts=Bureaubladsnelkoppelingen
StartMenuShortcuts=Snelkoppelingen in het Startmenu
WelcomeDescription=VCMI is een opensource-engine voor Heroes III met nieuwe en uitgebreide mogelijkheden. Om VCMI te gebruiken, moet u de oorspronkelijke gegevensbestanden van het spel bezitten.%n%nDeze wizard installeert VCMI - Open Heroes 3 op uw apparaat.%n%nHet wordt aanbevolen alle andere toepassingen te sluiten voordat u doorgaat.%n%nKlik op Volgende om door te gaan of op Annuleren om Setup af te sluiten.
WelcomeHighlightsTitle=Over VCMI
WelcomeHighlights=VCMI is een door de gemeenschap ontwikkelde herimplementatie van de Heroes of Might and Magic III-engine. Het project bewaart de geest van het origineel, overwint technische beperkingen van de klassieke engine en biedt een open basis voor mods en verdere ontwikkeling.
RequirementImportSpaceHelp=Ga terug en kies een andere map voor gebruikersgegevens, of schakel het automatisch kopiëren van Heroes III-gegevens uit.
RequirementDisableImportQuestion=Wilt u doorgaan zonder de Heroes III-gegevens te kopiëren?
RequirementFirewall=Firewall
RequirementMultiplayerGames=Multiplayergames
RequirementSelected=Geselecteerd
RequirementNotSelected=Niet geselecteerd — samen spelen op één computer blijft werken
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Firewallregels voor multiplayergames toevoegen
AssociateH3MFiles=.h3m-bestanden associëren met de VCMI Kaartbeheerder
AssociateVCMIMapFiles=Associëren .vmap en .vcmp bestanden met de VCMI Kaartbeheerder
CacheDirectory=Cache
CloudDataNotice=Deze gebruikersgegevenslijst lijkt gesynchroniseerd te zijn door een cloudopslagprovider.
CloudDataWarning=De geselecteerde gebruikersdata directory lijkt gesynchroniseerd te zijn door een cloud storage provider.%n%nWil je deze directory toch gebruiken?
CloudInstallNotice=Dit installatie directory lijkt gesynchroniseerd te zijn door een cloud storage provider.
CloudInstallWarning=De geselecteerde installatie directory lijkt gesynchroniseerd te zijn door een cloud storage provider. Een draagbare of gesynchroniseerde installatie kan falen wanneer de provider de applicatiebestanden tijdelijk sluit.%n%nWil je deze directory toch gebruiken?
CloudTargetSilentError=Een stille installatie kan zonder /ALLOWCLOUDTARGET=1 geen met de cloud gesynchroniseerde doelmap gebruiken.
CopyH3FilesError=De Heroes III-bestanden (%s) konden niet worden gekopieerd. Sommige bestanden zijn mogelijk al gekopieerd; u kunt de import veilig opnieuw uitvoeren.
CopyingHeroes3Data=Heroes III-gegevens kopiëren...
ConfigDirectory=Configuratie
CopyH3Files=Automatisch kopiëren vereist Heroes III de dossiers naar VCMI
CreateDesktopShortcuts=Creëer werkplaatsvermogen
CreateStartMenuShortcuts=Maak startmenu shortcuts
DataFolderDescription=Een kopie van de verstrekte gegevens bewaart Heroes III gegevens, wijzigingen, kaarten, opgeslagen spellen en andere gebruikersbestanden.
DataFolderTitle=Gebruikersgegevensmap
DeleteUserData=Gebruikersgegevens verwijderen
DeleteUserDataDescription=Selecteer mappen om permanent te verwijderen. Niet gecontroleerde mappen worden bewaard. Dit kan niet worden ongedaan gemaakt.
DeletingUserData=Gebruikersgegevens verwijderen...
DirectoryConfigWriteError=De instellingen voor de gebruikersmappen konden niet worden opgeslagen in %s. De installatie kan niet veilig doorgaan.
DirectoryNotWritable=Er kan niet worden geschreven naar de geselecteerde map (%s). Kies een andere map of voer het installatieprogramma uit met de benodigde rechten.%n%n%s
DirectoryRootNotAllowed=De geselecteerde map (%s) mag niet de hoofdmap van een station of netwerkshare zijn. Kies een aparte map.%n%n%s
DirectoryOverlapError=De installatie- en gebruikersgegevensmap mogen niet gelijk zijn of elkaar onveilig overlappen. Alleen een draagbare installatie mag gebruikersgegevens in de installatiemap opslaan.
ReadyUserDataLocation=Locatie van gebruikersgegevens:
RequirementPassed=VOLDAAN
RequirementFailed=MISLUKT
RequirementWarning=WAARSCHUWING
RequirementInfo=INFORMATIE
RequirementOperatingSystem=Operatiesysteem
RequirementOperatingSystemValue=Windows 7 SP1 of hoger; compatibiliteitslooptijd inbegrepen indien vereist
RequirementArchitecture=Architectuur
RequirementInstallWritable=Installatiemap beschrijfbaar
RequirementDataWritable=Gebruikersgegevensmap beschrijfbaar
RequirementDirectoryLayout=Inrichting van het directory
RequirementDirectoryLayoutValue=De installatie- en gegevenspaden zijn veilig gescheiden
RequirementApplicationSpace=Applicatiediskruimte
RequirementFreeSpaceValue=%s MB vrij; het installatieprogramma controleert ook de uiteindelijke pakketgrootte
RequirementHeroesDataSpace=Heroes III-import
RequirementInsufficientSpace=Onvoldoende vrije ruimte voor de geselecteerde Heroes III-import
RequirementRequiredSpaceValue=Ongeveer %s MB nodig voor de geselecteerde import
RequirementNotRequested=Heroes III-import niet geselecteerd
RequirementCloudStorage=Synchronisatie van opslag
RequirementCloudStorageValue=Een geselecteerd pad lijkt cloud synchronisatie te gebruiken
RequirementLocalStorageValue=De geselecteerde paden lijken lokale opslag te gebruiken
RequirementInstallationMode=Installatiemodus
RequirementModePortable=Draagbaar; geen ontinstallatie, register of systeemintegratie
RequirementModeAllUsers=Alle gebruikers
RequirementModeCurrentUser=Huidige gebruiker
RequirementUpgrade=bestaande installatie wordt bijgewerkt
RequirementsCheckTitle=Systeemvereisten controleren
RequirementsCheckDescription=Installatie controleerde de geselecteerde configuratie vóór installatie.
H3MDescription=Heroes 3 kaartbestand
InstallFolderTitle=Installatie map
InstallForAllUsers=Installatie voor alle gebruikers
InstallForAllUsers1=Vereist administratieve privileges
InstallForMeOnly=Installeer alleen voor mij.
InstallForMeOnly1=Een firewall prompt verschijnt bij het starten van het spel voor het eerst
InstallForMeOnly2=LAN-games werken niet als de firewall regel niet mag worden toegestaan
InstallPortable=Draagbare installatie
InstallPortable1=Houdt de applicatie en gebruikersgegevens samen in één map
InstallPortable2=Creëert geen uninstaller of wijzigt het register en de systeemintegratie
LogsDirectory=Logboeken
ResetFoldersToDefault=Reset op standaard
RunVCMILauncherAfterInstall=Start de VCMI Launcher
SavesDirectory=Gespaarde spelletjes
ScanningFiles=Bestanden zoeken...
SelectSetupInstallModeDesc=VCMI kan voor alle gebruikers, alleen voor u of als draagbare toepassing worden geïnstalleerd.
SelectSetupInstallModeSubTitle=Selecteer de geïnstalleerde installatiemodus:
SelectSetupInstallModeTitle=Selecteer de installatiemodus
SharedUserDataNotice=Gebruikersgegevens kunnen niet worden verwijderd omdat een andere VCMI de installatie gebruikt hetzelfde directory.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Bezoek de ambtenaar. VCMI Verschillen
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Start de VCMI Launcher
ShortcutMapEditor=VCMI Kaartbeheerder
ShortcutMapEditorComment=Maak de deur open. VCMI Kaartbeheerder
ShortcutWebPage=VCMI Website
ShortcutWebPageComment=Bezoek de ambtenaar VCMI website
SystemIntegration=Systemenintegratie
FileAssociations=Bestandskoppelingen
AssociateH3CFiles=Heroes III-campagnes (.h3c) openen in de VCMI-kaarteditor
H3CDescription=Heroes III-campagne
Uninstall=De installatie verwijderen
UserDataDirectory=Gebruikersgegevens (Heroes III gegevens, wijzigingen, kaarten en andere bestanden)
VCMISettings=Systeemconfiguratie
VCMPDescription=VCMI Campagnebestand
VMAPDescription=VCMI Kaartbestand
Warning=Waarschuwing
X86On64BitWarning=U installeert de 32-bit (x86) versie van VCMI Dit wordt ondersteund, maar de inheemse 64-bit versie wordt aanbevolen wanneer deze beschikbaar is.
Heroes3ImportReparsePoint=Heroes III-gegevens kunnen niet veilig worden geïmporteerd omdat een bestaande doelmap een koppelpunt of symbolische koppeling bevat. Verwijder de koppeling of kies een andere map.
OpenSetupLog=Open setup log
OpenSetupLogError=Het installatielog kon niet worden geopend.
LegacyUninstallStartFailed=Het vorige VCMI-deïnstallatieprogramma kon niet worden gestart:%n%s
LegacyUninstallExitFailed=Het vorige VCMI-deïnstallatieprogramma is mislukt met foutcode %s.
LegacyUninstallFailureChoice=Afbreken stopt de installatie. Opnieuw proberen voert het oude deïnstallatieprogramma nogmaals uit. Negeren gaat op eigen risico verder.
LegacyUninstallRequired=De vorige VCMI-installatie kon niet worden verwijderd. Er zijn geen nieuwe installatiebestanden gekopieerd.
InstallDirectoryUsedByOtherInstallation=De installatielijst overlapt met een andere geregistreerde VCMI installatie:%n%s%n%nSelecteer een ander directory.
X86OnARM64Warning=U installeert de 32-bit (x86) versie van VCMI op ARM64 Windows. Dit wordt ondersteund, maar de inheemse ARM64 versie wordt aanbevolen indien beschikbaar.
RequirementsColumnComponent=Component
RequirementsColumnDetails=Verplichting
RequirementsColumnStatus=Statussituatie
RequirementsColumnDetected=Uw systeem
RequirementDetectedWindows=Compatibele Windows-installatie
RequirementWritableValue=Beschrijfbare map
RequirementEnoughSpace=Voldoende vrije ruimte
RequirementProcessor=Verwerker
RequirementProcessorValue=1 GHz of hoger
RequirementMemory=Werkgeheugen
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11-runtime beschikbaar
RequirementDirectXMissing=DirectX 11-runtime niet gevonden
RequirementDetectionUnavailable=Niet vast te stellen
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Installatiemap
RequirementUserDataFolder=Map met gebruikersgegevens
RequirementDiskSpace=Gratis schijfruimte
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Aanbevolen
RequirementInternetAvailable=Beschikbaar
RequirementInternetUnavailable=Niet gedetecteerd
RequirementHeroesData=Heroes III-gegevens
RequirementRequiredToPlay=Nodig om te spelen
RequirementHeroesDataAvailable=Beschikbaar in de gebruikersgegevens
RequirementHeroesDataMissing=Niet gevonden; kan later worden ingevoerd
RequirementWritableAndSynced=Schrijfbaar en synchroniseerd
RequirementNotWritable=Niet beschrijfbaar
TasksCheckboxesTooltip=Selecteer optionele integraties en acties. Snelkoppelingen geven snelle toegang, bestandskoppelingen openen ondersteunde kaarten in de editor, firewallregels maken multiplayer mogelijk en importeren kopieert gevonden Heroes III-gegevens.
UninstallCheckboxesTooltip=Selecteer alleen de gebruikersgegevensmappen die u definitief wilt verwijderen. Uitgeschakelde gedeelde vermeldingen worden door een andere VCMI-installatie gebruikt.
InstallModeTooltip=Alle gebruikers: installeert VCMI voor alle Windows-accounts, normaal gesproken in Program Files. Vereist beheerdersrechten. Maakt systeembrede deïnstallatiegegevens, registervermeldingen, snelkoppelingen, bestandskoppelingen en een optionele firewallregel. Gebruikersgegevens blijven in de gekozen map.%n%nHuidige gebruiker: installeert VCMI alleen voor het aangemelde Windows-account, normaal gesproken in Local AppData, zonder beheerdersrechten. Maakt een deïnstallatieprogramma en integraties voor die gebruiker. Andere accounts zien deze installatie niet. Windows Firewall kan bij het eerste gebruik van multiplayer om toestemming vragen.%n%nDraagbaar: bewaart de toepassing en gebruikersgegevens samen in de gekozen map. Maakt geen deïnstallatieprogramma, registervermeldingen, snelkoppelingen, bestandskoppelingen of firewallregels. De map moet beschrijfbaar blijven. Verplaats of kopieer de map om de installatie over te zetten; verwijder de map om de installatie te verwijderen.
CopyH3FilesTooltip=Kopieert de gevonden Heroes III-mappen Data, Maps en Mp3 naar de gekozen VCMI-gebruikersgegevensmap. De oorspronkelijke bestanden blijven ongewijzigd.
ReadyHeroes3Import=Heroes III-gegevensimport:
