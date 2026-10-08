; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Vlastní parametry instalátoru VCMI:%n  /USERDATADIR=<cesta>  Nastaví složku uživatelských dat VCMI. Prefix expand: rozbalí konstanty Inno Setup.%n  /ALLOWCLOUDTARGET=1  Povolí při tiché instalaci instalační složku nebo složku uživatelských dat synchronizovanou s cloudem.%n  /PORTABLE=1  Nainstaluje aplikaci a data společně bez odinstalátoru, změn registru, zástupců, asociací a pravidel firewallu.%n  /LAUNCH  Spustí VCMI po instalaci, včetně tiché instalace.%n%nParametr odinstalátoru VCMI:%n  /DELETEUSERDATA=1  Odstraní všechny nakonfigurované uživatelské složky VCMI. Funguje pouze společně s /SILENT nebo /VERYSILENT. Operaci nelze vrátit.%n%nStandardní parametry jako /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART a /LOG jsou popsány výše.
WindowsVersionNotSupported=Tento program nelze spustit na vaší verzi Windows. Ujistěte se, že používáte správnou architekturu Windows (32bitovou nebo 64bitovou) a odpovídající verzi tohoto programu.
PrivilegesRequiredOverrideTitle=Režim instalace – oprávnění
PrivilegesRequiredOverrideInstruction=Zvolte, jak spustit instalační program
PrivilegesRequiredOverrideText1=Produkt %1 vyžaduje oprávnění správce pro instalaci pro všechny uživatele.%nMůžete jej také nainstalovat pouze pro svůj účet bez oprávnění správce.
PrivilegesRequiredOverrideText2=Produkt %1 lze nainstalovat pouze pro váš účet (bez oprávnění správce), nebo pro všechny uživatele (vyžaduje oprávnění správce).
PrivilegesRequiredOverrideAllUsers=Spustit jako &správce (instalace pro všechny uživatele)
PrivilegesRequiredOverrideAllUsersRecommended=Spustit jako &správce (doporučeno)
PrivilegesRequiredOverrideCurrentUser=Spustit jako &běžný uživatel (instalace pouze pro mě)
PrivilegesRequiredOverrideCurrentUserRecommended=Spustit jako &běžný uživatel (doporučeno)
ConfirmUninstall=Opravdu chcete spustit průvodce odinstalací %1?

[CustomMessages]
AddFirewallRules=Přidat pravidla brány firewall pro VCMI
AssociateH3MFiles=Asociovat .h3m soubory s editorem map VCMI
AssociateVCMIMapFiles=Asociovat .vmap a .vcmp soubory s editorem map VCMI
CacheDirectory=Mezipaměť
CloudDataNotice=Tento adresář uživatelských dat je pravděpodobně synchronizován cloudovým úložištěm.
CloudDataWarning=Vybraný adresář uživatelských dat je pravděpodobně synchronizován cloudovým úložištěm. Synchronizace může dočasně zamykat soubory a způsobit selhání instalace modů, spuštění hry nebo ukládání pozic.%n%nChcete tento adresář přesto použít?
CloudInstallNotice=Tento instalační adresář je pravděpodobně synchronizován cloudovým úložištěm.
CloudInstallWarning=Vybraný instalační adresář je pravděpodobně synchronizován cloudovým úložištěm. Přenosná nebo synchronizovaná instalace může selhat, pokud poskytovatel dočasně zamkne soubory aplikace.%n%nChcete tento adresář přesto použít?
CloudTargetSilentError=Tichá instalace nepoužije cíl synchronizovaný s cloudem bez přepínače /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Nepodařilo se zkopírovat soubory Heroes III %s.
CopyingHeroes3Data=Kopírování dat Heroes III...
ConfigDirectory=Konfigurace
CopyH3Files=Automaticky zkopírovat požadované soubory Heroes III do VCMI
CreateDesktopShortcuts=Vytvořit zástupce na ploše
CreateStartMenuShortcuts=Vytvořit zástupce v nabídce Start
DataFolderDescription=Obsahuje kopii poskytnutých dat Heroes III, modifikace, mapy, uložené hry a další uživatelské soubory.
DataFolderTitle=Složka uživatelských dat
DeleteUserData=Odstranit uživatelská data
DeleteUserDataDescription=Vyberte složky, které chcete trvale odstranit. Nezaškrtnuté složky zůstanou zachovány. Tuto akci nelze vrátit zpět.
DeletingUserData=Odstraňování uživatelských dat...
DirectoryConfigWriteError=Nepodařilo se uložit konfiguraci uživatelských složek do %s. Instalace nemůže bezpečně pokračovat.
H3MDescription=Soubor mapy Heroes 3
InstallFolderTitle=Instalační složka
InstallForAllUsers=Nainstalovat pro všechny uživatele
InstallForAllUsers1=Vyžaduje administrátorská práva
InstallForMeOnly=Nainstalovat pouze pro mě
InstallForMeOnly1=Při prvním spuštění hry se zobrazí výzva brány firewall
InstallForMeOnly2=LAN hry nebudou fungovat, pokud nebude možné povolit pravidlo brány firewall
InstallPortable=Portable instalace
InstallPortable1=Uchová aplikaci i uživatelská data společně v jedné složce
InstallPortable2=Nevytvoří odinstalátor ani nezmění registr a integraci systému
LogsDirectory=Protokoly
ResetFoldersToDefault=Obnovit výchozí
RunVCMILauncherAfterInstall=Spustit VCMI Launcher
SavesDirectory=Uložené hry
ScanningFiles=Prohledávání souborů...
SelectSetupInstallModeDesc=VCMI může být nainstalováno pro všechny uživatele nebo pouze pro vás.
SelectSetupInstallModeSubTitle=Vyberte preferovaný režim instalace:
SelectSetupInstallModeTitle=Vyberte režim instalace
SharedUserDataNotice=Uživatelská data nelze odstranit, protože stejný adresář používá jiná instalace VCMI.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Navštivte oficiální Discord VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Spustit VCMI Launcher
ShortcutMapEditor=Editor map VCMI
ShortcutMapEditorComment=Otevřít editor map VCMI
ShortcutWebPage=VCMI Web
ShortcutWebPageComment=Navštivte oficiální web VCMI
SystemIntegration=Systémová integrace
Uninstall=Odinstalovat
UserDataDirectory=Uživatelská data (data Heroes III, modifikace, mapy a další soubory)
VCMISettings=Konfigurace VCMI
VCMPDescription=Soubor kampaně VCMI
VMAPDescription=Soubor mapy VCMI
Warning=Varování
X86On64BitWarning=Instalujete 32bitovou (x86) verzi VCMI na 64bitový systém Windows. Tato instalace je podporována, ale pokud je dostupná nativní 64bitová verze, doporučujeme použít ji.
