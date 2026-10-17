;
; Romanian.isl, part of VCMI engine
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
HelpTextNote=Parametri de instalare VCMI:%n  /USERDATADIR=<path>  Stabilește directorul datelor utilizatorului VCMI. Prefixul expand: extinde constantele Inno Setup.%n  /ALLOWCLOUDTARGET=1  Permite un director de instalare sau de date sincronizat cu cloudul în timpul instalării silențioase.%n  /PORTABLE=1  Instalează aplicația și datele împreună, fără dezinstalator, modificări ale registrului, scurtături, asocieri de fișiere sau reguli de paravan de protecție.%n  /LAUNCH  Pornește VCMI după instalare, inclusiv în modul silențios.%n  /COPYH3DATA=0|1  Activează sau dezactivează copierea automată a datelor Heroes III detectate.%n%nNumele activităților pentru /TASKS și /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (numai instalare pentru toți utilizatorii cu drepturi de administrator)%n%nParametrul de dezinstalare VCMI:%n  /DELETEUSERDATA=1  Șterge toate directoarele utilizatorului configurate pentru VCMI. Funcționează numai împreună cu /SILENT sau /VERYSILENT. Acțiunea nu poate fi anulată.%n%nParametrii standard sunt descriși mai sus: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Acest program nu poate fi executat pe versiunea dvs. de Windows. Vă rugăm să vă asigurați că utilizați arhitectura Windows corectă (x86 / x64 / ARM64) şi versiunea pentru acest program.
PrivilegesRequiredOverrideTitle=Privilegiu de administrator necesar
PrivilegesRequiredOverrideInstruction=Alege modul de a rula instalatorul
PrivilegesRequiredOverrideText1=Instalarea %1 pentru toți utilizatorii necesită drepturi de administrator. Puteți instala doar pentru contul propriu fără aceste drepturi.
PrivilegesRequiredOverrideText2=%1 poate fi instalat doar pentru contul propriu fără drepturi de administrator sau pentru toți utilizatorii cu drepturi de administrator.
PrivilegesRequiredOverrideAllUsers=Foloseste ca &Administrator (instală pentru toți utilizatorii)
PrivilegesRequiredOverrideAllUsersRecommended=Foloseste ca &Administrator (recomandat)
PrivilegesRequiredOverrideCurrentUser=Executare ca utilizator &standard (doar pentru mine)
PrivilegesRequiredOverrideCurrentUserRecommended=Executare ca utilizator &standard (recomandat)
ConfirmUninstall=Eşti sigur că vrei să conduci %1 Desinstala Wizard-ul?

[CustomMessages]
DesktopShortcuts=Comenzi rapide pe desktop
StartMenuShortcuts=Comenzi rapide în meniul Start
WelcomeDescription=VCMI este un motor cu sursă deschisă pentru Heroes III, cu posibilități noi și extinse. Pentru a folosi VCMI, trebuie să dețineți fișierele de date ale jocului original.%n%nAcest expert va instala VCMI - Open Heroes 3 pe dispozitivul dvs.%n%nSe recomandă să închideți toate celelalte aplicații înainte de a continua.%n%nFaceți clic pe Următorul pentru a continua sau pe Anulare pentru a ieși din instalare.
WelcomeHighlightsTitle=Despre VCMI
WelcomeHighlights=VCMI este o reimplementare dezvoltată de comunitate a motorului Heroes of Might and Magic III. Proiectul păstrează spiritul jocului original, depășește limitele tehnice ale motorului clasic și oferă o bază deschisă pentru moduri și dezvoltare continuă.
RequirementImportSpaceHelp=Reveniți și selectați alt dosar pentru datele utilizatorului sau dezactivați copierea automată a datelor Heroes III.
RequirementDisableImportQuestion=Doriți să continuați fără a copia datele Heroes III?
RequirementFirewall=Firewall
RequirementMultiplayerGames=Jocuri multiplayer
RequirementSelected=Selectat
RequirementNotSelected=Neselectat — jocul pe același calculator va funcționa
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Adăugați reguli de firewall pentru jocurile multiplayer
AssociateH3MFiles=Asociati fişierele .h3m cu VCMI Editorul de hărți
AssociateVCMIMapFiles=Asociati fişierele .vmap şi .vcmp cu VCMI Editorul de hărți
CacheDirectory=Cache
CloudDataNotice=Acest directory de date cu utilizatori pare să fie sincronizat de un furnizor de stocare în cloud.
CloudDataWarning=Directoriul de date aleasă de utilizator pare să fie sincronizat de un furnizor de stocare în cloud. Sincronizarea poate bloca temporar fișierele și poate provoca instalarea modului, pornirea jocului sau eșecuri de salvare.%n%nOricum vrei să foloseşti acest directoar?
CloudInstallNotice=Acest directory de instalare pare să fie sincronizat de un furnizor de stocare în cloud.
CloudInstallWarning=Directoriul de instalații selectat pare să fie sincronizat de un furnizor de stocare în cloud.O instalație portabilă sau sincronizată poate eşua atunci când furnizorul blochează temporar fișierele de aplicații.%n%nOricum vrei să foloseşti acest directoar?
CloudTargetSilentError=Instalarea silențioasă nu poate folosi un director sincronizat cu cloudul fără /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Nu s-au putut copia fișierele Heroes III (%s). Unele fișiere pot fi deja copiate; puteți repeta importul în siguranță.
CopyingHeroes3Data=Se copiază datele Heroes III...
ConfigDirectory=Configurare
CopyH3Files=Copiere automată necesară Heroes III fişiere pentru VCMI
CreateDesktopShortcuts=Creează scurtături desktop
CreateStartMenuShortcuts=Creează scurtături pentru meniul de pornire
DataFolderDescription=Depozitează o copie a datelor furnizate Heroes III date, modificări, hărți, jocuri salvate și alte fișiere de utilizator.
DataFolderTitle=Dosarul de date cu utilizator
DeleteUserData=Ștergeți datele utilizatorului
DeleteUserDataDescription=Selectaţi dosarele pentru a fi șterse permanent. Dosarele necontrolate vor fi păstrate. Acest lucru nu poate fi desființat.
DeletingUserData=Se șterg datele utilizatorului...
DirectoryConfigWriteError=Nu s-a putut salva configurația directoarelor utilizatorului în %s. Instalarea nu poate continua în siguranță.
DirectoryNotWritable=Nu se poate scrie în directorul selectat (%s). Alegeți alt director sau rulați instalarea cu drepturile necesare.%n%n%s
DirectoryRootNotAllowed=Directorul selectat (%s) nu poate fi rădăcina unei unități sau a unei resurse partajate în rețea. Alegeți un director dedicat.%n%n%s
DirectoryOverlapError=Directoarele de instalare și de date nu pot fi identice și nu se pot suprapune nesigur. Numai o instalare portabilă poate păstra datele în directorul de instalare.
ReadyUserDataLocation=Locația datelor utilizatorului:
RequirementPassed=ÎNDEPLINIT
RequirementFailed=EROARE
RequirementWarning=AVERTISMENT
RequirementInfo=INFORMAȚII
RequirementOperatingSystem=Sistem de operare
RequirementOperatingSystemValue=Windows 7 SP1 sau mai recent; mediul de compatibilitate este inclus când este necesar
RequirementArchitecture=Arhitectură
RequirementInstallWritable=Directorul de instalare permite scrierea
RequirementDataWritable=Directorul datelor permite scrierea
RequirementDirectoryLayout=Layoutul directoriului
RequirementDirectoryLayoutValue=Căile de instalare și de date sunt separate în siguranță
RequirementApplicationSpace=Spațiu pe discul aplicației
RequirementFreeSpaceValue=%s MB liberi; instalatorul verifică și dimensiunea finală a pachetului
RequirementHeroesDataSpace=Import Heroes III
RequirementInsufficientSpace=Spațiu liber insuficient pentru importul datelor Heroes III selectate
RequirementRequiredSpaceValue=Aproximativ %s MB necesari pentru importul selectat
RequirementNotRequested=Importul datelor Heroes III nu este selectat
RequirementCloudStorage=Sincronizare de stocare
RequirementCloudStorageValue=Un traseu selectat pare să folosească sincronizarea cloud
RequirementLocalStorageValue=Căile selectate par să folosească stocare locală
RequirementInstallationMode=Modul de instalare
RequirementModePortable=Portable; nu există dezinstallare, registru sau integrare a sistemului
RequirementModeAllUsers=Toți utilizatorii
RequirementModeCurrentUser=Utilizatorul actual
RequirementUpgrade=instalarea existentă va fi actualizată
RequirementsCheckTitle=Verificarea cerințelor sistemului
RequirementsCheckDescription=Setup a verificat configurația selectată înainte de instalare.
H3MDescription=Fişier de hartă Heroes 3
InstallFolderTitle=Ordinea de instalare
InstallForAllUsers=Instalarea pentru toți utilizatorii
InstallForAllUsers1=Este necesară o autorizație administrativă.
InstallForMeOnly=Instala doar pentru mine.
InstallForMeOnly1=Un prompt firewall va apărea la lansarea jocului pentru prima dată
InstallForMeOnly2=Jocurile în rețeaua locală nu vor funcționa dacă paravanul nu permite accesul
InstallPortable=Instalație portabilă
InstallPortable1=Păstrează aplicația și datele utilizatorului împreună într-un singur dosar
InstallPortable2=Nu creează un uninstaller sau nu modifică integrarea registrului și a sistemului
LogsDirectory=Înregistrări
ResetFoldersToDefault=Resetarea la default
RunVCMILauncherAfterInstall=Lansaţi VCMI Lanţatorul
SavesDirectory=Jocuri salvate
ScanningFiles=Se caută fișiere...
SelectSetupInstallModeDesc=VCMI poate fi instalat pentru toți utilizatorii, doar pentru dumneavoastră sau în mod portabil.
SelectSetupInstallModeSubTitle=Selectați modul de instalare preferat:
SelectSetupInstallModeTitle=Alege modul de instalare
SharedUserDataNotice=Datele utilizatorului nu pot fi șterse deoarece un alt VCMI instalația folosește același directory.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Vizitaţi oficialul . VCMI Disconciliaţie
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Lansaţi VCMI Lanţatorul
ShortcutMapEditor=VCMI Editorul de hărți
ShortcutMapEditorComment=Deschideţi VCMI Editorul de hărți
ShortcutWebPage=VCMI Site-ul web
ShortcutWebPageComment=Vizitaţi oficialul . VCMI site-ul web
SystemIntegration=Integrarea sistemului
FileAssociations=Asocieri de fișiere
AssociateH3CFiles=Deschide campaniile Heroes III (.h3c) în Editorul de hărți VCMI
H3CDescription=Campanie Heroes III
Uninstall=Desinstalarea
UserDataDirectory=Datele utilizatorului (Heroes III date, modificări, hărți și alte fișiere)
VCMISettings=Configurare sistem
VCMPDescription=VCMI Fișierul de campanie
VMAPDescription=VCMI Fișier de hartă
Warning=Avertisment
X86On64BitWarning=Instalaţi sistemul 32-bit (x86) versiunea VCMI Acest lucru este susținut, dar versiunea nativă de 64 de biți este recomandată atunci când este disponibilă.
Heroes3ImportReparsePoint=Datele Heroes III nu pot fi importate în siguranță deoarece un director destinație existent conține o joncțiune sau o legătură simbolică. Eliminați legătura sau alegeți alt director.
OpenSetupLog=Deschide log de setare
OpenSetupLogError=Logul de setare nu a putut fi deschis.
LegacyUninstallStartFailed=Nu s-a putut porni vechiul dezinstalator VCMI:%n%s
LegacyUninstallExitFailed=Vechiul dezinstalator VCMI a eșuat cu codul %s.
LegacyUninstallFailureChoice=Abandonare oprește instalarea. Reîncercare rulează din nou vechiul dezinstalator. Ignorare continuă pe propria răspundere.
LegacyUninstallRequired=Instalarea VCMI anterioară nu a putut fi eliminată. Nu s-au copiat fișiere noi de instalare.
InstallDirectoryUsedByOtherInstallation=Directoriul de instalații se suprapune cu un alt registru VCMI instalare:%n%s%n%nAlege un alt directory.
X86OnARM64Warning=Instalaţi sistemul 32-bit (x86) versiunea VCMI în ARM64 Windows. Acest lucru este suportat, dar nativul ARM64 se recomandă versiunea, atunci când este disponibilă.
RequirementsColumnComponent=Componente
RequirementsColumnDetails=Required
RequirementsColumnStatus=Statut
RequirementsColumnDetected=Sistemul dumneavoastră
RequirementDetectedWindows=Instalare compatibilă Windows
RequirementWritableValue=Director cu acces la scriere
RequirementEnoughSpace=Spațiu liber suficient
RequirementProcessor=Procesor
RequirementProcessorValue=1 GHz sau mai rapid
RequirementMemory=Memorie RAM
RequirementMemoryValue=1 GB de RAM
RequirementMemoryDetected=%s RAM MB
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Mediul de execuție DirectX 11 este disponibil
RequirementDirectXMissing=Mediul de execuție DirectX 11 nu a fost găsit
RequirementDetectionUnavailable=Nu s-a putut detecta
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Directorul de instalare
RequirementUserDataFolder=Directorul datelor utilizatorului
RequirementDiskSpace=Spațiu liber pe disc
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Recomandate
RequirementInternetAvailable=Disponibil
RequirementInternetUnavailable=Nu este detectat
RequirementHeroesData=Date Heroes III
RequirementRequiredToPlay=Necesar pentru joc
RequirementHeroesDataAvailable=Disponibile în datele utilizatorului
RequirementHeroesDataMissing=Nu s-a găsit; poate fi importat mai târziu
RequirementWritableAndSynced=Scris și sincronizat
RequirementNotWritable=Nu se poate scrie
TasksCheckboxesTooltip=Selectați integrările și acțiunile opționale. Scurtăturile oferă acces rapid, asocierile deschid hărțile acceptate în editor, regulile paravanului permit jocul în rețea, iar importul copiază datele Heroes III detectate.
UninstallCheckboxesTooltip=Selectați numai directoarele de date pe care doriți să le ștergeți definitiv. Intrările partajate dezactivate sunt folosite de altă instalare VCMI.
InstallModeTooltip=Toți utilizatorii: instalează VCMI pentru toate conturile Windows, de obicei în Program Files. Necesită aprobarea administratorului. Creează informații de dezinstalare, intrări în registru, scurtături, asocieri de fișiere și o regulă opțională de paravan pentru întregul sistem. Datele rămân în directorul selectat.%n%nUtilizatorul curent: instalează VCMI numai pentru contul Windows conectat, de obicei în Local AppData, fără aprobarea administratorului. Creează un dezinstalator și integrări pentru acel utilizator. Alte conturi nu vor vedea această instalare. Paravanul Windows poate cere permisiunea la prima utilizare a jocului în rețea.%n%nPortabilă: păstrează aplicația și datele împreună în directorul selectat. Nu creează dezinstalator, intrări în registru, scurtături, asocieri sau reguli de paravan. Directorul trebuie să rămână accesibil la scriere. Mutați-l sau copiați-l pentru a transfera instalarea; ștergeți-l pentru a dezinstala.
CopyH3FilesTooltip=Copiază directoarele Data, Maps și Mp3 detectate din Heroes III în directorul datelor utilizatorului VCMI selectat. Fișierele originale rămân neschimbate.
ReadyHeroes3Import=Importul datelor Heroes III:
