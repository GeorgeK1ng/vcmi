;
; Russian.isl, part of VCMI engine
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
HelpTextNote=Параметры установки VCMI:%n  /USERDATADIR=<path>  Задаёт папку пользовательских данных VCMI. Префикс expand: раскрывает константы Inno Setup.%n  /ALLOWCLOUDTARGET=1  Разрешает синхронизируемую с облаком папку установки или пользовательских данных при тихой установке.%n  /PORTABLE=1  Устанавливает приложение и данные вместе без программы удаления, изменений реестра, ярлыков, файловых ассоциаций и правил брандмауэра.%n  /LAUNCH  Запускает VCMI после установки, в том числе тихой.%n  /COPYH3DATA=0|1  Включает или отключает автоматическое копирование найденных данных Heroes III.%n%nНазвания задач для /TASKS и /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (только установка для всех пользователей с правами администратора)%n%nПараметр удаления VCMI:%n  /DELETEUSERDATA=1  Удаляет все настроенные пользовательские папки VCMI. Действует только вместе с /SILENT или /VERYSILENT. Это действие нельзя отменить.%n%nСтандартные параметры описаны выше: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Эта программа не может работать с вашей версией Windows. Убедитесь, что вы используете правильную архитектуру Windows (x86 / x64 / ARM64) и соответствующую версию программы.
PrivilegesRequiredOverrideTitle=Режим установки – Права доступа
PrivilegesRequiredOverrideInstruction=Выберите, как запустить программу установки
PrivilegesRequiredOverrideText1=%1 требует прав администратора для установки для всех пользователей. Вы также можете установить её только для своей учётной записи без прав администратора.
PrivilegesRequiredOverrideText2=%1 может быть установлена только для вашей учётной записи (без прав администратора) или для всех пользователей (требуются права администратора).
PrivilegesRequiredOverrideAllUsers=Запустить от имени &Администратора (установка для всех пользователей)
PrivilegesRequiredOverrideAllUsersRecommended=Запустить от имени &Администратора (рекомендуется)
PrivilegesRequiredOverrideCurrentUser=Запустить как &Обычный пользователь (установка только для меня)
PrivilegesRequiredOverrideCurrentUserRecommended=Запустить как &Обычный пользователь (рекомендуется)
ConfirmUninstall=Вы уверены, что хотите запустить мастер удаления %1?

[CustomMessages]
DesktopShortcuts=Ярлыки на рабочем столе
StartMenuShortcuts=Ярлыки в меню «Пуск»
WelcomeDescription=VCMI — открытый движок Heroes III с новыми и расширенными возможностями. Для использования VCMI необходимо владеть оригинальными файлами данных игры.%n%nЭтот мастер установит VCMI - Open Heroes 3 на ваше устройство.%n%nПеред продолжением рекомендуется закрыть все остальные приложения.%n%nНажмите «Далее», чтобы продолжить, или «Отмена», чтобы выйти из программы установки.
WelcomeHighlightsTitle=О проекте VCMI
WelcomeHighlights=VCMI — разрабатываемая сообществом новая реализация движка Heroes of Might and Magic III. Проект сохраняет дух оригинальной игры, снимает технические ограничения классического движка и предоставляет открытую основу для модификаций и дальнейшего развития.
RequirementImportSpaceHelp=Вернитесь и выберите другую папку пользовательских данных или отключите автоматическое копирование данных Heroes III.
RequirementDisableImportQuestion=Продолжить без копирования данных Heroes III?
RequirementFirewall=Брандмауэр
RequirementMultiplayerGames=Многопользовательские игры
RequirementSelected=Выбрано
RequirementNotSelected=Не выбрано — игра за одним компьютером будет работать
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Добавить правила брандмауэра для многопользовательских игр
AssociateH3MFiles=Ассоциировать файлы .h3m с редактором карт VCMI
AssociateVCMIMapFiles=Ассоциировать файлы .vmap и .vcmp с редактором карт VCMI
CacheDirectory=Кэш
CloudDataNotice=Эта папка пользовательских данных, вероятно, синхронизируется облачным хранилищем.
CloudDataWarning=Выбранная папка пользовательских данных, вероятно, синхронизируется облачным хранилищем. Синхронизация может временно блокировать файлы и вызывать ошибки установки модов, запуска игры или сохранения.%n%nВсё равно использовать эту папку?
CloudInstallNotice=Эта папка установки, вероятно, синхронизируется облачным хранилищем.
CloudInstallWarning=Выбранная папка установки, вероятно, синхронизируется облачным хранилищем. Переносимая или синхронизируемая установка может дать сбой, если служба временно заблокирует файлы приложения.%n%nВсё равно использовать эту папку?
CloudTargetSilentError=Тихая установка не может использовать синхронизируемую с облаком папку без /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Не удалось скопировать файлы Heroes III (%s). Некоторые файлы уже могли быть скопированы; импорт можно безопасно повторить.
CopyingHeroes3Data=Копирование данных Heroes III...
ConfigDirectory=Настройки
CopyH3Files=Автоматически скопировать необходимые файлы Heroes III в VCMI
CreateDesktopShortcuts=Создать ярлыки на рабочем столе
CreateStartMenuShortcuts=Создать ярлыки в меню Пуск
DataFolderDescription=Содержит копию предоставленных данных Heroes III, модификации, карты, сохранения и другие пользовательские файлы.
DataFolderTitle=Папка пользовательских данных
DeleteUserData=Удалить пользовательские данные
DeleteUserDataDescription=Выберите папки для безвозвратного удаления. Неотмеченные папки будут сохранены. Это действие нельзя отменить.
DeletingUserData=Удаление пользовательских данных...
DirectoryConfigWriteError=Не удалось сохранить настройки пользовательских папок в %s. Установка не может безопасно продолжаться.
DirectoryNotWritable=Выбранная папка (%s) недоступна для записи. Выберите другую папку или запустите установку с необходимыми правами.%n%n%s
DirectoryRootNotAllowed=Выбранная папка (%s) не может быть корнем диска или сетевого ресурса. Выберите отдельную папку.%n%n%s
DirectoryOverlapError=Папки установки и пользовательских данных не должны совпадать или небезопасно пересекаться. Только переносная установка может хранить данные внутри папки установки.
ReadyUserDataLocation=Расположение пользовательских данных:
RequirementPassed=ВЫПОЛНЕНО
RequirementFailed=ОШИБКА
RequirementWarning=ПРЕДУПРЕЖДЕНИЕ
RequirementInfo=ИНФОРМАЦИЯ
RequirementOperatingSystem=Операционная система
RequirementOperatingSystemValue=Windows 7 SP1 или новейший; включено время выполнения совместимости, когда это необходимо
RequirementArchitecture=Архитектура
RequirementInstallWritable=Папка установки доступна для записи
RequirementDataWritable=Папка пользовательских данных доступна для записи
RequirementDirectoryLayout=Размер каталога
RequirementDirectoryLayoutValue=Папки установки и пользовательских данных безопасно разделены
RequirementApplicationSpace=Пространство на диске приложения
RequirementFreeSpaceValue=Свободно %s МБ; установщик также проверяет итоговый размер пакета
RequirementHeroesDataSpace=Импорт Heroes III
RequirementInsufficientSpace=Недостаточно свободного места для импорта выбранных данных Heroes III
RequirementRequiredSpaceValue=Для выбранного импорта требуется примерно %s МБ
RequirementNotRequested=Импорт данных Heroes III не выбран
RequirementCloudStorage=Синхронизация хранения
RequirementCloudStorageValue=Выбранный путь использует синхронизацию облака
RequirementLocalStorageValue=Выбранные пути используют локальное хранилище
RequirementInstallationMode=Режим установки
RequirementModePortable=Портативный; отсутствует деинсталлятор, реестр или интеграция системы
RequirementModeAllUsers=Все пользователи
RequirementModeCurrentUser=Текущий пользователь
RequirementUpgrade=существующая установка будет обновлена
RequirementsCheckTitle=Проверка системных требований
RequirementsCheckDescription=Настройка проверила выбранную конфигурацию перед установкой.
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
ScanningFiles=Поиск файлов...
SelectSetupInstallModeDesc=VCMI можно установить для всех пользователей, только для вас или в переносном режиме.
SelectSetupInstallModeSubTitle=Выберите предпочтительный режим установки:
SelectSetupInstallModeTitle=Выберите режим установки
SharedUserDataNotice=Пользовательские данные нельзя удалить, поскольку другая установка VCMI использует ту же папку.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Посетите официальный Discord VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Запустить VCMI Launcher
ShortcutMapEditor=Редактор карт VCMI
ShortcutMapEditorComment=Открыть редактор карт VCMI
ShortcutWebPage=Официальный сайт VCMI
ShortcutWebPageComment=Посетите официальный сайт VCMI
SystemIntegration=Интеграция с системой
FileAssociations=Ассоциации файлов
AssociateH3CFiles=Открывать кампании Heroes III (.h3c) в редакторе карт VCMI
H3CDescription=Кампания Heroes III
Uninstall=Удалить
UserDataDirectory=Пользовательские данные (данные Heroes III, модификации, карты и другие файлы)
VCMISettings=Настройки системы
VCMPDescription=Файл кампании VCMI
VMAPDescription=Файл карты VCMI
Warning=Предупреждение
X86On64BitWarning=Вы устанавливаете 32-разрядную версию (x86) VCMI в 64-разрядной Windows. Это поддерживается, но при наличии рекомендуется использовать нативную 64-разрядную версию.
Heroes3ImportReparsePoint=Невозможно безопасно импортировать данные Heroes III: существующая целевая папка содержит точку соединения или символическую ссылку. Удалите ссылку или выберите другую папку.
OpenSetupLog=Откройте регистрацию настройки
OpenSetupLogError=Журнал установки не был открыт.
LegacyUninstallStartFailed=Не удалось запустить предыдущую программу удаления VCMI:%n%s
LegacyUninstallExitFailed=Предыдущая программа удаления VCMI завершилась с кодом ошибки %s.
LegacyUninstallFailureChoice=Прервать — остановить установку. Повторить — снова запустить старую программу удаления. Игнорировать — продолжить на свой страх и риск.
LegacyUninstallRequired=Не удалось удалить предыдущую установку VCMI. Новые установочные файлы не были скопированы.
InstallDirectoryUsedByOtherInstallation=Справочник установки пересекается с другим зарегистрированным VCMI установка:%n%s%n%nВыберите другой справочник.
X86OnARM64Warning=Вы устанавливаете 32-битный (x86) версии VCMI на ARM64 Windows. Это поддерживается, но нативный ARM64 Рекомендуется использовать версию, если она доступна.
RequirementsColumnComponent=Компонент
RequirementsColumnDetails=Необходимо
RequirementsColumnStatus=Статус
RequirementsColumnDetected=Ваша система
RequirementDetectedWindows=Совместимая установка Windows
RequirementWritableValue=Папка доступна для записи
RequirementEnoughSpace=Достаточно свободного места
RequirementProcessor=Процессор
RequirementProcessorValue=1 ГГц или быстрее
RequirementMemory=Оперативная память
RequirementMemoryValue=1 ГБ оперативной памяти
RequirementMemoryDetected=%s МБ оперативной памяти
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Среда выполнения DirectX 11 доступна
RequirementDirectXMissing=Среда выполнения DirectX 11 не найдена
RequirementDetectionUnavailable=Не удалось определить
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Папка установки
RequirementUserDataFolder=Папка пользовательских данных
RequirementDiskSpace=Свободное пространство на диске
RequirementFreeSpaceShortValue=%s
RequirementInternet=Интернет
RequirementRecommended=Рекомендуется
RequirementInternetAvailable=Доступность
RequirementInternetUnavailable=Не обнаружено
RequirementHeroesData=Данные Heroes III
RequirementRequiredToPlay=Необходимо для игры
RequirementHeroesDataAvailable=Найдены в пользовательских данных
RequirementHeroesDataMissing=Не найдено; может быть импортировано позже
RequirementWritableAndSynced=Письменная и синхронизируемая
RequirementNotWritable=Запись недоступна
TasksCheckboxesTooltip=Выберите дополнительные действия и интеграции. Ярлыки упрощают запуск, файловые ассоциации открывают поддерживаемые карты в редакторе, правила брандмауэра разрешают сетевую игру, а импорт копирует найденные данные Heroes III.
UninstallCheckboxesTooltip=Отметьте только те папки пользовательских данных, которые нужно удалить навсегда. Недоступные общие папки используются другой установкой VCMI.
InstallModeTooltip=Все пользователи: устанавливает VCMI для всех учётных записей Windows, обычно в Program Files. Требует прав администратора. Создаёт общесистемные сведения об удалении, записи реестра, ярлыки, файловые ассоциации и необязательное правило брандмауэра. Данные остаются в выбранной папке.%n%nТекущий пользователь: устанавливает VCMI только для текущей учётной записи Windows, обычно в Local AppData, без прав администратора. Создаёт программу удаления и интеграции для этого пользователя. Другие учётные записи не увидят эту установку. При первом использовании сетевой игры брандмауэр Windows может запросить разрешение.%n%nПереносная установка: хранит приложение и данные вместе в выбранной папке. Не создаёт программу удаления, записи реестра, ярлыки, файловые ассоциации и правила брандмауэра. Папка должна оставаться доступной для записи. Переместите или скопируйте её для переноса установки; удалите её для удаления программы.
CopyH3FilesTooltip=Копирует найденные папки Heroes III Data, Maps и Mp3 в выбранную папку пользовательских данных VCMI. Исходные файлы остаются без изменений.
ReadyHeroes3Import=Импорт данных Heroes III:
