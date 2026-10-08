; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=VCMI 전용 설치 매개 변수:%n  /USERDATADIR=<경로>  VCMI 사용자 데이터 폴더를 지정합니다. expand: 접두사는 Inno Setup 상수를 확장합니다.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  제거 프로그램, 레지스트리 변경, 바로 가기, 파일 연결 또는 방화벽 규칙 없이 응용 프로그램과 데이터를 함께 설치합니다.%n  /LAUNCH  자동 설치를 포함하여 설치 후 VCMI를 실행합니다.%n%nVCMI 제거 프로그램 매개 변수:%n  /DELETEUSERDATA=1  구성된 모든 VCMI 사용자 폴더를 삭제합니다. /SILENT 또는 /VERYSILENT와 함께만 적용됩니다. 실행 취소할 수 없습니다.%n%n/DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART 및 /LOG 같은 표준 매개 변수는 위에 설명되어 있습니다.
WindowsVersionNotSupported=이 프로그램은 현재 사용 중인 Windows 버전에서 실행할 수 없습니다. 올바른 Windows 아키텍처(32비트 또는 64비트)와 이 프로그램의 올바른 버전을 사용하는지 확인하십시오.
PrivilegesRequiredOverrideTitle=설치 모드 – 권한 선택
PrivilegesRequiredOverrideInstruction=설치 프로그램 실행 방식을 선택하세요
PrivilegesRequiredOverrideText1=%1을 모든 사용자에게 설치하려면 관리자 권한이 필요합니다.%n관리자 권한 없이 현재 사용자 계정에만 설치할 수도 있습니다.
PrivilegesRequiredOverrideText2=%1은 관리자 권한 없이 현재 사용자 계정에만 설치하거나, 관리자 권한으로 모든 사용자에게 설치할 수 있습니다.
PrivilegesRequiredOverrideAllUsers=&관리자 권한으로 실행 (모든 사용자용 설치)
PrivilegesRequiredOverrideAllUsersRecommended=&관리자 권한으로 실행 (권장)
PrivilegesRequiredOverrideCurrentUser=&일반 사용자로 실행 (현재 사용자용 설치)
PrivilegesRequiredOverrideCurrentUserRecommended=&일반 사용자로 실행 (권장)
ConfirmUninstall=%1 제거 마법사를 실행하시겠습니까?

[CustomMessages]
AddFirewallRules=VCMI를 위한 방화벽 규칙 추가
AssociateH3MFiles=.h3m 파일을 VCMI 맵 에디터와 연결
AssociateVCMIMapFiles=.vmap 및 .vcmp 파일을 VCMI 맵 에디터와 연결
CacheDirectory=캐시
CloudDataNotice=이 사용자 데이터 디렉터리는 클라우드 저장소 공급자에 의해 동기화되는 것으로 보입니다.
CloudDataWarning=선택한 사용자 데이터 디렉터리가 클라우드 저장소 공급자에 의해 동기화되는 것으로 보입니다. 동기화 중 파일이 일시적으로 잠겨 모드 설치, 게임 실행 또는 저장에 실패할 수 있습니다.%n%n그래도 이 디렉터리를 사용하시겠습니까?
CloudInstallNotice=이 설치 디렉터리는 클라우드 저장소 공급자에 의해 동기화되는 것으로 보입니다.
CloudInstallWarning=선택한 설치 디렉터리가 클라우드 저장소 공급자에 의해 동기화되는 것으로 보입니다. 공급자가 응용 프로그램 파일을 일시적으로 잠그면 휴대용 또는 동기화 설치가 실패할 수 있습니다.%n%n그래도 이 디렉터리를 사용하시겠습니까?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=설정
CopyH3Files=필요한 Heroes III 파일을 VCMI로 자동 복사
CreateDesktopShortcuts=바탕 화면 바로 가기 생성
CreateStartMenuShortcuts=시작 메뉴 바로 가기 생성
DataFolderDescription=제공된 Heroes III 데이터의 복사본, 모드, 지도, 저장된 게임 및 기타 사용자 파일을 저장합니다.
DataFolderTitle=사용자 데이터 폴더
DeleteUserData=사용자 데이터 삭제
DeleteUserDataDescription=영구적으로 삭제할 폴더를 선택하십시오. 선택하지 않은 폴더는 유지됩니다. 이 작업은 취소할 수 없습니다.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
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
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI는 모든 사용자 또는 본인만을 위해 설치할 수 있습니다.
SelectSetupInstallModeSubTitle=선호하는 설치 모드를 선택하세요:
SelectSetupInstallModeTitle=설치 모드 선택
SharedUserDataNotice=다른 VCMI 설치가 같은 디렉터리를 사용하므로 사용자 데이터를 삭제할 수 없습니다.
ShortcutDiscord=VCMI 디스코드
ShortcutDiscordComment=VCMI 공식 디스코드 방문
ShortcutLauncher=VCMI 런처
ShortcutLauncherComment=VCMI 런처 실행
ShortcutMapEditor=VCMI 맵 에디터
ShortcutMapEditorComment=VCMI 맵 에디터 열기
ShortcutWebPage=VCMI 웹사이트
ShortcutWebPageComment=VCMI 공식 웹사이트 방문
SystemIntegration=시스템 통합
Uninstall=제거
UserDataDirectory=사용자 데이터(Heroes III 데이터, 모드, 지도 및 기타 파일)
VCMISettings=VCMI 설정
VCMPDescription=VCMI 캠페인 파일
VMAPDescription=VCMI 맵 파일
Warning=경고
X86On64BitWarning=64비트 Windows에 VCMI 32비트(x86) 버전을 설치하고 있습니다. 지원되는 구성이나, 가능한 경우 네이티브 64비트 버전을 사용하는 것이 좋습니다.
