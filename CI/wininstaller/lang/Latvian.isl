;
; Latvian.isl, part of VCMI engine
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
HelpTextNote=VCMI instalēšanas parametri:%n  /USERDATADIR=<path>  Iestata VCMI lietotāja datu mapi. Prefikss expand: izvērš Inno Setup konstantes.%n  /ALLOWCLOUDTARGET=1  Klusās instalēšanas laikā atļauj izmantot ar mākoņkrātuvi sinhronizētu instalācijas vai lietotāja datu mapi.%n  /PORTABLE=1  Instalē lietotni un datus kopā bez atinstalētāja, reģistra izmaiņām, saīsnēm, failu asociācijām vai ugunsmūra kārtulām.%n  /LAUNCH  Palaiž VCMI pēc instalēšanas, arī klusajā režīmā.%n  /COPYH3DATA=0|1  Iespējo vai atspējo atrasto Heroes III datu automātisku kopēšanu.%n%nUzdevumu nosaukumi parametriem /TASKS un /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (tikai instalēšanai visiem lietotājiem ar administratora tiesībām)%n%nVCMI atinstalēšanas parametrs:%n  /DELETEUSERDATA=1  Dzēš visas konfigurētās VCMI lietotāja mapes. Darbojas tikai kopā ar /SILENT vai /VERYSILENT. Šo darbību nevar atsaukt.%n%nStandarta parametri ir aprakstīti iepriekš: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Šī programma nevar tikt vadīta jūsu Windows versijā.x86 / x64 / ARM64) un šīs programmas versija.
PrivilegesRequiredOverrideTitle=Administratora pienākumi
PrivilegesRequiredOverrideInstruction=Izvēliet, kā runāt instalatoru
PrivilegesRequiredOverrideText1=Lai instalētu %1 visiem lietotājiem, nepieciešamas administratora tiesības. Varat to instalēt tikai savam kontam bez šīm tiesībām.
PrivilegesRequiredOverrideText2=%1 var instalēt tikai jūsu kontam bez administratora tiesībām vai visiem lietotājiem ar administratora tiesībām.
PrivilegesRequiredOverrideAllUsers=Palaist kā &administratoram (instalēt visiem lietotājiem)
PrivilegesRequiredOverrideAllUsersRecommended=Palaist kā &administratoram (ieteicams)
PrivilegesRequiredOverrideCurrentUser=Palaist kā &standarta lietotājam (tikai man)
PrivilegesRequiredOverrideCurrentUserRecommended=Palaist kā &standarta lietotājam (ieteicams)
ConfirmUninstall=Vai esat pārliecināts, ka vēlaties vadīt %1 atīlīt Vidzērnieku?

[CustomMessages]
DesktopShortcuts=Darbvirsmas saīsnes
StartMenuShortcuts=Izvēlnes Sākt saīsnes
WelcomeDescription=VCMI ir atvērtā pirmkoda Heroes III dzinis ar jaunām un paplašinātām iespējām. Lai izmantotu VCMI, jums jābūt oriģinālās spēles datu failiem.%n%nŠis vednis instalēs VCMI - Open Heroes 3 jūsu ierīcē.%n%nPirms turpināt, ieteicams aizvērt visas pārējās lietojumprogrammas.%n%nNoklikšķiniet Tālāk, lai turpinātu, vai Atcelt, lai izietu no instalēšanas.
WelcomeHighlightsTitle=Par VCMI
WelcomeHighlights=VCMI ir kopienas izstrādāta Heroes of Might and Magic III dziņa atkārtota realizācija. Projekts saglabā oriģinālās spēles garu, pārvar klasiskā dziņa tehniskos ierobežojumus un nodrošina atvērtu pamatu modifikācijām un turpmākai attīstībai.
RequirementImportSpaceHelp=Atgriezieties un izvēlieties citu lietotāja datu mapi vai izslēdziet automātisku Heroes III datu kopēšanu.
RequirementDisableImportQuestion=Vai turpināt bez Heroes III datu kopēšanas?
RequirementFirewall=Ugunsmūris
RequirementMultiplayerGames=Vairāku spēlētāju spēles
RequirementSelected=Atlasīts
RequirementNotSelected=Nav atlasīts — spēle pie viena datora darbosies
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Pievienot ugunsmūra kārtulas vairāku spēlētāju spēlēm
AssociateH3MFiles=Apvieno .h3m failus ar VCMI Karta redaktors
AssociateVCMIMapFiles=Apvieno .vmap un .vcmp failus ar VCMI Karta redaktors
CacheDirectory=Cache
CloudDataNotice=Šis lietotāju datu adresārs, šķiet, ir sinhronizēts ar pilnas uzglabāšanas pakalpojumu sniedzēju.
CloudDataWarning=Izvēlētais lietotāju datu adresārs šķiet sinhronizēts ar debesīšu uzglabāšanas pakalpojumu sniedzēju.%n%nVai tu vēl gribi izmantot šo adresāru?
CloudInstallNotice=Šis uzstādīšanas direktorijs, šķiet, ir sinhronizēts ar pilnas uzglabāšanas pakalpojumu sniedzēju.
CloudInstallWarning=Izvēlētajai instalācijas direktorijai šķiet, ka to sinhronizē pilnas uzglabāšanas pakalpojumu sniedzējs.%n%nVai tu vēl gribi izmantot šo adresāru?
CloudTargetSilentError=Klusā instalēšana nevar izmantot ar mākoņkrātuvi sinhronizētu mērķi bez /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Neizdevās kopēt Heroes III failus (%s). Daži faili var būt jau nokopēti; importēšanu var droši atkārtot.
CopyingHeroes3Data=Kopē Heroes III datus...
ConfigDirectory=Konfigurācija
CopyH3Files=Automatiska kopija Heroes III arīkojumi VCMI
CreateDesktopShortcuts=Izveidojiet desktop īrpuses
CreateStartMenuShortcuts=Izveidojiet Start menu īstu sarunu
DataFolderDescription=Apglabā kopiju no sniegto Heroes III datu, izmaiņas, kartes, saglabātās spēles un citas lietotāja datubāzes.
DataFolderTitle=Ar lietotāju datu mapju
DeleteUserData=Iztrēsk lietotāja datus
DeleteUserDataDescription=Izvēliet galeri, ko pastāvīgi izdzēst. Nav pārbaudīti galeri tiks saglabāti.
DeletingUserData=Dzēš lietotāja datus...
DirectoryConfigWriteError=Neizdevās saglabāt lietotāja mapju iestatījumus failā %s. Instalēšanu nevar droši turpināt.
DirectoryNotWritable=Atlasītajā mapē (%s) nevar rakstīt. Izvēlieties citu mapi vai palaidiet instalētāju ar nepieciešamajām tiesībām.%n%n%s
DirectoryRootNotAllowed=Atlasītā mape (%s) nevar būt diska vai tīkla koplietojuma sakne. Izvēlieties atsevišķu mapi.%n%n%s
DirectoryOverlapError=Instalācijas un lietotāja datu mapes nevar būt vienādas vai nedroši pārklāties. Tikai pārnēsājama instalācija var glabāt lietotāja datus instalācijas mapē.
ReadyUserDataLocation=Lietotāja datu atrašanās vieta:
RequirementPassed=IZPILDĪTS
RequirementFailed=KĻŪDA
RequirementWarning=BRĪDINĀJUMS
RequirementInfo=INFORMĀCIJA
RequirementOperatingSystem=Operācijas sistēma
RequirementOperatingSystemValue=Windows 7 SP1 vai jaunāka versija; nepieciešamības gadījumā iekļauta saderības izpildlaika vide
RequirementArchitecture=Arhitektūra
RequirementInstallWritable=Instalācijas mapē var rakstīt
RequirementDataWritable=Lietotāja datu mapē var rakstīt
RequirementDirectoryLayout=Direktorijas sastāva
RequirementDirectoryLayoutValue=Instalācijas un lietotāja datu ceļi ir droši nodalīti
RequirementApplicationSpace=Aplikācijas diska platība
RequirementFreeSpaceValue=%s MB brīvi; instalētājs pārbauda arī pakotnes galīgo lielumu
RequirementHeroesDataSpace=Heroes III datu importēšana
RequirementInsufficientSpace=Nepietiek brīvas vietas atlasīto Heroes III datu importēšanai
RequirementRequiredSpaceValue=Atlasītajai importēšanai nepieciešami aptuveni %s MB
RequirementNotRequested=Heroes III datu importēšana nav atlasīta
RequirementCloudStorage=Saimniekošanas sinhronizācija
RequirementCloudStorageValue=Izvēlēts ceļš, šķiet, izmanto debesīšu sinhronizāciju
RequirementLocalStorageValue=Izvēlēti maršruts, šķiet, izmanto vietējo uzglabāšanu
RequirementInstallationMode=Instalacijas veids
RequirementModePortable=Pārnēsājama; nav noinstalētāja, reģistra vai sistēmas integrācijas
RequirementModeAllUsers=Visi lietotāji
RequirementModeCurrentUser=Pašreizējais lietotājs
RequirementUpgrade=esošā instalācija tiks atjaunināta
RequirementsCheckTitle=Sistemas prasības pārbaude
RequirementsCheckDescription=Konfiguracija pirms uzstādīšanas pārbaudīja izvēlēto konfigurāciju.
H3MDescription=Heroes 3 Map File
InstallFolderTitle=Installacijas mapes
InstallForAllUsers=Installacija visiem lietotājiem
InstallForAllUsers1=Vajag administratīvās tiesības
InstallForMeOnly=Instalēt tikai man.
InstallForMeOnly1=Ja spēle sāksies pirmo reizi, parādīsies ugunsdzēsības vārda brīdinājums.
InstallForMeOnly2=Spēle lokālajā tīklā nedarbosies, ja ugunsmūris neatļaus piekļuvi
InstallPortable=Pārnēsājama instalācija
InstallPortable1=Aplikāciju un lietotāju datus glabā vienā mapē
InstallPortable2=Neizveido atīloto ierīci vai nekonvertē reģistru un sistēmas integrāciju
LogsDirectory=Šķiet, ka tas ir ļoti svarīgi.
ResetFoldersToDefault=Atkārtojiet ar nenovērtētu
RunVCMILauncherAfterInstall=Uzstājiet VCMI Izlaišanas ierīce
SavesDirectory=Izsludinātas spēles
ScanningFiles=Meklē failus...
SelectSetupInstallModeDesc=VCMI var instalēt visiem lietotājiem, tikai jums vai pārnēsājamā režīmā.
SelectSetupInstallModeSubTitle=Izvēlieties izvēloties uzstādīšanas režīmu:
SelectSetupInstallModeTitle=Izvēlējiet uzstādīšanas režīmu
SharedUserDataNotice=lietotāja datus nevar izdzirt, jo VCMI instalācija izmanto vienu un to pašu direktoriju.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Ziediet amatpersonu VCMI Neatbilstība
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Uzstājiet VCMI Izlaišanas ierīce
ShortcutMapEditor=VCMI Karta redaktors
ShortcutMapEditorComment=Atvērt VCMI Karta redaktors
ShortcutWebPage=VCMI Websajt
ShortcutWebPageComment=Ziediet amatpersonu VCMI tīmekļa vietne
SystemIntegration=Sistēmās integrācija
FileAssociations=Failu asociācijas
AssociateH3CFiles=Atvērt Heroes III kampaņas (.h3c) VCMI karšu redaktorā
H3CDescription=Heroes III kampaņa
Uninstall=Izinstallēt
UserDataDirectory=lietotāju dati (Heroes III dati, grozījumi, kartes un citas datubāzes)
VCMISettings=Sistēmas konfigurācija
VCMPDescription=VCMI Kampanjas dators
VMAPDescription=VCMI Map File
Warning=brīdinājums
X86On64BitWarning=Jūs uzstādīsiet 32-bitu (x86) versija VCMI 64 bitā Windows. Tas tiek atbalstīts, bet, ja ir pieejams, ieteicams izmantot 64-bitā versiju.
Heroes3ImportReparsePoint=Heroes III datus nevar droši importēt, jo esoša mērķa mape satur savienojuma punktu vai simbolisku saiti. Noņemiet saiti vai izvēlieties citu mapi.
OpenSetupLog=Atvērtā konfigurācijas žurnāla
OpenSetupLogError=Izveidošanas žurnālu nevar atvērt.
LegacyUninstallStartFailed=Neizdevās palaist iepriekšējo VCMI atinstalētāju:%n%s
LegacyUninstallExitFailed=Iepriekšējais VCMI atinstalētājs beidzās ar kļūdas kodu %s.
LegacyUninstallFailureChoice=Pārtraukt aptur instalēšanu. Mēģināt vēlreiz atkārtoti palaiž veco atinstalētāju. Ignorēt turpina uz jūsu atbildību.
LegacyUninstallRequired=Iepriekšējo VCMI instalāciju neizdevās noņemt. Jauni instalācijas faili netika kopēti.
InstallDirectoryUsedByOtherInstallation=Instalacijas direktorija pārklājas ar citu reģistrētu VCMI uzstādīšana:%n%s%n%nIzvēli citu direktoriju.
X86OnARM64Warning=Jūs uzstādīsiet 32-bitu (x86) versija VCMI uz ARM64 Windows. Tas ir atbalstīts, bet vietējais ARM64 ja ir pieejama versija.
RequirementsColumnComponent=Komponents
RequirementsColumnDetails=Vajadzība
RequirementsColumnStatus=Statuss
RequirementsColumnDetected=Jūsu sistēma
RequirementDetectedWindows=Kompatibils Windows uzstādīšana
RequirementWritableValue=Rakstāma mape
RequirementEnoughSpace=Pietiek brīvas vietas
RequirementProcessor=Processors
RequirementProcessorValue=1 GHz vai ātrāk
RequirementMemory=Operatīvā atmiņa
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Pieejama DirectX 11 izpildlaika vide
RequirementDirectXMissing=DirectX 11 izpildlaika vide nav atrasta
RequirementDetectionUnavailable=Neizdevās noteikt
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Instalācijas mape
RequirementUserDataFolder=Lietotāja datu mape
RequirementDiskSpace=Atbalsta diska telpa
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internets
RequirementRecommended=Rekomendēts
RequirementInternetAvailable=Pieejams
RequirementInternetUnavailable=Neatkarēts
RequirementHeroesData=Heroes III dati
RequirementRequiredToPlay=Nepieciešams spēlēšanai
RequirementHeroesDataAvailable=Pieejami lietotāja datos
RequirementHeroesDataMissing=Neatrodas; var importēt vēlāk
RequirementWritableAndSynced=Rakstams un sinhronizēts
RequirementNotWritable=Nav rakstīšanas tiesību
TasksCheckboxesTooltip=Atlasiet neobligātās integrācijas un darbības. Saīsnes atvieglo piekļuvi, failu asociācijas atver atbalstītās kartes redaktorā, ugunsmūra kārtulas atļauj daudzspēlētāju spēli, bet importēšana kopē atrastos Heroes III datus.
UninstallCheckboxesTooltip=Atlasiet tikai tās lietotāja datu mapes, kuras vēlaties neatgriezeniski dzēst. Atspējotos koplietotos ierakstus izmanto cita VCMI instalācija.
InstallModeTooltip=Visi lietotāji: instalē VCMI visiem Windows kontiem, parasti mapē Program Files. Nepieciešams administratora apstiprinājums. Izveido sistēmas mēroga atinstalēšanas informāciju, reģistra ierakstus, saīsnes, failu asociācijas un neobligātu ugunsmūra kārtulu. Dati paliek atlasītajā mapē.%n%nPašreizējais lietotājs: instalē VCMI tikai pašlaik izmantotajam Windows kontam, parasti mapē Local AppData, bez administratora apstiprinājuma. Izveido atinstalētāju un integrācijas šim lietotājam. Citi konti šo instalāciju neredzēs. Pirmajā daudzspēlētāju spēles izmantošanas reizē Windows ugunsmūris var prasīt atļauju.%n%nPārnēsājama: glabā lietotni un datus kopā atlasītajā mapē. Neizveido atinstalētāju, reģistra ierakstus, saīsnes, failu asociācijas vai ugunsmūra kārtulas. Mapei jāpaliek rakstāmai. Pārvietojiet vai kopējiet to, lai pārnestu instalāciju, vai dzēsiet to, lai atinstalētu.
CopyH3FilesTooltip=Kopē atrastās Heroes III mapes Data, Maps un Mp3 atlasītajā VCMI lietotāja datu mapē. Sākotnējie faili paliek nemainīti.
ReadyHeroes3Import=Heroes III datu importēšana:
