; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=VCMI 专用安装参数：%n  /USERDATADIR=<路径>  设置 VCMI 用户数据目录。使用 expand: 前缀可展开 Inno Setup 常量。%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  将应用和数据安装在一起，不创建卸载程序，也不修改注册表、快捷方式、文件关联或防火墙规则。%n  /LAUNCH  安装后启动 VCMI，包括静默安装。%n%nVCMI 卸载程序参数：%n  /DELETEUSERDATA=1  删除所有已配置的 VCMI 用户目录。仅与 /SILENT 或 /VERYSILENT 一起使用时生效。此操作无法撤销。%n%n/DIR、/LANG、/TASKS、/CURRENTUSER、/ALLUSERS、/SILENT、/VERYSILENT、/SUPPRESSMSGBOXES、/NORESTART 和 /LOG 等标准参数已在上方说明。
WindowsVersionNotSupported=此程序无法在您的 Windows 版本上运行。请确保您使用的是正确的 Windows 架构（32 位或 64 位）和此程序的正确版本。
PrivilegesRequiredOverrideTitle=安装模式 - 权限选择
PrivilegesRequiredOverrideInstruction=请选择如何运行安装程序
PrivilegesRequiredOverrideText1=%1 需要管理员权限才能为所有用户安装。%n您也可以仅为当前账户安装，无需管理员权限。
PrivilegesRequiredOverrideText2=%1 可以仅为当前账户安装（无需管理员权限），或为所有用户安装（需要管理员权限）。
PrivilegesRequiredOverrideAllUsers=以管理员身份运行(&A)（为所有用户安装）
PrivilegesRequiredOverrideAllUsersRecommended=以管理员身份运行(&A)（推荐）
PrivilegesRequiredOverrideCurrentUser=以普通用户身份运行(&M)（仅为我安装）
PrivilegesRequiredOverrideCurrentUserRecommended=以普通用户身份运行(&M)（推荐）
ConfirmUninstall=您确定要运行 %1 卸载向导吗？

[CustomMessages]
AddFirewallRules=为 VCMI 添加防火墙规则
AssociateH3MFiles=将 .h3m 文件与 VCMI 地图编辑器关联
AssociateVCMIMapFiles=将 .vmap 和 .vcmp 文件与 VCMI 地图编辑器关联
CacheDirectory=缓存
CloudDataNotice=此用户数据目录似乎由云存储服务同步。
CloudDataWarning=所选用户数据目录似乎由云存储服务同步。同步过程可能会暂时锁定文件，并导致模组安装、游戏启动或存档失败。%n%n仍要使用此目录吗？
CloudInstallNotice=此安装目录似乎由云存储服务同步。
CloudInstallWarning=所选安装目录似乎由云存储服务同步。如果服务暂时锁定应用程序文件，便携式或同步安装可能会失败。%n%n仍要使用此目录吗？
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=配置
CopyH3Files=自动将 Heroes III 所需文件复制到 VCMI
CreateDesktopShortcuts=创建桌面快捷方式
CreateStartMenuShortcuts=创建开始菜单快捷方式
DataFolderDescription=存储所提供 Heroes III 数据的副本、模组、地图、游戏存档和其他用户文件。
DataFolderTitle=用户数据文件夹
DeleteUserData=删除用户数据
DeleteUserDataDescription=选择要永久删除的文件夹。未勾选的文件夹将会保留。此操作无法撤销。
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
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
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI 可以为所有用户或仅为您安装。
SelectSetupInstallModeSubTitle=选择您的首选安装模式：
SelectSetupInstallModeTitle=选择安装模式
SharedUserDataNotice=无法删除用户数据，因为另一个 VCMI 安装正在使用同一目录。
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=访问 VCMI 官方 Discord
ShortcutLauncher=VCMI 启动器
ShortcutLauncherComment=启动 VCMI 启动器
ShortcutMapEditor=VCMI 地图编辑器
ShortcutMapEditorComment=打开 VCMI 地图编辑器
ShortcutWebPage=VCMI 网站
ShortcutWebPageComment=访问 VCMI 官方网站
SystemIntegration=系统集成
Uninstall=卸载
UserDataDirectory=用户数据（Heroes III 数据、模组、地图和其他文件）
VCMISettings=VCMI 配置
VCMPDescription=VCMI 战役文件
VMAPDescription=VCMI 地图文件
Warning=警告
X86On64BitWarning=您正在 64 位 Windows 上安装 32 位 (x86) VCMI。此配置受支持，但如果有原生 64 位版本，建议优先使用。
