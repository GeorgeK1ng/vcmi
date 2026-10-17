;
; Korean.isl, part of VCMI engine
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
HelpTextNote=VCMI 설치 매개변수:%n  /USERDATADIR=<path>  VCMI 사용자 데이터 폴더를 지정합니다. 경로 앞에 expand:를 붙이면 Inno Setup 상수를 확장합니다.%n  /ALLOWCLOUDTARGET=1  자동 설치 시 클라우드와 동기화되는 설치 폴더나 사용자 데이터 폴더를 허용합니다.%n  /PORTABLE=1  프로그램과 데이터를 함께 설치하며 제거 프로그램, 레지스트리 변경, 바로 가기, 파일 연결 및 방화벽 규칙을 만들지 않습니다.%n  /LAUNCH  자동 설치를 포함하여 설치 후 VCMI를 실행합니다.%n  /COPYH3DATA=0|1  감지된 Heroes III 데이터의 자동 복사를 켜거나 끕니다.%n%n/TASKS 및 /MERGETASKS의 작업 이름:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (관리자 권한으로 모든 사용자용 설치를 수행할 때만 사용)%n%nVCMI 제거 매개변수:%n  /DELETEUSERDATA=1  설정된 모든 VCMI 사용자 폴더를 삭제합니다. /SILENT 또는 /VERYSILENT와 함께 사용할 때만 적용됩니다. 이 작업은 되돌릴 수 없습니다.%n%n표준 매개변수는 위에 설명되어 있습니다: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=이 프로그램은 현재 사용 중인 Windows 버전에서 실행할 수 없습니다. 올바른 Windows 아키텍처(x86 / x64 / ARM64)와 이 프로그램의 올바른 버전을 사용하는지 확인하십시오.
PrivilegesRequiredOverrideTitle=설치 모드 – 권한 선택
PrivilegesRequiredOverrideInstruction=설치 프로그램 실행 방식을 선택하세요
PrivilegesRequiredOverrideText1=%1을 모든 사용자에게 설치하려면 관리자 권한이 필요합니다. 관리자 권한 없이 현재 사용자 계정에만 설치할 수도 있습니다.
PrivilegesRequiredOverrideText2=%1은 관리자 권한 없이 현재 사용자 계정에만 설치하거나, 관리자 권한으로 모든 사용자에게 설치할 수 있습니다.
PrivilegesRequiredOverrideAllUsers=&관리자 권한으로 실행 (모든 사용자용 설치)
PrivilegesRequiredOverrideAllUsersRecommended=&관리자 권한으로 실행 (권장)
PrivilegesRequiredOverrideCurrentUser=&일반 사용자로 실행 (현재 사용자용 설치)
PrivilegesRequiredOverrideCurrentUserRecommended=&일반 사용자로 실행 (권장)
ConfirmUninstall=%1 제거 마법사를 실행하시겠습니까?

[CustomMessages]
DesktopShortcuts=바탕 화면 바로 가기
StartMenuShortcuts=시작 메뉴 바로 가기
WelcomeDescription=VCMI는 Heroes III에 새로운 기능과 확장된 가능성을 제공하는 오픈 소스 엔진입니다. VCMI를 사용하려면 원본 게임의 데이터 파일을 소유해야 합니다.%n%n이 마법사는 장치에 VCMI - Open Heroes 3를 설치합니다.%n%n계속하기 전에 다른 모든 응용 프로그램을 닫는 것이 좋습니다.%n%n계속하려면 다음을, 설치를 종료하려면 취소를 클릭하십시오.
WelcomeHighlightsTitle=VCMI 소개
WelcomeHighlights=VCMI는 커뮤니티가 개발하는 Heroes of Might and Magic III 엔진의 재구현입니다. 원작의 정신을 보존하고 기존 엔진의 기술적 한계를 극복하며 모드와 지속적인 개발을 위한 개방형 기반을 제공합니다.
RequirementImportSpaceHelp=돌아가서 다른 사용자 데이터 폴더를 선택하거나 Heroes III 데이터 자동 복사를 해제하십시오.
RequirementDisableImportQuestion=Heroes III 데이터를 복사하지 않고 계속하시겠습니까?
RequirementFirewall=방화벽
RequirementMultiplayerGames=멀티플레이어 게임
RequirementSelected=선택됨
RequirementNotSelected=선택 안 함 — 한 컴퓨터에서 번갈아 하는 플레이는 가능합니다
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=멀티플레이어 게임용 방화벽 규칙 추가
AssociateH3MFiles=.h3m 파일을 VCMI 맵 에디터와 연결
AssociateVCMIMapFiles=.vmap 및 .vcmp 파일을 VCMI 맵 에디터와 연결
CacheDirectory=캐시
CloudDataNotice=이 사용자 데이터 디렉터리는 클라우드 저장소 공급자에 의해 동기화되는 것으로 보입니다.
CloudDataWarning=선택한 사용자 데이터 디렉터리가 클라우드 저장소 공급자에 의해 동기화되는 것으로 보입니다. 동기화 중 파일이 일시적으로 잠겨 모드 설치, 게임 실행 또는 저장에 실패할 수 있습니다.%n%n그래도 이 디렉터리를 사용하시겠습니까?
CloudInstallNotice=이 설치 디렉터리는 클라우드 저장소 공급자에 의해 동기화되는 것으로 보입니다.
CloudInstallWarning=선택한 설치 디렉터리가 클라우드 저장소 공급자에 의해 동기화되는 것으로 보입니다. 공급자가 응용 프로그램 파일을 일시적으로 잠그면 휴대용 또는 동기화 설치가 실패할 수 있습니다.%n%n그래도 이 디렉터리를 사용하시겠습니까?
CloudTargetSilentError=자동 설치에서 클라우드와 동기화되는 대상 폴더를 사용하려면 /ALLOWCLOUDTARGET=1이 필요합니다.
CopyH3FilesError=Heroes III 파일(%s)을 복사하지 못했습니다. 일부 파일이 이미 복사되었을 수 있으며 가져오기를 안전하게 다시 실행할 수 있습니다.
CopyingHeroes3Data=Heroes III 데이터 복사 중...
ConfigDirectory=설정
CopyH3Files=필요한 Heroes III 파일을 VCMI로 자동 복사
CreateDesktopShortcuts=바탕 화면 바로 가기 생성
CreateStartMenuShortcuts=시작 메뉴 바로 가기 생성
DataFolderDescription=제공된 Heroes III 데이터의 복사본, 모드, 지도, 저장된 게임 및 기타 사용자 파일을 저장합니다.
DataFolderTitle=사용자 데이터 폴더
DeleteUserData=사용자 데이터 삭제
DeleteUserDataDescription=영구적으로 삭제할 폴더를 선택하십시오. 선택하지 않은 폴더는 유지됩니다. 이 작업은 취소할 수 없습니다.
DeletingUserData=사용자 데이터 삭제 중...
DirectoryConfigWriteError=사용자 폴더 설정을 %s에 저장하지 못했습니다. 설치를 안전하게 계속할 수 없습니다.
DirectoryNotWritable=선택한 폴더(%s)에 쓸 수 없습니다. 다른 폴더를 선택하거나 필요한 권한으로 설치 프로그램을 실행하세요.%n%n%s
DirectoryRootNotAllowed=선택한 폴더(%s)는 드라이브나 네트워크 공유의 루트일 수 없습니다. 전용 폴더를 선택하세요.%n%n%s
DirectoryOverlapError=설치 폴더와 사용자 데이터 폴더는 같거나 안전하지 않게 겹칠 수 없습니다. 포터블 설치에서만 설치 폴더 안에 사용자 데이터를 저장할 수 있습니다.
ReadyUserDataLocation=사용자 데이터 위치:
RequirementPassed=충족
RequirementFailed=실패
RequirementWarning=경고
RequirementInfo=정보
RequirementOperatingSystem=운영 시스템
RequirementOperatingSystemValue=Windows 7 SP1 이상; 필요한 경우 호환성 런타임 포함
RequirementArchitecture=아키텍처
RequirementInstallWritable=설치 폴더 쓰기 가능
RequirementDataWritable=사용자 데이터 폴더 쓰기 가능
RequirementDirectoryLayout=디렉토리 레이아웃
RequirementDirectoryLayoutValue=설치 경로와 사용자 데이터 경로가 안전하게 분리됨
RequirementApplicationSpace=애플리케이션 디스크 공간
RequirementFreeSpaceValue=%s MB 여유 공간; 설치 프로그램이 최종 패키지 크기도 확인합니다
RequirementHeroesDataSpace=Heroes III 데이터 가져오기
RequirementInsufficientSpace=선택한 Heroes III 데이터를 가져올 여유 공간이 부족합니다
RequirementRequiredSpaceValue=선택한 가져오기에 약 %s MB 필요
RequirementNotRequested=Heroes III 데이터 가져오기를 선택하지 않음
RequirementCloudStorage=스토리지 동기화
RequirementCloudStorageValue=선택된 경로는 클라우드 동기화를 사용하는 것으로 보인다
RequirementLocalStorageValue=선택된 경로는 로컬 스토리지를 사용하는 것 같습니다.
RequirementInstallationMode=설치 방식
RequirementModePortable=휴대용; 해제 장치, 레지스트리 또는 시스템 통합이 없습니다
RequirementModeAllUsers=모든 이용자
RequirementModeCurrentUser=현재 사용자
RequirementUpgrade=기존 설치를 업그레이드합니다
RequirementsCheckTitle=시스템 요구사항 확인
RequirementsCheckDescription=설치는 설치를 하기 전에 선택한 구성을 확인했습니다.
H3MDescription=Heroes 3 맵 파일
InstallFolderTitle=설치 폴더
InstallForAllUsers=모든 사용자에게 설치
InstallForAllUsers1=관리자 권한이 필요합니다
InstallForMeOnly=본인만을 위해 설치
InstallForMeOnly1=게임을 처음 실행할 때 방화벽 알림이 표시됩니다
InstallForMeOnly2=방화벽 규칙을 허용하지 않으면 LAN 게임이 작동하지 않습니다
InstallPortable=포터블 설치
InstallPortable1=응용 프로그램과 사용자 데이터를 하나의 폴더에 함께 보관합니다
InstallPortable2=제거 프로그램을 만들거나 레지스트리 및 시스템 통합을 변경하지 않습니다
LogsDirectory=로그
ResetFoldersToDefault=기본값으로 재설정
RunVCMILauncherAfterInstall=VCMI 런처 실행
SavesDirectory=저장된 게임
ScanningFiles=파일 검색 중...
SelectSetupInstallModeDesc=VCMI는 모든 사용자용, 현재 사용자용 또는 포터블 모드로 설치할 수 있습니다.
SelectSetupInstallModeSubTitle=선호하는 설치 모드를 선택하세요:
SelectSetupInstallModeTitle=설치 모드 선택
SharedUserDataNotice=다른 VCMI 설치가 같은 디렉터리를 사용하므로 사용자 데이터를 삭제할 수 없습니다.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=VCMI 공식 디스코드 방문
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=VCMI 런처 실행
ShortcutMapEditor=VCMI 맵 에디터
ShortcutMapEditorComment=VCMI 맵 에디터 열기
ShortcutWebPage=VCMI 웹사이트
ShortcutWebPageComment=VCMI 공식 웹사이트 방문
SystemIntegration=시스템 통합
FileAssociations=파일 연결
AssociateH3CFiles=Heroes III 캠페인 파일(.h3c)을 VCMI 맵 에디터에서 열기
H3CDescription=Heroes III 캠페인
Uninstall=제거
UserDataDirectory=사용자 데이터(Heroes III 데이터, 모드, 지도 및 기타 파일)
VCMISettings=시스템 설정
VCMPDescription=VCMI 캠페인 파일
VMAPDescription=VCMI 맵 파일
Warning=경고
X86On64BitWarning=64비트 Windows에 VCMI 32비트(x86) 버전을 설치하고 있습니다. 지원되는 구성이나, 가능한 경우 네이티브 64비트 버전을 사용하는 것이 좋습니다.
Heroes3ImportReparsePoint=기존 대상 폴더에 정션이나 심볼릭 링크가 있어 Heroes III 데이터를 안전하게 가져올 수 없습니다. 링크를 제거하거나 다른 폴더를 선택하세요.
OpenSetupLog=설정 로그를 열
OpenSetupLogError=설정 로그는 열 수 없었습니다.
LegacyUninstallStartFailed=이전 VCMI 제거 프로그램을 시작하지 못했습니다:%n%s
LegacyUninstallExitFailed=이전 VCMI 제거 프로그램이 종료 코드 %s로 실패했습니다.
LegacyUninstallFailureChoice=중단은 설치를 멈춥니다. 다시 시도는 이전 제거 프로그램을 다시 실행합니다. 무시는 위험을 감수하고 계속합니다.
LegacyUninstallRequired=이전 VCMI 설치를 제거하지 못했습니다. 새 설치 파일은 복사되지 않았습니다.
InstallDirectoryUsedByOtherInstallation=설치 디렉토리는 다른 등록된 디렉토리를 덮고 있습니다. VCMI 설치:%n%s%n%n다른 디렉토리를 선택하세요.
X86OnARM64Warning=32비트 (x86) 에 대한 버전 VCMI 에 대해 ARM64 윈도우. 이것은 지원, 하지만 네이티브 ARM64 사용 가능한 경우 버전이 권장됩니다.
RequirementsColumnComponent=구성 요소
RequirementsColumnDetails=필요성
RequirementsColumnStatus=상태
RequirementsColumnDetected=사용 중인 시스템
RequirementDetectedWindows=호환되는 윈도우 설치
RequirementWritableValue=쓰기 가능한 폴더
RequirementEnoughSpace=여유 공간 충분
RequirementProcessor=프로세서
RequirementProcessorValue=1 GHz 또는 더 빠른
RequirementMemory=메모리
RequirementMemoryValue=1 GB의 RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11 런타임 사용 가능
RequirementDirectXMissing=DirectX 11 런타임을 찾을 수 없음
RequirementDetectionUnavailable=감지할 수 없음
RequirementOperatingSystemShortValue=윈도우 7 SP1
RequirementInstallFolder=설치 폴더
RequirementUserDataFolder=사용자 데이터 폴더
RequirementDiskSpace=무료 디스크 공간
RequirementFreeSpaceShortValue=%s
RequirementInternet=인터넷
RequirementRecommended=추천
RequirementInternetAvailable=사용 가능
RequirementInternetUnavailable=발견되지 않았습니다.
RequirementHeroesData=Heroes III 데이터
RequirementRequiredToPlay=플레이에 필요
RequirementHeroesDataAvailable=사용자 데이터에서 찾음
RequirementHeroesDataMissing=발견되지 않았습니다. 나중에 수입할 수 있습니다.
RequirementWritableAndSynced=글쓰기 및 동기화
RequirementNotWritable=쓰기 불가
TasksCheckboxesTooltip=선택적 통합 기능과 작업을 선택하세요. 바로 가기로 쉽게 실행하고, 파일 연결로 지원되는 지도를 편집기에서 열 수 있습니다. 방화벽 규칙은 멀티플레이를 허용하고 가져오기는 감지된 Heroes III 데이터를 복사합니다.
UninstallCheckboxesTooltip=영구적으로 삭제할 사용자 데이터 폴더만 선택하세요. 비활성화된 공유 항목은 다른 VCMI 설치에서 사용 중입니다.
InstallModeTooltip=모든 사용자: 모든 Windows 계정에 VCMI를 설치하며 일반적으로 Program Files에 저장합니다. 관리자 승인이 필요합니다. 시스템 전체의 제거 정보, 레지스트리 항목, 바로 가기, 파일 연결 및 선택적 방화벽 규칙을 만듭니다. 사용자 데이터는 선택한 폴더에 유지됩니다.%n%n현재 사용자: 로그인한 Windows 계정에만 설치하며 일반적으로 Local AppData에 저장합니다. 관리자 승인은 필요하지 않습니다. 해당 사용자용 제거 프로그램과 통합 기능을 만듭니다. 다른 계정에는 이 설치가 표시되지 않습니다. 멀티플레이를 처음 사용할 때 Windows 방화벽이 권한을 요청할 수 있습니다.%n%n포터블: 프로그램과 사용자 데이터를 선택한 폴더에 함께 저장합니다. 제거 프로그램, 레지스트리 항목, 바로 가기, 파일 연결 및 방화벽 규칙을 만들지 않습니다. 폴더는 쓰기 가능한 상태를 유지해야 합니다. 폴더를 이동하거나 복사하면 설치를 옮길 수 있으며 삭제하면 제거됩니다.
CopyH3FilesTooltip=감지된 Heroes III의 Data, Maps, Mp3 폴더를 선택한 VCMI 사용자 데이터 폴더로 복사합니다. 원본 파일은 변경되지 않습니다.
ReadyHeroes3Import=Heroes III 데이터 가져오기:
