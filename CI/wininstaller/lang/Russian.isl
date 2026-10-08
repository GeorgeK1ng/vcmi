; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Параметры установки VCMI:%n  /USERDATADIR=<путь>  Задаёт папку пользовательских данных VCMI. Префикс expand: разворачивает константы Inno Setup.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Устанавливает приложение и данные вместе без деинсталлятора, изменений реестра, ярлыков, ассоциаций и правил брандмауэра.%n  /LAUNCH  Запускает VCMI после установки, включая тихую установку.%n%nПараметр деинсталлятора VCMI:%n  /DELETEUSERDATA=1  Удаляет все настроенные пользовательские папки VCMI. Работает только вместе с /SILENT или /VERYSILENT. Действие необратимо.%n%nСтандартные параметры, включая /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART и /LOG, описаны выше.
WindowsVersionNotSupported=Эта программа не может работать с вашей версией Windows. Убедитесь, что вы используете правильную архитектуру Windows (32-битную или 64-битную) и соответствующую версию программы.
PrivilegesRequiredOverrideTitle=Режим установки – Права доступа
PrivilegesRequiredOverrideInstruction=Выберите, как запустить программу установки
PrivilegesRequiredOverrideText1=%1 требует прав администратора для установки для всех пользователей.%nВы также можете установить её только для своей учётной записи без прав администратора.
PrivilegesRequiredOverrideText2=%1 может быть установлена только для вашей учётной записи (без прав администратора) или для всех пользователей (требуются права администратора).
PrivilegesRequiredOverrideAllUsers=Запустить от имени &Администратора (установка для всех пользователей)
PrivilegesRequiredOverrideAllUsersRecommended=Запустить от имени &Администратора (рекомендуется)
PrivilegesRequiredOverrideCurrentUser=Запустить как &Обычный пользователь (установка только для меня)
PrivilegesRequiredOverrideCurrentUserRecommended=Запустить как &Обычный пользователь (рекомендуется)
ConfirmUninstall=Вы уверены, что хотите запустить мастер удаления %1?

[CustomMessages]
AddFirewallRules=Добавить правила брандмауэра для VCMI
AssociateH3MFiles=Ассоциировать файлы .h3m с редактором карт VCMI
AssociateVCMIMapFiles=Ассоциировать файлы .vmap и .vcmp с редактором карт VCMI
CacheDirectory=Кэш
CloudDataNotice=Эта папка пользовательских данных, вероятно, синхронизируется облачным хранилищем.
CloudDataWarning=Выбранная папка пользовательских данных, вероятно, синхронизируется облачным хранилищем. Синхронизация может временно блокировать файлы и вызывать ошибки установки модов, запуска игры или сохранения.%n%nВсё равно использовать эту папку?
CloudInstallNotice=Эта папка установки, вероятно, синхронизируется облачным хранилищем.
CloudInstallWarning=Выбранная папка установки, вероятно, синхронизируется облачным хранилищем. Переносимая или синхронизируемая установка может дать сбой, если служба временно заблокирует файлы приложения.%n%nВсё равно использовать эту папку?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Настройки
CopyH3Files=Автоматически скопировать необходимые файлы Heroes III в VCMI
CreateDesktopShortcuts=Создать ярлыки на рабочем столе
CreateStartMenuShortcuts=Создать ярлыки в меню Пуск
DataFolderDescription=Содержит копию предоставленных данных Heroes III, модификации, карты, сохранения и другие пользовательские файлы.
DataFolderTitle=Папка пользовательских данных
DeleteUserData=Удалить пользовательские данные
DeleteUserDataDescription=Выберите папки для безвозвратного удаления. Неотмеченные папки будут сохранены. Это действие нельзя отменить.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Файл карты Heroes 3
InstallFolderTitle=Папка установки
InstallForAllUsers=Установить для всех пользователей
InstallForAllUsers1=Требуются права администратора
InstallForMeOnly=Установить только для меня
InstallForMeOnly1=При первом запуске игры появится запрос от брандмауэра
InstallForMeOnly2=LAN-игры не будут работать, если правило брандмауэра не будет разрешено
InstallPortable=Портативная установка
InstallPortable1=Хранит приложение и пользовательские данные вместе в одной папке
InstallPortable2=Не создаёт деинсталлятор и не изменяет реестр и системную интеграцию
LogsDirectory=Журналы
ResetFoldersToDefault=Восстановить по умолчанию
RunVCMILauncherAfterInstall=Запустить VCMI Launcher
SavesDirectory=Сохранённые игры
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI можно установить для всех пользователей или только для вас.
SelectSetupInstallModeSubTitle=Выберите предпочтительный режим установки:
SelectSetupInstallModeTitle=Выберите режим установки
SharedUserDataNotice=Пользовательские данные нельзя удалить, поскольку другая установка VCMI использует ту же папку.
ShortcutDiscord=Discord VCMI
ShortcutDiscordComment=Посетите официальный Discord VCMI
ShortcutLauncher=Запускатор VCMI
ShortcutLauncherComment=Запустить VCMI Launcher
ShortcutMapEditor=Редактор карт VCMI
ShortcutMapEditorComment=Открыть редактор карт VCMI
ShortcutWebPage=Официальный сайт VCMI
ShortcutWebPageComment=Посетите официальный сайт VCMI
SystemIntegration=Интеграция с системой
Uninstall=Удалить
UserDataDirectory=Пользовательские данные (данные Heroes III, модификации, карты и другие файлы)
VCMISettings=Настройки VCMI
VCMPDescription=Файл кампании VCMI
VMAPDescription=Файл карты VCMI
Warning=Предупреждение
X86On64BitWarning=Вы устанавливаете 32-разрядную версию (x86) VCMI в 64-разрядной Windows. Это поддерживается, но при наличии рекомендуется использовать нативную 64-разрядную версию.
