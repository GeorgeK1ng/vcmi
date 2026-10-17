;
; Japanese.isl, part of VCMI engine
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
HelpTextNote=VCMI のインストールパラメーター：%n  /USERDATADIR=<path>  VCMI のユーザーデータフォルダーを指定します。expand: を先頭に付けると Inno Setup の定数を展開します。%n  /ALLOWCLOUDTARGET=1  サイレントインストールで、クラウドと同期されるインストール先またはユーザーデータフォルダーの使用を許可します。%n  /PORTABLE=1  アプリケーションとデータを一緒に配置し、アンインストーラー、レジストリの変更、ショートカット、ファイルの関連付け、ファイアウォール規則を作成しません。%n  /LAUNCH  サイレントインストールを含め、インストール後に VCMI を起動します。%n  /COPYH3DATA=0|1  検出された Heroes III データの自動コピーを有効または無効にします。%n%n/TASKS と /MERGETASKS で指定できるタスク名：%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (管理者権限でのすべてのユーザー向けインストールのみ)%n%nVCMI のアンインストールパラメーター：%n  /DELETEUSERDATA=1  設定済みの VCMI ユーザーフォルダーをすべて削除します。/SILENT または /VERYSILENT と併用した場合のみ有効です。この操作は元に戻せません。%n%n標準パラメーターについては上記を参照してください： /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=このプログラムは,Windowsのバージョンで実行できません.正しいWindowsアーキテクチャを使用していることを確認してください (x86 / x64 / ARM64) とこのプログラムのバージョン.
PrivilegesRequiredOverrideTitle=管理 者 の 特権 が 必要
PrivilegesRequiredOverrideInstruction=インストーラを実行する方法を選択します
PrivilegesRequiredOverrideText1=%1 をすべてのユーザー向けにインストールするには管理者権限が必要です。管理者権限なしで、自分のアカウントだけにインストールすることもできます。
PrivilegesRequiredOverrideText2=%1 は、自分のアカウントだけに管理者権限なしでインストールするか、すべてのユーザー向けに管理者権限でインストールできます。
PrivilegesRequiredOverrideAllUsers=管理者として実行(&A)（すべてのユーザー向け）
PrivilegesRequiredOverrideAllUsersRecommended=管理者として実行(&A)（推奨）
PrivilegesRequiredOverrideCurrentUser=標準ユーザーとして実行(&S)（自分だけにインストール）
PrivilegesRequiredOverrideCurrentUserRecommended=標準ユーザーとして実行(&S)（推奨）
ConfirmUninstall=実行したいと確信していますか? %1 ウィザードをアンインストールする?

[CustomMessages]
DesktopShortcuts=デスクトップ ショートカット
StartMenuShortcuts=スタート メニュー ショートカット
WelcomeDescription=VCMI は Heroes III に新しい機能と拡張された可能性を提供するオープンソースエンジンです。VCMI を使用するには、元のゲームのデータファイルを所有している必要があります。%n%nこのウィザードは VCMI - Open Heroes 3 をデバイスにインストールします。%n%n続行する前に、他のすべてのアプリケーションを終了することをお勧めします。%n%n続行するには「次へ」、セットアップを終了するには「キャンセル」をクリックしてください。
WelcomeHighlightsTitle=VCMI について
WelcomeHighlights=VCMI はコミュニティによって開発されている Heroes of Might and Magic III エンジンの再実装です。原作の精神を守り、従来のエンジンの技術的制約を克服し、Mod と継続的な開発のためのオープンな基盤を提供します。
RequirementImportSpaceHelp=戻って別のユーザーデータフォルダーを選択するか、Heroes III データの自動コピーを解除してください。
RequirementDisableImportQuestion=Heroes III データをコピーせずに続行しますか？
RequirementFirewall=ファイアウォール
RequirementMultiplayerGames=マルチプレイヤーゲーム
RequirementSelected=選択済み
RequirementNotSelected=未選択 — 同じコンピューターでの交代プレイは利用できます
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=マルチプレイヤーゲーム用のファイアウォール規則を追加
AssociateH3MFiles=. h3m ファイルと関連付け VCMI 地図編集者
AssociateVCMIMapFiles=.vmap と .vcmp ファイルを VCMI 地図編集者
CacheDirectory=キャッシュ
CloudDataNotice=このユーザーデータディレクトリはクラウドストレージプロバイダーによって同期されているようです.
CloudDataWarning=選択したユーザーデータディレクトリはクラウドストレージプロバイダーによって同期されているようです.同期化は一時的にファイルをロックし,モッドインストール,ゲーム起動,保存障害を引き起こす可能性があります.%n%nこのディレクトリを使いたいですか?
CloudInstallNotice=このインストールディレクトリはクラウドストレージプロバイダによって同期されているようです.
CloudInstallWarning=選択したインストールディレクトリは,クラウドストレージプロバイダーによって同期されているように見える.プロバイダーがアプリケーションファイルを一時的にロックすると,ポータブルまたは同期化されたインストールが失敗する可能性があります.%n%nこのディレクトリを使いたいですか?
CloudTargetSilentError=サイレントインストールでクラウド同期先を使用するには /ALLOWCLOUDTARGET=1 が必要です。
CopyH3FilesError=Heroes III ファイル（%s）をコピーできませんでした。一部のファイルはコピー済みの可能性があります。安全にインポートをやり直せます。
CopyingHeroes3Data=Heroes III データをコピーしています...
ConfigDirectory=構成
CopyH3Files=自動コピーが必要 Heroes III ファイル VCMI
CreateDesktopShortcuts=デスクトップショートカットを作成する
CreateStartMenuShortcuts=スタートメニューのショートカットを作成する
DataFolderDescription=提供された文書のコピーを保存する Heroes III データ,修正,地図,保存されたゲーム,その他のユーザーファイル.
DataFolderTitle=ユーザーデータフォルダ
DeleteUserData=ユーザーデータを削除する
DeleteUserDataDescription=永久に削除するフォルダを選択します. チェックされていないフォルダは保存されます. これは取り消すことはできません.
DeletingUserData=ユーザーデータを削除しています...
DirectoryConfigWriteError=ユーザーフォルダーの設定を %s に保存できませんでした。安全にインストールを続行できません。
DirectoryNotWritable=選択したフォルダー（%s）に書き込めません。別のフォルダーを選ぶか、必要な権限でインストーラーを実行してください。%n%n%s
DirectoryRootNotAllowed=選択したフォルダー（%s）にドライブまたはネットワーク共有のルートは使用できません。専用のフォルダーを選んでください。%n%n%s
DirectoryOverlapError=インストール先とユーザーデータのフォルダーは、同一または安全でない包含関係にできません。インストール先にユーザーデータを保存できるのはポータブルインストールのみです。
ReadyUserDataLocation=ユーザーデータの場所：
RequirementPassed=適合
RequirementFailed=不適合
RequirementWarning=警告
RequirementInfo=情報
RequirementOperatingSystem=操作システム
RequirementOperatingSystemValue=Windows 7 SP1 以降。必要に応じて互換性ランタイムを同梱
RequirementArchitecture=アーキテクチャ
RequirementInstallWritable=インストール先に書き込み可能
RequirementDataWritable=ユーザーデータフォルダーへの書き込み
RequirementDirectoryLayout=ディレクトリレイアウト
RequirementDirectoryLayoutValue=インストール先とユーザーデータのパスは安全に分離されています
RequirementApplicationSpace=アプリケーションディスク空間
RequirementFreeSpaceValue=空き容量 %s MB。インストーラーは最終的なパッケージサイズも確認します
RequirementHeroesDataSpace=Heroes III データのインポート
RequirementInsufficientSpace=選択した Heroes III データのインポートに必要な空き容量が不足しています
RequirementRequiredSpaceValue=選択したインポートには約 %s MB が必要です
RequirementNotRequested=Heroes III データのインポートは選択されていません
RequirementCloudStorage=収納同期化
RequirementCloudStorageValue=選択された経路はクラウド同期を使用しているようです
RequirementLocalStorageValue=選択された経路は,ローカルストレージを使用しているようです.
RequirementInstallationMode=インストールモード
RequirementModePortable=ポータブル; デイインストーラー,レジストリ,システム統合がない
RequirementModeAllUsers=すべてのユーザー
RequirementModeCurrentUser=現在使用者
RequirementUpgrade=既存のインストールを更新します
RequirementsCheckTitle=システム要件チェック
RequirementsCheckDescription=セットアップはインストール前に選択した設定をチェックした.
H3MDescription=ヒーローズ 3 マップファイル
InstallFolderTitle=インストールフォルダ
InstallForAllUsers=すべてのユーザー向けにインストール
InstallForAllUsers1=管理特権を要求する
InstallForMeOnly=設置は私だけ
InstallForMeOnly1=ファイアウォールプロンプトがゲームを初めて起動すると表示されます
InstallForMeOnly2=ファイアウォールルールが許されない場合,LANゲームは動作しません.
InstallPortable=携帯装置
InstallPortable1=アプリケーションとユーザーデータを1つのフォルダーにまとめて保存します
InstallPortable2=リストとシステム統合を削除したり変更したりしない
LogsDirectory=ログ
ResetFoldersToDefault=デフォルトにリセット
RunVCMILauncherAfterInstall=打ち上げ VCMI 打ち上げ機
SavesDirectory=保存されたゲーム
ScanningFiles=ファイルを検索しています...
SelectSetupInstallModeDesc=VCMI はすべてのユーザー向け、自分だけ、またはポータブルモードでインストールできます。
SelectSetupInstallModeSubTitle=好きなインストールモードを選択します.
SelectSetupInstallModeTitle=インストールモードを選択
SharedUserDataNotice=ユーザーデータは削除できません VCMI 装置は同じディレクトリを使用します
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=官員を訪れ VCMI 異議
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=打ち上げ VCMI 打ち上げ機
ShortcutMapEditor=VCMI 地図編集者
ShortcutMapEditorComment=オープン VCMI 地図編集者
ShortcutWebPage=VCMI ウェブサイト
ShortcutWebPageComment=官員を訪れ VCMI ウェブサイト
SystemIntegration=システム統合
FileAssociations=ファイルの関連付け
AssociateH3CFiles=Heroes III キャンペーン (.h3c) を VCMI マップエディターで開く
H3CDescription=Heroes III キャンペーン
Uninstall=解除する
UserDataDirectory=ユーザーデータ (Heroes III データ,修正,地図,その他のファイル)
VCMISettings=システム設定
VCMPDescription=VCMI キャンペーンファイル
VMAPDescription=VCMI マップファイル
Warning=警告
X86On64BitWarning=32 ビット (x86) のバージョン VCMI これはサポートされていますが,本来の64ビットバージョンは利用可能であれば推奨されます.
Heroes3ImportReparsePoint=既存のインポート先にジャンクションまたはシンボリックリンクが含まれるため、Heroes III データを安全にインポートできません。リンクを削除するか、別のフォルダーを選択してください。
OpenSetupLog=設定ログを開く
OpenSetupLogError=設定ログは開けられなかった.
LegacyUninstallStartFailed=以前の VCMI アンインストーラーを起動できませんでした：%n%s
LegacyUninstallExitFailed=以前の VCMI アンインストーラーが終了コード %s で失敗しました。
LegacyUninstallFailureChoice=「中止」はインストールを停止します。「再試行」は以前のアンインストーラーを再実行します。「無視」は自己責任で続行します。
LegacyUninstallRequired=以前の VCMI インストールを削除できませんでした。新しいインストールファイルはコピーされていません。
InstallDirectoryUsedByOtherInstallation=インストールディレクトリは登録された他のディレクトリに重なり合っています VCMI 設置:%n%s%n%n別のディレクトリを選択します.
X86OnARM64Warning=32 ビット (x86) のバージョン VCMI について ARM64 Windows. これはサポートされていますが,ネイティブは ARM64 入手可能な場合,バージョンが推奨されます.
RequirementsColumnComponent=構成要素
RequirementsColumnDetails=必須
RequirementsColumnStatus=ステータス
RequirementsColumnDetected=お使いのシステム
RequirementDetectedWindows=互換性 Windows インストール
RequirementWritableValue=書き込み可能なフォルダー
RequirementEnoughSpace=十分な空き容量
RequirementProcessor=プロセッサ
RequirementProcessorValue=1 GHzまたはそれ以上
RequirementMemory=メモリ
RequirementMemoryValue=1GBのRAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11 ランタイムが利用可能
RequirementDirectXMissing=DirectX 11 ランタイムが見つかりません
RequirementDetectionUnavailable=検出できませんでした
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=インストール先フォルダー
RequirementUserDataFolder=ユーザーデータフォルダー
RequirementDiskSpace=フリーディスクスペース
RequirementFreeSpaceShortValue=%s
RequirementInternet=インターネット
RequirementRecommended=推奨する
RequirementInternetAvailable=入手可能
RequirementInternetUnavailable=検出されていない
RequirementHeroesData=Heroes III データ
RequirementRequiredToPlay=プレイに必要
RequirementHeroesDataAvailable=ユーザーデータ内にあります
RequirementHeroesDataMissing=見つかりませんでしたが,後で輸入できます
RequirementWritableAndSynced=書き込みと同期化
RequirementNotWritable=書き込み不可
TasksCheckboxesTooltip=追加する機能や操作を選択してください。ショートカットでアクセスしやすくなり、ファイルの関連付けで対応するマップをエディターで開けます。ファイアウォール規則はマルチプレイを許可し、インポートは検出した Heroes III データをコピーします。
UninstallCheckboxesTooltip=完全に削除するユーザーデータの場所だけを選択してください。無効な共有項目は、別の VCMI インストールで使用されています。
InstallModeTooltip=すべてのユーザー：すべての Windows アカウント向けに VCMI をインストールします。通常は Program Files に配置され、管理者の承認が必要です。システム全体のアンインストール情報、レジストリ項目、ショートカット、ファイルの関連付け、および任意のファイアウォール規則を作成します。ユーザーデータは選択したフォルダーに保存されます。%n%n現在のユーザー：ログイン中の Windows アカウントだけに、通常は Local AppData にインストールします。管理者の承認は不要です。そのユーザー用のアンインストーラーと統合機能を作成し、ほかのアカウントには表示されません。初めてマルチプレイを使用するときに Windows ファイアウォールが許可を求める場合があります。%n%nポータブル：アプリケーションとユーザーデータを選択したフォルダーにまとめます。アンインストーラー、レジストリ項目、ショートカット、関連付け、ファイアウォール規則は作成しません。フォルダーは書き込み可能である必要があります。移動やコピーで環境を移せます。削除すればアンインストールできます。
CopyH3FilesTooltip=検出した Heroes III の Data、Maps、Mp3 フォルダーを、選択した VCMI ユーザーデータフォルダーへコピーします。元のファイルは変更されません。
ReadyHeroes3Import=Heroes III データのインポート：
