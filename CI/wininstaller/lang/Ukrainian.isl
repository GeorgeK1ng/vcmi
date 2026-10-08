; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Параметри встановлення VCMI:%n  /USERDATADIR=<шлях>  Задає папку даних користувача VCMI. Префікс expand: розгортає константи Inno Setup.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Встановлює програму й дані разом без деінсталятора, змін реєстру, ярликів, асоціацій і правил брандмауера.%n  /LAUNCH  Запускає VCMI після встановлення, включно з тихим режимом.%n%nПараметр деінсталятора VCMI:%n  /DELETEUSERDATA=1  Видаляє всі налаштовані папки користувача VCMI. Працює лише разом із /SILENT або /VERYSILENT. Дію неможливо скасувати.%n%nСтандартні параметри, зокрема /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART і /LOG, описані вище.
WindowsVersionNotSupported=Ця програма не може працювати на вашій версії Windows. Переконайтеся, що ви використовуєте правильну архітектуру Windows (32-розрядну або 64-розрядну) та відповідну версію програми.
PrivilegesRequiredOverrideTitle=Режим встановлення – Права доступу
PrivilegesRequiredOverrideInstruction=Виберіть, як запустити програму встановлення
PrivilegesRequiredOverrideText1=%1 потребує прав адміністратора для встановлення для всіх користувачів.%nВи також можете встановити його лише для свого облікового запису без прав адміністратора.
PrivilegesRequiredOverrideText2=%1 може бути встановлено лише для вашого облікового запису (без прав адміністратора) або для всіх користувачів (потребує прав адміністратора).
PrivilegesRequiredOverrideAllUsers=Запустити від імені &Адміністратора (встановлення для всіх користувачів)
PrivilegesRequiredOverrideAllUsersRecommended=Запустити від імені &Адміністратора (рекомендується)
PrivilegesRequiredOverrideCurrentUser=Запустити як &Звичайний користувач (встановлення лише для мене)
PrivilegesRequiredOverrideCurrentUserRecommended=Запустити як &Звичайний користувач (рекомендується)
ConfirmUninstall=Ви впевнені, що хочете запустити майстер видалення %1?

[CustomMessages]
AddFirewallRules=Додати правила брандмауера для VCMI
AssociateH3MFiles=Зв'язати файли .h3m з Редактором Карт VCMI
AssociateVCMIMapFiles=Зв'язати файли .vmap і .vcmp з Редактором Карт VCMI
CacheDirectory=Кеш
CloudDataNotice=Цей каталог даних користувача, ймовірно, синхронізується хмарним сховищем.
CloudDataWarning=Вибраний каталог даних користувача, ймовірно, синхронізується хмарним сховищем. Синхронізація може тимчасово блокувати файли та спричиняти помилки встановлення модів, запуску гри або збереження.%n%nУсе одно використовувати цей каталог?
CloudInstallNotice=Цей каталог встановлення, ймовірно, синхронізується хмарним сховищем.
CloudInstallWarning=Вибраний каталог встановлення, ймовірно, синхронізується хмарним сховищем. Переносне або синхронізоване встановлення може завершитися помилкою, якщо служба тимчасово заблокує файли програми.%n%nУсе одно використовувати цей каталог?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Налаштування
CopyH3Files=Автоматично скопіювати необхідні файли Heroes III до VCMI
CreateDesktopShortcuts=Створити ярлики на робочому столі
CreateStartMenuShortcuts=Створити ярлики в меню Пуск
DataFolderDescription=Містить копію наданих даних Heroes III, модифікації, мапи, збереження та інші файли користувача.
DataFolderTitle=Тека даних користувача
DeleteUserData=Видалити дані користувача
DeleteUserDataDescription=Виберіть теки для остаточного видалення. Непозначені теки буде збережено. Цю дію неможливо скасувати.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Файл карти Heroes 3
InstallFolderTitle=Тека встановлення
InstallForAllUsers=Встановити для всіх користувачів
InstallForAllUsers1=Потребує прав адміністратора
InstallForMeOnly=Встановити лише для мене
InstallForMeOnly1=При першому запуску гри з'явиться повідомлення брандмауера
InstallForMeOnly2=LAN-ігри не працюватимуть, якщо правило брандмауера не буде дозволено
InstallPortable=Портативне встановлення
InstallPortable1=Зберігає програму й дані користувача разом в одній папці
InstallPortable2=Не створює деінсталятор і не змінює реєстр та інтеграцію із системою
LogsDirectory=Журнали
ResetFoldersToDefault=Відновити типові
RunVCMILauncherAfterInstall=Запустити VCMI Launcher
SavesDirectory=Збережені ігри
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI можна встановити для всіх користувачів або лише для вас.
SelectSetupInstallModeSubTitle=Виберіть бажаний режим встановлення:
SelectSetupInstallModeTitle=Виберіть режим встановлення
SharedUserDataNotice=Дані користувача не можна видалити, оскільки інше встановлення VCMI використовує той самий каталог.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Відвідати офіційний Discord VCMI
ShortcutLauncher=Запускатор VCMI
ShortcutLauncherComment=Запустити VCMI Launcher
ShortcutMapEditor=Редактор Карт VCMI
ShortcutMapEditorComment=Відкрити Редактор Карт VCMI
ShortcutWebPage=Офіційний сайт VCMI
ShortcutWebPageComment=Відвідати офіційний сайт VCMI
SystemIntegration=Інтеграція з системою
Uninstall=Видалити
UserDataDirectory=Дані користувача (дані Heroes III, модифікації, мапи та інші файли)
VCMISettings=Налаштування VCMI
VCMPDescription=Файл кампанії VCMI
VMAPDescription=Файл карти VCMI
Warning=Попередження
X86On64BitWarning=Ви встановлюєте 32-розрядну версію (x86) VCMI у 64-розрядній Windows. Це підтримується, але за наявності рекомендовано використовувати нативну 64-розрядну версію.
