;
; ChineseSimplified.isl, part of VCMI engine
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
HelpTextNote=VCMI 安装参数：%n  /USERDATADIR=<path>  设置 VCMI 用户数据文件夹。使用 expand: 前缀可展开 Inno Setup 常量。%n  /ALLOWCLOUDTARGET=1  允许在静默安装时使用与云端同步的安装文件夹或用户数据文件夹。%n  /PORTABLE=1  将应用程序和用户数据安装在一起，不创建卸载程序，不修改注册表，也不创建快捷方式、文件关联或防火墙规则。%n  /LAUNCH  安装后启动 VCMI，包括静默安装。%n  /COPYH3DATA=0|1  启用或禁用自动复制检测到的 Heroes III 数据。%n%n用于 /TASKS 和 /MERGETASKS 的任务名称：%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (仅适用于具有管理员权限的所有用户安装)%n%nVCMI 卸载参数：%n  /DELETEUSERDATA=1  删除所有已配置的 VCMI 用户文件夹。仅与 /SILENT 或 /VERYSILENT 一起使用时生效。此操作无法撤销。%n%n标准参数已在上方说明： /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=此程序无法在您的 Windows 版本上运行。请确保您使用的是正确的 Windows 架构（32 位或 64 位）和此程序的正确版本。 (x86 / x64 / ARM64)
PrivilegesRequiredOverrideTitle=安装模式 - 权限选择
PrivilegesRequiredOverrideInstruction=请选择如何运行安装程序
PrivilegesRequiredOverrideText1=%1 需要管理员权限才能为所有用户安装。 您也可以仅为当前账户安装，无需管理员权限。
PrivilegesRequiredOverrideText2=%1 可以仅为当前账户安装（无需管理员权限），或为所有用户安装（需要管理员权限）。
PrivilegesRequiredOverrideAllUsers=以管理员身份运行(&A)（为所有用户安装）
PrivilegesRequiredOverrideAllUsersRecommended=以管理员身份运行(&A)（推荐）
PrivilegesRequiredOverrideCurrentUser=以普通用户身份运行(&M)（仅为我安装）
PrivilegesRequiredOverrideCurrentUserRecommended=以普通用户身份运行(&M)（推荐）
ConfirmUninstall=您确定要运行 %1 卸载向导吗？

[CustomMessages]
DesktopShortcuts=桌面快捷方式
StartMenuShortcuts=开始菜单快捷方式
WelcomeDescription=VCMI 是 Heroes III 的开源引擎，提供新的功能并扩展原有体验。使用 VCMI 需要拥有游戏的原始数据文件。%n%n此向导将在您的设备上安装 VCMI - Open Heroes 3。%n%n建议在继续之前关闭所有其他应用程序。%n%n单击“下一步”继续，或单击“取消”退出安装程序。
WelcomeHighlightsTitle=关于 VCMI
WelcomeHighlights=VCMI 是由社区开发的《英雄无敌 III》引擎重新实现。该项目旨在保留原作精神，突破经典引擎的技术限制，并为模组和持续开发提供开放基础。
RequirementImportSpaceHelp=返回并选择其他用户数据文件夹，或取消自动复制《英雄无敌 III》数据。
RequirementDisableImportQuestion=是否继续而不复制《英雄无敌 III》数据？
RequirementFirewall=防火墙
RequirementMultiplayerGames=多人游戏
RequirementSelected=已选择
RequirementNotSelected=未选择 — 仍可在同一台计算机上轮流游戏
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=为多人游戏添加防火墙规则
AssociateH3MFiles=将 .h3m 文件与 VCMI 地图编辑器关联
AssociateVCMIMapFiles=将 .vmap 和 .vcmp 文件与 VCMI 地图编辑器关联
CacheDirectory=缓存
CloudDataNotice=此用户数据目录似乎由云存储服务同步。
CloudDataWarning=所选用户数据目录似乎由云存储服务同步。同步过程可能会暂时锁定文件，并导致模组安装、游戏启动或存档失败。%n%n仍要使用此目录吗？
CloudInstallNotice=此安装目录似乎由云存储服务同步。
CloudInstallWarning=所选安装目录似乎由云存储服务同步。如果服务暂时锁定应用程序文件，便携式或同步安装可能会失败。%n%n仍要使用此目录吗？
CloudTargetSilentError=静默安装无法使用与云端同步的目标，除非指定 /ALLOWCLOUDTARGET=1。
CopyH3FilesError=无法复制 Heroes III 文件（%s）。部分文件可能已复制；您可以安全地重新执行导入。
CopyingHeroes3Data=正在复制 Heroes III 数据...
ConfigDirectory=配置
CopyH3Files=自动将 Heroes III 所需文件复制到 VCMI
CreateDesktopShortcuts=创建桌面快捷方式
CreateStartMenuShortcuts=创建开始菜单快捷方式
DataFolderDescription=存储所提供 Heroes III 数据的副本、模组、地图、游戏存档和其他用户文件。
DataFolderTitle=用户数据文件夹
DeleteUserData=删除用户数据
DeleteUserDataDescription=选择要永久删除的文件夹。未勾选的文件夹将会保留。此操作无法撤销。
DeletingUserData=正在删除用户数据...
DirectoryConfigWriteError=无法将用户文件夹配置保存到 %s。安装无法安全继续。
DirectoryNotWritable=无法写入所选文件夹（%s）。请选择其他文件夹，或使用所需权限运行安装程序。%n%n%s
DirectoryRootNotAllowed=所选文件夹（%s）不能是驱动器或网络共享的根目录。请选择专用文件夹。%n%n%s
DirectoryOverlapError=安装文件夹与用户数据文件夹不能相同或存在不安全的包含关系。只有便携安装可以将用户数据放在安装文件夹中。
ReadyUserDataLocation=用户数据位置：
RequirementPassed=通过
RequirementFailed=失败
RequirementWarning=警告
RequirementInfo=信息
RequirementOperatingSystem=操作系统
RequirementOperatingSystemValue=Windows 7 SP1 或更高版本；需要时包含兼容性运行时
RequirementArchitecture=体系结构
RequirementInstallWritable=安装文件夹可写入
RequirementDataWritable=用户数据文件夹可写入
RequirementDirectoryLayout=目录布局
RequirementDirectoryLayoutValue=安装路径与用户数据路径已安全分离
RequirementApplicationSpace=应用程序磁盘空间
RequirementFreeSpaceValue=%s MB 可用；安装程序还会检查最终安装包的大小
RequirementHeroesDataSpace=Heroes III 数据导入
RequirementInsufficientSpace=没有足够的可用空间来导入所选 Heroes III 数据
RequirementRequiredSpaceValue=所选导入大约需要 %s MB
RequirementNotRequested=未选择导入 Heroes III 数据
RequirementCloudStorage=存储同步
RequirementCloudStorageValue=选定的路径似乎使用云同步
RequirementLocalStorageValue=选定的路径似乎使用本地存储
RequirementInstallationMode=安装方式
RequirementModePortable=便携的;没有卸载程序、注册表或系统集成
RequirementModeAllUsers=所有用户
RequirementModeCurrentUser=当前用户
RequirementUpgrade=将升级现有安装
RequirementsCheckTitle=系统要求检查
RequirementsCheckDescription=安装程序在安装前检查了所选的配置。
H3MDescription=Heroes 3 地图文件
InstallFolderTitle=安装文件夹
InstallForAllUsers=为所有用户安装
InstallForAllUsers1=需要管理员权限
InstallForMeOnly=仅为我安装
InstallForMeOnly1=首次启动游戏时会出现防火墙提示
InstallForMeOnly2=如果无法允许防火墙规则，则局域网游戏将无法运行
InstallPortable=便携式安装
InstallPortable1=将应用程序和用户数据保存在同一个文件夹中
InstallPortable2=不创建卸载程序，也不修改注册表或系统集成
LogsDirectory=日志
ResetFoldersToDefault=恢复默认值
RunVCMILauncherAfterInstall=启动 VCMI 启动器
SavesDirectory=游戏存档
ScanningFiles=正在扫描文件...
SelectSetupInstallModeDesc=VCMI 可以为所有用户安装、仅为您安装，或以便携模式安装。
SelectSetupInstallModeSubTitle=选择您的首选安装模式：
SelectSetupInstallModeTitle=选择安装模式
SharedUserDataNotice=无法删除用户数据，因为另一个 VCMI 安装正在使用同一目录。
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=访问 VCMI 官方 Discord
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=启动 VCMI 启动器
ShortcutMapEditor=VCMI 地图编辑器
ShortcutMapEditorComment=打开 VCMI 地图编辑器
ShortcutWebPage=VCMI 网站
ShortcutWebPageComment=访问 VCMI 官方网站
SystemIntegration=系统集成
FileAssociations=文件关联
AssociateH3CFiles=在 VCMI 地图编辑器中打开 Heroes III 战役文件 (.h3c)
H3CDescription=Heroes III 战役
Uninstall=卸载
UserDataDirectory=用户数据（Heroes III 数据、模组、地图和其他文件）
VCMISettings=系统配置
VCMPDescription=VCMI 战役文件
VMAPDescription=VCMI 地图文件
Warning=警告
X86On64BitWarning=您正在 64 位 Windows 上安装 32 位 (x86) VCMI。此配置受支持，但如果有原生 64 位版本，建议优先使用。
Heroes3ImportReparsePoint=无法安全导入 Heroes III 数据，因为现有目标文件夹包含目录联接或符号链接。请移除链接或选择其他文件夹。
OpenSetupLog=打开设置日志
OpenSetupLogError=无法打开安装日志。
LegacyUninstallStartFailed=无法启动旧版 VCMI 卸载程序：%n%s
LegacyUninstallExitFailed=旧版 VCMI 卸载程序失败，退出代码为 %s。
LegacyUninstallFailureChoice=“中止”会停止安装。“重试”会重新运行旧版卸载程序。“忽略”会继续安装，风险由您自行承担。
LegacyUninstallRequired=无法移除旧版 VCMI 安装。未复制任何新的安装文件。
InstallDirectoryUsedByOtherInstallation=安装目录与另一个注册的VCMI安装重叠：%n%s%n%n选择不同的目录。
X86OnARM64Warning=您正在 ARM64 Windows 上安装 32 位 (x86) 版本的 VCMI。这是受支持的，但建议使用本机 ARM64 版本（如果可用）。
RequirementsColumnComponent=成分
RequirementsColumnDetails=必需的
RequirementsColumnStatus=地位
RequirementsColumnDetected=您的系统
RequirementDetectedWindows=兼容Windows安装
RequirementWritableValue=可写入的文件夹
RequirementEnoughSpace=可用空间充足
RequirementProcessor=处理器
RequirementProcessorValue=1 GHz 或更快
RequirementMemory=内存
RequirementMemoryValue=1 GB 内存
RequirementMemoryDetected=%s MB 内存
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11 运行库可用
RequirementDirectXMissing=未找到 DirectX 11 运行库
RequirementDetectionUnavailable=无法检测
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=安装文件夹
RequirementUserDataFolder=用户数据文件夹
RequirementDiskSpace=可用磁盘空间
RequirementFreeSpaceShortValue=%s
RequirementInternet=互联网
RequirementRecommended=受到推崇的
RequirementInternetAvailable=可用的
RequirementInternetUnavailable=未检测到
RequirementHeroesData=Heroes III 数据
RequirementRequiredToPlay=游戏运行必需
RequirementHeroesDataAvailable=已在用户数据中找到
RequirementHeroesDataMissing=未找到;可以稍后导入
RequirementWritableAndSynced=可写且同步
RequirementNotWritable=不可写入
TasksCheckboxesTooltip=选择可选集成和操作。快捷方式便于访问，文件关联可在编辑器中打开支持的地图，防火墙规则允许多人游戏，导入功能会复制检测到的 Heroes III 数据。
UninstallCheckboxesTooltip=仅勾选要永久删除的用户数据文件夹。已禁用的共享项目正被另一套 VCMI 安装使用。
InstallModeTooltip=所有用户：为所有 Windows 帐户安装 VCMI，通常位于 Program Files。需要管理员批准。创建系统级卸载信息、注册表项、快捷方式、文件关联和可选的防火墙规则。用户数据保留在所选文件夹中。%n%n当前用户：仅为当前登录的 Windows 帐户安装 VCMI，通常位于 Local AppData，无需管理员批准。为该用户创建卸载程序和集成。其他帐户不会看到此安装。首次使用多人游戏时，Windows 防火墙可能请求许可。%n%n便携安装：将应用程序和用户数据放在所选文件夹中。不创建卸载程序、注册表项、快捷方式、文件关联或防火墙规则。文件夹必须保持可写。移动或复制文件夹即可转移安装，删除文件夹即可卸载。
CopyH3FilesTooltip=将检测到的 Heroes III 文件夹 Data、Maps 和 Mp3 复制到所选 VCMI 用户数据文件夹。原始文件保持不变。
ReadyHeroes3Import=Heroes III 数据导入：
