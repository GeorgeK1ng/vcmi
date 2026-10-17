;
; ChineseTraditional.isl, part of VCMI engine
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
HelpTextNote=VCMI 安裝參數：%n  /USERDATADIR=<path>  設定 VCMI 使用者資料夾。使用 expand: 前綴可展開 Inno Setup 常數。%n  /ALLOWCLOUDTARGET=1  允許在無訊息安裝時使用與雲端同步的安裝資料夾或使用者資料夾。%n  /PORTABLE=1  將應用程式和使用者資料安裝在一起，不建立解除安裝程式、不修改登錄，也不建立捷徑、檔案關聯或防火牆規則。%n  /LAUNCH  安裝後啟動 VCMI，包括無訊息安裝。%n  /COPYH3DATA=0|1  啟用或停用自動複製偵測到的 Heroes III 資料。%n%n用於 /TASKS 和 /MERGETASKS 的工作名稱：%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (僅適用於具有系統管理員權限的所有使用者安裝)%n%nVCMI 解除安裝參數：%n  /DELETEUSERDATA=1  刪除所有已設定的 VCMI 使用者資料夾。僅與 /SILENT 或 /VERYSILENT 一起使用時生效。此操作無法復原。%n%n標準參數已在上方說明： /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=此程式無法在您的 Windows 版本上執行。請確認程式適用於您的 Windows 架構（x86 / x64 / ARM64）及版本。
PrivilegesRequiredOverrideTitle=需要系統管理員權限
PrivilegesRequiredOverrideInstruction=選擇執行安裝程式的方式
PrivilegesRequiredOverrideText1=為所有使用者安裝 %1 需要系統管理員權限。您也可以不使用系統管理員權限，僅為自己的帳戶安裝。
PrivilegesRequiredOverrideText2=%1 可以僅為您的帳戶安裝（不需系統管理員權限），或為所有使用者安裝（需要系統管理員權限）。
PrivilegesRequiredOverrideAllUsers=以系統管理員身分執行(&A)（為所有使用者安裝）
PrivilegesRequiredOverrideAllUsersRecommended=以系統管理員身分執行(&A)（建議）
PrivilegesRequiredOverrideCurrentUser=以標準使用者身分執行(&S)（僅為自己安裝）
PrivilegesRequiredOverrideCurrentUserRecommended=以標準使用者身分執行(&S)（建議）
ConfirmUninstall=確定要執行 %1 解除安裝精靈嗎？

[CustomMessages]
DesktopShortcuts=桌面捷徑
StartMenuShortcuts=開始功能表捷徑
WelcomeDescription=VCMI 是 Heroes III 的開源引擎，提供新功能並擴充原有體驗。使用 VCMI 需要擁有遊戲的原始資料檔案。%n%n此精靈將在您的裝置上安裝 VCMI - Open Heroes 3。%n%n建議您先關閉所有其他應用程式再繼續。%n%n按「下一步」繼續，或按「取消」結束安裝程式。
WelcomeHighlightsTitle=關於 VCMI
WelcomeHighlights=VCMI 是由社群開發的《英雄無敵 III》引擎重新實作。此專案旨在保留原作精神、突破經典引擎的技術限制，並為模組與持續開發提供開放基礎。
RequirementImportSpaceHelp=返回並選擇其他使用者資料資料夾，或取消自動複製《英雄無敵 III》資料。
RequirementDisableImportQuestion=是否繼續而不複製《英雄無敵 III》資料？
RequirementFirewall=防火牆
RequirementMultiplayerGames=多人遊戲
RequirementSelected=已選取
RequirementNotSelected=未選擇 — 仍可在同一部電腦上輪流遊戲
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=為多人遊戲新增防火牆規則
AssociateH3MFiles=將 .h3m 檔案關聯至 VCMI 地圖編輯器
AssociateVCMIMapFiles=將 .vmap 和 .vcmp 檔案關聯至 VCMI 地圖編輯器
CacheDirectory=快取
CloudDataNotice=這份使用者數據目錄似乎由雲端存儲提供商同步.
CloudDataWarning=選擇的使用者數據目錄似乎由雲端存儲提供商同步.同步可能暫時鎖定檔案,導致模組安裝,遊戲啟動或儲存故障.%n%n您是否想使用這個目錄?
CloudInstallNotice=這個安裝目錄似乎是由雲端儲存提供商同步的.
CloudInstallWarning=選擇的安裝目錄似乎由雲端存儲提供商同步. 當提供商暫時鎖定應用程式檔案時,便携式或同步安裝可能會故障.%n%n你還是想使用這個目錄嗎?
CloudTargetSilentError=無訊息安裝無法使用與雲端同步的目標，除非指定 /ALLOWCLOUDTARGET=1。
CopyH3FilesError=無法複製 Heroes III 檔案（%s）。部分檔案可能已複製；您可以安全地重新執行匯入。
CopyingHeroes3Data=正在複製 Heroes III 資料...
ConfigDirectory=設定
CopyH3Files=將 Heroes III 檔案複製到 VCMI 資料夾
CreateDesktopShortcuts=建立桌面捷徑
CreateStartMenuShortcuts=建立開始功能表捷徑
DataFolderDescription=儲存 Heroes III 資料的副本、模組、地圖、遊戲存檔和其他使用者檔案。
DataFolderTitle=使用者資料夾
DeleteUserData=刪除使用者資料
DeleteUserDataDescription=選擇要永久刪除的資料夾。未勾選的資料夾將會保留。此操作無法復原。
DeletingUserData=正在刪除使用者資料...
DirectoryConfigWriteError=無法將使用者資料夾設定儲存至 %s。安裝無法安全繼續。
DirectoryNotWritable=無法寫入所選資料夾（%s）。請選擇其他資料夾，或以所需權限執行安裝程式。%n%n%s
DirectoryRootNotAllowed=所選資料夾（%s）不能是磁碟機或網路共用的根目錄。請選擇專用資料夾。%n%n%s
DirectoryOverlapError=安裝資料夾與使用者資料夾不能相同或存在不安全的包含關係。只有可攜式安裝可以將使用者資料放在安裝資料夾中。
ReadyUserDataLocation=使用者資料位置：
RequirementPassed=通過
RequirementFailed=失敗
RequirementWarning=警告
RequirementInfo=資訊
RequirementOperatingSystem=操作系統
RequirementOperatingSystemValue=Windows 7 SP1 或更新版本；必要時包含相容性執行階段
RequirementArchitecture=架構
RequirementInstallWritable=安裝資料夾可寫入
RequirementDataWritable=使用者資料夾可寫入
RequirementDirectoryLayout=資料庫布局
RequirementDirectoryLayoutValue=安裝路徑與使用者資料路徑已安全分離
RequirementApplicationSpace=應用程式磁盤空間
RequirementFreeSpaceValue=%s MB 可用；安裝程式還會檢查最終安裝套件的大小
RequirementHeroesDataSpace=Heroes III 資料匯入
RequirementInsufficientSpace=沒有足夠的可用空間來匯入所選 Heroes III 資料
RequirementRequiredSpaceValue=所選匯入大約需要 %s MB
RequirementNotRequested=未選擇匯入 Heroes III 資料
RequirementCloudStorage=存儲同步
RequirementCloudStorageValue=選擇的路徑似乎使用雲端同步
RequirementLocalStorageValue=選擇的路徑顯示使用本地存儲
RequirementInstallationMode=裝置方式
RequirementModePortable=可攜式；無解除安裝程式、登錄變更或系統整合
RequirementModeAllUsers=所有使用者
RequirementModeCurrentUser=目前使用者
RequirementUpgrade=將升級現有的安裝
RequirementsCheckTitle=檢查系統要求
RequirementsCheckDescription=安裝程式已在安裝前檢查所選設定。
H3MDescription=英雄 3 地圖檔案
InstallFolderTitle=裝置文件
InstallForAllUsers=為所有使用者安裝
InstallForAllUsers1=需要系統管理員權限
InstallForMeOnly=只是為了我而安裝
InstallForMeOnly1=在首次啟動遊戲時會出現防火牆提示
InstallForMeOnly2=如果無法允許防火牆規則，區域網路遊戲將無法運作
InstallPortable=可攜式安裝
InstallPortable1=將應用程式與使用者資料放在一起，不建立解除安裝程式，也不變更系統
InstallPortable2=
LogsDirectory=記錄檔
ResetFoldersToDefault=預設重置
RunVCMILauncherAfterInstall=啟動 VCMI 啟動器
SavesDirectory=保存的遊戲
ScanningFiles=正在掃描檔案...
SelectSetupInstallModeDesc=VCMI 可以為所有使用者安裝、僅為您安裝，或以可攜式模式安裝。
SelectSetupInstallModeSubTitle=選擇您喜歡的安裝模式:
SelectSetupInstallModeTitle=選擇安裝模式
SharedUserDataNotice=無法刪除使用者資料，因為另一套 VCMI 安裝正在使用同一個資料夾。
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=建立前往 Discord 上 VCMI 官方社群的捷徑
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=建立啟動 VCMI、管理模組及設定遊戲的捷徑
ShortcutMapEditor=VCMI 地圖編輯器
ShortcutMapEditorComment=建立設計和編輯 Heroes III 及 VCMI 地圖的捷徑
ShortcutWebPage=VCMI 網站
ShortcutWebPageComment=建立前往 VCMI 官方網站和專案資源的捷徑
SystemIntegration=系統整合
FileAssociations=檔案關聯
AssociateH3CFiles=在 VCMI 地圖編輯器中開啟 Heroes III 戰役檔案 (.h3c)
H3CDescription=Heroes III 戰役
Uninstall=取消安裝
UserDataDirectory=使用者數據 (Heroes III 資料,修改,地圖和其他檔案)
VCMISettings=系統設定
VCMPDescription=VCMI 戰役
VMAPDescription=VCMI 地圖
Warning=警告
X86On64BitWarning=您正在安裝32位 (x86) 的版本 VCMI 在 64 位的 Windows 上. 這項支持, 但在可用時, 建議使用原生 64 位版本.
Heroes3ImportReparsePoint=無法安全匯入 Heroes III 資料，因為現有的目標資料夾包含目錄連接點或符號連結。請移除連結或選擇其他資料夾。
OpenSetupLog=打開設定日志
OpenSetupLogError=我們無法打開安裝日志.
LegacyUninstallStartFailed=無法啟動舊版 VCMI 解除安裝程式：%n%s
LegacyUninstallExitFailed=舊版 VCMI 解除安裝程式失敗，結束代碼為 %s。
LegacyUninstallFailureChoice=「中止」會停止安裝。「重試」會重新執行舊版解除安裝程式。「忽略」會繼續安裝，風險由您自行承擔。
LegacyUninstallRequired=無法移除舊版 VCMI 安裝。未複製任何新的安裝檔案。
InstallDirectoryUsedByOtherInstallation=裝置目錄覆蓋其他已註冊的目錄 VCMI 裝置:%n%s%n%n選擇不同的目錄.
X86OnARM64Warning=您正在安裝32位 (x86) 的版本 VCMI 在 ARM64 Windows 這個支持,但本土的 ARM64 在可用情況下,
RequirementsColumnComponent=組成部分
RequirementsColumnDetails=必須的
RequirementsColumnStatus=狀態
RequirementsColumnDetected=您的系統
RequirementDetectedWindows=兼容的Windows安裝
RequirementWritableValue=可寫入的資料夾
RequirementEnoughSpace=可用空間充足
RequirementProcessor=處理器
RequirementProcessorValue=1 GHz 或更快
RequirementMemory=記憶體
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11 執行階段可用
RequirementDirectXMissing=找不到 DirectX 11 執行階段
RequirementDetectionUnavailable=無法偵測
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=安裝資料夾
RequirementUserDataFolder=使用者資料夾
RequirementDiskSpace=磁碟空間
RequirementFreeSpaceShortValue=%s
RequirementInternet=網際網路
RequirementRecommended=推薦使用
RequirementInternetAvailable=可供使用
RequirementInternetUnavailable=沒有發現
RequirementHeroesData=Heroes III 資料
RequirementRequiredToPlay=執行遊戲所需
RequirementHeroesDataAvailable=已在使用者資料中找到
RequirementHeroesDataMissing=沒有找到;後來可以進口
RequirementWritableAndSynced=可寫和同步
RequirementNotWritable=無法寫入
TasksCheckboxesTooltip=選擇選用的整合和操作。捷徑方便存取，檔案關聯可在編輯器中開啟支援的地圖，防火牆規則允許多人遊戲，匯入功能會複製偵測到的 Heroes III 資料。
UninstallCheckboxesTooltip=僅勾選要永久刪除的使用者資料夾。已停用的共用項目正由另一套 VCMI 安裝使用。
InstallModeTooltip=所有使用者：為所有 Windows 帳戶安裝 VCMI，通常位於 Program Files。需要系統管理員核准。建立系統層級的解除安裝資訊、登錄項目、捷徑、檔案關聯和選用的防火牆規則。使用者資料保留在所選資料夾中。%n%n目前使用者：僅為目前登入的 Windows 帳戶安裝 VCMI，通常位於 Local AppData，不需系統管理員核准。為該使用者建立解除安裝程式和整合。其他帳戶不會看到此安裝。首次使用多人遊戲時，Windows 防火牆可能會要求許可。%n%n可攜式安裝：將應用程式和使用者資料放在所選資料夾中。不建立解除安裝程式、登錄項目、捷徑、檔案關聯或防火牆規則。資料夾必須保持可寫入。移動或複製資料夾即可轉移安裝，刪除資料夾即可解除安裝。
CopyH3FilesTooltip=將偵測到的 Heroes III 資料夾 Data、Maps 和 Mp3 複製到所選 VCMI 使用者資料夾。原始檔案保持不變。
ReadyHeroes3Import=Heroes III 資料匯入：
