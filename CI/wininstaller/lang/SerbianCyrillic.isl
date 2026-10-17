;
; SerbianCyrillic.isl, part of VCMI engine
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
HelpTextNote=Параметри инсталације VCMI:%n  /USERDATADIR=<path>  Поставља фасциклу са корисничким подацима VCMI. Префикс expand: развија константе Inno Setup.%n  /ALLOWCLOUDTARGET=1  Дозвољава фасциклу за инсталацију или податке синхронизовану са облаком током тихе инсталације.%n  /PORTABLE=1  Инсталира програм и податке заједно без деинсталатора, измена регистра, пречица, придруживања датотека или правила заштитног зида.%n  /LAUNCH  Покреће VCMI након инсталације, укључујући тиху инсталацију.%n  /COPYH3DATA=0|1  Укључује или искључује аутоматско копирање пронађених података Heroes III.%n%nНазиви задатака за /TASKS и /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (само инсталација за све кориснике са администраторским правима)%n%nПараметар деинсталације VCMI:%n  /DELETEUSERDATA=1  Брише све подешене корисничке фасцикле VCMI. Важи само уз /SILENT или /VERYSILENT. Ова радња се не може поништити.%n%nСтандардни параметри су описани изнад: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Овај програм не може да се покреће на Вашој верзији Виндовса.x86 / x64 / ARM64) и верзија за овај програм.
PrivilegesRequiredOverrideTitle=Потребна су администраторска права
PrivilegesRequiredOverrideInstruction=Изаберите начин покретања инсталатора
PrivilegesRequiredOverrideText1=За инсталацију %1 за све кориснике потребна су администраторска права. Можете инсталирати програм само за свој налог без тих права.
PrivilegesRequiredOverrideText2=%1 може да се инсталира само за ваш налог без администраторских права или за све кориснике са администраторским правима.
PrivilegesRequiredOverrideAllUsers=Покрени као &администратор (инсталација за све кориснике)
PrivilegesRequiredOverrideAllUsersRecommended=Покрени као &администратор (препоручено)
PrivilegesRequiredOverrideCurrentUser=Покрени као &стандардни корисник (само за мене)
PrivilegesRequiredOverrideCurrentUserRecommended=Покрени као &стандардни корисник (препоручено)
ConfirmUninstall=Да ли си сигуран да желиш да водиш %1 Увођење Уизорда?

[CustomMessages]
DesktopShortcuts=Пречице на радној површини
StartMenuShortcuts=Пречице у менију Старт
WelcomeDescription=VCMI је мотор отвореног кода за Heroes III са новим и проширеним могућностима. За коришћење VCMI морате поседовати изворне датотеке са подацима игре.%n%nОвај чаробњак ће инсталирати VCMI - Open Heroes 3 на ваш уређај.%n%nПрепоручује се да затворите све остале апликације пре него што наставите.%n%nКликните на Даље за наставак или на Откажи за излаз из инсталације.
WelcomeHighlightsTitle=О VCMI-ју
WelcomeHighlights=VCMI је нова имплементација мотора Heroes of Might and Magic III коју развија заједница. Пројекат чува дух оригиналне игре, превазилази техничка ограничења класичног мотора и пружа отворену основу за модификације и даљи развој.
RequirementImportSpaceHelp=Вратите се и изаберите другу фасциклу корисничких података или искључите аутоматско копирање података Heroes III.
RequirementDisableImportQuestion=Желите ли да наставите без копирања података Heroes III?
RequirementFirewall=Заштитни зид
RequirementMultiplayerGames=Игре за више играча
RequirementSelected=Изабрано
RequirementNotSelected=Није изабрано — игра на истом рачунару ће радити
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Додај правила заштитног зида за игре за више играча
AssociateH3MFiles=Одружити .h3m датотеке са VCMI Редактор мапе
AssociateVCMIMapFiles=Одружити .vmap и .vcmp датотеке са VCMI Редактор мапе
CacheDirectory=Каше
CloudDataNotice=Овај справочник података корисника изгледа синхронизован од стране провајдера облачног складиштења.
CloudDataWarning=Избрани справочник података корисника се чини да је синхронизован од стране провајдера облачног складиштења. Синхронизација може привремено блокирати датотеке и изазвати инсталацију мода, покретање игре или неуспех спасења.%n%nХоћеш ли да користиш овај справочник?
CloudInstallNotice=Овај директориј за инсталацију изгледа синхронизован од стране провајдера облачног складиштења.
CloudInstallWarning=Избрана директорија за инсталацију се чини да је синхронизована од стране провајдера облачног складиштења.%n%nХоћеш ли да користиш овај справочник?
CloudTargetSilentError=Тиха инсталација не може да користи фасциклу синхронизовану са облаком без /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Није могуће копирати датотеке Heroes III (%s). Неке датотеке су можда већ копиране; можете безбедно поновити увоз.
CopyingHeroes3Data=Копирање података Heroes III...
ConfigDirectory=Конфигурација
CopyH3Files=Аутоматска копија потребна Heroes III датотеке до VCMI
CreateDesktopShortcuts=Стварити пресконце за десктоп
CreateStartMenuShortcuts=Стварање прескочина за Менју почетка
DataFolderDescription=Схрањује копију обезбеђеног Heroes III податке, модификације, мапе, спасана игре и друге корисничке датотеке.
DataFolderTitle=Фолдер података корисника
DeleteUserData=Избришајте податке корисника
DeleteUserDataDescription=Изаберете папки које ћете трајно избрисати. Неконтролисане папки ће се чувати. Ово се не може укинути.
DeletingUserData=Брисање корисничких података...
DirectoryConfigWriteError=Није могуће сачувати подешавања корисничких фасцикли у %s. Инсталација не може безбедно да се настави.
DirectoryNotWritable=У изабрану фасциклу (%s) није могуће уписивати. Изаберите другу фасциклу или покрените инсталацију са потребним правима.%n%n%s
DirectoryRootNotAllowed=Изабрана фасцикла (%s) не може бити корен диска или мрежног дељења. Изаберите посебну фасциклу.%n%n%s
DirectoryOverlapError=Фасцикле за инсталацију и корисничке податке не смеју бити исте нити се небезбедно преклапати. Само преносива инсталација може чувати податке у фасцикли за инсталацију.
ReadyUserDataLocation=Локација корисничких података:
RequirementPassed=ИСПУЊЕНО
RequirementFailed=ГРЕШКА
RequirementWarning=УПОЗОРЕЊЕ
RequirementInfo=ИНФОРМАЦИЈЕ
RequirementOperatingSystem=Оперативни систем
RequirementOperatingSystemValue=Windows 7 SP1 или новији; окружење за компатибилност је укључено када је потребно
RequirementArchitecture=Архитектура
RequirementInstallWritable=Инсталациона фасцикла дозвољава упис
RequirementDataWritable=Корисничка фасцикла дозвољава упис
RequirementDirectoryLayout=Директорски распоред
RequirementDirectoryLayoutValue=Путање инсталације и корисничких података су безбедно раздвојене
RequirementApplicationSpace=Простор апликације на диску
RequirementFreeSpaceValue=%s МБ слободно; инсталатор проверава и коначну величину пакета
RequirementHeroesDataSpace=Увоз података Heroes III
RequirementInsufficientSpace=Нема довољно слободног простора за увоз изабраних података Heroes III
RequirementRequiredSpaceValue=За изабрани увоз потребно је приближно %s МБ
RequirementNotRequested=Увоз података Heroes III није изабран
RequirementCloudStorage=Синхронизација складиштења
RequirementCloudStorageValue=Избрани пут се чини да користи синхронизацију облака
RequirementLocalStorageValue=Избрани путеви се појављују као да користе локално складиштење
RequirementInstallationMode=Режим инсталације
RequirementModePortable=Портабилни; нема деинсталлера, регистра или системске интеграције
RequirementModeAllUsers=Сви корисници
RequirementModeCurrentUser=Актуелни корисник
RequirementUpgrade=постојећа инсталација ће бити надограђена
RequirementsCheckTitle=Проверка системских захтева
RequirementsCheckDescription=Наређење је проверило одабрану конфигурацију пре инсталирања.
H3MDescription=Хероес 3 Карта Файл
InstallFolderTitle=Папка за инсталирање
InstallForAllUsers=Инсталирање за све кориснике
InstallForAllUsers1=Потребно је административне привилегије
InstallForMeOnly=Инсталирајте само за мене.
InstallForMeOnly1=Појавио ће се пожарни зид при покретању игре први пут.
InstallForMeOnly2=Игра у локалној мрежи неће радити ако приступ није дозвољен кроз заштитни зид
InstallPortable=Портабилна инсталација
InstallPortable1=Држе апликацију и корисничке податке заједно у једном папчику
InstallPortable2=Не креира деинсталлер или мења регистар и системску интеграцију
LogsDirectory=Логови
ResetFoldersToDefault=Ресетовање на дефолт
RunVCMILauncherAfterInstall=Попустите VCMI Попуштач
SavesDirectory=Счуване игре
ScanningFiles=Тражење датотека...
SelectSetupInstallModeDesc=VCMI може да се инсталира за све кориснике, само за вас или у преносивом режиму.
SelectSetupInstallModeSubTitle=Изаберете пожељан режим инсталације:
SelectSetupInstallModeTitle=Изаберите режим инсталације
SharedUserDataNotice=Додаци корисника се не могу избрисати јер је друга VCMI инсталација користи исти справочник.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Посетите званичника. VCMI Разбијање
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Попустите VCMI Попуштач
ShortcutMapEditor=VCMI Редактор мапе
ShortcutMapEditorComment=Отвори VCMI Редактор мапе
ShortcutWebPage=VCMI Веб сајт
ShortcutWebPageComment=Посетите званичника. VCMI веб локација
SystemIntegration=Интеграција система
FileAssociations=Асоцијације датотека
AssociateH3CFiles=Отварај кампање Heroes III (.h3c) у VCMI уређивачу мапа
H3CDescription=Heroes III кампања
Uninstall=Деинсталирајте
UserDataDirectory=Подаци корисника (Heroes III подаци, модификације, мапе и друге датотеке)
VCMISettings=Подешавање система
VCMPDescription=VCMI Файл кампање
VMAPDescription=VCMI Файл мапе
Warning=Предупређење
X86On64BitWarning=Инсталирате 32-битну (x86) верзије VCMI Ово се подржава, али се препоручује матична 64-битна верзија када је доступна.
Heroes3ImportReparsePoint=Подаци Heroes III не могу безбедно да се увезу јер постојећа циљна фасцикла садржи спојницу или симболичку везу. Уклоните везу или изаберите другу фасциклу.
OpenSetupLog=Отворите регистар подешавања
OpenSetupLogError=Не може се отворити часопис за подешавање.
LegacyUninstallStartFailed=Није могуће покренути претходни деинсталатор VCMI:%n%s
LegacyUninstallExitFailed=Претходни деинсталатор VCMI је завршен са кодом грешке %s.
LegacyUninstallFailureChoice=Прекини зауставља инсталацију. Покушај поново поново покреће стари деинсталатор. Занемари наставља на вашу одговорност.
LegacyUninstallRequired=Није могуће уклонити претходну инсталацију VCMI. Нове инсталационе датотеке нису копиране.
InstallDirectoryUsedByOtherInstallation=Инсталацијски справочник се преклапа са другим регистрованим VCMI инсталација:%n%s%n%nИзаберите другачију директорију.
X86OnARM64Warning=Инсталирате 32-битну (x86) верзије VCMI на ARM64 Windows. Ово је поддржано, али је изворна ARM64 Рекомендује се верзија када је доступна.
RequirementsColumnComponent=Компонент
RequirementsColumnDetails=Потребно
RequirementsColumnStatus=Статус
RequirementsColumnDetected=Ваш систем
RequirementDetectedWindows=Компатибилна инсталација Виндовса
RequirementWritableValue=Фасцикла дозвољава упис
RequirementEnoughSpace=Довољно слободног простора
RequirementProcessor=Процесор
RequirementProcessorValue=1 ГГц или брже
RequirementMemory=Радна меморија
RequirementMemoryValue=1 ГБ оперативног простора
RequirementMemoryDetected=%s МБ Рама
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Извршно окружење DirectX 11 је доступно
RequirementDirectXMissing=Извршно окружење DirectX 11 није пронађено
RequirementDetectionUnavailable=Није могуће открити
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Инсталациона фасцикла
RequirementUserDataFolder=Фасцикла корисничких података
RequirementDiskSpace=Слободан простор на диску
RequirementFreeSpaceShortValue=%s
RequirementInternet=Интернет
RequirementRecommended=Препоручује се
RequirementInternetAvailable=Доступна
RequirementInternetUnavailable=Не откривено
RequirementHeroesData=Подаци Heroes III
RequirementRequiredToPlay=Неопходно за играње
RequirementHeroesDataAvailable=Доступни у корисничким подацима
RequirementHeroesDataMissing=Не пронађено; може се увећи касније
RequirementWritableAndSynced=Списано и синхронизовано
RequirementNotWritable=Упис није дозвољен
TasksCheckboxesTooltip=Изаберите необавезне интеграције и радње. Пречице олакшавају приступ, придруживања датотека отварају подржане мапе у уређивачу, правила заштитног зида омогућавају мрежну игру, а увоз копира пронађене податке Heroes III.
UninstallCheckboxesTooltip=Означите само фасцикле корисничких података које желите трајно да обришете. Онемогућене дељене ставке користи друга инсталација VCMI.
InstallModeTooltip=Сви корисници: инсталира VCMI за све Windows налоге, обично у Program Files. Захтева администраторска права. Прави системске податке о деинсталацији, ставке регистра, пречице, придруживања датотека и необавезно правило заштитног зида. Подаци остају у изабраној фасцикли.%n%nТренутни корисник: инсталира VCMI само за пријављени Windows налог, обично у Local AppData, без администраторских права. Прави деинсталатор и интеграције за тог корисника. Други налози неће видети ову инсталацију. Заштитни зид Windows може затражити дозволу при првом коришћењу мрежне игре.%n%nПреносива инсталација: чува програм и податке заједно у изабраној фасцикли. Не прави деинсталатор, ставке регистра, пречице, придруживања датотека нити правила заштитног зида. Фасцикла мора остати доступна за упис. Преместите је или копирајте да пренесете инсталацију; обришите је да деинсталирате програм.
CopyH3FilesTooltip=Копира пронађене фасцикле Data, Maps и Mp3 игре Heroes III у изабрану фасциклу корисничких података VCMI. Изворне датотеке остају непромењене.
ReadyHeroes3Import=Увоз података Heroes III:
