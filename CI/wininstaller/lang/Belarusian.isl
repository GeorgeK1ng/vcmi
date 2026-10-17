;
; Belarusian.isl, part of VCMI engine
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
HelpTextNote=Параметры ўсталёўкі VCMI:%n  /USERDATADIR=<path>  Задае каталог даных карыстальніка VCMI. Прэфікс expand: разгортвае канстанты Inno Setup.%n  /ALLOWCLOUDTARGET=1  Дазваляе выкарыстоўваць каталог усталёўкі або даных, сінхранізаваны з воблакам, пры ціхай усталёўцы.%n  /PORTABLE=1  Усталёўвае праграму і даныя разам без дэінсталятара, змяненняў рэестра, цэтлікаў, асацыяцый файлаў і правілаў брандмаўэра.%n  /LAUNCH  Запускае VCMI пасля ўсталёўкі, у тым ліку ціхай.%n  /COPYH3DATA=0|1  Уключае або выключае аўтаматычнае капіраванне знойдзеных даных Heroes III.%n%nНазвы задач для /TASKS і /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (толькі ўсталёўка для ўсіх карыстальнікаў з правамі адміністратара)%n%nПараметр дэінсталятара VCMI:%n  /DELETEUSERDATA=1  Выдаляе ўсе настроеныя каталогі карыстальніка VCMI. Дзейнічае толькі разам з /SILENT або /VERYSILENT. Гэта немагчыма адмяніць.%n%nСтандартныя параметры апісаны вышэй: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Гэта праграма не можа працаваць у вашай версіі Windows. Пераканайцеся, што вы выкарыстоўваеце правільную архітэктуру Windows (x86 / x64 / ARM64) і версію гэтай праграмы.
PrivilegesRequiredOverrideTitle=Патрабуюцца прывілеі адміністратара
PrivilegesRequiredOverrideInstruction=Выберыце, як запусціць праграму ўстаноўкі
PrivilegesRequiredOverrideText1=%1 патрабуе правоў адміністратара для ўстаноўкі для ўсіх карыстальнікаў. Вы таксама можаце ўсталяваць толькі для свайго ўліковага запісу без правоў адміністратара.
PrivilegesRequiredOverrideText2=%1 можна ўсталяваць толькі для вашага ўліковага запісу без правоў адміністратара або для ўсіх карыстальнікаў з правамі адміністратара.
PrivilegesRequiredOverrideAllUsers=Запуск ад &адміністратара (усталяваць для ўсіх карыстальнікаў)
PrivilegesRequiredOverrideAllUsersRecommended=Запуск ад &адміністратара (рэкамендуецца)
PrivilegesRequiredOverrideCurrentUser=Запуск як &стандартны карыстальнік (усталяваць толькі для мяне)
PrivilegesRequiredOverrideCurrentUserRecommended=Запуск як &стандартны карыстальнік (рэкамендуецца)
ConfirmUninstall=Вы ўпэўнены, што хочаце запусціць майстар выдалення %1?

[CustomMessages]
DesktopShortcuts=Ярлыкі на працоўным стале
StartMenuShortcuts=Ярлыкі ў меню «Пуск»
WelcomeDescription=VCMI — рухавік з адкрытым зыходным кодам для Heroes III з новымі і пашыранымі магчымасцямі. Для выкарыстання VCMI неабходна мець арыгінальныя файлы даных гульні.%n%nГэты майстар усталюе VCMI - Open Heroes 3 на вашу прыладу.%n%nПерад працягам рэкамендуецца закрыць усе іншыя праграмы.%n%nНацісніце «Далей», каб працягнуць, або «Адмена», каб выйсці з праграмы ўсталявання.
WelcomeHighlightsTitle=Пра VCMI
WelcomeHighlights=VCMI — распрацаваная супольнасцю новая рэалізацыя рухавіка Heroes of Might and Magic III. Праект захоўвае дух арыгінальнай гульні, пераадольвае тэхнічныя абмежаванні класічнага рухавіка і дае адкрытую аснову для мадыфікацый і далейшага развіцця.
RequirementImportSpaceHelp=Вярніцеся і выберыце іншую папку карыстальніцкіх даных або адключыце аўтаматычнае капіраванне даных Heroes III.
RequirementDisableImportQuestion=Працягнуць без капіравання даных Heroes III?
RequirementFirewall=Брандмаўэр
RequirementMultiplayerGames=Шматкарыстальніцкія гульні
RequirementSelected=Выбрана
RequirementNotSelected=Не выбрана — гульня за адным камп'ютарам будзе працаваць
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Дадаць правілы брандмаўэра для шматкарыстальніцкіх гульняў
AssociateH3MFiles=Звязаць файлы .h3m з рэдактарам карт VCMI
AssociateVCMIMapFiles=Звязаць файлы .vmap і .vcmp з рэдактарам карт VCMI
CacheDirectory=Кэш
CloudDataNotice=Гэтая папка даных карыстальніка, верагодна, сінхранізуецца з воблачным сховішчам.
CloudDataWarning=Выбраная папка даных карыстальніка, верагодна, сінхранізуецца з воблачным сховішчам. Сінхранізацыя можа часова блакіраваць файлы і перашкаджаць усталёўцы мадыфікацый, запуску гульні або захаванню.%n%nУсё роўна выкарыстоўваць гэтую папку?
CloudInstallNotice=Здаецца, гэты каталог усталёўкі сінхранізаваны пастаўшчыком воблачнага сховішча.
CloudInstallWarning=Здаецца, абраны каталог усталёўкі сінхранізаваны пастаўшчыком воблачнага сховішча. Пераносная або сінхранізаваная ўстаноўка можа не атрымацца, калі пастаўшчык часова блакуе файлы прыкладання.%n%nВы ўсё роўна хочаце выкарыстоўваць гэты каталог?
CloudTargetSilentError=Ціхая ўсталёўка не можа выкарыстоўваць сінхранізаваную з воблакам папку без /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Не ўдалося скапіраваць файлы Heroes III (%s). Частка файлаў ужо магла быць скапіраваная; імпарт можна бяспечна паўтарыць.
CopyingHeroes3Data=Капіраванне даных Heroes III...
ConfigDirectory=Канфігурацыя
CopyH3Files=Аўтаматычна капіраваць неабходныя файлы Heroes III у VCMI
CreateDesktopShortcuts=Стварэнне ярлыкоў на працоўным стале
CreateStartMenuShortcuts=Стварэнне цэтлікаў у меню "Пуск".
DataFolderDescription=Захоўвае копію даных Heroes III, мадыфікацыі, карты, захаваныя гульні і іншыя файлы карыстальніка.
DataFolderTitle=Папка даных карыстальніка
DeleteUserData=Выдаліць даныя карыстальніка
DeleteUserDataDescription=Выберыце папкі для канчатковага выдалення. Неправераныя тэчкі будуць захаваны. Гэта нельга адмяніць.
DeletingUserData=Выдаленне даных карыстальніка...
DirectoryConfigWriteError=Не ўдалося захаваць налады папак карыстальніка ў %s. Усталёўка не можа бяспечна працягвацца.
DirectoryNotWritable=Выбраная папка (%s) недаступная для запісу. Выберыце іншую папку або запусціце ўсталёўку з патрэбнымі правамі.%n%n%s
DirectoryRootNotAllowed=Выбраная папка (%s) не можа быць коранем дыска ці сеткавага рэсурсу. Выберыце асобную папку.%n%n%s
DirectoryOverlapError=Папкі ўсталёўкі і даных карыстальніка не павінны супадаць або небяспечна перакрывацца. Толькі пераносная ўсталёўка можа захоўваць даныя ў папцы ўсталёўкі.
ReadyUserDataLocation=Размяшчэнне даных карыстальніка:
RequirementPassed=ВЫКАНАНА
RequirementFailed=ПАМЫЛКА
RequirementWarning=ПАПЯРЭДЖАННЕ
RequirementInfo=ІНФАРМАЦЫЯ
RequirementOperatingSystem=Аперацыйная сістэма
RequirementOperatingSystemValue=Windows 7 SP1 або навей; пры неабходнасці ўключаецца асяроддзе выканання сумяшчальнасці
RequirementArchitecture=Архітэктура
RequirementInstallWritable=Папка ўсталёўкі даступная для запісу
RequirementDataWritable=Папка даных карыстальніка даступная для запісу
RequirementDirectoryLayout=Макет каталога
RequirementDirectoryLayoutValue=Шляхі ўсталёўкі і даных карыстальніка бяспечна падзеленыя
RequirementApplicationSpace=Прастора на дыску прыкладання
RequirementFreeSpaceValue=Вольна %s МБ; усталёўшчык таксама правярае канчатковы памер пакета
RequirementHeroesDataSpace=Імпарт Heroes III
RequirementInsufficientSpace=Недастаткова вольнага месца для імпарту выбраных даных Heroes III
RequirementRequiredSpaceValue=Для выбранага імпарту патрабуецца прыблізна %s МБ
RequirementNotRequested=Імпарт даных Heroes III не выбраны
RequirementCloudStorage=Сінхранізацыя сховішча
RequirementCloudStorageValue=З'яўляецца выбраны шлях для выкарыстання воблачнай сінхранізацыі
RequirementLocalStorageValue=Здаецца, выбраныя шляхі выкарыстоўваюць лакальнае сховішча
RequirementInstallationMode=Рэжым ўстаноўкі
RequirementModePortable=партатыўны; без дэінсталятара, рэестра або сістэмнай інтэграцыі
RequirementModeAllUsers=Усе карыстальнікі
RequirementModeCurrentUser=Бягучы карыстальнік
RequirementUpgrade=існая ўсталёўка будзе абноўлена
RequirementsCheckTitle=Праверка сістэмных патрабаванняў
RequirementsCheckDescription=Праграма ўстаноўкі правярала выбраную канфігурацыю перад устаноўкай.
H3MDescription=Файл карты герояў 3
InstallFolderTitle=Тэчка ўстаноўкі
InstallForAllUsers=Усталяваць для ўсіх карыстальнікаў
InstallForAllUsers1=Патрабуецца адміністрацыйныя прывілеі
InstallForMeOnly=Усталяваць толькі для мяне
InstallForMeOnly1=Пры першым запуску гульні з'явіцца запыт брандмаўэра
InstallForMeOnly2=Гульні па лакальнай сетцы не будуць працаваць, калі правіла брандмаўэра не дазволена
InstallPortable=Пераносная ўстаноўка
InstallPortable1=Захоўвае праграму і даныя карыстальніка разам без дэінсталятара і змяненняў сістэмы
InstallPortable2=Не стварае праграму выдалення і не змяняе рэестр і сістэмную інтэграцыю
LogsDirectory=Лагі
ResetFoldersToDefault=Скід па змаўчанні
RunVCMILauncherAfterInstall=Запусціце праграму запуску VCMI
SavesDirectory=Захаваныя гульні
ScanningFiles=Пошук файлаў...
SelectSetupInstallModeDesc=VCMI можна ўсталяваць для ўсіх карыстальнікаў, толькі для вас або ў пераносным рэжыме.
SelectSetupInstallModeSubTitle=Выберыце жаданы рэжым усталёўкі:
SelectSetupInstallModeTitle=Абярыце рэжым ўстаноўкі
SharedUserDataNotice=Даныя карыстальніка нельга выдаліць, бо гэтую папку выкарыстоўвае іншая ўсталёўка VCMI.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Наведайце афіцыйны VCMI Discord
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Запусціце праграму запуску VCMI
ShortcutMapEditor=Рэдактар ​​карт VCMI
ShortcutMapEditorComment=Адкрыйце рэдактар ​​карт VCMI
ShortcutWebPage=Вэб-сайт VCMI
ShortcutWebPageComment=Наведайце афіцыйны сайт VCMI
SystemIntegration=Сістэмная інтэграцыя
FileAssociations=Асацыяцыі файлаў
AssociateH3CFiles=Адкрываць кампаніі Heroes III (.h3c) у рэдактары карт VCMI
H3CDescription=Кампанія Heroes III
Uninstall=Выдаліць
UserDataDirectory=Даныя карыстальніка (даныя Heroes III, мадыфікацыі, карты і іншыя файлы)
VCMISettings=Канфігурацыя сістэмы
VCMPDescription=VCMI Файл кампаніі
VMAPDescription=Файл карты VCMI
Warning=Папярэджанне
X86On64BitWarning=Вы ўсталёўваеце 32-бітную (x86) версію VCMI на 64-бітную Windows. Гэта падтрымліваецца, але рэкамендуецца родная 64-бітная версія, калі яна даступная.
Heroes3ImportReparsePoint=Немагчыма бяспечна імпартаваць даныя Heroes III: існая мэтавая папка змяшчае пункт злучэння або сімвалічную спасылку. Выдаліце спасылку або выберыце іншую папку.
OpenSetupLog=Адкрыць журнал налад
OpenSetupLogError=Не ўдалося адкрыць журнал усталёўкі.
LegacyUninstallStartFailed=Не ўдалося запусціць папярэдні дэінсталятар VCMI:%n%s
LegacyUninstallExitFailed=Папярэдні дэінсталятар VCMI завяршыўся з кодам памылкі %s.
LegacyUninstallFailureChoice=Перапыніць — спыніць усталёўку. Паўтарыць — зноў запусціць стары дэінсталятар. Ігнараваць — працягнуць на ўласную рызыку.
LegacyUninstallRequired=Не ўдалося выдаліць папярэднюю ўсталёўку VCMI. Новыя ўсталявальныя файлы не былі скапіраваны.
InstallDirectoryUsedByOtherInstallation=Каталог усталёўкі перакрывае іншую зарэгістраваную ўстаноўку VCMI:%n%s%n%nВыберыце іншы каталог.
X86OnARM64Warning=Вы ўсталёўваеце 32-бітную (x86) версію VCMI на ARM64 Windows. Гэта падтрымліваецца, але пры наяўнасці рэкамендуецца родная версія ARM64.
RequirementsColumnComponent=Кампанент
RequirementsColumnDetails=абавязковы
RequirementsColumnStatus=Статус
RequirementsColumnDetected=Ваша сістэма
RequirementDetectedWindows=Сумяшчальная ўстаноўка Windows
RequirementWritableValue=Папка даступная для запісу
RequirementEnoughSpace=Дастаткова вольнага месца
RequirementProcessor=Працэсар
RequirementProcessorValue=1 Ггц або хутчэй
RequirementMemory=Аператыўная памяць
RequirementMemoryValue=1 ГБ аператыўнай памяці
RequirementMemoryDetected=%s МБ аператыўнай памяці
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Асяроддзе выканання DirectX 11 даступнае
RequirementDirectXMissing=Асяроддзе выканання DirectX 11 не знойдзена
RequirementDetectionUnavailable=Не ўдалося вызначыць
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Папка ўсталёўкі
RequirementUserDataFolder=Папка даных карыстальніка
RequirementDiskSpace=Вольнае месца на дыску
RequirementFreeSpaceShortValue=%s
RequirementInternet=Інтэрнэт
RequirementRecommended=Рэкамендуецца
RequirementInternetAvailable=Даступны
RequirementInternetUnavailable=Не выяўлена
RequirementHeroesData=Даныя Heroes III
RequirementRequiredToPlay=Неабходна для гульні
RequirementHeroesDataAvailable=Знойдзены ў даных карыстальніка
RequirementHeroesDataMissing=Не знойдзены; можна імпартаваць пазней
RequirementWritableAndSynced=Можна запісваць і сінхранізаваць
RequirementNotWritable=Запіс недаступны
TasksCheckboxesTooltip=Выберыце дадатковыя дзеянні і інтэграцыі. Цэтлікі спрашчаюць доступ, асацыяцыі файлаў адкрываюць падтрыманыя карты ў рэдактары, правілы брандмаўэра дазваляюць сеткавую гульню, а імпарт капіруе знойдзеныя даныя Heroes III.
UninstallCheckboxesTooltip=Пазначце толькі тыя папкі даных карыстальніка, якія трэба выдаліць назаўсёды. Недаступныя агульныя папкі выкарыстоўваюцца іншай усталёўкай VCMI.
InstallModeTooltip=Усе карыстальнікі: усталёўвае VCMI для ўсіх уліковых запісаў Windows, звычайна ў Program Files. Патрабуе правоў адміністратара. Стварае агульнасістэмныя звесткі аб выдаленні, запісы рэестра, цэтлікі, асацыяцыі файлаў і неабавязковае правіла брандмаўэра. Даныя застаюцца ў выбранай папцы.%n%nБягучы карыстальнік: усталёўвае VCMI толькі для бягучага ўліковага запісу Windows, звычайна ў Local AppData, без правоў адміністратара. Стварае дэінсталятар і інтэграцыі для гэтага карыстальніка. Іншыя ўліковыя запісы не ўбачаць гэтую ўсталёўку. Пры першым выкарыстанні сеткавай гульні брандмаўэр Windows можа запытаць дазвол.%n%nПераносная ўсталёўка: захоўвае праграму і даныя разам у выбранай папцы. Не стварае дэінсталятар, запісы рэестра, цэтлікі, асацыяцыі файлаў і правілы брандмаўэра. Папка павінна заставацца даступнай для запісу. Перамясціце або скапіруйце яе для пераносу ўсталёўкі; выдаліце яе для выдалення праграмы.
CopyH3FilesTooltip=Капіруе знойдзеныя папкі Heroes III Data, Maps і Mp3 у выбраную папку даных карыстальніка VCMI. Зыходныя файлы застаюцца нязменнымі.
ReadyHeroes3Import=Імпарт даных Heroes III:
