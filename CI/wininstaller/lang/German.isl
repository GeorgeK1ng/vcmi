; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=VCMI-spezifische Setup-Parameter:%n  /USERDATADIR=<Pfad>  Legt den VCMI-Benutzerdatenordner fest. Das Präfix expand: erweitert Inno-Setup-Konstanten.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Installiert Anwendung und Daten zusammen ohne Deinstallationsprogramm, Registrierungsänderungen, Verknüpfungen, Zuordnungen oder Firewallregeln.%n  /LAUNCH  Startet VCMI nach dem Setup, auch bei stiller Installation.%n%nVCMI-Deinstallationsparameter:%n  /DELETEUSERDATA=1  Löscht alle konfigurierten VCMI-Benutzerordner. Wird nur zusammen mit /SILENT oder /VERYSILENT ausgeführt. Dies kann nicht rückgängig gemacht werden.%n%nStandardparameter wie /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART und /LOG sind oben beschrieben.
WindowsVersionNotSupported=Dieses Programm kann auf Ihrer Windows-Version nicht ausgeführt werden. Stellen Sie sicher, dass Sie die richtige Windows-Architektur (32-Bit oder 64-Bit) und die entsprechende Version dieses Programms verwenden.
PrivilegesRequiredOverrideTitle=Installationsmodus – Berechtigungen
PrivilegesRequiredOverrideInstruction=Wählen Sie, wie das Installationsprogramm ausgeführt werden soll
PrivilegesRequiredOverrideText1=%1 erfordert Administratorrechte, um für alle Benutzer installiert zu werden.%nSie können es auch nur für Ihr Benutzerkonto ohne Administratorrechte installieren.
PrivilegesRequiredOverrideText2=%1 kann nur für Ihr Benutzerkonto (ohne Administratorrechte) oder für alle Benutzer (erfordert Administratorrechte) installiert werden.
PrivilegesRequiredOverrideAllUsers=Als &Administrator ausführen (Installation für alle Benutzer)
PrivilegesRequiredOverrideAllUsersRecommended=Als &Administrator ausführen (empfohlen)
PrivilegesRequiredOverrideCurrentUser=Als &Standardbenutzer ausführen (Installation nur für mich)
PrivilegesRequiredOverrideCurrentUserRecommended=Als &Standardbenutzer ausführen (empfohlen)
ConfirmUninstall=Möchten Sie den %1 Deinstallationsassistenten wirklich ausführen?

[CustomMessages]
AddFirewallRules=Firewall-Regeln für VCMI hinzufügen
AssociateH3MFiles=.h3m-Dateien mit dem VCMI-Karteneditor verknüpfen
AssociateVCMIMapFiles=.vmap- und .vcmp-Dateien mit dem VCMI-Karteneditor verknüpfen
CacheDirectory=Cache
CloudDataNotice=Dieses Benutzerdatenverzeichnis wird wahrscheinlich von einem Cloudspeicheranbieter synchronisiert.
CloudDataWarning=Das ausgewählte Benutzerdatenverzeichnis wird wahrscheinlich von einem Cloudspeicheranbieter synchronisiert. Die Synchronisierung kann Dateien vorübergehend sperren und Fehler bei der Mod-Installation, beim Spielstart oder beim Speichern verursachen.%n%nMöchten Sie dieses Verzeichnis trotzdem verwenden?
CloudInstallNotice=Dieses Installationsverzeichnis wird wahrscheinlich von einem Cloudspeicheranbieter synchronisiert.
CloudInstallWarning=Das ausgewählte Installationsverzeichnis wird wahrscheinlich von einem Cloudspeicheranbieter synchronisiert. Eine portable oder synchronisierte Installation kann fehlschlagen, wenn Anwendungsdateien vorübergehend gesperrt werden.%n%nMöchten Sie dieses Verzeichnis trotzdem verwenden?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Konfiguration
CopyH3Files=Erforderliche Heroes-III-Dateien automatisch in VCMI kopieren
CreateDesktopShortcuts=Desktop-Verknüpfungen erstellen
CreateStartMenuShortcuts=Verknüpfungen im Startmenü erstellen
DataFolderDescription=Enthält eine Kopie der bereitgestellten Heroes-III-Daten, Modifikationen, Karten, Spielstände und weitere Benutzerdateien.
DataFolderTitle=Ordner für Benutzerdaten
DeleteUserData=Benutzerdaten löschen
DeleteUserDataDescription=Wählen Sie Ordner aus, die dauerhaft gelöscht werden sollen. Nicht ausgewählte Ordner bleiben erhalten. Dies kann nicht rückgängig gemacht werden.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Heroes-3-Kartendatei
InstallFolderTitle=Installationsordner
InstallForAllUsers=Für alle Benutzer installieren
InstallForAllUsers1=Erfordert Administratorrechte
InstallForMeOnly=Nur für mich installieren
InstallForMeOnly1=Beim ersten Start des Spiels erscheint eine Firewall-Benachrichtigung
InstallForMeOnly2=LAN-Spiele funktionieren nicht, wenn die Firewall-Regel nicht zugelassen werden kann
InstallPortable=Portable Installation
InstallPortable1=Speichert Anwendung und Benutzerdaten gemeinsam in einem Ordner
InstallPortable2=Erstellt kein Deinstallationsprogramm und ändert weder Registrierung noch Systemintegration
LogsDirectory=Protokolle
ResetFoldersToDefault=Standard wiederherstellen
RunVCMILauncherAfterInstall=VCMI Launcher starten
SavesDirectory=Spielstände
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI kann für alle Benutzer oder nur für Sie installiert werden.
SelectSetupInstallModeSubTitle=Wählen Sie den bevorzugten Installationsmodus:
SelectSetupInstallModeTitle=Wählen Sie den Installationsmodus
SharedUserDataNotice=Die Benutzerdaten können nicht gelöscht werden, weil eine andere VCMI-Installation dasselbe Verzeichnis verwendet.
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
UserDataDirectory=Benutzerdaten (Heroes-III-Daten, Modifikationen, Karten und weitere Dateien)
VCMISettings=VCMI-Konfiguration
VCMPDescription=VCMI-Kampagnendatei
VMAPDescription=VCMI-Kartendatei
Warning=Warnung
X86On64BitWarning=Sie installieren die 32-Bit-Version (x86) von VCMI unter 64-Bit-Windows. Dies wird unterstützt, aber die native 64-Bit-Version wird empfohlen, sofern sie verfügbar ist.
