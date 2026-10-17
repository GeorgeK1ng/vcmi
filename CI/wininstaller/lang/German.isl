;
; German.isl, part of VCMI engine
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
HelpTextNote=VCMI-Installationsparameter:%n  /USERDATADIR=<path>  Legt den VCMI-Benutzerdatenordner fest. Das Präfix expand: ersetzt Inno-Setup-Konstanten durch ihre Werte.%n  /ALLOWCLOUDTARGET=1  Erlaubt bei einer unbeaufsichtigten Installation einen mit der Cloud synchronisierten Installations- oder Benutzerdatenordner.%n  /PORTABLE=1  Installiert Anwendung und Daten gemeinsam, ohne Deinstallationsprogramm, Registrierungsänderungen, Verknüpfungen, Dateizuordnungen oder Firewallregeln.%n  /LAUNCH  Startet VCMI nach der Installation, auch im unbeaufsichtigten Modus.%n  /COPYH3DATA=0|1  Aktiviert oder deaktiviert das automatische Kopieren gefundener Heroes-III-Daten.%n%nAufgabennamen für /TASKS und /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (nur Installation für alle Benutzer mit Administratorrechten)%n%nVCMI-Deinstallationsparameter:%n  /DELETEUSERDATA=1  Löscht alle konfigurierten VCMI-Benutzerordner. Wirkt nur zusammen mit /SILENT oder /VERYSILENT. Dies kann nicht rückgängig gemacht werden.%n%nDie Standardparameter sind oben beschrieben: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Dieses Programm kann auf Ihrer Windows-Version nicht ausgeführt werden. Stellen Sie sicher, dass Sie die richtige Windows-Architektur (x86 / x64 / ARM64) und die entsprechende Version dieses Programms verwenden.
PrivilegesRequiredOverrideTitle=Installationsmodus – Berechtigungen
PrivilegesRequiredOverrideInstruction=Wählen Sie, wie das Installationsprogramm ausgeführt werden soll
PrivilegesRequiredOverrideText1=%1 erfordert Administratorrechte, um für alle Benutzer installiert zu werden. Sie können es auch nur für Ihr Benutzerkonto ohne Administratorrechte installieren.
PrivilegesRequiredOverrideText2=%1 kann nur für Ihr Benutzerkonto (ohne Administratorrechte) oder für alle Benutzer (erfordert Administratorrechte) installiert werden.
PrivilegesRequiredOverrideAllUsers=Als &Administrator ausführen (Installation für alle Benutzer)
PrivilegesRequiredOverrideAllUsersRecommended=Als &Administrator ausführen (empfohlen)
PrivilegesRequiredOverrideCurrentUser=Als &Standardbenutzer ausführen (Installation nur für mich)
PrivilegesRequiredOverrideCurrentUserRecommended=Als &Standardbenutzer ausführen (empfohlen)
ConfirmUninstall=Möchten Sie den %1 Deinstallationsassistenten wirklich ausführen?

[CustomMessages]
DesktopShortcuts=Desktopverknüpfungen
StartMenuShortcuts=Startmenü-Verknüpfungen
WelcomeDescription=VCMI ist eine quelloffene Engine für Heroes III mit neuen und erweiterten Möglichkeiten. Zur Nutzung von VCMI müssen Sie die Originaldatendateien des Spiels besitzen.%n%nDieser Assistent installiert VCMI - Open Heroes 3 auf Ihrem Gerät.%n%nEs wird empfohlen, vor dem Fortfahren alle anderen Anwendungen zu schließen.%n%nKlicken Sie auf Weiter, um fortzufahren, oder auf Abbrechen, um Setup zu beenden.
WelcomeHighlightsTitle=Über VCMI
WelcomeHighlights=VCMI ist eine von der Community entwickelte Neuimplementierung der Heroes-of-Might-and-Magic-III-Engine. Das Projekt bewahrt den Geist des Originals, überwindet technische Grenzen der klassischen Engine und schafft eine offene Grundlage für Mods und weitere Entwicklung.
RequirementImportSpaceHelp=Gehen Sie zurück und wählen Sie einen anderen Benutzerdatenordner oder deaktivieren Sie das automatische Kopieren der Heroes-III-Daten.
RequirementDisableImportQuestion=Möchten Sie fortfahren, ohne die Heroes-III-Daten zu kopieren?
RequirementFirewall=Firewall
RequirementMultiplayerGames=Mehrspielerpartien
RequirementSelected=Ausgewählt
RequirementNotSelected=Nicht ausgewählt — Hotseat auf einem Computer funktioniert weiterhin
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Firewallregeln für Mehrspielerpartien hinzufügen
AssociateH3MFiles=.h3m-Dateien mit dem VCMI-Karteneditor verknüpfen
AssociateVCMIMapFiles=.vmap- und .vcmp-Dateien mit dem VCMI-Karteneditor verknüpfen
CacheDirectory=Cache
CloudDataNotice=Dieses Benutzerdatenverzeichnis wird wahrscheinlich von einem Cloudspeicheranbieter synchronisiert.
CloudDataWarning=Das ausgewählte Benutzerdatenverzeichnis wird wahrscheinlich von einem Cloudspeicheranbieter synchronisiert. Die Synchronisierung kann Dateien vorübergehend sperren und Fehler bei der Mod-Installation, beim Spielstart oder beim Speichern verursachen.%n%nMöchten Sie dieses Verzeichnis trotzdem verwenden?
CloudInstallNotice=Dieses Installationsverzeichnis wird wahrscheinlich von einem Cloudspeicheranbieter synchronisiert.
CloudInstallWarning=Das ausgewählte Installationsverzeichnis wird wahrscheinlich von einem Cloudspeicheranbieter synchronisiert. Eine portable oder synchronisierte Installation kann fehlschlagen, wenn Anwendungsdateien vorübergehend gesperrt werden.%n%nMöchten Sie dieses Verzeichnis trotzdem verwenden?
CloudTargetSilentError=Eine unbeaufsichtigte Installation darf ohne /ALLOWCLOUDTARGET=1 kein mit der Cloud synchronisiertes Ziel verwenden.
CopyH3FilesError=Die Heroes-III-Dateien (%s) konnten nicht kopiert werden. Bereits kopierte Dateien bleiben erhalten; Sie können den Import gefahrlos erneut starten.
CopyingHeroes3Data=Heroes-III-Daten werden kopiert...
ConfigDirectory=Konfiguration
CopyH3Files=Erforderliche Heroes-III-Dateien automatisch in VCMI kopieren
CreateDesktopShortcuts=Desktop-Verknüpfungen erstellen
CreateStartMenuShortcuts=Verknüpfungen im Startmenü erstellen
DataFolderDescription=Enthält eine Kopie der bereitgestellten Heroes-III-Daten, Modifikationen, Karten, Spielstände und weitere Benutzerdateien.
DataFolderTitle=Ordner für Benutzerdaten
DeleteUserData=Benutzerdaten löschen
DeleteUserDataDescription=Wählen Sie Ordner aus, die dauerhaft gelöscht werden sollen. Nicht ausgewählte Ordner bleiben erhalten. Dies kann nicht rückgängig gemacht werden.
DeletingUserData=Benutzerdaten werden gelöscht...
DirectoryConfigWriteError=Die Konfiguration der Benutzerverzeichnisse konnte nicht unter %s gespeichert werden. Die Installation kann nicht sicher fortgesetzt werden.
DirectoryNotWritable=In das ausgewählte Verzeichnis (%s) kann nicht geschrieben werden. Wählen Sie einen anderen Ordner oder starten Sie die Installation mit den erforderlichen Rechten.%n%n%s
DirectoryRootNotAllowed=Das ausgewählte Verzeichnis (%s) darf kein Laufwerks- oder Netzwerkfreigabestamm sein. Wählen Sie einen eigenen Ordner.%n%n%s
DirectoryOverlapError=Installations- und Benutzerdatenordner dürfen nicht identisch sein oder sich unzulässig überschneiden. Nur bei einer portablen Installation dürfen die Benutzerdaten im Installationsordner liegen.
ReadyUserDataLocation=Speicherort der Benutzerdaten:
RequirementPassed=ERFÜLLT
RequirementFailed=FEHLER
RequirementWarning=WARNUNG
RequirementInfo=HINWEIS
RequirementOperatingSystem=Betriebssystem
RequirementOperatingSystemValue=Windows 7 SP1 oder neuer; Kompatibilitätslaufzeit inbegriffen, wenn erforderlich
RequirementArchitecture=Architektur
RequirementInstallWritable=Installationsordner beschreibbar
RequirementDataWritable=Benutzerdatenordner beschreibbar
RequirementDirectoryLayout=Layout des Verzeichnisses
RequirementDirectoryLayoutValue=Installations- und Benutzerdatenpfade sind sicher getrennt
RequirementApplicationSpace=Anwendungsspeicherplatz
RequirementFreeSpaceValue=%s MB frei; die Installation prüft auch die endgültige Paketgröße
RequirementHeroesDataSpace=Heroes-III-Import
RequirementInsufficientSpace=Nicht genügend freier Speicherplatz für den ausgewählten Heroes-III-Import
RequirementRequiredSpaceValue=Etwa %s MB für den ausgewählten Import erforderlich
RequirementNotRequested=Heroes-III-Import nicht ausgewählt
RequirementCloudStorage=Speichersynchronisierung
RequirementCloudStorageValue=Ein ausgewählter Pfad scheint Cloud-Synchronisation zu verwenden
RequirementLocalStorageValue=Die ausgewählten Pfade scheinen lokale Speicherung zu verwenden
RequirementInstallationMode=Installationsmodus
RequirementModePortable=Portable; keine Uninstaller, Registry oder Systemintegration
RequirementModeAllUsers=Alle Benutzer
RequirementModeCurrentUser=Aktueller Benutzer
RequirementUpgrade=vorhandene Installation wird aktualisiert
RequirementsCheckTitle=Überprüfung der Systemanforderungen
RequirementsCheckDescription=Setup überprüfte die gewählte Konfiguration vor der Installation.
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
ScanningFiles=Dateien werden durchsucht...
SelectSetupInstallModeDesc=VCMI kann für alle Benutzer, nur für Sie oder als portable Anwendung installiert werden.
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
FileAssociations=Dateizuordnungen
AssociateH3CFiles=Heroes-III-Kampagnen (.h3c) im VCMI-Karteneditor öffnen
H3CDescription=Heroes-III-Kampagne
Uninstall=Deinstallieren
UserDataDirectory=Benutzerdaten (Heroes-III-Daten, Modifikationen, Karten und weitere Dateien)
VCMISettings=Systemkonfiguration
VCMPDescription=VCMI-Kampagnendatei
VMAPDescription=VCMI-Kartendatei
Warning=Warnung
X86On64BitWarning=Sie installieren die 32-Bit-Version (x86) von VCMI unter 64-Bit-Windows. Dies wird unterstützt, aber die native 64-Bit-Version wird empfohlen, sofern sie verfügbar ist.
Heroes3ImportReparsePoint=Heroes-III-Daten können nicht sicher importiert werden, da ein vorhandener Zielordner eine Verzeichnisverbindung oder symbolische Verknüpfung enthält. Entfernen Sie diese oder wählen Sie einen anderen Ordner.
OpenSetupLog=Öffnen Sie das Setup-Log
OpenSetupLogError=Das Setup-Log konnte nicht geöffnet werden.
LegacyUninstallStartFailed=Das vorherige VCMI-Deinstallationsprogramm konnte nicht gestartet werden:%n%s
LegacyUninstallExitFailed=Das vorherige VCMI-Deinstallationsprogramm wurde mit Fehlercode %s beendet.
LegacyUninstallFailureChoice=Abbrechen beendet die Installation. Wiederholen startet das alte Deinstallationsprogramm erneut. Ignorieren setzt die Installation auf eigenes Risiko fort.
LegacyUninstallRequired=Die vorherige VCMI-Installation konnte nicht entfernt werden. Es wurden keine neuen Installationsdateien kopiert.
InstallDirectoryUsedByOtherInstallation=Das Installationsverzeichnis überschneidet sich mit einem anderen registrierten Verzeichnis VCMI Installation:%n%s%n%nWählen Sie ein anderes Verzeichnis aus.
X86OnARM64Warning=Sie installieren das 32-Bit (x86) Version von VCMI auf ARM64 Windows. Dies wird unterstützt, aber die native ARM64 Version wird empfohlen, wenn sie verfügbar ist.
RequirementsColumnComponent=Komponente
RequirementsColumnDetails=Erforderlich
RequirementsColumnStatus=Status
RequirementsColumnDetected=Ihr System
RequirementDetectedWindows=Kompatible Windows-Installation
RequirementWritableValue=Beschreibbarer Ordner
RequirementEnoughSpace=Genügend freier Speicherplatz
RequirementProcessor=Prozessor
RequirementProcessorValue=1 GHz oder höher
RequirementMemory=Arbeitsspeicher
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX-11-Laufzeit verfügbar
RequirementDirectXMissing=DirectX-11-Laufzeit nicht gefunden
RequirementDetectionUnavailable=Nicht ermittelbar
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Installationsordner
RequirementUserDataFolder=Benutzerdatenordner
RequirementDiskSpace=Freier Speicherplatz
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=empfohlen
RequirementInternetAvailable=Erhältlich
RequirementInternetUnavailable=Nicht erkannt
RequirementHeroesData=Heroes-III-Daten
RequirementRequiredToPlay=Zum Spielen erforderlich
RequirementHeroesDataAvailable=In den Benutzerdaten vorhanden
RequirementHeroesDataMissing=Nicht gefunden; kann später importiert werden
RequirementWritableAndSynced=Schreibbar und synchronisiert
RequirementNotWritable=Nicht beschreibbar
TasksCheckboxesTooltip=Wählen Sie optionale Systemintegrationen und Aktionen. Verknüpfungen erleichtern den Zugriff, Dateizuordnungen öffnen unterstützte Karten im Editor, Firewallregeln ermöglichen Mehrspielerpartien und der Import kopiert gefundene Heroes-III-Daten.
UninstallCheckboxesTooltip=Wählen Sie nur Benutzerdatenordner aus, die dauerhaft gelöscht werden sollen. Deaktivierte gemeinsame Einträge werden von einer anderen VCMI-Installation verwendet.
InstallModeTooltip=Alle Benutzer: Installiert VCMI für alle Windows-Konten, normalerweise unter Program Files. Erfordert Administratorrechte. Erstellt systemweite Deinstallationsinformationen, Registrierungseinträge, Verknüpfungen, Dateizuordnungen und optional eine Firewallregel. Benutzerdaten bleiben im ausgewählten Datenordner.%n%nAktueller Benutzer: Installiert VCMI nur für das angemeldete Windows-Konto, normalerweise unter Local AppData, ohne Administratorrechte. Erstellt Deinstallationsprogramm und Systemintegrationen nur für diesen Benutzer. Andere Konten sehen diese Installation nicht. Beim ersten Mehrspielereinsatz kann die Windows-Firewall um Erlaubnis bitten.%n%nPortabel: Speichert Anwendung und Benutzerdaten gemeinsam im ausgewählten Ordner. Erstellt weder Deinstallationsprogramm noch Registrierungseinträge, Verknüpfungen, Dateizuordnungen oder Firewallregeln. Der Ordner muss beschreibbar bleiben. Verschieben oder kopieren Sie ihn zum Übertragen der Installation; löschen Sie ihn zum Deinstallieren.
CopyH3FilesTooltip=Kopiert die gefundenen Heroes-III-Ordner Data, Maps und Mp3 in den ausgewählten VCMI-Benutzerdatenordner. Die Originaldateien bleiben unverändert.
ReadyHeroes3Import=Heroes-III-Datenimport:
