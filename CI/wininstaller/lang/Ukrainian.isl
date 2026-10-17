;
; Ukrainian.isl, part of VCMI engine
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
HelpTextNote=Параметри встановлення VCMI:%n  /USERDATADIR=<path>  Задає папку даних користувача VCMI. Префікс expand: розгортає константи Inno Setup.%n  /ALLOWCLOUDTARGET=1  Дозволяє синхронізовану з хмарою папку встановлення або даних користувача під час тихого встановлення.%n  /PORTABLE=1  Встановлює програму й дані разом без деінсталятора, змін реєстру, ярликів, файлових асоціацій і правил брандмауера.%n  /LAUNCH  Запускає VCMI після встановлення, зокрема тихого.%n  /COPYH3DATA=0|1  Вмикає або вимикає автоматичне копіювання знайдених даних Heroes III.%n%nНазви завдань для /TASKS і /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (лише встановлення для всіх користувачів із правами адміністратора)%n%nПараметр видалення VCMI:%n  /DELETEUSERDATA=1  Видаляє всі налаштовані папки користувача VCMI. Діє лише разом із /SILENT або /VERYSILENT. Цю дію неможливо скасувати.%n%nСтандартні параметри описані вище: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Ця програма не може працювати на вашій версії Windows. Переконайтеся, що ви використовуєте правильну архітектуру Windows (x86 / x64 / ARM64) та відповідну версію програми.
PrivilegesRequiredOverrideTitle=Режим встановлення – Права доступу
PrivilegesRequiredOverrideInstruction=Виберіть, як запустити програму встановлення
PrivilegesRequiredOverrideText1=%1 потребує прав адміністратора для встановлення для всіх користувачів. Ви також можете встановити його лише для свого облікового запису без прав адміністратора.
PrivilegesRequiredOverrideText2=%1 може бути встановлено лише для вашого облікового запису (без прав адміністратора) або для всіх користувачів (потребує прав адміністратора).
PrivilegesRequiredOverrideAllUsers=Запустити від імені &Адміністратора (встановлення для всіх користувачів)
PrivilegesRequiredOverrideAllUsersRecommended=Запустити від імені &Адміністратора (рекомендується)
PrivilegesRequiredOverrideCurrentUser=Запустити як &Звичайний користувач (встановлення лише для мене)
PrivilegesRequiredOverrideCurrentUserRecommended=Запустити як &Звичайний користувач (рекомендується)
ConfirmUninstall=Ви впевнені, що хочете запустити майстер видалення %1?

[CustomMessages]
DesktopShortcuts=Ярлики на робочому столі
StartMenuShortcuts=Ярлики в меню «Пуск»
WelcomeDescription=VCMI — відкритий рушій Heroes III з новими та розширеними можливостями. Для використання VCMI необхідно володіти оригінальними файлами даних гри.%n%nЦей майстер встановить VCMI - Open Heroes 3 на ваш пристрій.%n%nПеред продовженням рекомендовано закрити всі інші програми.%n%nНатисніть «Далі», щоб продовжити, або «Скасувати», щоб вийти з інсталятора.
WelcomeHighlightsTitle=Про VCMI
WelcomeHighlights=VCMI — це розроблена спільнотою нова реалізація рушія Heroes of Might and Magic III. Проєкт зберігає дух оригінальної гри, усуває технічні обмеження класичного рушія та надає відкриту основу для модифікацій і подальшого розвитку.
RequirementImportSpaceHelp=Поверніться та виберіть іншу папку даних користувача або вимкніть автоматичне копіювання даних Heroes III.
RequirementDisableImportQuestion=Продовжити без копіювання даних Heroes III?
RequirementFirewall=Брандмауер
RequirementMultiplayerGames=Багатокористувацькі ігри
RequirementSelected=Вибрано
RequirementNotSelected=Не вибрано — гра за одним комп'ютером працюватиме
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Додати правила брандмауера для багатокористувацьких ігор
AssociateH3MFiles=Зв'язати файли .h3m з Редактором Карт VCMI
AssociateVCMIMapFiles=Зв'язати файли .vmap і .vcmp з Редактором Карт VCMI
CacheDirectory=Кеш
CloudDataNotice=Цей каталог даних користувача, ймовірно, синхронізується хмарним сховищем.
CloudDataWarning=Вибраний каталог даних користувача, ймовірно, синхронізується хмарним сховищем. Синхронізація може тимчасово блокувати файли та спричиняти помилки встановлення модів, запуску гри або збереження.%n%nУсе одно використовувати цей каталог?
CloudInstallNotice=Цей каталог встановлення, ймовірно, синхронізується хмарним сховищем.
CloudInstallWarning=Вибраний каталог встановлення, ймовірно, синхронізується хмарним сховищем. Переносне або синхронізоване встановлення може завершитися помилкою, якщо служба тимчасово заблокує файли програми.%n%nУсе одно використовувати цей каталог?
CloudTargetSilentError=Тихе встановлення не може використовувати синхронізовану з хмарою папку без /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Не вдалося скопіювати файли Heroes III (%s). Деякі файли вже могли бути скопійовані; імпорт можна безпечно повторити.
CopyingHeroes3Data=Копіювання даних Heroes III...
ConfigDirectory=Налаштування
CopyH3Files=Автоматично скопіювати необхідні файли Heroes III до VCMI
CreateDesktopShortcuts=Створити ярлики на робочому столі
CreateStartMenuShortcuts=Створити ярлики в меню Пуск
DataFolderDescription=Містить копію наданих даних Heroes III, модифікації, мапи, збереження та інші файли користувача.
DataFolderTitle=Тека даних користувача
DeleteUserData=Видалити дані користувача
DeleteUserDataDescription=Виберіть теки для остаточного видалення. Непозначені теки буде збережено. Цю дію неможливо скасувати.
DeletingUserData=Видалення даних користувача...
DirectoryConfigWriteError=Не вдалося зберегти налаштування папок користувача в %s. Встановлення не може безпечно продовжуватися.
DirectoryNotWritable=Вибрана папка (%s) недоступна для запису. Виберіть іншу папку або запустіть встановлення з потрібними правами.%n%n%s
DirectoryRootNotAllowed=Вибрана папка (%s) не може бути коренем диска чи мережевого ресурсу. Виберіть окрему папку.%n%n%s
DirectoryOverlapError=Папки встановлення та даних користувача не повинні збігатися або небезпечно перетинатися. Лише переносне встановлення може зберігати дані всередині папки встановлення.
ReadyUserDataLocation=Розташування даних користувача:
RequirementPassed=ВИКОНАНО
RequirementFailed=ПОМИЛКА
RequirementWarning=ПОПЕРЕДЖЕННЯ
RequirementInfo=ІНФОРМАЦІЯ
RequirementOperatingSystem=Операційна система
RequirementOperatingSystemValue=Windows 7 SP1 або новітніше; включено час запуску сумісності, коли це потрібно
RequirementArchitecture=Архітектура
RequirementInstallWritable=Папка встановлення доступна для запису
RequirementDataWritable=Папка даних користувача доступна для запису
RequirementDirectoryLayout=Розмір каталогів
RequirementDirectoryLayoutValue=Шляхи встановлення та даних користувача безпечно розділені
RequirementApplicationSpace=Простійний простір на диску додатків
RequirementFreeSpaceValue=Вільно %s МБ; інсталятор також перевіряє остаточний розмір пакунка
RequirementHeroesDataSpace=Імпорт Heroes III
RequirementInsufficientSpace=Недостатньо вільного місця для імпорту вибраних даних Heroes III
RequirementRequiredSpaceValue=Для вибраного імпорту потрібно приблизно %s МБ
RequirementNotRequested=Імпорт даних Heroes III не вибрано
RequirementCloudStorage=Синхронізація зберігання
RequirementCloudStorageValue=Вибраний шлях використовує синхронізацію хмари
RequirementLocalStorageValue=Вибрані шляхи використовують локальне зберігання
RequirementInstallationMode=Режим установки
RequirementModePortable=Портабельний; жодного деінсталлятора, реєстру або системної інтеграції
RequirementModeAllUsers=Всі користувачі
RequirementModeCurrentUser=Останній користувач
RequirementUpgrade=наявне встановлення буде оновлено
RequirementsCheckTitle=Перевірка системних вимог
RequirementsCheckDescription=Установка перевірила обрану конфігурацію перед установкою.
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
ScanningFiles=Пошук файлів...
SelectSetupInstallModeDesc=VCMI можна встановити для всіх користувачів, лише для вас або в переносному режимі.
SelectSetupInstallModeSubTitle=Виберіть бажаний режим встановлення:
SelectSetupInstallModeTitle=Виберіть режим встановлення
SharedUserDataNotice=Дані користувача не можна видалити, оскільки інше встановлення VCMI використовує той самий каталог.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Відвідати офіційний Discord VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Запустити VCMI Launcher
ShortcutMapEditor=Редактор Карт VCMI
ShortcutMapEditorComment=Відкрити Редактор Карт VCMI
ShortcutWebPage=Офіційний сайт VCMI
ShortcutWebPageComment=Відвідати офіційний сайт VCMI
SystemIntegration=Інтеграція з системою
FileAssociations=Асоціації файлів
AssociateH3CFiles=Відкривати кампанії Heroes III (.h3c) у редакторі карт VCMI
H3CDescription=Кампанія Heroes III
Uninstall=Видалити
UserDataDirectory=Дані користувача (дані Heroes III, модифікації, мапи та інші файли)
VCMISettings=Налаштування системи
VCMPDescription=Файл кампанії VCMI
VMAPDescription=Файл карти VCMI
Warning=Попередження
X86On64BitWarning=Ви встановлюєте 32-розрядну версію (x86) VCMI у 64-розрядній Windows. Це підтримується, але за наявності рекомендовано використовувати нативну 64-розрядну версію.
Heroes3ImportReparsePoint=Неможливо безпечно імпортувати дані Heroes III: наявна цільова папка містить точку з'єднання або символічне посилання. Видаліть посилання або виберіть іншу папку.
OpenSetupLog=Відкрити реєстр налаштування
OpenSetupLogError=Не вдалося відкрити реєстр налаштування.
LegacyUninstallStartFailed=Не вдалося запустити попередню програму видалення VCMI:%n%s
LegacyUninstallExitFailed=Попередня програма видалення VCMI завершилася з кодом помилки %s.
LegacyUninstallFailureChoice=Перервати — зупинити встановлення. Повторити — знову запустити стару програму видалення. Ігнорувати — продовжити на власний ризик.
LegacyUninstallRequired=Не вдалося видалити попереднє встановлення VCMI. Нові інсталяційні файли не були скопійовані.
InstallDirectoryUsedByOtherInstallation=Справочник установки перекривається з іншим зареєстрованим VCMI установка:%n%s%n%nВиберіть інший каталог.
X86OnARM64Warning=Ви встановлюєте 32-бітний (x86) версії VCMI на ARM64 Windows. Це підтримується, але рідній ARM64 рекомендується версія, коли вона є доступна.
RequirementsColumnComponent=Компонент
RequirementsColumnDetails=Необхідний
RequirementsColumnStatus=Статус
RequirementsColumnDetected=Ваша система
RequirementDetectedWindows=Сумісна установка Windows
RequirementWritableValue=Папка доступна для запису
RequirementEnoughSpace=Достатньо вільного місця
RequirementProcessor=Процесор
RequirementProcessorValue=1 ГГц або швидше
RequirementMemory=Оперативна пам'ять
RequirementMemoryValue=1 ГБ оперативної пам'яті
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Середовище виконання DirectX 11 доступне
RequirementDirectXMissing=Середовище виконання DirectX 11 не знайдено
RequirementDetectionUnavailable=Не вдалося визначити
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Папка встановлення
RequirementUserDataFolder=Папка даних користувача
RequirementDiskSpace=Вільний простір на диску
RequirementFreeSpaceShortValue=%s
RequirementInternet=Інтернет
RequirementRecommended=Рекомендується
RequirementInternetAvailable=Доступна
RequirementInternetUnavailable=Не виявлено
RequirementHeroesData=Дані Heroes III
RequirementRequiredToPlay=Потрібно для гри
RequirementHeroesDataAvailable=Знайдено в даних користувача
RequirementHeroesDataMissing=Не знайдено; може бути імпортовано пізніше
RequirementWritableAndSynced=Написаний і синхронізований
RequirementNotWritable=Запис недоступний
TasksCheckboxesTooltip=Виберіть додаткові дії та інтеграції. Ярлики спрощують доступ, файлові асоціації відкривають підтримувані карти в редакторі, правила брандмауера дозволяють мережеву гру, а імпорт копіює знайдені дані Heroes III.
UninstallCheckboxesTooltip=Позначте лише ті папки даних користувача, які потрібно видалити назавжди. Недоступні спільні папки використовує інше встановлення VCMI.
InstallModeTooltip=Усі користувачі: встановлює VCMI для всіх облікових записів Windows, зазвичай у Program Files. Потребує прав адміністратора. Створює загальносистемні відомості про видалення, записи реєстру, ярлики, файлові асоціації та необов'язкове правило брандмауера. Дані залишаються у вибраній папці.%n%nПоточний користувач: встановлює VCMI лише для поточного облікового запису Windows, зазвичай у Local AppData, без прав адміністратора. Створює деінсталятор та інтеграції для цього користувача. Інші облікові записи не бачитимуть цього встановлення. Під час першого використання мережевої гри брандмауер Windows може запросити дозвіл.%n%nПереносне встановлення: зберігає програму й дані разом у вибраній папці. Не створює деінсталятора, записів реєстру, ярликів, файлових асоціацій чи правил брандмауера. Папка має залишатися доступною для запису. Перемістіть або скопіюйте її для перенесення встановлення; видаліть її для видалення програми.
CopyH3FilesTooltip=Копіює знайдені папки Heroes III Data, Maps і Mp3 до вибраної папки даних користувача VCMI. Початкові файли залишаються без змін.
ReadyHeroes3Import=Імпорт даних Heroes III:
