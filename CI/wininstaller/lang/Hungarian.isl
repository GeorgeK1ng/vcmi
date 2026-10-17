;
; Hungarian.isl, part of VCMI engine
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
HelpTextNote=A VCMI telepítési paraméterei:%n  /USERDATADIR=<path>  Beállítja a VCMI felhasználói adatmappáját. Az expand: előtag feloldja az Inno Setup állandóit.%n  /ALLOWCLOUDTARGET=1  Csendes telepítéskor engedélyezi a felhővel szinkronizált telepítési vagy felhasználói adatmappa használatát.%n  /PORTABLE=1  Együtt telepíti az alkalmazást és az adatokat eltávolító, beállításjegyzék-módosítások, parancsikonok, fájltársítások és tűzfalszabályok nélkül.%n  /LAUNCH  A telepítés után elindítja a VCMI-t, csendes telepítéskor is.%n  /COPYH3DATA=0|1  Engedélyezi vagy letiltja az észlelt Heroes III-adatok automatikus másolását.%n%nFeladatnevek a /TASKS és /MERGETASKS paraméterekhez:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (csak minden felhasználónak történő telepítéskor, rendszergazdai jogosultsággal)%n%nA VCMI eltávolítási paramétere:%n  /DELETEUSERDATA=1  Törli az összes beállított VCMI felhasználói mappát. Csak a /SILENT vagy /VERYSILENT paraméterrel együtt érvényes. A művelet nem vonható vissza.%n%nA szokásos paraméterek leírása fent található: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Ez a program nem futtatható az Ön Windows-verzióján. Kérjük, győződjön meg arról, hogy a megfelelő Windows-architektúrát (x86 / x64 / ARM64) és a program helyes verzióját használja.
PrivilegesRequiredOverrideTitle=Telepítési mód – Jogosultságok
PrivilegesRequiredOverrideInstruction=Válassza ki, hogyan fusson a telepítő
PrivilegesRequiredOverrideText1=%1 rendszergazdai jogosultságot igényel, ha az összes felhasználó számára telepíti. Telepítheti csak a saját fiókjára is rendszergazdai jogosultság nélkül.
PrivilegesRequiredOverrideText2=%1 telepíthető csak a saját fiókjára (rendszergazdai jogosultság nélkül), vagy az összes felhasználó számára (rendszergazdai jogosultság szükséges).
PrivilegesRequiredOverrideAllUsers=Futtatás &rendszergazdaként (telepítés mindenkinek)
PrivilegesRequiredOverrideAllUsersRecommended=Futtatás &rendszergazdaként (ajánlott)
PrivilegesRequiredOverrideCurrentUser=Futtatás &normál felhasználóként (telepítés csak nekem)
PrivilegesRequiredOverrideCurrentUserRecommended=Futtatás &normál felhasználóként (ajánlott)
ConfirmUninstall=Biztosan futtatni szeretné a %1 eltávolítási varázslót?

[CustomMessages]
DesktopShortcuts=Asztali parancsikonok
StartMenuShortcuts=Start menü parancsikonjai
WelcomeDescription=A VCMI a Heroes III nyílt forráskódú játékmotorja, amely új és kibővített lehetőségeket kínál. A VCMI használatához rendelkeznie kell az eredeti játék adatfájljaival.%n%nA varázsló telepíti a VCMI - Open Heroes 3 programot az eszközére.%n%nA folytatás előtt ajánlott bezárni minden más alkalmazást.%n%nA folytatáshoz kattintson a Tovább, a kilépéshez pedig a Mégse gombra.
WelcomeHighlightsTitle=A VCMI-ről
WelcomeHighlights=A VCMI a Heroes of Might and Magic III motorjának közösség által fejlesztett újraimplementálása. Megőrzi az eredeti játék szellemiségét, feloldja a klasszikus motor technikai korlátait, és nyílt alapot biztosít a modokhoz és a további fejlesztéshez.
RequirementImportSpaceHelp=Lépjen vissza, és válasszon másik felhasználói adatmappát, vagy kapcsolja ki a Heroes III adatainak automatikus másolását.
RequirementDisableImportQuestion=Folytatja a Heroes III adatainak másolása nélkül?
RequirementFirewall=Tűzfal
RequirementMultiplayerGames=Többjátékos játékok
RequirementSelected=Kiválasztva
RequirementNotSelected=Nincs kiválasztva — az egy gépen játszható többjátékos mód működni fog
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Tűzfalszabályok hozzáadása többjátékos játékokhoz
AssociateH3MFiles=.h3m-Dateien mit dem VCMI-Karteneditor verknüpfen
AssociateVCMIMapFiles=.vmap- und .vcmp-Dateien mit dem VCMI-Karteneditor verknüpfen
CacheDirectory=Gyorsítótár
CloudDataNotice=Ezt a felhasználói adatkönyvtárat valószínűleg felhőalapú tárhelyszolgáltató szinkronizálja.
CloudDataWarning=A kiválasztott felhasználói adatkönyvtárat valószínűleg felhőalapú tárhelyszolgáltató szinkronizálja. A szinkronizálás ideiglenesen zárolhat fájlokat, és hibát okozhat a modok telepítésekor, a játék indításakor vagy mentéskor.%n%nEnnek ellenére használja ezt a könyvtárat?
CloudInstallNotice=Ezt a telepítési könyvtárat valószínűleg felhőalapú tárhelyszolgáltató szinkronizálja.
CloudInstallWarning=A kiválasztott telepítési könyvtárat valószínűleg felhőalapú tárhelyszolgáltató szinkronizálja. A hordozható vagy szinkronizált telepítés meghiúsulhat, ha a szolgáltató ideiglenesen zárolja az alkalmazás fájljait.%n%nEnnek ellenére használja ezt a könyvtárat?
CloudTargetSilentError=A csendes telepítés nem használhat felhővel szinkronizált célmappát az /ALLOWCLOUDTARGET=1 paraméter nélkül.
CopyH3FilesError=Nem sikerült másolni a Heroes III fájljait (%s). Néhány fájl másolása már megtörténhetett; az importálás biztonságosan megismételhető.
CopyingHeroes3Data=Heroes III-adatok másolása...
ConfigDirectory=Beállítások
CopyH3Files=Erforderliche Heroes-III-Dateien automatisch in VCMI kopieren
CreateDesktopShortcuts=Desktop-Verknüpfungen erstellen
CreateStartMenuShortcuts=Verknüpfungen im Startmenü erstellen
DataFolderDescription=A megadott Heroes III-adatok másolatát, módosításokat, pályákat, mentéseket és egyéb felhasználói fájlokat tárolja.
DataFolderTitle=Felhasználói adatok mappája
DeleteUserData=Felhasználói adatok törlése
DeleteUserDataDescription=Válassza ki a véglegesen törlendő mappákat. A kijelöletlen mappák megmaradnak. A művelet nem vonható vissza.
DeletingUserData=Felhasználói adatok törlése...
DirectoryConfigWriteError=Nem sikerült menteni a felhasználói mappák beállításait ide: %s. A telepítés nem folytatható biztonságosan.
DirectoryNotWritable=A kiválasztott mappa (%s) nem írható. Válasszon másik mappát, vagy futtassa a telepítőt a szükséges jogosultságokkal.%n%n%s
DirectoryRootNotAllowed=A kiválasztott mappa (%s) nem lehet meghajtó vagy hálózati megosztás gyökere. Válasszon külön mappát.%n%n%s
DirectoryOverlapError=A telepítési és a felhasználói adatmappa nem egyezhet meg, és nem fedheti át egymást veszélyesen. Csak hordozható telepítés tárolhat felhasználói adatokat a telepítési mappában.
ReadyUserDataLocation=Felhasználói adatok helye:
RequirementPassed=TELJESÜLT
RequirementFailed=HIBA
RequirementWarning=FIGYELMEZTETÉS
RequirementInfo=TÁJÉKOZTATÁS
RequirementOperatingSystem=Gyakorlati rendszer
RequirementOperatingSystemValue=Windows 7 SP1 vagy újabb; kompatibilitás futási ideje, ha szükséges
RequirementArchitecture=Architektúra
RequirementInstallWritable=A telepítési mappa írható
RequirementDataWritable=A felhasználói adatmappa írható
RequirementDirectoryLayout=Könyvtár elrendezése
RequirementDirectoryLayoutValue=A telepítési és felhasználói adatútvonalak biztonságosan elkülönülnek
RequirementApplicationSpace=Alkalmazási lemezterület
RequirementFreeSpaceValue=%s MB szabad; a telepítő a csomag végleges méretét is ellenőrzi
RequirementHeroesDataSpace=Heroes III-adatok importálása
RequirementInsufficientSpace=Nincs elég szabad hely a kiválasztott Heroes III-adatok importálásához
RequirementRequiredSpaceValue=A kiválasztott importáláshoz körülbelül %s MB szükséges
RequirementNotRequested=Heroes III-adatok importálása nincs kiválasztva
RequirementCloudStorage=A tárolás szinkronizációja
RequirementCloudStorageValue=A kiválasztott út úgy tűnik, felhő szinkronizációját használja
RequirementLocalStorageValue=A kiválasztott útvonalak úgy tűnik, hogy helyi tárolást használnak.
RequirementInstallationMode=Beépítési mód
RequirementModePortable=hordozható; nincs felszerelés, regisztráció vagy rendszerintegráció
RequirementModeAllUsers=Minden felhasználó
RequirementModeCurrentUser=Jelenleges felhasználó
RequirementUpgrade=a meglévő telepítés frissül
RequirementsCheckTitle=A rendszerkövetelmények ellenőrzése
RequirementsCheckDescription=A telepítés a telepítés előtt ellenőrizte a kiválasztott konfigurációt.
H3MDescription=Heroes-3-Kartendatei
InstallFolderTitle=Telepítési mappa
InstallForAllUsers=Für alle Benutzer installieren
InstallForAllUsers1=Erfordert Administratorrechte
InstallForMeOnly=Nur für mich installieren
InstallForMeOnly1=Beim ersten Start des Spiels erscheint eine Firewall-Benachrichtigung
InstallForMeOnly2=LAN-Spiele funktionieren nicht, wenn die Firewall-Regel nicht zugelassen werden kann
InstallPortable=Hordozható telepítés
InstallPortable1=Az alkalmazást és a felhasználói adatokat egy mappában tartja
InstallPortable2=Nem hoz létre eltávolítót, és nem módosítja a rendszerleíró adatbázist vagy a rendszerintegrációt
LogsDirectory=Naplók
ResetFoldersToDefault=Alapértékek visszaállítása
RunVCMILauncherAfterInstall=VCMI Launcher starten
SavesDirectory=Mentett játékok
ScanningFiles=Fájlok keresése...
SelectSetupInstallModeDesc=A VCMI minden felhasználónak, csak Önnek vagy hordozható módban is telepíthető.
SelectSetupInstallModeSubTitle=Wählen Sie den bevorzugten Installationsmodus:
SelectSetupInstallModeTitle=Wählen Sie den Installationsmodus
SharedUserDataNotice=A felhasználói adatok nem törölhetők, mert egy másik VCMI-telepítés ugyanazt a könyvtárat használja.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Offiziellen VCMI Discord besuchen
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=VCMI Launcher starten
ShortcutMapEditor=VCMI Karteneditor
ShortcutMapEditorComment=VCMI Karteneditor öffnen
ShortcutWebPage=VCMI Webseite
ShortcutWebPageComment=Offizielle VCMI-Webseite besuchen
SystemIntegration=Systemintegration
FileAssociations=Fájltársítások
AssociateH3CFiles=Heroes III kampányok (.h3c) megnyitása a VCMI térképszerkesztőben
H3CDescription=Heroes III kampány
Uninstall=Deinstallieren
UserDataDirectory=Felhasználói adatok (Heroes III-adatok, módosítások, pályák és egyéb fájlok)
VCMISettings=Rendszerbeállítások
VCMPDescription=VCMI-Kampagnendatei
VMAPDescription=VCMI-Kartendatei
Warning=Warnung
X86On64BitWarning=A VCMI 32 bites (x86) verzióját telepíti 64 bites Windows rendszerre. Ez támogatott, de ha elérhető, a natív 64 bites verzió használata ajánlott.
Heroes3ImportReparsePoint=A Heroes III-adatok nem importálhatók biztonságosan, mert egy meglévő célmappa csatlakozási pontot vagy szimbolikus hivatkozást tartalmaz. Távolítsa el a hivatkozást, vagy válasszon másik mappát.
OpenSetupLog=Nyissa ki a beállítási naplót
OpenSetupLogError=A beállítási naplót nem lehetett kinyitni.
LegacyUninstallStartFailed=Nem sikerült elindítani a VCMI korábbi eltávolítóját:%n%s
LegacyUninstallExitFailed=A VCMI korábbi eltávolítója %s hibakóddal állt le.
LegacyUninstallFailureChoice=A Megszakítás leállítja a telepítést. Az Újra újraindítja a régi eltávolítót. A Kihagyás saját felelősségre folytatja a telepítést.
LegacyUninstallRequired=Nem sikerült eltávolítani a VCMI korábbi telepítését. Új telepítési fájlok másolása nem történt meg.
InstallDirectoryUsedByOtherInstallation=A telepítési könyvtár egy másik bejegyzett könyveléssel összekapcsolódik. VCMI telepítés:%n%s%n%nVálassza ki egy másik címlapot.
X86OnARM64Warning=Beállítja a 32-bit (x86) változata VCMI az ARM64 Windows. Ez támogatott, de az eredeti ARM64 a rendelkezésre álló változat ajánlott.
RequirementsColumnComponent=Részete
RequirementsColumnDetails=Szükséges
RequirementsColumnStatus=Általános állapot
RequirementsColumnDetected=Az Ön rendszere
RequirementDetectedWindows=Kompatibilis Windows telepítés
RequirementWritableValue=Írható mappa
RequirementEnoughSpace=Elegendő szabad hely
RequirementProcessor=A feldolgozó
RequirementProcessorValue=1 GHz vagy annál gyorsabb
RequirementMemory=Memória
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11 futtatókörnyezet elérhető
RequirementDirectXMissing=DirectX 11 futtatókörnyezet nem található
RequirementDetectionUnavailable=Nem sikerült észlelni
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Telepítési mappa
RequirementUserDataFolder=Felhasználói adatmappa
RequirementDiskSpace=Szabad lemezterület
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=A javasolt
RequirementInternetAvailable=Szükséges
RequirementInternetUnavailable=Nem észlelt
RequirementHeroesData=Heroes III-adatok
RequirementRequiredToPlay=A játékhoz szükséges
RequirementHeroesDataAvailable=Elérhető a felhasználói adatok között
RequirementHeroesDataMissing=Nem talált, később behozható
RequirementWritableAndSynced=Írható és szinkronizált
RequirementNotWritable=Nem írható
TasksCheckboxesTooltip=Válassza ki az opcionális integrációkat és műveleteket. A parancsikonok gyors hozzáférést biztosítanak, a fájltársítások a szerkesztőben nyitják meg a támogatott pályákat, a tűzfalszabályok engedélyezik a hálózati játékot, az importálás pedig másolja az észlelt Heroes III-adatokat.
UninstallCheckboxesTooltip=Csak a véglegesen törlendő felhasználói adatmappákat jelölje be. A letiltott, megosztott elemeket másik VCMI-telepítés használja.
InstallModeTooltip=Minden felhasználó: minden Windows-fióknak telepíti a VCMI-t, általában a Program Files mappába. Rendszergazdai jóváhagyást igényel. Rendszerszintű eltávolítási adatokat, beállításjegyzék-bejegyzéseket, parancsikonokat, fájltársításokat és opcionális tűzfalszabályt hoz létre. A felhasználói adatok a kiválasztott mappában maradnak.%n%nJelenlegi felhasználó: csak a bejelentkezett Windows-fióknak telepíti a VCMI-t, általában a Local AppData mappába, rendszergazdai jóváhagyás nélkül. Felhasználói eltávolítót és integrációkat hoz létre. Más fiókok nem látják ezt a telepítést. A Windows tűzfal a hálózati játék első használatakor engedélyt kérhet.%n%nHordozható: az alkalmazást és az adatokat együtt tárolja a kiválasztott mappában. Nem hoz létre eltávolítót, beállításjegyzék-bejegyzéseket, parancsikonokat, fájltársításokat vagy tűzfalszabályokat. A mappának írhatónak kell maradnia. Áthelyezéssel vagy másolással vihető át, törléssel távolítható el a telepítés.
CopyH3FilesTooltip=Az észlelt Heroes III Data, Maps és Mp3 mappákat a kiválasztott VCMI felhasználói adatmappába másolja. Az eredeti fájlok változatlanok maradnak.
ReadyHeroes3Import=Heroes III-adatok importálása:
