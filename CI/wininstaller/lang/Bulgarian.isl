;
; Bulgarian.isl, part of VCMI engine
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
HelpTextNote=Параметри за инсталиране на VCMI:%n  /USERDATADIR=<path>  Задава папката с потребителски данни на VCMI. Префиксът expand: разгръща константите на Inno Setup.%n  /ALLOWCLOUDTARGET=1  Позволява папка за инсталиране или данни, синхронизирана с облака, при тиха инсталация.%n  /PORTABLE=1  Инсталира приложението и данните заедно без деинсталатор, промени в регистъра, преки пътища, файлови асоциации или правила на защитната стена.%n  /LAUNCH  Стартира VCMI след инсталиране, включително при тиха инсталация.%n  /COPYH3DATA=0|1  Включва или изключва автоматичното копиране на откритите данни на Heroes III.%n%nИмена на задачи за /TASKS и /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (само инсталация за всички потребители с администраторски права)%n%nПараметър на деинсталатора на VCMI:%n  /DELETEUSERDATA=1  Изтрива всички зададени потребителски папки на VCMI. Действа само заедно с /SILENT или /VERYSILENT. Това не може да бъде отменено.%n%nСтандартните параметри са описани по-горе: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Тази програма не може да работи на вашата версия на Windows. Моля, уверете се, че използвате правилната Windows архитектура (x86 / x64 / ARM64) и версия за тази програма.
PrivilegesRequiredOverrideTitle=Изискват се администраторски права
PrivilegesRequiredOverrideInstruction=Изберете как да стартирате инсталатора
PrivilegesRequiredOverrideText1=%1 изисква администраторски права за инсталиране за всички потребители. Можете също така да инсталирате само за вашия акаунт без администраторски привилегии.
PrivilegesRequiredOverrideText2=%1 може да се инсталира само за вашия акаунт (не са необходими администраторски права) или за всички потребители (изискват се администраторски права).
PrivilegesRequiredOverrideAllUsers=Стартирайте като &администратор (инсталирайте за всички потребители)
PrivilegesRequiredOverrideAllUsersRecommended=Стартирай като &администратор (препоръчително)
PrivilegesRequiredOverrideCurrentUser=Стартирай като &стандартен потребител (инсталирай само за мен)
PrivilegesRequiredOverrideCurrentUserRecommended=Изпълнение като &стандартен потребител (препоръчително)
ConfirmUninstall=Сигурни ли сте, че искате да стартирате съветника за деинсталиране на %1?

[CustomMessages]
DesktopShortcuts=Преки пътища на работния плот
StartMenuShortcuts=Преки пътища в менюто „Старт“
WelcomeDescription=VCMI е енджин с отворен код за Heroes III с нови и разширени възможности. За да използвате VCMI, трябва да притежавате оригиналните файлове с данни на играта.%n%nТози съветник ще инсталира VCMI - Open Heroes 3 на вашето устройство.%n%nПрепоръчва се да затворите всички други приложения, преди да продължите.%n%nЩракнете върху Напред, за да продължите, или Отказ, за да излезете от инсталацията.
WelcomeHighlightsTitle=За VCMI
WelcomeHighlights=VCMI е разработена от общността нова реализация на двигателя на Heroes of Might and Magic III. Проектът запазва духа на оригиналната игра, преодолява техническите ограничения на класическия двигател и предоставя отворена основа за модификации и бъдещо развитие.
RequirementImportSpaceHelp=Върнете се и изберете друга папка за потребителски данни или изключете автоматичното копиране на данните от Heroes III.
RequirementDisableImportQuestion=Искате ли да продължите без копиране на данните от Heroes III?
RequirementFirewall=Защитна стена
RequirementMultiplayerGames=Мултиплейър игри
RequirementSelected=Избрано
RequirementNotSelected=Не е избрано — играта на един компютър ще работи
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Добавяне на правила на защитната стена за мултиплейър игри
AssociateH3MFiles=Свържете .h3m файлове с редактора на карти VCMI
AssociateVCMIMapFiles=Свържете .vmap и .vcmp файлове с редактора на карти VCMI
CacheDirectory=Кеш памет
CloudDataNotice=Тази папка с потребителски данни вероятно се синхронизира с облачно хранилище.
CloudDataWarning=Избраната папка с потребителски данни вероятно се синхронизира с облачно хранилище. Синхронизирането може временно да заключи файлове и да попречи на инсталирането на модификации, стартирането на играта или записването.%n%nИскате ли все пак да използвате тази папка?
CloudInstallNotice=Тази инсталационна директория изглежда е синхронизирана от доставчик на облачно хранилище.
CloudInstallWarning=Избраната инсталационна директория изглежда е синхронизирана от доставчик на облачно хранилище. Преносима или синхронизирана инсталация може да се провали, когато доставчикът временно заключи файловете на приложението.%n%nИскате ли все пак да използвате тази директория?
CloudTargetSilentError=Тихата инсталация не може да използва папка, синхронизирана с облака, без /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Неуспешно копиране на файловете на Heroes III (%s). Някои файлове може вече да са копирани; можете безопасно да повторите импортирането.
CopyingHeroes3Data=Копиране на данни на Heroes III...
ConfigDirectory=Конфигурация
CopyH3Files=Копирайте автоматично необходимите Heroes III файлове в VCMI
CreateDesktopShortcuts=Създайте преки пътища на работния плот
CreateStartMenuShortcuts=Създайте преки пътища в менюто "Старт".
DataFolderDescription=Съхранява копие на данните на Heroes III, модификации, карти, запазени игри и други потребителски файлове.
DataFolderTitle=Папка с потребителски данни
DeleteUserData=Изтриване на потребителски данни
DeleteUserDataDescription=Изберете папки, които да изтриете за постоянно. Непроверените папки ще бъдат запазени. Това не може да бъде отменено.
DeletingUserData=Изтриване на потребителски данни...
DirectoryConfigWriteError=Настройките на потребителските папки не могат да бъдат записани в %s. Инсталацията не може да продължи безопасно.
DirectoryNotWritable=В избраната папка (%s) не може да се записва. Изберете друга папка или стартирайте инсталацията с необходимите права.%n%n%s
DirectoryRootNotAllowed=Избраната папка (%s) не може да е корен на диск или мрежов ресурс. Изберете отделна папка.%n%n%s
DirectoryOverlapError=Папките за инсталация и потребителски данни не трябва да съвпадат или да се припокриват опасно. Само преносима инсталация може да съхранява данни в папката за инсталация.
ReadyUserDataLocation=Местоположение на потребителските данни:
RequirementPassed=ИЗПЪЛНЕНО
RequirementFailed=ГРЕШКА
RequirementWarning=ПРЕДУПРЕЖДЕНИЕ
RequirementInfo=ИНФОРМАЦИЯ
RequirementOperatingSystem=Операционна система
RequirementOperatingSystemValue=Windows 7 SP1 или по-нова версия; при нужда е включена среда за съвместимост
RequirementArchitecture=Архитектура
RequirementInstallWritable=Инсталационната папка е достъпна за запис
RequirementDataWritable=Потребителската папка е достъпна за запис
RequirementDirectoryLayout=Оформление на директорията
RequirementDirectoryLayoutValue=Пътищата за инсталация и данни са безопасно разделени
RequirementApplicationSpace=Дисково пространство на приложението
RequirementFreeSpaceValue=%s МБ свободни; инсталаторът проверява и окончателния размер на пакета
RequirementHeroesDataSpace=Импортиране на Heroes III
RequirementInsufficientSpace=Недостатъчно свободно място за импортиране на избраните данни на Heroes III
RequirementRequiredSpaceValue=Приблизително %s МБ са необходими за избраното импортиране
RequirementNotRequested=Импортирането на данни на Heroes III не е избрано
RequirementCloudStorage=Синхронизация на съхранението
RequirementCloudStorageValue=Изглежда, че избран път използва синхронизация в облак
RequirementLocalStorageValue=Избраните пътища изглежда използват локално хранилище
RequirementInstallationMode=Режим на инсталиране
RequirementModePortable=Преносим; без програма за деинсталиране, регистър или системна интеграция
RequirementModeAllUsers=Всички потребители
RequirementModeCurrentUser=Текущ потребител
RequirementUpgrade=съществуващата инсталация ще бъде обновена
RequirementsCheckTitle=Проверка на системните изисквания
RequirementsCheckDescription=Инсталационната програма провери избраната конфигурация преди инсталацията.
H3MDescription=Файл с карта на Heroes 3
InstallFolderTitle=Инсталационна папка
InstallForAllUsers=Инсталирайте за всички потребители
InstallForAllUsers1=Изисква администраторски привилегии
InstallForMeOnly=Инсталирайте само за мен
InstallForMeOnly1=Ще се появи подкана на защитната стена, когато стартирате играта за първи път
InstallForMeOnly2=LAN игрите няма да работят, ако правилото на защитната стена не може да бъде разрешено
InstallPortable=Преносим монтаж
InstallPortable1=Съхранява приложението и данните заедно без деинсталатор или системни промени
InstallPortable2=Не създава програма за деинсталиране и не променя регистъра и системната интеграция
LogsDirectory=трупи
ResetFoldersToDefault=Възстановяване по подразбиране
RunVCMILauncherAfterInstall=Стартирайте VCMI Launcher
SavesDirectory=Запазени игри
ScanningFiles=Търсене на файлове...
SelectSetupInstallModeDesc=VCMI може да се инсталира за всички потребители, само за вас или в преносим режим.
SelectSetupInstallModeSubTitle=Изберете предпочитания от вас режим на инсталиране:
SelectSetupInstallModeTitle=Изберете режим на инсталиране
SharedUserDataNotice=Данните не могат да бъдат изтрити, защото друга инсталация на VCMI използва същата папка.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Посетете официалния VCMI Discord
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Стартирайте VCMI Launcher
ShortcutMapEditor=VCMI Редактор на карти
ShortcutMapEditorComment=Отворете редактора на карти VCMI
ShortcutWebPage=VCMI уебсайт
ShortcutWebPageComment=Посетете официалния уебсайт на VCMI
SystemIntegration=Системна интеграция
FileAssociations=Файлови асоциации
AssociateH3CFiles=Отваряне на кампании Heroes III (.h3c) в редактора на карти VCMI
H3CDescription=Кампания Heroes III
Uninstall=Деинсталиране
UserDataDirectory=Потребителски данни (данни на Heroes III, модификации, карти и други файлове)
VCMISettings=Системна конфигурация
VCMPDescription=Файл на кампанията VCMI
VMAPDescription=VCMI Картографски файл
Warning=Предупреждение
X86On64BitWarning=Вие инсталирате 32-битовата (x86) версия на VCMI на 64-битов Windows. Това се поддържа, но родната 64-битова версия се препоръчва, когато е налична.
Heroes3ImportReparsePoint=Данните на Heroes III не могат да бъдат импортирани безопасно, защото съществуваща целева папка съдържа съединение или символна връзка. Премахнете връзката или изберете друга папка.
OpenSetupLog=Отворете регистрационния файл за настройка
OpenSetupLogError=Регистърът за настройка не можа да бъде отворен.
LegacyUninstallStartFailed=Предишният деинсталатор на VCMI не може да бъде стартиран:%n%s
LegacyUninstallExitFailed=Предишният деинсталатор на VCMI завърши с код за грешка %s.
LegacyUninstallFailureChoice=Прекратяване спира инсталацията. Повторен опит стартира отново стария деинсталатор. Игнориране продължава на ваша отговорност.
LegacyUninstallRequired=Предишната инсталация на VCMI не може да бъде премахната. Не са копирани нови инсталационни файлове.
InstallDirectoryUsedByOtherInstallation=Инсталационната директория припокрива друга регистрирана VCMI инсталация: %n%s%n%nИзберете друга директория.
X86OnARM64Warning=Вие инсталирате 32-битовата (x86) версия на VCMI на ARM64 Windows. Това се поддържа, но родната версия ARM64 се препоръчва, когато е налична.
RequirementsColumnComponent=Компонент
RequirementsColumnDetails=Задължително
RequirementsColumnStatus=Статус
RequirementsColumnDetected=Вашата система
RequirementDetectedWindows=Съвместима инсталация на Windows
RequirementWritableValue=Папка с достъп за запис
RequirementEnoughSpace=Достатъчно свободно място
RequirementProcessor=Процесор
RequirementProcessorValue=1 GHz или по-бърз
RequirementMemory=Оперативна памет
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Средата за изпълнение DirectX 11 е налична
RequirementDirectXMissing=Средата за изпълнение DirectX 11 не е намерена
RequirementDetectionUnavailable=Не може да се открие
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Инсталационна папка
RequirementUserDataFolder=Папка с потребителски данни
RequirementDiskSpace=Свободно дисково пространство
RequirementFreeSpaceShortValue=%s
RequirementInternet=Интернет
RequirementRecommended=Препоръчва се
RequirementInternetAvailable=Наличен
RequirementInternetUnavailable=Не е открит
RequirementHeroesData=Данни на Heroes III
RequirementRequiredToPlay=Необходимо за игра
RequirementHeroesDataAvailable=Налични в потребителските данни
RequirementHeroesDataMissing=Не е намерено; могат да бъдат импортирани по-късно
RequirementWritableAndSynced=Записваем и синхронизиран
RequirementNotWritable=Записът е забранен
TasksCheckboxesTooltip=Изберете незадължителни интеграции и действия. Преките пътища улесняват достъпа, файловите асоциации отварят поддържаните карти в редактора, правилата на защитната стена позволяват мрежова игра, а импортирането копира откритите данни на Heroes III.
UninstallCheckboxesTooltip=Отбележете само папките с потребителски данни, които искате да изтриете окончателно. Забранените споделени записи се използват от друга инсталация на VCMI.
InstallModeTooltip=Всички потребители: инсталира VCMI за всички акаунти в Windows, обикновено в Program Files. Изисква администраторски права. Създава общосистемна информация за деинсталиране, записи в регистъра, преки пътища, файлови асоциации и незадължително правило на защитната стена. Данните остават в избраната папка.%n%nТекущ потребител: инсталира VCMI само за влезлия в Windows акаунт, обикновено в Local AppData, без администраторски права. Създава деинсталатор и интеграции за този потребител. Другите акаунти няма да виждат тази инсталация. При първото използване на мрежова игра защитната стена на Windows може да поиска разрешение.%n%nПреносима инсталация: съхранява приложението и данните заедно в избраната папка. Не създава деинсталатор, записи в регистъра, преки пътища, файлови асоциации или правила на защитната стена. Папката трябва да остава достъпна за запис. Преместете или копирайте я, за да прехвърлите инсталацията, или я изтрийте, за да деинсталирате.
CopyH3FilesTooltip=Копира откритите папки Data, Maps и Mp3 на Heroes III в избраната папка с потребителски данни на VCMI. Оригиналните файлове остават непроменени.
ReadyHeroes3Import=Импортиране на данни на Heroes III:
