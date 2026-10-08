; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Parametry instalatora właściwe dla VCMI:%n  /USERDATADIR=<ścieżka>  Ustawia folder danych użytkownika VCMI. Prefiks expand: rozwija stałe Inno Setup.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Instaluje aplikację i dane razem bez deinstalatora, zmian rejestru, skrótów, skojarzeń i reguł zapory.%n  /LAUNCH  Uruchamia VCMI po instalacji, również cichej.%n%nParametr deinstalatora VCMI:%n  /DELETEUSERDATA=1  Usuwa wszystkie skonfigurowane foldery użytkownika VCMI. Działa tylko razem z /SILENT lub /VERYSILENT. Operacji nie można cofnąć.%n%nStandardowe parametry, takie jak /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART i /LOG, opisano powyżej.
WindowsVersionNotSupported=Ten program nie moze zostac uruchomiony na uzywanej wersji systemu Windows. Upewnij sie, ze uzywasz odpowiedniej architektury systemu Windows (32-bitowej lub 64-bitowej) i wlasciwej wersji tego programu.
PrivilegesRequiredOverrideTitle=Tryb instalacji – Uprawnienia
PrivilegesRequiredOverrideInstruction=Wybierz sposób uruchomienia instalatora
PrivilegesRequiredOverrideText1=Do zainstalowania %1 dla wszystkich użytkowników wymagane są uprawnienia administratora.%nMożesz również zainstalować aplikację tylko dla swojego konta bez uprawnień administratora.
PrivilegesRequiredOverrideText2=%1 może zostać zainstalowana tylko dla twojego konta (bez uprawnień administratora) lub dla wszystkich użytkowników (wymagane są uprawnienia administratora).
PrivilegesRequiredOverrideAllUsers=Uruchom jako &Administrator (instalacja dla wszystkich użytkowników)
PrivilegesRequiredOverrideAllUsersRecommended=Uruchom jako &Administrator (zalecane)
PrivilegesRequiredOverrideCurrentUser=Uruchom jako &Użytkownik standardowy (instalacja tylko dla mnie)
PrivilegesRequiredOverrideCurrentUserRecommended=Uruchom jako &Użytkownik standardowy (zalecane)
ConfirmUninstall=Czy na pewno chcesz uruchomic kreatora deinstalacji %1?

[CustomMessages]
AddFirewallRules=Dodaj reguly zapory dla VCMI
AssociateH3MFiles=Powiaz pliki .h3m z Edytorem Map VCMI
AssociateVCMIMapFiles=Powiaz pliki .vmap i .vcmp z Edytorem Map VCMI
CacheDirectory=Pamięć podręczna
CloudDataNotice=Ten katalog danych użytkownika jest prawdopodobnie synchronizowany przez usługę przechowywania w chmurze.
CloudDataWarning=Wybrany katalog danych użytkownika jest prawdopodobnie synchronizowany przez usługę przechowywania w chmurze. Synchronizacja może tymczasowo blokować pliki i powodować błędy instalacji modów, uruchamiania gry lub zapisywania stanu gry.%n%nCzy mimo to chcesz użyć tego katalogu?
CloudInstallNotice=Ten katalog instalacyjny jest prawdopodobnie synchronizowany przez usługę przechowywania w chmurze.
CloudInstallWarning=Wybrany katalog instalacyjny jest prawdopodobnie synchronizowany przez usługę przechowywania w chmurze. Instalacja przenośna lub synchronizowana może się nie powieść, jeśli usługa tymczasowo zablokuje pliki aplikacji.%n%nCzy mimo to chcesz użyć tego katalogu?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Konfiguracja
CopyH3Files=Automatycznie skopiuj wymagane pliki Heroes III do VCMI
CreateDesktopShortcuts=Utwórz skróty na pulpicie
CreateStartMenuShortcuts=Utwórz skróty w menu Start
DataFolderDescription=Zawiera kopię dostarczonych danych Heroes III, modyfikacje, mapy, zapisane gry i inne pliki użytkownika.
DataFolderTitle=Folder danych użytkownika
DeleteUserData=Usun dane uzytkownika
DeleteUserDataDescription=Wybierz foldery do trwałego usunięcia. Niezaznaczone foldery zostaną zachowane. Tej operacji nie można cofnąć.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
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
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI moze zostac zainstalowane dla wszystkich uzytkowników lub tylko dla Ciebie.
SelectSetupInstallModeSubTitle=Wybierz preferowany tryb instalacji:
SelectSetupInstallModeTitle=Wybierz tryb instalacji
SharedUserDataNotice=Nie można usunąć danych użytkownika, ponieważ inna instalacja VCMI używa tego samego katalogu.
ShortcutDiscord=Discord VCMI
ShortcutDiscordComment=Odwiedz oficjalny Discord VCMI
ShortcutLauncher=Launcher VCMI
ShortcutLauncherComment=Uruchom Launcher VCMI
ShortcutMapEditor=Edytor Map VCMI
ShortcutMapEditorComment=Otwórz Edytor Map VCMI
ShortcutWebPage=Strona internetowa VCMI
ShortcutWebPageComment=Odwiedz oficjalna strone VCMI
SystemIntegration=Integracja z systemem
Uninstall=Odinstaluj
UserDataDirectory=Dane użytkownika (dane Heroes III, modyfikacje, mapy i inne pliki)
VCMISettings=Konfiguracja VCMI
VCMPDescription=Plik kampanii VCMI
VMAPDescription=Plik mapy VCMI
Warning=Ostrzezenie
X86On64BitWarning=Instalujesz 32-bitową wersję (x86) VCMI w 64-bitowym systemie Windows. Jest to obsługiwane, ale zalecana jest natywna wersja 64-bitowa, jeśli jest dostępna.
