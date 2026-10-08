; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=VCMI-specifikus telepítési paraméterek:%n  /USERDATADIR=<elérési út>  Beállítja a VCMI felhasználói adatmappáját. Az expand: előtag feloldja az Inno Setup állandóit.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Az alkalmazást és az adatokat együtt telepíti eltávolító, rendszerleíróadatbázis-módosítás, parancsikonok, társítások és tűzfalszabályok nélkül.%n  /LAUNCH  A telepítés után elindítja a VCMI-t, csendes telepítés esetén is.%n%nVCMI-eltávolító paramétere:%n  /DELETEUSERDATA=1  Törli az összes beállított VCMI felhasználói mappát. Csak /SILENT vagy /VERYSILENT mellett használható. A művelet nem vonható vissza.%n%nA szabványos paraméterek, például /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART és /LOG fent találhatók.
WindowsVersionNotSupported=Ez a program nem futtatható az Ön Windows-verzióján. Kérjük, győződjön meg arról, hogy a megfelelő Windows-architektúrát (32 bites vagy 64 bites) és a program helyes verzióját használja.
PrivilegesRequiredOverrideTitle=Telepítési mód – Jogosultságok
PrivilegesRequiredOverrideInstruction=Válassza ki, hogyan fusson a telepítő
PrivilegesRequiredOverrideText1=%1 rendszergazdai jogosultságot igényel, ha az összes felhasználó számára telepíti.%nTelepítheti csak a saját fiókjára is rendszergazdai jogosultság nélkül.
PrivilegesRequiredOverrideText2=%1 telepíthető csak a saját fiókjára (rendszergazdai jogosultság nélkül), vagy az összes felhasználó számára (rendszergazdai jogosultság szükséges).
PrivilegesRequiredOverrideAllUsers=Futtatás &rendszergazdaként (telepítés mindenkinek)
PrivilegesRequiredOverrideAllUsersRecommended=Futtatás &rendszergazdaként (ajánlott)
PrivilegesRequiredOverrideCurrentUser=Futtatás &normál felhasználóként (telepítés csak nekem)
PrivilegesRequiredOverrideCurrentUserRecommended=Futtatás &normál felhasználóként (ajánlott)
ConfirmUninstall=Biztosan futtatni szeretné a %1 eltávolítási varázslót?

[CustomMessages]
AddFirewallRules=Firewall-Regeln für VCMI hinzufügen
AssociateH3MFiles=.h3m-Dateien mit dem VCMI-Karteneditor verknüpfen
AssociateVCMIMapFiles=.vmap- und .vcmp-Dateien mit dem VCMI-Karteneditor verknüpfen
CacheDirectory=Gyorsítótár
CloudDataNotice=Ezt a felhasználói adatkönyvtárat valószínűleg felhőalapú tárhelyszolgáltató szinkronizálja.
CloudDataWarning=A kiválasztott felhasználói adatkönyvtárat valószínűleg felhőalapú tárhelyszolgáltató szinkronizálja. A szinkronizálás ideiglenesen zárolhat fájlokat, és hibát okozhat a modok telepítésekor, a játék indításakor vagy mentéskor.%n%nEnnek ellenére használja ezt a könyvtárat?
CloudInstallNotice=Ezt a telepítési könyvtárat valószínűleg felhőalapú tárhelyszolgáltató szinkronizálja.
CloudInstallWarning=A kiválasztott telepítési könyvtárat valószínűleg felhőalapú tárhelyszolgáltató szinkronizálja. A hordozható vagy szinkronizált telepítés meghiúsulhat, ha a szolgáltató ideiglenesen zárolja az alkalmazás fájljait.%n%nEnnek ellenére használja ezt a könyvtárat?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Beállítások
CopyH3Files=Erforderliche Heroes-III-Dateien automatisch in VCMI kopieren
CreateDesktopShortcuts=Desktop-Verknüpfungen erstellen
CreateStartMenuShortcuts=Verknüpfungen im Startmenü erstellen
DataFolderDescription=A megadott Heroes III-adatok másolatát, módosításokat, pályákat, mentéseket és egyéb felhasználói fájlokat tárolja.
DataFolderTitle=Felhasználói adatok mappája
DeleteUserData=Felhasználói adatok törlése
DeleteUserDataDescription=Válassza ki a véglegesen törlendő mappákat. A kijelöletlen mappák megmaradnak. A művelet nem vonható vissza.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
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
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI kann für alle Benutzer oder nur für Sie installiert werden.
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
Uninstall=Deinstallieren
UserDataDirectory=Felhasználói adatok (Heroes III-adatok, módosítások, pályák és egyéb fájlok)
VCMISettings=VCMI-Konfiguration
VCMPDescription=VCMI-Kampagnendatei
VMAPDescription=VCMI-Kartendatei
Warning=Warnung
X86On64BitWarning=A VCMI 32 bites (x86) verzióját telepíti 64 bites Windows rendszerre. Ez támogatott, de ha elérhető, a natív 64 bites verzió használata ajánlott.
