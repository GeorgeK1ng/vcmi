;
; Norwegian.isl, part of VCMI engine
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
HelpTextNote=Installasjonsparametere for VCMI:%n  /USERDATADIR=<path>  Angir mappen for VCMI-brukerdata. Prefikset expand: utvider Inno Setup-konstanter.%n  /ALLOWCLOUDTARGET=1  Tillater en sky-synkronisert installasjons- eller brukerdatamappe ved stille installasjon.%n  /PORTABLE=1  Installerer programmet og dataene sammen uten avinstallasjonsprogram, registerendringer, snarveier, filtilknytninger eller brannmurregler.%n  /LAUNCH  Starter VCMI etter installasjonen, også ved stille installasjon.%n  /COPYH3DATA=0|1  Aktiverer eller deaktiverer automatisk kopiering av oppdagede Heroes III-data.%n%nOppgavenavn for /TASKS og /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (bare installasjon for alle brukere med administratorrettigheter)%n%nAvinstallasjonsparameter for VCMI:%n  /DELETEUSERDATA=1  Sletter alle konfigurerte VCMI-brukermapper. Gjelder bare sammen med /SILENT eller /VERYSILENT. Dette kan ikke angres.%n%nStandardparameterne er beskrevet ovenfor: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Dette programmet kan ikke kjøre på din versjon av Windows.x86 / x64 / ARM64) og versjon for dette programmet.
PrivilegesRequiredOverrideTitle=Administrativt privilegium som kreves
PrivilegesRequiredOverrideInstruction=Velg hvordan du kjører installeren
PrivilegesRequiredOverrideText1=%1 Du kan også installere bare for kontoen din uten administrasjonsbevis.
PrivilegesRequiredOverrideText2=%1 kan bare installeres for kontoen din (ingen administrativ rett kreves) eller for alle brukere (kreves administrative rettigheter).
PrivilegesRequiredOverrideAllUsers=Kjør som &Administrator (installer for alle brukere)
PrivilegesRequiredOverrideAllUsersRecommended=Kjør som &Administrator (rekommendert)
PrivilegesRequiredOverrideCurrentUser=Kjør som &Standard User (installer bare for meg)
PrivilegesRequiredOverrideCurrentUserRecommended=Kjør som &Standard User (rekommendert)
ConfirmUninstall=Er du sikker på at du vil kjøre %1 Uninstall wizard?

[CustomMessages]
DesktopShortcuts=Skrivebordssnarveier
StartMenuShortcuts=Startmenysnarveier
WelcomeDescription=VCMI er en spillmotor med åpen kildekode for Heroes III med nye og utvidede muligheter. For å bruke VCMI må du eie datafilene fra originalspillet.%n%nDenne veiviseren installerer VCMI - Open Heroes 3 på enheten din.%n%nDet anbefales at du lukker alle andre programmer før du fortsetter.%n%nKlikk Neste for å fortsette, eller Avbryt for å avslutte installasjonen.
WelcomeHighlightsTitle=Om VCMI
WelcomeHighlights=VCMI er en fellesskapsutviklet nyimplementering av Heroes of Might and Magic III-motoren. Prosjektet bevarer ånden i originalspillet, overvinner tekniske begrensninger i den klassiske motoren og gir et åpent grunnlag for modifikasjoner og videre utvikling.
RequirementImportSpaceHelp=Gå tilbake og velg en annen mappe for brukerdata, eller fjern automatisk kopiering av Heroes III-data.
RequirementDisableImportQuestion=Vil du fortsette uten å kopiere Heroes III-dataene?
RequirementFirewall=Brannmur
RequirementMultiplayerGames=Flerspillerspill
RequirementSelected=Valgt
RequirementNotSelected=Ikke valgt — spill på samme datamaskin vil fortsatt fungere
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Legg til brannmurregler for flerspillerspill
AssociateH3MFiles=Associere .h3m-filer med VCMI Kartutrediger
AssociateVCMIMapFiles=Associere .vmap og .vcmp filer med VCMI Kartutrediger
CacheDirectory=Cache
CloudDataNotice=Dette brukerdata-registeret ser ut til å være synkronisert av en cloudlagringsleverandør.
CloudDataWarning=Den valgte brukerdata-registeret ser ut til å være synkronisert av en skylagringsleverandør. Synkronisering kan midlertidig låse filer og forårsake installasjon av mod, spillstart eller lagre feil.%n%nVil du bruke dette kataloget uansett?
CloudInstallNotice=Dette installasjonsdirektoriet ser ut til å være synkronisert av en cloudlagringsleverandør.
CloudInstallWarning=Det valgte installasjonsdirektoriet ser ut til å være synkronisert av en cloud-lagringsleverandør. En bærbar eller synkronisert installasjon kan mislykkes når leverandøren midlertidig låser applikasjonsfiler.%n%nVil du bruke dette kataloget uansett?
CloudTargetSilentError=Stille installasjon kan ikke bruke en sky-synkronisert målmappe uten /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Kunne ikke kopiere Heroes III-filene (%s). Noen filer kan allerede være kopiert; du kan kjøre importen på nytt uten risiko.
CopyingHeroes3Data=Kopierer Heroes III-data...
ConfigDirectory=Konfigurasjon
CopyH3Files=Automatisk kopiering nødvendig Heroes III filer til VCMI
CreateDesktopShortcuts=Skape skrivebord snarveier
CreateStartMenuShortcuts=Lag snarveier til Start-menyen
DataFolderDescription=Lagrer en kopi av den leverte Heroes III data, modifikasjoner, kart, lagre spill og andre brukerfiler.
DataFolderTitle=Brukerdata mappe
DeleteUserData=Slett brukerdata
DeleteUserDataDescription=Velg mapper å slette permanent. Ukontrollerte mapper vil bli holdt. Dette kan ikke avvikles.
DeletingUserData=Sletter brukerdata...
DirectoryConfigWriteError=Kunne ikke lagre innstillingene for brukermapper i %s. Installasjonen kan ikke fortsette trygt.
DirectoryNotWritable=Kan ikke skrive til den valgte mappen (%s). Velg en annen mappe eller kjør installasjonen med nødvendige rettigheter.%n%n%s
DirectoryRootNotAllowed=Den valgte mappen (%s) kan ikke være roten på en stasjon eller nettverksressurs. Velg en egen mappe.%n%n%s
DirectoryOverlapError=Installasjons- og brukerdatamappene kan ikke være identiske eller overlappe på en utrygg måte. Bare en portabel installasjon kan lagre brukerdata i installasjonsmappen.
ReadyUserDataLocation=Plassering av brukerdata:
RequirementPassed=GODKJENT
RequirementFailed=FEIL
RequirementWarning=ADVARSEL
RequirementInfo=INFORMASJON
RequirementOperatingSystem=Operasjonssystem
RequirementOperatingSystemValue=Windows 7 SP1 eller nyere; kompatibilitetsløpet inkludert når nødvendig
RequirementArchitecture=Arkitektur
RequirementInstallWritable=Installasjonsmappen er skrivbar
RequirementDataWritable=Brukerdatamappen er skrivbar
RequirementDirectoryLayout=Ordningsregisters layout
RequirementDirectoryLayoutValue=Installasjons- og brukerdatabanene er trygt atskilt
RequirementApplicationSpace=Applikasjonsdiskplasser
RequirementFreeSpaceValue=%s MB ledig; installasjonsprogrammet kontrollerer også pakkens endelige størrelse
RequirementHeroesDataSpace=Heroes III-import
RequirementInsufficientSpace=Ikke nok ledig plass til den valgte Heroes III-importen
RequirementRequiredSpaceValue=Omtrent %s MB kreves for den valgte importen
RequirementNotRequested=Heroes III-import er ikke valgt
RequirementCloudStorage=Lagringssynkronisering
RequirementCloudStorageValue=En valgt vei ser ut til å bruke sky synkronisering
RequirementLocalStorageValue=Velgede veier ser ut til å bruke lokal lagring
RequirementInstallationMode=Installasjonsmodus
RequirementModePortable=Portable; ingen uninstaller, register eller systemintegrasjon
RequirementModeAllUsers=Alle brukere
RequirementModeCurrentUser=Nærværende bruker
RequirementUpgrade=eksisterende installasjon oppgraderes
RequirementsCheckTitle=Kontroll av systemkrav
RequirementsCheckDescription=Install sjekket den valgte konfigurasjonen før installasjonen.
H3MDescription=Heroes 3 kartfil
InstallFolderTitle=Installationsmappe
InstallForAllUsers=Install for alle brukere
InstallForAllUsers1=Krav på administrative privilegier
InstallForMeOnly=Install bare for meg
InstallForMeOnly1=En brannmur prompt vises når du lanserer spillet for første gang
InstallForMeOnly2=LAN-spill vil ikke fungere hvis brannmurregelen ikke kan tillates
InstallPortable=Portable installasjon
InstallPortable1=Lagrer applikasjonen og brukerdata sammen i én mappe
InstallPortable2=Ikke oppretter en uninstaller eller endrer registret og systemintegrasjonen
LogsDirectory=Logger
ResetFoldersToDefault=Omstilling til standard
RunVCMILauncherAfterInstall=Lansere VCMI Launcher
SavesDirectory=Spilte spill
ScanningFiles=Søker etter filer...
SelectSetupInstallModeDesc=VCMI kan installeres for alle brukere, bare for deg eller i portabel modus.
SelectSetupInstallModeSubTitle=Velg din foretrukne installasjonsmodus:
SelectSetupInstallModeTitle=Velg installasjonsmodus
SharedUserDataNotice=Brukerdata kan ikke slettes fordi en annen VCMI installasjonen bruker samme katalog.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Besøk tjenestemannen VCMI Uenighet
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Lansere VCMI Launcher
ShortcutMapEditor=VCMI Kartutrediger
ShortcutMapEditorComment=Åpne VCMI Kartutrediger
ShortcutWebPage=VCMI Nettsted
ShortcutWebPageComment=Besøk tjenestemannen VCMI nettsted
SystemIntegration=Systemintegrasjon
FileAssociations=Filtilknytninger
AssociateH3CFiles=Åpne Heroes III-kampanjer (.h3c) i VCMI-kartredigering
H3CDescription=Heroes III-kampanje
Uninstall=Uninstallere
UserDataDirectory=Brukerdata (Heroes III data, modifikasjoner, kart og andre filer)
VCMISettings=Systemkonfigurasjon
VCMPDescription=VCMI Kampanjefil
VMAPDescription=VCMI Kartfil
Warning=Advarsel
X86On64BitWarning=Du installerer 32-bit (x86) versjon av VCMI Dette støttes, men den opprinnelige 64-bit-versjonen anbefales når den er tilgjengelig.
Heroes3ImportReparsePoint=Heroes III-data kan ikke importeres trygt fordi en eksisterende målmappe inneholder et koblingspunkt eller en symbolsk lenke. Fjern lenken eller velg en annen mappe.
OpenSetupLog=Åpne innstillingslogg
OpenSetupLogError=Installasjonsloggen kunne ikke åpnes.
LegacyUninstallStartFailed=Kunne ikke starte det forrige avinstallasjonsprogrammet for VCMI:%n%s
LegacyUninstallExitFailed=Det forrige avinstallasjonsprogrammet for VCMI mislyktes med feilkode %s.
LegacyUninstallFailureChoice=Avbryt stopper installasjonen. Prøv igjen kjører det gamle avinstallasjonsprogrammet på nytt. Ignorer fortsetter på egen risiko.
LegacyUninstallRequired=Den forrige VCMI-installasjonen kunne ikke fjernes. Ingen nye installasjonsfiler ble kopiert.
InstallDirectoryUsedByOtherInstallation=Installationsregisteret overlapper en annen registrert VCMI installasjon:%n%s%n%nVelg et annet katalog.
X86OnARM64Warning=Du installerer 32-bit (x86) versjon av VCMI på ARM64 Windows. Dette er støttet, men den opprinnelige ARM64 versjon anbefales når den er tilgjengelig.
RequirementsColumnComponent=Komponent
RequirementsColumnDetails=Forutsetning
RequirementsColumnStatus=Status
RequirementsColumnDetected=Systemet ditt
RequirementDetectedWindows=Kompatibel installasjon av Windows
RequirementWritableValue=Skrivbar mappe
RequirementEnoughSpace=Nok ledig plass
RequirementProcessor=Prosessor
RequirementProcessorValue=1 GHz eller høyere
RequirementMemory=Arbeidsminne
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11-kjøremiljø er tilgjengelig
RequirementDirectXMissing=DirectX 11-kjøremiljø ble ikke funnet
RequirementDetectionUnavailable=Kunne ikke oppdages
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Installasjonsmappe
RequirementUserDataFolder=Brukerdatamappe
RequirementDiskSpace=Gratis diskplass
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internett
RequirementRecommended=Anbefalt
RequirementInternetAvailable=Tilgjengelig
RequirementInternetUnavailable=Ikke oppdaget
RequirementHeroesData=Heroes III-data
RequirementRequiredToPlay=Kreves for å spille
RequirementHeroesDataAvailable=Finnes i brukerdata
RequirementHeroesDataMissing=Ikke funnet; kan importeres senere
RequirementWritableAndSynced=Skrevbar og synkronisert
RequirementNotWritable=Ikke skrivbar
TasksCheckboxesTooltip=Velg valgfrie integrasjoner og handlinger. Snarveier gir enkel tilgang, filtilknytninger åpner støttede kart i redigeringsverktøyet, brannmurregler tillater flerspillerspill og import kopierer oppdagede Heroes III-data.
UninstallCheckboxesTooltip=Merk bare brukerdatamappene du vil slette permanent. Deaktiverte delte oppføringer brukes av en annen VCMI-installasjon.
InstallModeTooltip=Alle brukere: installerer VCMI for alle Windows-kontoer, vanligvis i Program Files. Krever administratorgodkjenning. Oppretter systemomfattende avinstallasjonsinformasjon, registeroppføringer, snarveier, filtilknytninger og en valgfri brannmurregel. Brukerdata forblir i den valgte mappen.%n%nGjeldende bruker: installerer VCMI bare for den påloggede Windows-kontoen, vanligvis i Local AppData, uten administratorgodkjenning. Oppretter et avinstallasjonsprogram og integrasjoner for brukeren. Andre kontoer ser ikke installasjonen. Windows-brannmuren kan be om tillatelse første gang flerspillerspill brukes.%n%nPortabel: lagrer programmet og brukerdata sammen i den valgte mappen. Oppretter ikke avinstallasjonsprogram, registeroppføringer, snarveier, filtilknytninger eller brannmurregler. Mappen må forbli skrivbar. Flytt eller kopier den for å overføre installasjonen; slett den for å avinstallere.
CopyH3FilesTooltip=Kopierer de oppdagede Heroes III-mappene Data, Maps og Mp3 til den valgte VCMI-brukerdatamappen. De opprinnelige filene endres ikke.
ReadyHeroes3Import=Import av Heroes III-data:
