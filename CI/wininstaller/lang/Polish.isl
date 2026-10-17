;
; Polish.isl, part of VCMI engine
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
HelpTextNote=Parametry instalacji VCMI:%n  /USERDATADIR=<path>  Ustawia katalog danych użytkownika VCMI. Prefiks expand: rozwija stałe Inno Setup.%n  /ALLOWCLOUDTARGET=1  Zezwala na katalog instalacji lub danych synchronizowany z chmurą podczas instalacji cichej.%n  /PORTABLE=1  Instaluje aplikację i dane razem bez deinstalatora, zmian rejestru, skrótów, skojarzeń plików i reguł zapory.%n  /LAUNCH  Uruchamia VCMI po instalacji, również w trybie cichym.%n  /COPYH3DATA=0|1  Włącza lub wyłącza automatyczne kopiowanie wykrytych danych Heroes III.%n%nNazwy zadań dla /TASKS i /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (tylko instalacja dla wszystkich użytkowników z uprawnieniami administratora)%n%nParametr deinstalatora VCMI:%n  /DELETEUSERDATA=1  Usuwa wszystkie skonfigurowane katalogi użytkownika VCMI. Działa tylko z /SILENT lub /VERYSILENT. Tej operacji nie można cofnąć.%n%nStandardowe parametry opisano powyżej: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Ten program nie moze zostac uruchomiony na uzywanej wersji systemu Windows. Upewnij sie, ze uzywasz odpowiedniej architektury systemu Windows (x86 / x64 / ARM64) i wlasciwej wersji tego programu.
PrivilegesRequiredOverrideTitle=Tryb instalacji – Uprawnienia
PrivilegesRequiredOverrideInstruction=Wybierz sposób uruchomienia instalatora
PrivilegesRequiredOverrideText1=Do zainstalowania %1 dla wszystkich użytkowników wymagane są uprawnienia administratora. Możesz również zainstalować aplikację tylko dla swojego konta bez uprawnień administratora.
PrivilegesRequiredOverrideText2=%1 może zostać zainstalowana tylko dla twojego konta (bez uprawnień administratora) lub dla wszystkich użytkowników (wymagane są uprawnienia administratora).
PrivilegesRequiredOverrideAllUsers=Uruchom jako &Administrator (instalacja dla wszystkich użytkowników)
PrivilegesRequiredOverrideAllUsersRecommended=Uruchom jako &Administrator (zalecane)
PrivilegesRequiredOverrideCurrentUser=Uruchom jako &Użytkownik standardowy (instalacja tylko dla mnie)
PrivilegesRequiredOverrideCurrentUserRecommended=Uruchom jako &Użytkownik standardowy (zalecane)
ConfirmUninstall=Czy na pewno chcesz uruchomic kreatora deinstalacji %1?

[CustomMessages]
DesktopShortcuts=Skróty na pulpicie
StartMenuShortcuts=Skróty w menu Start
WelcomeDescription=VCMI to otwartoźródłowy silnik Heroes III oferujący nowe i rozszerzone możliwości. Aby używać VCMI, trzeba posiadać oryginalne pliki danych gry.%n%nTen kreator zainstaluje VCMI - Open Heroes 3 na urządzeniu.%n%nPrzed kontynuowaniem zaleca się zamknięcie wszystkich innych aplikacji.%n%nKliknij Dalej, aby kontynuować, lub Anuluj, aby zakończyć instalację.
WelcomeHighlightsTitle=O VCMI
WelcomeHighlights=VCMI to rozwijana przez społeczność reimplementacja silnika Heroes of Might and Magic III. Projekt zachowuje ducha oryginalnej gry, usuwa ograniczenia techniczne klasycznego silnika i zapewnia otwartą podstawę dla modów oraz dalszego rozwoju.
RequirementImportSpaceHelp=Wróć i wybierz inny folder danych użytkownika albo wyłącz automatyczne kopiowanie danych Heroes III.
RequirementDisableImportQuestion=Czy chcesz kontynuować bez kopiowania danych Heroes III?
RequirementFirewall=Zapora
RequirementMultiplayerGames=Gry wieloosobowe
RequirementSelected=Wybrano
RequirementNotSelected=Nie wybrano — gra na jednym komputerze będzie działać
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Dodaj reguły zapory dla gier wieloosobowych
AssociateH3MFiles=Powiaz pliki .h3m z Edytorem Map VCMI
AssociateVCMIMapFiles=Powiaz pliki .vmap i .vcmp z Edytorem Map VCMI
CacheDirectory=Pamięć podręczna
CloudDataNotice=Ten katalog danych użytkownika jest prawdopodobnie synchronizowany przez usługę przechowywania w chmurze.
CloudDataWarning=Wybrany katalog danych użytkownika jest prawdopodobnie synchronizowany przez usługę przechowywania w chmurze. Synchronizacja może tymczasowo blokować pliki i powodować błędy instalacji modów, uruchamiania gry lub zapisywania stanu gry.%n%nCzy mimo to chcesz użyć tego katalogu?
CloudInstallNotice=Ten katalog instalacyjny jest prawdopodobnie synchronizowany przez usługę przechowywania w chmurze.
CloudInstallWarning=Wybrany katalog instalacyjny jest prawdopodobnie synchronizowany przez usługę przechowywania w chmurze. Instalacja przenośna lub synchronizowana może się nie powieść, jeśli usługa tymczasowo zablokuje pliki aplikacji.%n%nCzy mimo to chcesz użyć tego katalogu?
CloudTargetSilentError=Cicha instalacja nie może użyć katalogu synchronizowanego z chmurą bez /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Nie udało się skopiować plików Heroes III (%s). Niektóre pliki mogły już zostać skopiowane; import można bezpiecznie powtórzyć.
CopyingHeroes3Data=Kopiowanie danych Heroes III...
ConfigDirectory=Konfiguracja
CopyH3Files=Automatycznie skopiuj wymagane pliki Heroes III do VCMI
CreateDesktopShortcuts=Utwórz skróty na pulpicie
CreateStartMenuShortcuts=Utwórz skróty w menu Start
DataFolderDescription=Zawiera kopię dostarczonych danych Heroes III, modyfikacje, mapy, zapisane gry i inne pliki użytkownika.
DataFolderTitle=Folder danych użytkownika
DeleteUserData=Usun dane uzytkownika
DeleteUserDataDescription=Wybierz foldery do trwałego usunięcia. Niezaznaczone foldery zostaną zachowane. Tej operacji nie można cofnąć.
DeletingUserData=Usuwanie danych użytkownika...
DirectoryConfigWriteError=Nie udało się zapisać ustawień katalogów użytkownika w %s. Instalacja nie może być bezpiecznie kontynuowana.
DirectoryNotWritable=Nie można zapisywać w wybranym katalogu (%s). Wybierz inny katalog lub uruchom instalator z wymaganymi uprawnieniami.%n%n%s
DirectoryRootNotAllowed=Wybrany katalog (%s) nie może być katalogiem głównym dysku ani udziału sieciowego. Wybierz osobny katalog.%n%n%s
DirectoryOverlapError=Katalogi instalacji i danych użytkownika nie mogą być takie same ani niebezpiecznie się nakładać. Tylko instalacja przenośna może przechowywać dane w katalogu instalacji.
ReadyUserDataLocation=Lokalizacja danych użytkownika:
RequirementPassed=SPEŁNIONO
RequirementFailed=BŁĄD
RequirementWarning=OSTRZEŻENIE
RequirementInfo=INFORMACJA
RequirementOperatingSystem=System operacyjny
RequirementOperatingSystemValue=Windows 7 SP1 lub nowsza; czas uruchomienia zgodności wraz z wymaganiami
RequirementArchitecture=Architektura
RequirementInstallWritable=Katalog instalacji z możliwością zapisu
RequirementDataWritable=Katalog danych użytkownika z możliwością zapisu
RequirementDirectoryLayout=Układ katalogów
RequirementDirectoryLayoutValue=Ścieżki instalacji i danych są bezpiecznie rozdzielone
RequirementApplicationSpace=Przestrzeni dyskowej aplikacji
RequirementFreeSpaceValue=%s MB wolnego miejsca; instalator sprawdza również końcowy rozmiar pakietu
RequirementHeroesDataSpace=Import Heroes III
RequirementInsufficientSpace=Za mało wolnego miejsca na import wybranych danych Heroes III
RequirementRequiredSpaceValue=Wybrany import wymaga około %s MB
RequirementNotRequested=Import danych Heroes III nie został wybrany
RequirementCloudStorage=Synchronizacja przechowywania
RequirementCloudStorageValue=Wybrana ścieżka używa synchronizacji chmury
RequirementLocalStorageValue=Wybrane ścieżki wydają się wykorzystywać lokalne przechowywanie
RequirementInstallationMode=Tryb instalacji
RequirementModePortable=Przenośny; bez odinstalowania, rejestru lub integracji systemu
RequirementModeAllUsers=Wszyscy użytkownicy
RequirementModeCurrentUser=Obecny użytkownik
RequirementUpgrade=istniejąca instalacja zostanie zaktualizowana
RequirementsCheckTitle=Sprawdzenie wymogów systemu
RequirementsCheckDescription=Setup sprawdził wybraną konfigurację przed instalacją.
H3MDescription=Plik mapy Heroes 3
InstallFolderTitle=Folder instalacyjny
InstallForAllUsers=Zainstaluj dla wszystkich uzytkowników
InstallForAllUsers1=Wymagane uprawnienia administratora
InstallForMeOnly=Zainstaluj tylko dla mnie
InstallForMeOnly1=Podczas pierwszego uruchomienia gry pojawi sie komunikat zapory
InstallForMeOnly2=Gry LAN nie beda dzialac, jesli regula zapory nie zostanie zaakceptowana
InstallPortable=Instalacja przenośna
InstallPortable1=Przechowuje aplikację i dane użytkownika razem w jednym folderze
InstallPortable2=Nie tworzy deinstalatora ani nie modyfikuje rejestru i integracji systemowej
LogsDirectory=Dzienniki
ResetFoldersToDefault=Przywróć domyślne
RunVCMILauncherAfterInstall=Uruchom Launcher VCMI
SavesDirectory=Zapisane gry
ScanningFiles=Wyszukiwanie plików...
SelectSetupInstallModeDesc=VCMI można zainstalować dla wszystkich użytkowników, tylko dla Ciebie lub w trybie przenośnym.
SelectSetupInstallModeSubTitle=Wybierz preferowany tryb instalacji:
SelectSetupInstallModeTitle=Wybierz tryb instalacji
SharedUserDataNotice=Nie można usunąć danych użytkownika, ponieważ inna instalacja VCMI używa tego samego katalogu.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Odwiedz oficjalny Discord VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Uruchom Launcher VCMI
ShortcutMapEditor=Edytor Map VCMI
ShortcutMapEditorComment=Otwórz Edytor Map VCMI
ShortcutWebPage=Strona internetowa VCMI
ShortcutWebPageComment=Odwiedz oficjalna strone VCMI
SystemIntegration=Integracja z systemem
FileAssociations=Skojarzenia plików
AssociateH3CFiles=Otwieraj kampanie Heroes III (.h3c) w Edytorze Map VCMI
H3CDescription=Kampania Heroes III
Uninstall=Odinstaluj
UserDataDirectory=Dane użytkownika (dane Heroes III, modyfikacje, mapy i inne pliki)
VCMISettings=Konfiguracja systemu
VCMPDescription=Plik kampanii VCMI
VMAPDescription=Plik mapy VCMI
Warning=Ostrzezenie
X86On64BitWarning=Instalujesz 32-bitową wersję (x86) VCMI w 64-bitowym systemie Windows. Jest to obsługiwane, ale zalecana jest natywna wersja 64-bitowa, jeśli jest dostępna.
Heroes3ImportReparsePoint=Nie można bezpiecznie zaimportować danych Heroes III, ponieważ istniejący katalog docelowy zawiera punkt połączenia lub dowiązanie symboliczne. Usuń dowiązanie lub wybierz inny katalog.
OpenSetupLog=Otwórz zapis konfiguracji
OpenSetupLogError=Nie można otworzyć dziennika konfiguracji.
LegacyUninstallStartFailed=Nie udało się uruchomić poprzedniego deinstalatora VCMI:%n%s
LegacyUninstallExitFailed=Poprzedni deinstalator VCMI zakończył się kodem błędu %s.
LegacyUninstallFailureChoice=Przerwij zatrzymuje instalację. Ponów uruchamia stary deinstalator ponownie. Ignoruj kontynuuje na własne ryzyko.
LegacyUninstallRequired=Nie udało się usunąć poprzedniej instalacji VCMI. Nie skopiowano żadnych nowych plików instalacyjnych.
InstallDirectoryUsedByOtherInstallation=Pliki instalacji pokrywają się z innymi zarejestrowanymi VCMI instalacja:%n%s%n%nWybierz inny katalog.
X86OnARM64Warning=Zainstalujesz 32-bitowy system (x86) wersji VCMI w sprawie ARM64 Windows. To jest obsługiwane, ale rodzime ARM64 zaleca się wersję, gdy jest ona dostępna.
RequirementsColumnComponent=Komponent
RequirementsColumnDetails=Wymagane
RequirementsColumnStatus=Status
RequirementsColumnDetected=Twój system
RequirementDetectedWindows=Kompatybilna instalacja systemu Windows
RequirementWritableValue=Katalog z możliwością zapisu
RequirementEnoughSpace=Wystarczająca ilość wolnego miejsca
RequirementProcessor=Procesor
RequirementProcessorValue=1 GHz lub szybciej
RequirementMemory=Pamięć operacyjna
RequirementMemoryValue=1 GB pamięci RAM
RequirementMemoryDetected=%s MB pamięci RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Środowisko wykonawcze DirectX 11 jest dostępne
RequirementDirectXMissing=Nie znaleziono środowiska wykonawczego DirectX 11
RequirementDetectionUnavailable=Nie udało się wykryć
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Katalog instalacji
RequirementUserDataFolder=Katalog danych użytkownika
RequirementDiskSpace=Wolne miejsce na dysku
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Zalecana
RequirementInternetAvailable=Dostępne
RequirementInternetUnavailable=Nie wykryte
RequirementHeroesData=Dane Heroes III
RequirementRequiredToPlay=Wymagane do gry
RequirementHeroesDataAvailable=Dostępne w danych użytkownika
RequirementHeroesDataMissing=Nie znaleziono; może być później importowane
RequirementWritableAndSynced=Pisanie i synchronizowanie
RequirementNotWritable=Brak możliwości zapisu
TasksCheckboxesTooltip=Wybierz opcjonalne integracje i działania. Skróty ułatwiają dostęp, skojarzenia plików otwierają obsługiwane mapy w edytorze, reguły zapory umożliwiają grę sieciową, a import kopiuje wykryte dane Heroes III.
UninstallCheckboxesTooltip=Zaznacz tylko katalogi danych użytkownika, które chcesz trwale usunąć. Wyłączone współdzielone pozycje są używane przez inną instalację VCMI.
InstallModeTooltip=Wszyscy użytkownicy: instaluje VCMI dla wszystkich kont Windows, zwykle w Program Files. Wymaga zgody administratora. Tworzy ogólnosystemowe informacje deinstalacji, wpisy rejestru, skróty, skojarzenia plików i opcjonalną regułę zapory. Dane pozostają w wybranym katalogu.%n%nBieżący użytkownik: instaluje VCMI tylko dla zalogowanego konta Windows, zwykle w Local AppData, bez zgody administratora. Tworzy deinstalator i integracje dla tego użytkownika. Inne konta nie zobaczą tej instalacji. Przy pierwszym użyciu gry sieciowej Zapora Windows może poprosić o pozwolenie.%n%nInstalacja przenośna: przechowuje aplikację i dane razem w wybranym katalogu. Nie tworzy deinstalatora, wpisów rejestru, skrótów, skojarzeń plików ani reguł zapory. Katalog musi pozostać zapisywalny. Przenieś go lub skopiuj, aby przenieść instalację; usuń go, aby odinstalować.
CopyH3FilesTooltip=Kopiuje wykryte katalogi Data, Maps i Mp3 z Heroes III do wybranego katalogu danych użytkownika VCMI. Pliki źródłowe pozostają bez zmian.
ReadyHeroes3Import=Import danych Heroes III:
