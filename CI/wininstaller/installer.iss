; ============================================================================
; Building and maintenance
; ============================================================================
;
; Local build instructions, architecture mapping, command-line parameters,
; plugin behavior, directory metadata, and uninstall behavior are documented in:
;   docs/developers/Building_Windows.md#building-the-windows-installer
; Translation maintenance is documented in:
;   docs/translators/Maintenance.md#translating-the-installer
;
; build_installer.cmd supplies the preprocessor definitions below. InstallerArch
; is the payload architecture (x86, x64, or arm64); SetupArch is the architecture
; of Setup and installerPlugin.dll and is limited to x86 or x64.

; #define AppVersion "1.7.0"
; #define AppBuild "1122334455A"
; #define InstallerArch "x64"
; #define AllowedArch "x64os"
; #define SetupArch "x64"
; #define VCMIFolder "VCMI"
; #define InstallerName "VCMI-Windows"
; #define SourceFilesPath "C:\_VCMI_source\bin\Release"
; #define InstallerPluginPath "C:\_VCMI_Source\CI\wininstaller\plugins\build\bin\Release"
; #define UCRTFilesPath "C:\Program Files (x86)\Windows Kits\10\Redist\10.0.22621.0\ucrt\DLLs"
; #define LangPath "C:\_VCMI_Source\CI\wininstaller\lang"
; #define UnofficialLangPath "C:\Temp\vcmi-inno-languages-7.1.0"
; #define LicenseFile "C:\_VCMI_Source\license.txt"
; #define IconFile "C:\_VCMI_Source\clientapp\icons\vcmi.ico"
; #define SmallLogo "C:\_VCMI_Source\CI\wininstaller\vcmismalllogo.bmp"
; #define WizardLogo "C:\_VCMI_Source\CI\wininstaller\vcmilogo.bmp"

#define VCMIFilesFolder "My Games\VCMI"

; Display name (user-facing). VCMIFolder above is the install/registry identity and must not change.
#ifndef VCMIDisplayName
  #define VCMIDisplayName "VCMI - Open Heroes 3"
#endif

#define AppComment "VCMI is an open-source engine for Heroes III, offering new and extended possibilities."
#define VCMITeam "VCMI Team"
#define VCMICopyright "Copyright © VCMI Team. All rights reserved."

#define VCMIHome "https://vcmi.eu/"
#define VCMIContact "https://discord.gg/chBT42V"

[Setup]
AppId={#VCMIFolder}.{#InstallerArch}
AppName={#VCMIDisplayName}
AppVersion={#AppVersion}.{#AppBuild}
AppVerName={#VCMIDisplayName}
AppPublisher={#VCMITeam}
AppPublisherURL={#VCMIHome}
AppSupportURL={#VCMIContact}
AppComments={#AppComment}
DefaultDirName={code:GetDefaultDir}
DefaultGroupName={#VCMIFolder}
Uninstallable=not IsPortableInstall
CreateUninstallRegKey=not IsPortableInstall
UninstallDisplayIcon={app}\VCMI_launcher.exe
OutputBaseFilename={#InstallerName}
PrivilegesRequiredOverridesAllowed=commandline dialog
ShowLanguageDialog=yes
LanguageDetectionMethod=uilanguage
DisableWelcomePage=no
DisableProgramGroupPage=yes
ChangesAssociations=yes
UsePreviousLanguage=yes
DirExistsWarning=no
UsePreviousAppDir=yes
UsePreviousTasks=yes
UsePreviousGroup=yes
DisableStartupPrompt=yes
UsedUserAreasWarning=no
CloseApplicationsFilter=*.exe
CloseApplications=force
Compression=lzma2/ultra64
SolidCompression=yes
SetupLogging=yes
ArchitecturesAllowed={#AllowedArch}
SetupArchitecture={#SetupArch}
LicenseFile={#LicenseFile}
SetupIconFile={#IconFile}
WizardSmallImageFile={#SmallLogo}
WizardImageFile={#WizardLogo}
WizardSizePercent=125
WizardResizable=yes

; Version information
MinVersion=6.1sp1
VersionInfoCompany={#VCMITeam}
VersionInfoDescription={#VCMIDisplayName} {#AppVersion} Setup (Build {#AppBuild})
VersionInfoProductName={#VCMIDisplayName}
VersionInfoCopyright={#VCMICopyright}
VersionInfoVersion={#AppVersion}
VersionInfoOriginalFileName={#InstallerName}.exe

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl,{#LangPath}\English.isl"
Name: "belarusian"; MessagesFile: "{#UnofficialLangPath}\Belarusian.isl,{#LangPath}\Belarusian.isl"
Name: "bulgarian"; MessagesFile: "compiler:Languages\Bulgarian.isl,{#LangPath}\Bulgarian.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl,{#LangPath}\Czech.isl"
Name: "chinese"; MessagesFile: "compiler:Languages\ChineseSimplified.isl,{#LangPath}\ChineseSimplified.isl"
Name: "tchinese"; MessagesFile: "compiler:Languages\ChineseTraditional.isl,{#LangPath}\ChineseTraditional.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl,{#LangPath}\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl,{#LangPath}\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl,{#LangPath}\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl,{#LangPath}\German.isl"
Name: "greek"; MessagesFile: "{#UnofficialLangPath}\Greek.isl,{#LangPath}\Greek.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl,{#LangPath}\Hungarian.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl,{#LangPath}\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl,{#LangPath}\Japanese.isl"
Name: "korean"; MessagesFile: "compiler:Languages\Korean.isl,{#LangPath}\Korean.isl"
Name: "latvian"; MessagesFile: "{#UnofficialLangPath}\Latvian.isl,{#LangPath}\Latvian.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl,{#LangPath}\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl,{#LangPath}\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl,{#LangPath}\BrazilianPortuguese.isl"
Name: "romanian"; MessagesFile: "{#UnofficialLangPath}\Romanian.isl,{#LangPath}\Romanian.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl,{#LangPath}\Russian.isl"
Name: "serbian"; MessagesFile: "{#UnofficialLangPath}\SerbianCyrillic.isl,{#LangPath}\SerbianCyrillic.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl,{#LangPath}\Spanish.isl"
Name: "swedish"; MessagesFile: "compiler:Languages\Swedish.isl,{#LangPath}\Swedish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl,{#LangPath}\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl,{#LangPath}\Ukrainian.isl"
Name: "vietnamese"; MessagesFile: "{#UnofficialLangPath}\Vietnamese.isl,{#LangPath}\Vietnamese.isl"

[Files]
Source: "{#InstallerPluginPath}\installerPlugin.dll"; Flags: dontcopy noencryption
Source: "install-mode-all-users.bmp"; Flags: dontcopy noencryption
Source: "install-mode-current-user.bmp"; Flags: dontcopy noencryption
Source: "install-mode-portable.bmp"; Flags: dontcopy noencryption
Source: "folder-vcmi.bmp"; Flags: dontcopy noencryption
Source: "folder-user.bmp"; Flags: dontcopy noencryption
Source: "requirement-status-ok.bmp"; Flags: dontcopy noencryption
Source: "requirement-status-ok-alternate.bmp"; Flags: dontcopy noencryption
Source: "requirement-status-info.bmp"; Flags: dontcopy noencryption
Source: "requirement-status-info-alternate.bmp"; Flags: dontcopy noencryption
Source: "requirement-status-fail.bmp"; Flags: dontcopy noencryption
Source: "requirement-status-fail-alternate.bmp"; Flags: dontcopy noencryption
Source: "requirement-status-warn.bmp"; Flags: dontcopy noencryption
Source: "requirement-status-warn-alternate.bmp"; Flags: dontcopy noencryption
Source: "{#InstallerPluginPath}\installerPlugin.dll"; DestDir: "{app}"; DestName: "VCMI_installerPlugin.dll"; Flags: ignoreversion; Check: not IsPortableInstall
Source: "{#SourceFilesPath}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pdb,*.lib,*.exp,*.ilk,*.obj,*.tlog,*.log,*.pch,*.idb,*.res,*.tmp,*.bak,*.sdf,*.ipch,*.vc.db,*.iobj,*.ipdb,config\dirs.json"
Source: "{#UCRTFilesPath}\{#InstallerArch}\*"; DestDir: "{app}"; Flags: ignoreversion; Check: IsUCRTNeeded

[Icons]
Name: "{group}\{cm:ShortcutLauncher}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_launcher.exe"; Comment: "{cm:ShortcutLauncherComment}{code:GetBranchSuffix}"; Tasks: startmenu_launcher; Check: not IsPortableInstall
Name: "{group}\{cm:ShortcutMapEditor}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_mapeditor.exe"; Comment: "{cm:ShortcutMapEditorComment}{code:GetBranchSuffix}"; Tasks: startmenu_mapeditor; Check: not IsPortableInstall
Name: "{group}\{cm:ShortcutWebPage}"; Filename: "{#VCMIHome}"; Comment: "{cm:ShortcutWebPageComment}"; Tasks: startmenu_website; Check: not IsPortableInstall
Name: "{group}\{cm:ShortcutDiscord}"; Filename: "{#VCMIContact}"; Comment: "{cm:ShortcutDiscordComment}"; Tasks: startmenu_discord; Check: not IsPortableInstall

Name: "{code:GetUserDesktopFolder}\{cm:ShortcutLauncher}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_launcher.exe"; Comment: "{cm:ShortcutLauncherComment}{code:GetBranchSuffix}"; Tasks: desktop_launcher; Check: not IsPortableInstall
Name: "{code:GetUserDesktopFolder}\{cm:ShortcutMapEditor}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_mapeditor.exe"; Comment: "{cm:ShortcutMapEditorComment}{code:GetBranchSuffix}"; Tasks: desktop_mapeditor; Check: not IsPortableInstall

[Tasks]
Name: "startmenu_launcher"; Description: "{cm:ShortcutLauncher}"; GroupDescription: "{cm:StartMenuShortcuts}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "startmenu_mapeditor"; Description: "{cm:ShortcutMapEditor}"; GroupDescription: "{cm:StartMenuShortcuts}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "startmenu_website"; Description: "{cm:ShortcutWebPage}"; GroupDescription: "{cm:StartMenuShortcuts}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "startmenu_discord"; Description: "{cm:ShortcutDiscord}"; GroupDescription: "{cm:StartMenuShortcuts}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "desktop_launcher"; Description: "{cm:ShortcutLauncher}"; GroupDescription: "{cm:DesktopShortcuts}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "desktop_mapeditor"; Description: "{cm:ShortcutMapEditor}"; GroupDescription: "{cm:DesktopShortcuts}"; Flags: unchecked; Check: not IsPRInstaller and not IsPortableInstall
Name: "fileassociation_vmap"; Description: "{cm:VMAPDescription}"; GroupDescription: "{cm:FileAssociations}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "fileassociation_vcmp"; Description: "{cm:VCMPDescription}"; GroupDescription: "{cm:FileAssociations}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "fileassociation_h3m"; Description: "{cm:H3MDescription}"; GroupDescription: "{cm:FileAssociations}"; Flags: unchecked; Check: not IsPRInstaller and not IsPortableInstall
Name: "fileassociation_h3c"; Description: "{cm:H3CDescription}"; GroupDescription: "{cm:FileAssociations}"; Flags: unchecked; Check: not IsPRInstaller and not IsPortableInstall

Name: "firewallrules"; Description: "{cm:AddFirewallRules}"; GroupDescription: "{cm:VCMISettings}"; Check: not IsPRInstaller and IsAdminInstallMode and not IsPortableInstall

[Registry]
Root: HKA; Subkey: "Software\VCMI\Installer\{#InstallerArch}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Flags: uninsdeletekey; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\VCMI\Installer\{#InstallerArch}"; ValueType: string; ValueName: "userDataPath"; ValueData: "{code:GetSelectedDataDir}"; Flags: uninsdeletekey; Check: not IsPortableInstall

Root: HKA; Subkey: "Software\Classes\.vmap"; ValueType: string; ValueName: ""; ValueData: "VCMI.vmap"; Tasks: fileassociation_vmap; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.vmap"; ValueType: string; ValueName: ""; ValueData: "{cm:VMAPDescription}"; Tasks: fileassociation_vmap; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.vmap\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_vmap; Check: not IsPortableInstall

Root: HKA; Subkey: "Software\Classes\.vcmp"; ValueType: string; ValueName: ""; ValueData: "VCMI.vcmp"; Tasks: fileassociation_vcmp; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.vcmp"; ValueType: string; ValueName: ""; ValueData: "{cm:VCMPDescription}"; Tasks: fileassociation_vcmp; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.vcmp\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_vcmp; Check: not IsPortableInstall

Root: HKA; Subkey: "Software\Classes\.h3m"; ValueType: string; ValueName: ""; ValueData: "VCMI.h3m"; Tasks: fileassociation_h3m; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.h3m"; ValueType: string; ValueName: ""; ValueData: "{cm:H3MDescription}"; Tasks: fileassociation_h3m; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.h3m\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_h3m; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\.h3c"; ValueType: string; ValueName: ""; ValueData: "VCMI.h3c"; Tasks: fileassociation_h3c; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.h3c"; ValueType: string; ValueName: ""; ValueData: "{cm:H3CDescription}"; Tasks: fileassociation_h3c; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.h3c\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_h3c; Check: not IsPortableInstall

[Run]
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""VCMI server - {#VCMIFolder} ({#InstallerArch})"""; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin and not IsPortableInstall
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""VCMI server - {#VCMIFolder} ({#InstallerArch})"" dir=in action=allow program=""{app}\vcmi_server.exe"" enable=yes profile=public,private"; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin and not IsPortableInstall
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""VCMI client - {#VCMIFolder} ({#InstallerArch})"""; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin and not IsPortableInstall
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""VCMI client - {#VCMIFolder} ({#InstallerArch})"" dir=in action=allow program=""{app}\vcmi_client.exe"" enable=yes profile=public,private"; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin and not IsPortableInstall

Filename: "{app}\VCMI_launcher.exe"; Description: "{cm:RunVCMILauncherAfterInstall}"; Flags: nowait postinstall; Check: ShouldRunLauncher
Filename: "{log}"; Description: "{cm:OpenSetupLog}"; Flags: postinstall shellexec skipifsilent unchecked

[UninstallRun]
; Remove firewall rules
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""VCMI server - {#VCMIFolder} ({#InstallerArch})"""; Flags: runhidden; Check: IsAdmin; RunOnceId: "RemoveFirewallVCMIServer"
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""VCMI client - {#VCMIFolder} ({#InstallerArch})"""; Flags: runhidden; Check: IsAdmin; RunOnceId: "RemoveFirewallVCMIClient"

[UninstallDelete]
; dirs.json is generated by [Code], so it is not tracked as an installed [Files] entry.
Type: files; Name: "{app}\config\dirs.json"
Type: dirifempty; Name: "{app}\config"
Type: dirifempty; Name: "{app}"

[Code]
type
  TUninstallPathArray = array[0..4] of String;
  TUninstallPathDescriptionArray = array[0..4] of String;
  TUninstallPathProtectionArray = array[0..4] of Boolean;
  TRequirementCellArray = array[0..14] of TPanel;
  TRequirementIconArray = array[0..14] of TBitmapImage;
  TMemoryStatusEx = record
    Length: DWord;
    MemoryLoad: DWord;
    TotalPhysical: Int64;
    AvailablePhysical: Int64;
    TotalPageFile: Int64;
    AvailablePageFile: Int64;
    TotalVirtual: Int64;
    AvailableVirtual: Int64;
    AvailableExtendedVirtual: Int64;
  end;

const
  WTS_CURRENT_SERVER_HANDLE = 0;
  WTS_CURRENT_SESSION = -1;
  WTSUserName = 5;
  FILE_ATTRIBUTE_REPARSE_POINT_VALUE = $400;
  INVALID_FILE_ATTRIBUTES = $FFFFFFFF;

var
  InstallModePage: TInputOptionWizardPage;
  InstallModeRowPanels: array[0..2] of TPanel;
  InstallModeRadioButtons: array[0..2] of TNewRadioButton;
  InstallModeTitleLabels: array[0..2] of TNewStaticText;
  InstallModeLabels: array[0..2] of TNewStaticText;
  InstallModeIconPanels: array[0..2] of TPanel;
  InstallModeBitmaps: array[0..2] of TBitmapImage;
  WelcomeInstructionsLabel: TNewStaticText;
  FooterLabel: TLabel;
  IsUpgrade: Boolean;
  RegisteredInstallPath: String;
  UninstallPathCount: Integer;
  UninstallPaths: TUninstallPathArray;
  UninstallPathDescriptions: TUninstallPathDescriptionArray;
  UninstallPathProtected: TUninstallPathProtectionArray;
  DeletePathsList: TNewCheckListBox;
  DeleteAllUserData: Boolean;
  Heroes3Path: String;
  Heroes3MapsSize, Heroes3DataSize, Heroes3Mp3Size: Int64;
  Heroes3MapsFiles, Heroes3DataFiles, Heroes3Mp3Files: Integer;
  GlobalUserName: String;
  GlobalUserDocsFolder: String;
  GlobalUserAppdataFolder: String;
  DefaultDataDir: String;

  VCMIMapsFolder, VCMIDataFolder, VCMIMp3Folder: String;
  Heroes3MapsFolder, Heroes3DataFolder, Heroes3Mp3Folder: String;

  DirSelectPage: TWizardPage;

  InstallDirBitmap: TBitmapImage;
  DataDirBitmap: TBitmapImage;

  LabelInstallInfo1: TNewStaticText;
  LabelInstall: TNewStaticText;
  CloudInstallNotice: TNewStaticText;
  InstallDirEdit: TEdit;
  InstallDirBrowseBtn: TButton;

  LabelData: TNewStaticText;
  LabelDataInfo: TNewStaticText;
  CloudDataNotice: TNewStaticText;
  DataDirEdit: TEdit;
  DataDirBrowseBtn: TButton;
  ResetDirsBtn: TButton;
  CopyHeroes3DataCheck: TNewCheckBox;
  CopyHeroes3DataSelected: Boolean;
  RequirementsPage: TWizardPage;
  RequirementsComponentLabels: TRequirementCellArray;
  RequirementsRequiredLabels: TRequirementCellArray;
  RequirementsDetailsLabels: TRequirementCellArray;
  RequirementsStatusLabels: TRequirementCellArray;
  RequirementsStatusIcons: TRequirementIconArray;
  RequirementsRowCount: Integer;
  DiskSpaceLabel: TNewStaticText;
  BaseDiskSpaceCaption: String;

  SelectedDataDir: String;
  ConfirmedCloudInstallDir: String;
  ConfirmedCloudDataDir: String;
  CommandLineUserDataDir: String;
  CustomProgressTotal: Integer;
  CustomProgressPosition: Integer;
  CustomUninstallStatusText: String;
  HasCommandLineInstallDir: Boolean;
  CommandLinePortable: Boolean;
  FirewallTaskPreviouslySelected: Boolean;
  Heroes3CopyWasAvailable: Boolean;
  HoverPreviewTimerID: Integer;
  InstallModePreviewPanel, TasksPreviewPanel: TPanel;
  InstallModePreviewLabel, TasksPreviewLabel: TNewStaticText;
  CustomTaskChecks: array[0..10] of TNewCheckBox;
  CustomTaskNativeIndexes: array[0..10] of Integer;
  CustomTaskGroupLabels: array[0..3] of TNewStaticText;
  LastInstallModeHover, LastTasksHover: Integer;
  ReadySummaryPanel: TPanel;
  ReadyInstallCard, ReadyDataCard, ReadyModeCard, ReadyTasksCard: TPanel;
  ReadyInstallValue, ReadyDataValue, ReadyModeValue, ReadyTasksValue: TNewStaticText;
  ReadyTasksMemo: TNewMemo;

// Keep all imported APIs before the first routine implementation. Pascal Script
// does not allow new external declarations after routine bodies have started.
function WTSQuerySessionInformation(hServer: THandle; SessionId: Cardinal; WTSInfoClass: Integer; var pBuffer: NativeUInt; var BytesReturned: DWord): Boolean;
  external 'WTSQuerySessionInformationW@wtsapi32.dll stdcall';
procedure WTSFreeMemory(pMemory: NativeUInt);
  external 'WTSFreeMemory@wtsapi32.dll stdcall';
procedure RtlMoveMemoryAsString(Dest: string; Source: NativeUInt; Len: Integer);
  external 'RtlMoveMemory@kernel32.dll stdcall';
function GlobalMemoryStatusEx(var Buffer: TMemoryStatusEx): Boolean;
  external 'GlobalMemoryStatusEx@kernel32.dll stdcall';
function InternetGetConnectedState(var Flags: DWord; Reserved: DWord): Boolean;
  external 'InternetGetConnectedState@wininet.dll stdcall';
function ExpandEnvironmentStrings(Source, Destination: String; Size: Cardinal): Cardinal;
  external 'ExpandEnvironmentStringsW@kernel32.dll stdcall';
function PluginIsCloudStoragePath(Path: string): BOOL;
  external 'IsCloudStoragePath@files:installerPlugin.dll stdcall setuponly delayload';
function InstalledPluginIsCloudStoragePath(Path: string): BOOL;
  external 'IsCloudStoragePath@{app}\VCMI_installerPlugin.dll stdcall uninstallonly delayload';
function PluginModerFolderPicker(Owner: HWND; Title, Initial: string; OutPath: string; OutCch: Cardinal): BOOL;
  external 'ModerFolderPicker@files:installerPlugin.dll stdcall setuponly delayload';
function GetFileAttributes(FileName: String): Cardinal;
  external 'GetFileAttributesW@kernel32.dll stdcall';
function GetTempFileName(PathName, PrefixString: String; Unique: Cardinal; TempFileName: String): Cardinal;
  external 'GetTempFileNameW@kernel32.dll stdcall';
function GetCursorPos(var Point: TPoint): Boolean;
  external 'GetCursorPos@user32.dll stdcall';
function ScreenToClient(Window: HWND; var Point: TPoint): Boolean;
  external 'ScreenToClient@user32.dll stdcall';
function SetTimer(Window, EventID, Interval, TimerCallback: LongWord): LongWord;
  external 'SetTimer@user32.dll stdcall';
function KillTimer(Window, EventID: LongWord): Boolean;
  external 'KillTimer@user32.dll stdcall';

function EnsureNonEmptyDir(const CaptionText, DirText: String): Boolean;
begin
  Result := True;
  if Trim(DirText) = '' then
  begin
    MsgBox(Format('%s'#13#10#13#10'%s', [CaptionText, SetupMessage(msgInvalidPath)]),
      mbError, MB_OK);
    Result := False;
  end;
end;

function RegistryQueryPath(Key, ValueName: String): String;
begin
  Result := '';
  if IsWin64 and RegQueryStringValue(HKLM64, Key, ValueName, Result) then
    Exit;
  RegQueryStringValue(HKLM32, Key, ValueName, Result);
end;

function HasCommandLineSwitch(const Name: String): Boolean;
var
  Index: Integer;
  SwitchName, Argument: String;
begin
  Result := False;
  SwitchName := '/' + Name;
  for Index := 1 to ParamCount do
  begin
    Argument := ParamStr(Index);
    if (CompareText(Argument, SwitchName) = 0)
      or (CompareText(Argument, SwitchName + '=1') = 0) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure UpdateDiskSpaceLabel(); forward;
function IsCloudStoragePath(const Path: String): Boolean; forward;
function IsCloudStorageRoot(const Path: String): Boolean; forward;
function IsPortableInstall(): Boolean; forward;
function ExistingDirectoryForWriteTest(const Path: String): String; forward;
function FindTopLevelJsonStringValue(const Content, Key: String;
  var ValueStart, ValueEnd: Integer): Boolean; forward;

function ShouldRunLauncher(): Boolean;
begin
  Result := not WizardSilent or HasCommandLineSwitch('LAUNCH');
end;

function VdfValueAfter(const Content, Key: String; StartPosition: Integer;
  var Value, NextContent: String): Boolean;
var
  KeyPosition, Position, ValueEnd: Integer;
  SearchContent, SearchKey: String;
begin
  Result := False;
  Value := '';
  NextContent := '';
  SearchContent := Copy(Content, StartPosition, Length(Content));
  SearchKey := '"' + Key + '"';
  KeyPosition := Pos(UpperCase(SearchKey), UpperCase(SearchContent));
  if KeyPosition = 0 then
    Exit;

  Position := KeyPosition + Length(SearchKey);
  while (Position <= Length(SearchContent)) and (SearchContent[Position] <> '"') do
    Position := Position + 1;
  if Position > Length(SearchContent) then
    Exit;

  ValueEnd := Position + 1;
  while (ValueEnd <= Length(SearchContent)) and (SearchContent[ValueEnd] <> '"') do
    ValueEnd := ValueEnd + 1;
  if ValueEnd > Length(SearchContent) then
    Exit;

  Value := Copy(SearchContent, Position + 1, ValueEnd - Position - 1);
  StringChangeEx(Value, '\\', '\', True);
  NextContent := Copy(SearchContent, ValueEnd + 1, Length(SearchContent));
  Result := Value <> '';
end;

function LoadTextLines(const FileName: String; var Content: String): Boolean;
var
  Lines: TArrayOfString;
  Index: Integer;
begin
  Content := '';
  Result := LoadStringsFromFile(FileName, Lines);
  if not Result then
    Exit;

  for Index := 0 to GetArrayLength(Lines) - 1 do
    Content := Content + Lines[Index] + #10;
end;

function FindSteamGameInLibrary(const LibraryPath, AppId,
  FallbackInstallDir: String): String;
var
  Manifest, InstallDir, Remaining: String;
begin
  Result := '';
  if not LoadTextLines(AddBackslash(LibraryPath) +
    'steamapps\appmanifest_' + AppId + '.acf', Manifest) then
    Exit;

  InstallDir := FallbackInstallDir;
  if VdfValueAfter(Manifest, 'installdir', 1, Result, Remaining) then
    InstallDir := Result;

  Result := AddBackslash(LibraryPath) + 'steamapps\common\' + InstallDir;
  if not DirExists(Result) then
    Result := '';
end;

function FindSteamGameInstallDir(const AppId, FallbackInstallDir: String): String;
var
  SteamPath, LibraryFolders, LibraryPath, Remaining, Candidate: String;
begin
  Result := '';
  if IsWin64 then
    RegQueryStringValue(HKCU64, 'Software\Valve\Steam', 'SteamPath', SteamPath);
  if SteamPath = '' then
    RegQueryStringValue(HKCU32, 'Software\Valve\Steam', 'SteamPath', SteamPath);
  if (SteamPath = '') and IsWin64 then
    RegQueryStringValue(HKLM64, 'SOFTWARE\Valve\Steam', 'InstallPath', SteamPath);
  if SteamPath = '' then
    RegQueryStringValue(HKLM32, 'SOFTWARE\Valve\Steam', 'InstallPath', SteamPath);
  if SteamPath = '' then
    Exit;

  Result := FindSteamGameInLibrary(SteamPath, AppId, FallbackInstallDir);
  if Result <> '' then
    Exit;

  if not LoadTextLines(AddBackslash(SteamPath) +
    'steamapps\libraryfolders.vdf', LibraryFolders) then
    Exit;

  Remaining := LibraryFolders;
  while VdfValueAfter(Remaining, 'path', 1, LibraryPath, Remaining) do
  begin
    Candidate := FindSteamGameInLibrary(LibraryPath, AppId, FallbackInstallDir);
    if Candidate <> '' then
    begin
      Result := Candidate;
      Exit;
    end;
  end;
end;

function IsCloudTargetAllowed(): Boolean;
begin
  Result := HasCommandLineSwitch('ALLOWCLOUDTARGET');
end;

function ConfirmCloudTarget(const Path, WarningMessage: String;
  var ConfirmedPath: String): Boolean;
begin
  Result := True;
  if not IsCloudStoragePath(Path) then
  begin
    ConfirmedPath := '';
    Exit;
  end;
  if CompareText(ConfirmedPath, Path) = 0 then
    Exit;
  if WizardSilent then
  begin
    if not IsCloudTargetAllowed() then
      RaiseException(ExpandConstant('{cm:CloudTargetSilentError}'));
  end
  else if MsgBox(WarningMessage, mbConfirmation, MB_YESNO) <> IDYES then
  begin
    Result := False;
    Exit;
  end;
  ConfirmedPath := Path;
end;

procedure AddFolderStats(const FolderPath: String; var TotalSize: Int64;
  var FileCount: Integer);
var
  FindRec: TFindRec;
  FileSizeValue: Int64;
begin
  if FindFirst(FolderPath + '\*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Attributes and $400) <> 0 then
          Continue
        else if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
        begin
          if FileSize64(FolderPath + '\' + FindRec.Name, FileSizeValue) then
            TotalSize := TotalSize + FileSizeValue;
          FileCount := FileCount + 1;
        end
        else if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
          AddFolderStats(FolderPath + '\' + FindRec.Name, TotalSize, FileCount);
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end;
end;

function FolderContains(const FolderPath, Pattern: String): Boolean;
var
  FindRecord: TFindRec;
begin
  Result := FindFirst(AddBackslash(FolderPath) + Pattern, FindRecord);
  if Result then
    FindClose(FindRecord);
end;

procedure GetFolderStats(const FolderPath: String; var TotalSize: Int64;
  var FileCount: Integer);
begin
  TotalSize := 0;
  FileCount := 0;
  AddFolderStats(FolderPath, TotalSize, FileCount);
end;

function IsMapsFolderValid(const FolderPath: String): Boolean;
begin
  Result := DirExists(FolderPath) and FolderContains(FolderPath, '*.h3m');
end;

function IsDataFolderValid(const FolderPath: String): Boolean;
begin
  Result := DirExists(FolderPath)
    and FileExists(AddBackslash(FolderPath) + 'H3bitmap.lod')
    and FileExists(AddBackslash(FolderPath) + 'H3sprite.lod');
end;

function IsMp3FolderValid(const FolderPath: String): Boolean;
begin
  Result := DirExists(FolderPath) and FolderContains(FolderPath, '*.mp3');
end;

function IsHeroes3PathValid(const Path: String): Boolean;
begin
  Result := IsDataFolderValid(AddBackslash(Path) + 'Data')
    and IsMapsFolderValid(AddBackslash(Path) + 'Maps');
end;

procedure SetHeroes3PathIfValid(const Candidate: String);
begin
  if (Heroes3Path = '') and IsHeroes3PathValid(Candidate) then
    Heroes3Path := RemoveBackslashUnlessRoot(Candidate);
end;

function Heroes3CopySize(): Int64;
begin
  Result := 0;
  if (Heroes3MapsSize > 0) and not IsMapsFolderValid(VCMIMapsFolder) then
    Result := Result + Heroes3MapsSize;
  if (Heroes3DataSize > 0) and not IsDataFolderValid(VCMIDataFolder) then
    Result := Result + Heroes3DataSize;
  if (Heroes3Mp3Size > 0) and not IsMp3FolderValid(VCMIMp3Folder) then
    Result := Result + Heroes3Mp3Size;
end;

procedure UpdateInstallCopyProgress(const FileName: String);
begin
  CustomProgressPosition := CustomProgressPosition + 1;
  WizardForm.ProgressGauge.Position := CustomProgressPosition;
  WizardForm.FilenameLabel.Caption := MinimizePathName(
    FileName, WizardForm.FilenameLabel.Font, WizardForm.FilenameLabel.Width);
  WizardForm.Update;
end;

function CopyFolderContents(SourceDir, DestDir: String; Overwrite: Boolean): Boolean;
var
  FindRec: TFindRec;
  SourceFile, DestFile: String;
  SourceSize, DestSize: Int64;
begin
  Result := False;
  if not DirExists(SourceDir) then
  begin
    Log('Heroes III source directory is unavailable: ' + SourceDir);
    Exit;
  end;
  if not DirExists(DestDir) then
    if not ForceDirectories(DestDir) then
      Exit;

  if not FindFirst(SourceDir + '\*', FindRec) then
  begin
    Log('Failed to enumerate Heroes III source directory: ' + SourceDir);
    Exit;
  end;
  try
    repeat
        SourceFile := SourceDir + '\' + FindRec.Name;
        DestFile := DestDir + '\' + FindRec.Name;

        // Copy directory contents only. Junctions and other reparse points may
        // lead outside the selected Heroes III directory or form a cycle.
        if (FindRec.Attributes and $400) <> 0 then
          Log('Skipping Heroes III reparse point: ' + SourceFile)
        else if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
        begin
          if Overwrite or not FileExists(DestFile) then
          begin
            if not CopyFile(SourceFile, DestFile, not Overwrite) then
            begin
              Log('Failed to copy Heroes III file from ' + SourceFile + ' to ' + DestFile);
              Exit;
            end;
          end;
          if not FileSize64(SourceFile, SourceSize)
            or not FileSize64(DestFile, DestSize)
            or (SourceSize <> DestSize) then
          begin
            Log('Copied Heroes III file failed size verification: ' + DestFile);
            Exit;
          end;
          UpdateInstallCopyProgress(SourceFile);
        end
        else if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          if not CopyFolderContents(SourceFile, DestFile, Overwrite) then
            Exit;
        end;
    until not FindNext(FindRec);
  finally
    FindClose(FindRec);
  end;
  Result := True;
end;

// Setup may be elevated with credentials of a different administrator. Resolve
// the interactive session user so user-facing paths still belong to the person
// who launched Setup. NativeUInt keeps returned pointers safe in 32/64-bit Setup.
function GetCurrentSessionUserName: String;
var
  Buffer: NativeUInt;
  BytesReturned: DWord;
  QueryResult: Boolean;
begin
  Result := GetUserNameString;
  Buffer := 0;
  BytesReturned := 0;
  QueryResult := WTSQuerySessionInformation(
    WTS_CURRENT_SERVER_HANDLE, WTS_CURRENT_SESSION, WTSUserName, Buffer, BytesReturned);
  if not QueryResult or (Buffer = 0) then
    Exit;

  try
    if BytesReturned < 2 then
      Exit;
    SetLength(Result, (BytesReturned div 2) - 1);
    if Result <> '' then
      RtlMoveMemoryAsString(Result, Buffer, BytesReturned - 2)
    else
      Result := GetUserNameString;
  finally
    WTSFreeMemory(Buffer);
  end;
end;

function GetBranchSuffix(Param: string): string;
var
  Branch: string;
begin
  Branch := UpperCase(ExpandConstant('{#VCMIFolder}'));

  if Pos('(BRANCH BETA)', Branch) > 0 then
    Result := ' (Beta)'
  else
  if Pos('(BRANCH DEVELOP)', Branch) > 0 then
    Result := ' (Develop)'
  else
    Result := '';
end;

function GetCommonProgramFilesDir: String;
begin
  if ExpandConstant('{#InstallerArch}') = 'arm64' then
    // The ARM64 payload belongs in native Program Files even though its Setup bootstrapper is x86.
    Result := ExpandConstant('{commonpf64}')
  else if IsARM64 then
  begin
    if ExpandConstant('{#InstallerArch}') = 'x86' then
      // For 32-bit installer on ARM64, return the 32-bit Program Files directory
      Result := ExpandConstant('{commonpf32}')
    else
      // For AMR64 installer, return the Program Files directory
      Result := ExpandConstant('{commonpf}')
  end
  else if IsWin64 then
  begin
    if ExpandConstant('{#InstallerArch}') = 'x64' then
      // For 64-bit installer, return the 64-bit Program Files directory
      Result := ExpandConstant('{commonpf64}')
    else
      // For 32-bit installer on 64-bit system, return the 32-bit Program Files directory
      Result := ExpandConstant('{commonpf32}');
  end
  else
    // On 32-bit systems, always return the 32-bit Program Files directory
    Result := ExpandConstant('{commonpf32}');
end;

function GetDefaultDir(Default: String): String;
begin
  if IsAdminInstallMode then
    // Default to Program Files for admins
    Result := GetCommonProgramFilesDir + '\{#VCMIFolder}'
  else
    // Default to User AppData for non-admin users
    Result := GlobalUserAppdataFolder + '\{#VCMIFolder}';
end;

function GetUserFolderPath(Constant: String): String;
var
  FolderPath, OriginalUserName, CurrentSessionUserName: String;
begin
  CurrentSessionUserName := '\' + GlobalUserName + '\';
  OriginalUserName := '\' + GetUserNameString + '\';
  FolderPath := ExpandConstant(Constant);
  StringChangeEx(FolderPath, OriginalUserName, CurrentSessionUserName, True);
  Result := FolderPath;
end;

procedure OnTaskCheck(Sender: TObject);
var
  FirewallSelected: Boolean;
begin
  FirewallSelected := WizardIsTaskSelected('firewallrules');
  if FirewallTaskPreviouslySelected and not FirewallSelected then
  begin
    MsgBox(ExpandConstant('{cm:Warning}') + '!' + #13#10 + #13#10 + ExpandConstant('{cm:InstallForMeOnly1}') + #13#10 + ExpandConstant('{cm:InstallForMeOnly2}'), mbError, MB_OK);
  end;
  FirewallTaskPreviouslySelected := FirewallSelected;
  UpdateDiskSpaceLabel();
end;

function InstallModePreview(Index: Integer): String;
begin
  Result := '';
  case Index of
    0: Result := ExpandConstant('{cm:InstallForAllUsers}') + ' — ' +
      ExpandConstant('{cm:InstallForAllUsers1}');
    1: Result := ExpandConstant('{cm:InstallForMeOnly}') + ' — ' +
      ExpandConstant('{cm:InstallForMeOnly1}') + ' ' +
      ExpandConstant('{cm:InstallForMeOnly2}');
    2: Result := ExpandConstant('{cm:InstallPortable}') + ' — ' +
      ExpandConstant('{cm:InstallPortable1}') + ' ' +
      ExpandConstant('{cm:InstallPortable2}') + ' ' +
      ExpandConstant('{cm:InstallForMeOnly2}');
  end;
end;

function TaskPreview(Index: Integer): String;
var
  CaptionText: String;
begin
  Result := '';
  if (Index < 0) or (Index >= WizardForm.TasksList.Items.Count) then
    Exit;
  CaptionText := WizardForm.TasksList.ItemCaption[Index];
  if CompareText(CaptionText, ExpandConstant('{cm:ShortcutLauncher}')) = 0 then
    Result := CaptionText + ' — ' + ExpandConstant('{cm:ShortcutLauncherComment}')
  else if CompareText(CaptionText, ExpandConstant('{cm:ShortcutMapEditor}')) = 0 then
    Result := CaptionText + ' — ' + ExpandConstant('{cm:ShortcutMapEditorComment}')
  else if CompareText(CaptionText, ExpandConstant('{cm:ShortcutWebPage}')) = 0 then
    Result := CaptionText + ' — ' + ExpandConstant('{cm:ShortcutWebPageComment}')
  else if CompareText(CaptionText, ExpandConstant('{cm:ShortcutDiscord}')) = 0 then
    Result := CaptionText + ' — ' + ExpandConstant('{cm:ShortcutDiscordComment}')
  else if CompareText(CaptionText, ExpandConstant('{cm:H3MDescription}')) = 0 then
    Result := CaptionText + ' (.h3m) — ' + ExpandConstant('{cm:AssociateH3MFiles}')
  else if CompareText(CaptionText, ExpandConstant('{cm:H3CDescription}')) = 0 then
    Result := CaptionText + ' (.h3c) — ' + ExpandConstant('{cm:AssociateH3CFiles}')
  else if CompareText(CaptionText, ExpandConstant('{cm:VMAPDescription}')) = 0 then
    Result := CaptionText + ' (.vmap) — ' + ExpandConstant('{cm:AssociateVCMIMapFiles}')
  else if CompareText(CaptionText, ExpandConstant('{cm:VCMPDescription}')) = 0 then
    Result := CaptionText + ' (.vcmp) — ' + ExpandConstant('{cm:AssociateVCMIMapFiles}')
  else if CompareText(CaptionText, ExpandConstant('{cm:AddFirewallRules}')) = 0 then
    Result := CaptionText + ' — ' + ExpandConstant('{cm:InstallForMeOnly2}');
end;

procedure MapCustomTaskItems();
var
  Index, OptionIndex, LauncherCount, EditorCount: Integer;
  CaptionText: String;
begin
  for OptionIndex := 0 to 10 do
    CustomTaskNativeIndexes[OptionIndex] := -1;
  LauncherCount := 0;
  EditorCount := 0;
  for Index := 0 to WizardForm.TasksList.Items.Count - 1 do
  begin
    CaptionText := WizardForm.TasksList.ItemCaption[Index];
    if CompareText(CaptionText, ExpandConstant('{cm:ShortcutLauncher}')) = 0 then
    begin
      if LauncherCount = 0 then
        CustomTaskNativeIndexes[0] := Index
      else
        CustomTaskNativeIndexes[4] := Index;
      LauncherCount := LauncherCount + 1;
    end
    else if CompareText(CaptionText, ExpandConstant('{cm:ShortcutMapEditor}')) = 0 then
    begin
      if EditorCount = 0 then
        CustomTaskNativeIndexes[1] := Index
      else
        CustomTaskNativeIndexes[5] := Index;
      EditorCount := EditorCount + 1;
    end
    else if CompareText(CaptionText, ExpandConstant('{cm:ShortcutWebPage}')) = 0 then
      CustomTaskNativeIndexes[2] := Index
    else if CompareText(CaptionText, ExpandConstant('{cm:ShortcutDiscord}')) = 0 then
      CustomTaskNativeIndexes[3] := Index
    else if CompareText(CaptionText, ExpandConstant('{cm:VMAPDescription}')) = 0 then
      CustomTaskNativeIndexes[6] := Index
    else if CompareText(CaptionText, ExpandConstant('{cm:VCMPDescription}')) = 0 then
      CustomTaskNativeIndexes[7] := Index
    else if CompareText(CaptionText, ExpandConstant('{cm:H3MDescription}')) = 0 then
      CustomTaskNativeIndexes[8] := Index
    else if CompareText(CaptionText, ExpandConstant('{cm:H3CDescription}')) = 0 then
      CustomTaskNativeIndexes[9] := Index
    else if CompareText(CaptionText, ExpandConstant('{cm:AddFirewallRules}')) = 0 then
      CustomTaskNativeIndexes[10] := Index;
  end;

  for OptionIndex := 0 to 10 do
  begin
    CustomTaskChecks[OptionIndex].Visible :=
      CustomTaskNativeIndexes[OptionIndex] >= 0;
    if CustomTaskChecks[OptionIndex].Visible then
    begin
      CustomTaskChecks[OptionIndex].Checked :=
        WizardForm.TasksList.Checked[CustomTaskNativeIndexes[OptionIndex]];
      CustomTaskChecks[OptionIndex].Enabled :=
        WizardForm.TasksList.ItemEnabled[CustomTaskNativeIndexes[OptionIndex]];
    end;
  end;
  CustomTaskGroupLabels[3].Visible := CustomTaskNativeIndexes[10] >= 0;
end;

procedure CustomTaskCheckClick(Sender: TObject);
var
  OptionIndex, NativeIndex: Integer;
begin
  for OptionIndex := 0 to 10 do
    if Sender = CustomTaskChecks[OptionIndex] then
    begin
      NativeIndex := CustomTaskNativeIndexes[OptionIndex];
      if NativeIndex >= 0 then
      begin
        WizardForm.TasksList.Checked[NativeIndex] :=
          CustomTaskChecks[OptionIndex].Checked;
        OnTaskCheck(Sender);
      end;
      Exit;
    end;
end;

function CreateCustomTaskGroup(const CaptionText: String;
  LeftPos, TopPos, Width: Integer): TNewStaticText;
begin
  Result := TNewStaticText.Create(WizardForm.SelectTasksPage);
  Result.Parent := WizardForm.TasksList.Parent;
  Result.Left := LeftPos;
  Result.Top := TopPos;
  Result.Width := Width;
  Result.Height := ScaleY(18);
  Result.AutoSize := False;
  Result.Caption := CaptionText;
  Result.Font.Style := [fsBold];
end;

procedure CreateCustomTaskOption(Index: Integer; const CaptionText: String;
  LeftPos, TopPos, Width: Integer);
begin
  CustomTaskChecks[Index] := TNewCheckBox.Create(WizardForm.SelectTasksPage);
  CustomTaskChecks[Index].Parent := WizardForm.TasksList.Parent;
  CustomTaskChecks[Index].Left := LeftPos;
  CustomTaskChecks[Index].Top := TopPos;
  CustomTaskChecks[Index].Width := Width;
  CustomTaskChecks[Index].Height := ScaleY(19);
  CustomTaskChecks[Index].Caption := CaptionText;
  CustomTaskChecks[Index].OnClick := @CustomTaskCheckClick;
end;

function HoveredCustomTaskNativeIndex(): Integer;
var
  Cursor: TPoint;
  OptionIndex: Integer;
begin
  Result := -1;
  if not GetCursorPos(Cursor) or
    not ScreenToClient(WizardForm.TasksList.Parent.Handle, Cursor) then
    Exit;
  for OptionIndex := 0 to 10 do
    if CustomTaskChecks[OptionIndex].Visible and
      (Cursor.X >= CustomTaskChecks[OptionIndex].Left) and
      (Cursor.X < CustomTaskChecks[OptionIndex].Left + CustomTaskChecks[OptionIndex].Width) and
      (Cursor.Y >= CustomTaskChecks[OptionIndex].Top) and
      (Cursor.Y < CustomTaskChecks[OptionIndex].Top + CustomTaskChecks[OptionIndex].Height) then
    begin
      Result := CustomTaskNativeIndexes[OptionIndex];
      Exit;
    end;
end;

function HoveredCheckListItem(CheckList: TNewCheckListBox): Integer;
var
  Cursor: TPoint;
  HitResult: Integer;
begin
  Result := -1;
  if not GetCursorPos(Cursor) or not ScreenToClient(CheckList.Handle, Cursor) then
    Exit;
  if (Cursor.X < 0) or (Cursor.Y < 0) or
    (Cursor.X >= CheckList.ClientWidth) or (Cursor.Y >= CheckList.ClientHeight) then
    Exit;
  HitResult := SendMessage(CheckList.Handle, $01A9, 0,
    (Cursor.Y shl 16) or (Cursor.X and $FFFF));
  if ((HitResult shr 16) and $FFFF) = 0 then
    Result := HitResult and $FFFF;
  if Result >= CheckList.Items.Count then
    Result := -1;
end;

procedure HoverPreviewTimerTick(Arg1, Arg2, Arg3, Arg4: LongWord);
var
  Index: Integer;
  PreviewText: String;
  Cursor: TPoint;
begin
  if Assigned(InstallModePage) and (WizardForm.CurPageID = InstallModePage.ID) then
  begin
    Index := -1;
    if GetCursorPos(Cursor) and ScreenToClient(InstallModePage.Surface.Handle, Cursor) then
    begin
      if (Cursor.X >= InstallModePage.CheckListBox.Left) and
        (Cursor.X < InstallModeRowPanels[0].Left + InstallModeRowPanels[0].Width) then
      begin
        if (Cursor.Y >= InstallModeRowPanels[0].Top) and
          (Cursor.Y < InstallModeRowPanels[0].Top + InstallModeRowPanels[0].Height) then
          Index := 0
        else if (Cursor.Y >= InstallModeRowPanels[1].Top) and
          (Cursor.Y < InstallModeRowPanels[1].Top + InstallModeRowPanels[1].Height) then
          Index := 1
        else if (Cursor.Y >= InstallModeRowPanels[2].Top) and
          (Cursor.Y < InstallModeRowPanels[2].Top + InstallModeRowPanels[2].Height) then
          Index := 2;
      end;
    end;
    if Index < 0 then
      Index := InstallModePage.SelectedValueIndex;
    if Index <> LastInstallModeHover then
    begin
      LastInstallModeHover := Index;
      InstallModePreviewLabel.Caption := InstallModePreview(Index);
    end;
  end
  else if WizardForm.CurPageID = wpSelectTasks then
  begin
    Index := HoveredCustomTaskNativeIndex();
    if Index >= 0 then
    begin
      PreviewText := TaskPreview(Index);
      if (PreviewText <> '') and (Index <> LastTasksHover) then
      begin
        LastTasksHover := Index;
        TasksPreviewLabel.Caption := PreviewText;
      end
      else if PreviewText = '' then
      begin
        LastTasksHover := -1;
        TasksPreviewLabel.Caption := '';
      end;
    end
    else if LastTasksHover <> -1 then
    begin
      LastTasksHover := -1;
      TasksPreviewLabel.Caption := '';
    end;
  end;
end;

// Specific functions for user folders
function GetUserDocsFolder: String;
begin
  Result := GetUserFolderPath('{userdocs}');
end;

function GetUserAppdataFolder: String;
begin
  Result := GetUserFolderPath('{userappdata}');
end;

function GetUserDesktopFolder(Default: String): String;
begin
  Result := GetUserFolderPath('{userdesktop}');
end;

function EscapeJsonString(Value: String): String;
begin
  Result := Value;
  StringChangeEx(Result, '\', '\\', True);
  StringChangeEx(Result, '"', '\"', True);
end;

function LoadUTF8TextFile(const FileName: String; var Content: String): Boolean;
var
  Lines: TArrayOfString;
  Index: Integer;
begin
  Content := '';
  Result := LoadStringsFromFile(FileName, Lines);
  if not Result then
    Exit;

  for Index := 0 to GetArrayLength(Lines) - 1 do
  begin
    if Index > 0 then
      Content := Content + #13#10;
    Content := Content + Lines[Index];
  end;
end;

function SaveUTF8TextFile(const FileName, Content: String): Boolean;
var
  Lines: TArrayOfString;
begin
  SetArrayLength(Lines, 1);
  Lines[0] := Content;
  Result := SaveStringsToUTF8FileWithoutBOM(FileName, Lines, False);
end;

function ExpandEnvironmentPath(const Value: String): String;
var
  ExpandedSize: Cardinal;
begin
  Result := Value;
  ExpandedSize := ExpandEnvironmentStrings(Value, '', 0);
  if ExpandedSize = 0 then
    Exit;

  SetLength(Result, ExpandedSize);
  if ExpandEnvironmentStrings(Value, Result, ExpandedSize) <> ExpandedSize then
  begin
    Result := Value;
    Exit;
  end;
  SetLength(Result, ExpandedSize - 1);
end;

function ReadPathFromConfig(const InstallDir, Key, Fallback: String): String;
var
  Content, ConfigFile, Value: String;
  Position, ValueStart, ValueEnd: Integer;
  Escaped: Boolean;
begin
  Result := Fallback;
  ConfigFile := AddBackslash(InstallDir) + 'config\dirs.json';
  if not LoadUTF8TextFile(ConfigFile, Content) then
    Exit;

  if not FindTopLevelJsonStringValue(Content, Key, ValueStart, ValueEnd) then
    Exit;

  Position := ValueStart;
  Escaped := False;
  while Position < ValueEnd do
  begin
    if Escaped then
    begin
      Value := Value + Content[Position];
      Escaped := False;
    end
    else if Content[Position] = '\' then
      Escaped := True
    else
      Value := Value + Content[Position];
    Position := Position + 1;
  end;
  Result := ExpandEnvironmentPath(Value);
end;

function GetSelectedDataDir(Default: String): String;
begin
  Result := SelectedDataDir;
end;

function ReadUserDataPath(const InstallDir, Fallback: String): String;
begin
  // Preserve the path of legacy upgrades. New installations write dirs.json
  // directly and never create this registry fallback.
  if IsWin64 then
    if RegQueryStringValue(HKCU64, 'Software\VCMI', 'userDataPath', Result) then
      Exit;
  if RegQueryStringValue(HKCU32, 'Software\VCMI', 'userDataPath', Result) then
    Exit;
  Result := ReadPathFromConfig(InstallDir, 'userDataPath', Fallback);
end;

function ReadArchitectureValue(const Architecture, ValueName: String; var Value: String): Boolean;
var
  Key: String;
begin
  Key := 'Software\VCMI\Installer\' + Architecture;
  Result := False;
  if IsWin64 then
    Result := RegQueryStringValue(HKCU64, Key, ValueName, Value);
  if not Result then
    Result := RegQueryStringValue(HKCU32, Key, ValueName, Value);
  if not Result and IsWin64 then
    Result := RegQueryStringValue(HKLM64, Key, ValueName, Value);
  if not Result then
    Result := RegQueryStringValue(HKLM32, Key, ValueName, Value);
end;

function ReadArchitectureInstallPath(const Architecture: String; var InstallPath: String): Boolean;
var
  UninstallKey: String;
begin
  if ReadArchitectureValue(Architecture, 'InstallPath', InstallPath) then
  begin
    Result := True;
    Exit;
  end;

  // Installers created before per-architecture metadata still have an Inno
  // uninstall entry. Check both views because their Setup process was x86.
  UninstallKey := 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#VCMIFolder}.'
    + Architecture + '_is1';
  Result := False;
  if IsWin64 then
  begin
    Result := RegQueryStringValue(HKCU64, UninstallKey, 'InstallLocation', InstallPath);
    if not Result then
      Result := RegQueryStringValue(HKLM64, UninstallKey, 'InstallLocation', InstallPath);
  end;
  if not Result then
    Result := RegQueryStringValue(HKCU32, UninstallKey, 'InstallLocation', InstallPath);
  if not Result then
    Result := RegQueryStringValue(HKLM32, UninstallKey, 'InstallLocation', InstallPath);
end;

function UseAlternativeMapEditor(const InstallPath: String; var MapEditorPath: String): Boolean;
begin
  MapEditorPath := AddBackslash(InstallPath) + 'VCMI_mapeditor.exe';
  Result := (CompareText(RemoveBackslashUnlessRoot(InstallPath),
    RemoveBackslashUnlessRoot(ExpandConstant('{app}'))) <> 0)
    and FileExists(MapEditorPath);
end;

function FindOtherMapEditor(var MapEditorPath: String): Boolean;
var
  InstallPath: String;
begin
  Result := False;
  if (CompareText('{#InstallerArch}', 'x64') <> 0)
    and ReadArchitectureInstallPath('x64', InstallPath)
    and UseAlternativeMapEditor(InstallPath, MapEditorPath) then
    Result := True
  else if (CompareText('{#InstallerArch}', 'arm64') <> 0)
    and ReadArchitectureInstallPath('arm64', InstallPath)
    and UseAlternativeMapEditor(InstallPath, MapEditorPath) then
    Result := True
  else if (CompareText('{#InstallerArch}', 'x86') <> 0)
    and ReadArchitectureInstallPath('x86', InstallPath)
    and UseAlternativeMapEditor(InstallPath, MapEditorPath) then
    Result := True;
end;

function IntegrationRegistryRoot: Integer;
begin
  if IsAdminInstallMode then
    Result := HKLM
  else
    Result := HKCU;
end;

procedure MaintainFileAssociation(const Extension, ProgId, Description: String);
var
  RootKey: Integer;
  CommandKey, CurrentCommand, CurrentProgId, ReplacementEditor: String;
begin
  RootKey := IntegrationRegistryRoot;
  CommandKey := 'Software\Classes\' + ProgId + '\shell\open\command';
  if not RegQueryStringValue(RootKey, CommandKey, '', CurrentCommand) then
    Exit;

  // A coexisting architecture may have replaced this association after this
  // setup ran. Never remove an association owned by that newer installation.
  if CompareText(CurrentCommand,
    '"' + ExpandConstant('{app}\VCMI_mapeditor.exe') + '" "%1"') <> 0 then
    Exit;

  if FindOtherMapEditor(ReplacementEditor) then
  begin
    RegWriteStringValue(RootKey, 'Software\Classes\' + Extension, '', ProgId);
    RegWriteStringValue(RootKey, 'Software\Classes\' + ProgId, '', Description);
    RegWriteStringValue(RootKey, CommandKey, '', '"' + ReplacementEditor + '" "%1"');
    Log('File association ' + Extension + ' transferred to ' + ReplacementEditor);
  end
  else
  begin
    RegDeleteKeyIncludingSubkeys(RootKey, 'Software\Classes\' + ProgId);
    if RegQueryStringValue(RootKey, 'Software\Classes\' + Extension, '', CurrentProgId)
      and (CompareText(CurrentProgId, ProgId) = 0) then
      RegDeleteValue(RootKey, 'Software\Classes\' + Extension, '');
  end;
end;

function ReadUninstallUserDataPath(const InstallDir, Fallback: String): String;
begin
  Result := ReadUserDataPath(InstallDir, '');
  if Result <> '' then
    Exit;
  if ReadArchitectureValue('{#InstallerArch}', 'userDataPath', Result) then
    Exit;
  Result := Fallback;
end;

function ReadRuntimePath(const InstallDir, Key, Fallback: String): String;
begin
  // This mirrors VCMIDirsWIN32::getPathFromConfigOrDefault. Architecture-specific
  // registry values below are installer ownership metadata, not runtime paths.
  if IsWin64 then
    if RegQueryStringValue(HKCU64, 'Software\VCMI', Key, Result) then
      Exit;
  if RegQueryStringValue(HKCU32, 'Software\VCMI', Key, Result) then
    Exit;
  Result := ReadPathFromConfig(InstallDir, Key, Fallback);
end;

function IsSameOrChildPath(const Path, Parent: String): Boolean;
var
  NormalizedPath, NormalizedParent: String;
begin
  NormalizedPath := RemoveBackslashUnlessRoot(Path);
  NormalizedParent := RemoveBackslashUnlessRoot(Parent);
  Result := CompareText(NormalizedPath, NormalizedParent) = 0;
  if not Result and (Length(NormalizedPath) > Length(NormalizedParent)) then
    Result := (CompareText(Copy(NormalizedPath, 1, Length(NormalizedParent)), NormalizedParent) = 0)
      and (NormalizedPath[Length(NormalizedParent) + 1] = '\');
end;

function PathsOverlap(const First, Second: String): Boolean;
begin
  Result := IsSameOrChildPath(First, Second) or IsSameOrChildPath(Second, First);
end;

function IsProtectedUserFolder(const Path: String): Boolean;
var
  NormalizedPath, UserProfile: String;
begin
  NormalizedPath := RemoveBackslashUnlessRoot(ExpandFileName(Path));
  UserProfile := RemoveBackslashUnlessRoot(
    ExtractFileDir(ExtractFileDir(GlobalUserAppdataFolder)));
  Result := (CompareText(NormalizedPath, UserProfile) = 0)
    or (CompareText(NormalizedPath, RemoveBackslashUnlessRoot(GlobalUserDocsFolder)) = 0)
    or (CompareText(NormalizedPath, RemoveBackslashUnlessRoot(GetUserDesktopFolder(''))) = 0)
    or (CompareText(NormalizedPath, RemoveBackslashUnlessRoot(GlobalUserAppdataFolder)) = 0)
    or (CompareText(NormalizedPath,
      RemoveBackslashUnlessRoot(GetUserFolderPath('{localappdata}'))) = 0)
    or (CompareText(NormalizedPath, UserProfile + '\Downloads') = 0)
    or (CompareText(NormalizedPath, UserProfile + '\Music') = 0)
    or (CompareText(NormalizedPath, UserProfile + '\Pictures') = 0)
    or (CompareText(NormalizedPath, UserProfile + '\Videos') = 0)
    or IsCloudStorageRoot(NormalizedPath);
end;

function IsSafeUninstallRoot(const Path: String): Boolean;
var
  NormalizedPath, UserProfile: String;
begin
  NormalizedPath := RemoveBackslashUnlessRoot(ExpandFileName(Path));
  Result := (NormalizedPath <> '')
    and (CompareText(NormalizedPath, AddBackslash(ExtractFileDrive(NormalizedPath))) <> 0);
  if not Result then
    Exit;

  UserProfile := ExtractFileDir(ExtractFileDir(GlobalUserAppdataFolder));
  Result := not PathsOverlap(NormalizedPath, ExpandConstant('{win}'))
    and not PathsOverlap(NormalizedPath, ExpandConstant('{commonpf32}'))
    and not IsSameOrChildPath(UserProfile, NormalizedPath)
    and not IsProtectedUserFolder(NormalizedPath)
    and not PathsOverlap(NormalizedPath, ExpandConstant('{app}'));
  if Result and IsWin64 then
    Result := not PathsOverlap(NormalizedPath, ExpandConstant('{commonpf64}'));
end;

function ArchitectureUsesPath(const Architecture, Path: String): Boolean;
var
  InstallPath, DataPath, CachePath, ConfigPath, LogsPath, SavesPath: String;
begin
  Result := False;
  if CompareText(Architecture, '{#InstallerArch}') = 0 then
    Exit;
  if not ReadArchitectureInstallPath(Architecture, InstallPath) then
    Exit;

  DataPath := ReadRuntimePath(InstallPath, 'userDataPath', '');
  if DataPath = '' then
    ReadArchitectureValue(Architecture, 'userDataPath', DataPath);
  if DataPath = '' then
    Exit;

  CachePath := ReadRuntimePath(InstallPath, 'userCachePath', DataPath + '\cache');
  ConfigPath := ReadRuntimePath(InstallPath, 'userConfigPath', DataPath + '\config');
  LogsPath := ReadRuntimePath(InstallPath, 'userLogsPath', DataPath + '\logs');
  SavesPath := ReadRuntimePath(InstallPath, 'userSavePath', DataPath + '\saves');
  Result := PathsOverlap(Path, DataPath) or PathsOverlap(Path, CachePath)
    or PathsOverlap(Path, ConfigPath) or PathsOverlap(Path, LogsPath)
    or PathsOverlap(Path, SavesPath);
end;

function IsPathUsedByOtherInstallation(const Path: String): Boolean;
begin
  Result := ArchitectureUsesPath('x86', Path)
    or ArchitectureUsesPath('x64', Path)
    or ArchitectureUsesPath('arm64', Path);
end;

function ArchitectureInstallPathOverlaps(const Architecture, Path: String): Boolean;
var
  OtherInstallPath: String;
begin
  Result := False;
  { A normal setup may update its own architecture in place. Portable setup has
    no ownership metadata and must not overwrite any registered installation. }
  if not IsPortableInstall
    and (CompareText(Architecture, '{#InstallerArch}') = 0) then
    Exit;
  if ReadArchitectureInstallPath(Architecture, OtherInstallPath) then
    Result := PathsOverlap(Path, OtherInstallPath);
end;

function IsInstallPathUsedByRegisteredInstallation(const Path: String): Boolean;
begin
  Result := ArchitectureInstallPathOverlaps('x86', Path)
    or ArchitectureInstallPathOverlaps('x64', Path)
    or ArchitectureInstallPathOverlaps('arm64', Path);
end;

procedure AddUninstallPath(const Path, Description: String);
var
  Index, WriteIndex: Integer;
  NormalizedPath: String;
begin
  NormalizedPath := RemoveBackslashUnlessRoot(Path);
  if NormalizedPath = '' then
    Exit;
  if not IsSafeUninstallRoot(NormalizedPath) then
  begin
    Log('Refusing unsafe user-data deletion root: ' + NormalizedPath);
    Exit;
  end;
  for Index := 0 to UninstallPathCount - 1 do
    if IsSameOrChildPath(NormalizedPath, UninstallPaths[Index]) then
      Exit;

  { If the parent is discovered after one or more children, replace all of those
    children with the parent. This keeps every checkbox independent. }
  WriteIndex := 0;
  for Index := 0 to UninstallPathCount - 1 do
  begin
    if not IsSameOrChildPath(UninstallPaths[Index], NormalizedPath) then
    begin
      if WriteIndex <> Index then
      begin
        UninstallPaths[WriteIndex] := UninstallPaths[Index];
        UninstallPathDescriptions[WriteIndex] := UninstallPathDescriptions[Index];
        UninstallPathProtected[WriteIndex] := UninstallPathProtected[Index];
      end;
      WriteIndex := WriteIndex + 1;
    end;
  end;
  UninstallPathCount := WriteIndex;

  if UninstallPathCount > 4 then
    Exit;

  UninstallPaths[UninstallPathCount] := NormalizedPath;
  UninstallPathDescriptions[UninstallPathCount] := Description;
  UninstallPathProtected[UninstallPathCount] := IsPathUsedByOtherInstallation(NormalizedPath);
  UninstallPathCount := UninstallPathCount + 1;
end;

procedure LoadUninstallPaths(const InstallDir, DataPath: String);
var
  CachePath: String;
begin
  UninstallPathCount := 0;
  CachePath := ReadRuntimePath(InstallDir, 'userCachePath', DataPath + '\cache');
  AddUninstallPath(DataPath, ExpandConstant('{cm:UserDataDirectory}'));
  AddUninstallPath(CachePath, ExpandConstant('{cm:CacheDirectory}'));
  AddUninstallPath(ReadRuntimePath(InstallDir, 'userConfigPath', DataPath + '\config'), ExpandConstant('{cm:ConfigDirectory}'));
  AddUninstallPath(ReadRuntimePath(InstallDir, 'userLogsPath', DataPath + '\logs'), ExpandConstant('{cm:LogsDirectory}'));
  AddUninstallPath(ReadRuntimePath(InstallDir, 'userSavePath', DataPath + '\saves'), ExpandConstant('{cm:SavesDirectory}'));
end;

function IsCloudStoragePath(const Path: String): Boolean;
begin
  Result := False;
  try
    Result := PluginIsCloudStoragePath(Path);
  except
    try
      Result := InstalledPluginIsCloudStoragePath(Path);
    except
      // Cloud detection is advisory. A missing or incompatible plugin must not
      // prevent setup or uninstall from running on supported Windows versions.
      Log('Cloud storage detection plugin is unavailable for: ' + Path);
    end;
  end;
end;

procedure UpdateDataFolders(const Root: String);
begin
  VCMIMapsFolder := Root + '\Maps';
  VCMIDataFolder := Root + '\Data';
  VCMIMp3Folder := Root + '\Mp3';
end;

function IsUCRTNeeded: Boolean;
var
  FileName: String;
begin
  Result := True; // Default to copy the file

  FileName := ExtractFileName(ExpandConstant(CurrentFileName));

  // Only check system if the file name contains "api"
  if Pos('API', UpperCase(FileName)) = 1 then
  begin
    // Check existence based on architecture
    if IsWin64 then
    begin
      if ExpandConstant('{#InstallerArch}') = 'arm64' then
        // ARM64 uses an x86 bootstrapper, so bypass WOW64 redirection.
        Result := not FileExists(ExpandConstant('{sysnative}\' + FileName))
      else if ExpandConstant('{#InstallerArch}') = 'x64' then
        Result := not FileExists(ExpandConstant('{win}\System32\' + FileName))
      else
        // For 32-bit installer on 64-bit OS, check SysWOW64
        Result := not FileExists(ExpandConstant('{win}\SysWOW64\' + FileName));
    end
    else
      // For 32-bit OS, always check System32
      Result := not FileExists(ExpandConstant('{win}\System32\' + FileName));
  end;
end;

function IsHeroes3Installed(): Boolean;
begin
  Result := False;

  if (Heroes3Path <> '') then
    Result := True;

end;

function IsCopyFilesNeeded(): Boolean;
begin
  Result := not (IsDataFolderValid(VCMIDataFolder)
    and IsMapsFolderValid(VCMIMapsFolder) and IsMp3FolderValid(VCMIMp3Folder));

end;

function IsPRInstaller(): Boolean;
begin
  // Skip Tasks page if this is a PR build
  Result := Pos('-PR-', ExpandConstant('{#InstallerName}')) > 0;

end;

function IsPortableInstall(): Boolean;
begin
  Result := CommandLinePortable
    or (Assigned(InstallModePage) and (InstallModePage.SelectedValueIndex = 2));
end;

function ExpandCommandLinePath(const Value: String): String;
begin
  Result := Value;
  if CompareText(Copy(Value, 1, 7), 'expand:') = 0 then
    Result := ExpandConstant(Copy(Value, 8, Length(Value)));
end;

function FormatByteSize(const Bytes: Int64): String;
var
  Divisor, WholeValue, TenthsValue: Int64;
  DecimalSeparator, UnitName: String;
begin
  if Bytes >= Int64(1024) * 1024 * 1024 * 1024 then
  begin
    Divisor := Int64(1024) * 1024 * 1024 * 1024;
    UnitName := 'TB';
  end
  else if Bytes >= Int64(1024) * 1024 * 1024 then
  begin
    Divisor := Int64(1024) * 1024 * 1024;
    UnitName := 'GB';
  end
  else if Bytes >= Int64(1024) * 1024 then
  begin
    Divisor := Int64(1024) * 1024;
    UnitName := 'MB';
  end
  else if Bytes >= 1024 then
  begin
    Divisor := 1024;
    UnitName := 'KB';
  end
  else
  begin
    Result := IntToStr(Bytes) + ' B';
    Exit;
  end;

  WholeValue := Bytes div Divisor;
  TenthsValue := (((Bytes mod Divisor) * 10) + (Divisor div 2)) div Divisor;
  if TenthsValue = 10 then
  begin
    WholeValue := WholeValue + 1;
    TenthsValue := 0;
  end;
  DecimalSeparator := Copy(FloatToStr(1.5), 2, 1);
  Result := IntToStr(WholeValue) + DecimalSeparator +
    IntToStr(TenthsValue) + ' ' + UnitName;
end;

function FormatLocalizedByteMessage(const MessageTemplate: String;
  const Bytes: Int64): String;
begin
  { Existing translations include a hard-coded MB after %s. Remove that unit
    around a marker, then substitute the adaptively formatted size. }
  Result := Format(MessageTemplate, ['{SIZE}']);
  StringChangeEx(Result, ' MB', '', False);
  StringChangeEx(Result, 'MB ', '', False);
  StringChangeEx(Result, ' МБ', '', False);
  StringChangeEx(Result, 'МБ ', '', False);
  StringChangeEx(Result, '{SIZE}', FormatByteSize(Bytes), False);
end;

procedure UpdateDiskSpaceLabel();
var
  ImportSize: Int64;
begin
  if not Assigned(DiskSpaceLabel) then
    Exit;

  DiskSpaceLabel.Caption := BaseDiskSpaceCaption;
  if IsHeroes3Installed and IsCopyFilesNeeded and CopyHeroes3DataSelected then
  begin
    ImportSize := Heroes3CopySize();
    DiskSpaceLabel.Caption := DiskSpaceLabel.Caption + #13#10 +
      FormatLocalizedByteMessage(
        ExpandConstant('{cm:RequirementRequiredSpaceValue}'), ImportSize);
  end;
  DiskSpaceLabel.Top := DiskSpaceLabel.Parent.Height -
    DiskSpaceLabel.Height - ScaleY(7);
end;

function HasSpaceForHeroes3Import(): Boolean;
var
  FreeSpace, TotalSpace, RequiredSpace: Int64;
  ProbeDirectory: String;
begin
  Result := True;
  if not (CopyHeroes3DataSelected and IsCopyFilesNeeded) then
    Exit;
  RequiredSpace := Heroes3CopySize();
  if RequiredSpace <= 0 then
    Exit;
  ProbeDirectory := ExistingDirectoryForWriteTest(Trim(DataDirEdit.Text));
  Result := (ProbeDirectory <> '') and
    GetSpaceOnDisk64(ProbeDirectory, FreeSpace, TotalSpace) and
    (FreeSpace >= RequiredSpace);
end;

function ExistingDirectoryForWriteTest(const Path: String): String;
var
  ParentPath: String;
begin
  Result := RemoveBackslashUnlessRoot(ExpandFileName(Path));
  while (Result <> '') and not DirExists(Result) do
  begin
    ParentPath := RemoveBackslashUnlessRoot(ExtractFileDir(Result));
    if CompareText(ParentPath, Result) = 0 then
    begin
      Result := '';
      Exit;
    end;
    Result := ParentPath;
  end;
end;

function IsCloudStorageRoot(const Path: String): Boolean;
var
  NormalizedPath, ParentPath: String;
begin
  NormalizedPath := RemoveBackslashUnlessRoot(ExpandFileName(Path));
  ParentPath := RemoveBackslashUnlessRoot(ExtractFileDir(NormalizedPath));
  Result := (NormalizedPath <> '') and IsCloudStoragePath(NormalizedPath)
    and ((ParentPath = '') or not IsCloudStoragePath(ParentPath));
end;

function IsDirectoryWritable(const Path: String): Boolean;
var
  ProbeDirectory, TestFile: String;
  NullPosition: Integer;
begin
  Result := False;
  if FileExists(Path) then
    Exit;

  ProbeDirectory := ExistingDirectoryForWriteTest(Path);
  if ProbeDirectory = '' then
    Exit;

  SetLength(TestFile, 32768);
  try
    if GetTempFileName(ProbeDirectory, 'vcm', 0, TestFile) = 0 then
      Exit;
    NullPosition := Pos(#0, TestFile);
    if NullPosition > 0 then
      SetLength(TestFile, NullPosition - 1);
    Result := SaveStringToFile(TestFile, 'VCMI write test', False);
  except
    Result := False;
  end;
  if TestFile <> '' then
    DeleteFile(TestFile);
end;

function ReportInvalidDirectory(const MessageText: String): Boolean;
begin
  Log(MessageText);
  if WizardSilent then
    RaiseException(MessageText)
  else
    MsgBox(MessageText, mbError, MB_OK);
  Result := False;
end;

function ValidateDirectorySelection(const Path, Description: String): Boolean;
var
  NormalizedPath: String;
begin
  NormalizedPath := RemoveBackslashUnlessRoot(ExpandFileName(Trim(Path)));
  if NormalizedPath = '' then
  begin
    Result := ReportInvalidDirectory(Format(
      ExpandConstant('{cm:DirectoryNotWritable}'), [Description, Path]));
    Exit;
  end;

  if CompareText(NormalizedPath, AddBackslash(ExtractFileDrive(NormalizedPath))) = 0 then
  begin
    Result := ReportInvalidDirectory(Format(
      ExpandConstant('{cm:DirectoryRootNotAllowed}'), [Description, NormalizedPath]));
    Exit;
  end;

  if not IsDirectoryWritable(NormalizedPath) then
  begin
    Result := ReportInvalidDirectory(Format(
      ExpandConstant('{cm:DirectoryNotWritable}'), [Description, NormalizedPath]));
    Exit;
  end;

  Result := True;
end;

function DirectoryPairIsSafe(const InstallPath, DataPath: String): Boolean;
var
  NormalizedInstallPath, NormalizedDataPath: String;
begin
  NormalizedInstallPath := RemoveBackslashUnlessRoot(ExpandFileName(InstallPath));
  NormalizedDataPath := RemoveBackslashUnlessRoot(ExpandFileName(DataPath));

  // Portable data normally lives below the application directory. In every
  // other mode the trees must be independent; the application must never be
  // nested below user data because data cleanup could then remove the app.
  Result := not ((CompareText(NormalizedInstallPath, NormalizedDataPath) = 0)
    or IsSameOrChildPath(NormalizedInstallPath, NormalizedDataPath)
    or (not IsPortableInstall and IsSameOrChildPath(NormalizedDataPath, NormalizedInstallPath)));
end;

function ValidateDirectoryPair(const InstallPath, DataPath: String): Boolean;
begin
  Result := DirectoryPairIsSafe(InstallPath, DataPath);
  if not Result then
  begin
    Result := ReportInvalidDirectory(ExpandConstant('{cm:DirectoryOverlapError}'));
    Exit;
  end;
end;

function InitializeSetup(): Boolean;
var
  InstallPath: String;
begin
  CommandLinePortable := CompareText(ExpandConstant('{param:PORTABLE|0}'), '1') = 0;

  // Check if the application is already installed
  IsUpgrade := ReadArchitectureInstallPath('{#InstallerArch}', InstallPath);
  if IsUpgrade then
    RegisteredInstallPath := RemoveBackslashUnlessRoot(ExpandFileName(InstallPath))
  else
    RegisteredInstallPath := '';
  if CommandLinePortable then
  begin
    IsUpgrade := False;
    RegisteredInstallPath := '';
  end;

  // Initialize the global variable during setup
  GlobalUserName := GetCurrentSessionUserName();
  GlobalUserDocsFolder := GetUserDocsFolder();
  GlobalUserAppdataFolder := GetUserAppdataFolder();
  HasCommandLineInstallDir := ExpandConstant('{param:DIR|}') <> '';
  CommandLineUserDataDir := Trim(ExpandCommandLinePath(
    ExpandConstant('{param:USERDATADIR|}')));

  // Cloud sync clients can temporarily lock files while VCMI is writing them.
  // Prefer Local AppData whenever Documents belongs to OneDrive or another registered provider.
  if IsCloudStoragePath(GlobalUserDocsFolder) then
    DefaultDataDir := GlobalUserAppdataFolder + '\VCMI'
  else
    DefaultDataDir := GlobalUserDocsFolder + '\' + '{#VCMIFilesFolder}';
  if CommandLineUserDataDir <> '' then
  begin
    CommandLineUserDataDir := RemoveBackslashUnlessRoot(CommandLineUserDataDir);
    DefaultDataDir := CommandLineUserDataDir;
  end;
  if IsUpgrade then
    SelectedDataDir := ReadUserDataPath(RegisteredInstallPath, DefaultDataDir)
  else
    SelectedDataDir := DefaultDataDir;
  UpdateDataFolders(SelectedDataDir);

  // Validate every candidate before accepting it. Stale registry entries must
  // not prevent detection from continuing with Ubisoft Connect or Steam.
  Heroes3Path := '';
  SetHeroes3PathIfValid(RegistryQueryPath(
    'SOFTWARE\GOG.com\Games\1207658787', 'path'));
  SetHeroes3PathIfValid(RegistryQueryPath(
    'SOFTWARE\New World Computing\Heroes of Might and Magic® III\1.0', 'AppPath'));
  SetHeroes3PathIfValid(RegistryQueryPath(
    'SOFTWARE\New World Computing\Heroes of Might and Magic III\1.0', 'AppPath'));
  SetHeroes3PathIfValid(RegistryQueryPath(
    'SOFTWARE\Ubisoft\Launcher\Installs\353', 'InstallDir'));
  SetHeroes3PathIfValid(FindSteamGameInstallDir(
    '4921760', 'Heroes of Might and Magic III'));

  if (Heroes3Path <> '') then
  begin
    Heroes3MapsFolder := Heroes3Path + '\Maps';
    Heroes3DataFolder := Heroes3Path + '\Data';
    Heroes3Mp3Folder := Heroes3Path + '\Mp3';
    GetFolderStats(Heroes3MapsFolder, Heroes3MapsSize, Heroes3MapsFiles);
    GetFolderStats(Heroes3DataFolder, Heroes3DataSize, Heroes3DataFiles);
    GetFolderStats(Heroes3Mp3Folder, Heroes3Mp3Size, Heroes3Mp3Files);
  end;
  CopyHeroes3DataSelected := (Heroes3Path <> '')
    and (CompareText(ExpandConstant('{param:COPYH3DATA|1}'), '0') <> 0);

  Result := True;
end;

function InitializeUninstall(): Boolean;
begin
  // Initialize the global variable during uninstall
  GlobalUserName := GetCurrentSessionUserName();
  GlobalUserDocsFolder := GetUserDocsFolder();
  GlobalUserAppdataFolder := GetUserAppdataFolder();
  DefaultDataDir := GlobalUserDocsFolder + '\' + '{#VCMIFilesFolder}';
  SelectedDataDir := ReadUninstallUserDataPath(ExpandConstant('{app}'), DefaultDataDir);
  { Classify every candidate against the provider's current sync-root
    registration. Do not persist cloud roots: providers can move or unregister
    them between installation and uninstall. }
  LoadUninstallPaths(ExpandConstant('{app}'), SelectedDataDir);
  { Cloud classification is complete. Release the installed helper before the
    uninstall phase so Windows does not keep the DLL locked in the app folder. }
  UnloadDLL(ExpandConstant('{app}\VCMI_installerPlugin.dll'));
  // Intended for unattended maintenance and CI. It is deliberately explicit;
  // silent uninstall without this parameter always preserves user data.
  DeleteAllUserData := UninstallSilent
    and (CompareText(ExpandConstant('{param:DELETEUSERDATA|0}'), '1') = 0);

  Result := True;
end;

function PickFolderModern(const Title, Initial: string): string;
var
  buf: string;
  ok: BOOL;
  n: Integer;
begin
  // Large buffer (counted in UTF-16 code units)
  SetLength(buf, 32768);
  try
    ok := PluginModerFolderPicker(WizardForm.Handle, Title, Initial, buf, Length(buf));
  except
    // Keep setup usable when the optional modern picker cannot be loaded.
    Log('Modern folder picker plugin is unavailable; using the standard picker.');
    Result := Initial;
    if not BrowseForFolder(Title, Result, True) then
      Result := '';
    Exit;
  end;
  if not ok then
    Exit;

  // Trim at the first NUL (defensive; the DLL already writes a NUL)
  n := Pos(#0, buf);
  if n > 0 then
    SetLength(buf, n - 1);

  Result := buf; // fully Unicode
end;

procedure BrowseDirClick(Sender: TObject);
var
  title, startPath, picked: string;
begin
  if Sender = InstallDirBrowseBtn then
  begin
    startPath := InstallDirEdit.Text;
    title := ExpandConstant('{cm:InstallFolderTitle}');
  end
  else
  begin
    startPath := DataDirEdit.Text;
    title := ExpandConstant('{cm:DataFolderTitle}');
  end;

  picked := PickFolderModern(title, startPath);
  if picked <> '' then
  begin
    picked := RemoveBackslashUnlessRoot(ExpandFileName(picked));
    if not ValidateDirectorySelection(picked, title) then
      Exit;

    if Sender = InstallDirBrowseBtn then
    begin
      if (Trim(DataDirEdit.Text) <> '')
        and not ValidateDirectoryPair(picked, DataDirEdit.Text) then
        Exit;
      if not ConfirmCloudTarget(picked, ExpandConstant('{cm:CloudInstallWarning}'),
        ConfirmedCloudInstallDir) then
        Exit;
      InstallDirEdit.Text := picked
    end
    else
    begin
      if not ValidateDirectoryPair(InstallDirEdit.Text, picked) then
        Exit;
      if not ConfirmCloudTarget(picked, ExpandConstant('{cm:CloudDataWarning}'),
        ConfirmedCloudDataDir) then
        Exit;
      DataDirEdit.Text := picked;
    end;
  end;
end;

procedure UpdateCloudDataNotice();
begin
  CloudDataNotice.Visible := IsCloudStoragePath(Trim(DataDirEdit.Text));
  if not CloudDataNotice.Visible then
    ConfirmedCloudDataDir := '';
end;

procedure UpdateCloudInstallNotice();
begin
  CloudInstallNotice.Visible := IsCloudStoragePath(Trim(InstallDirEdit.Text));
  if not CloudInstallNotice.Visible then
    ConfirmedCloudInstallDir := '';
end;

procedure InstallDirEditChange(Sender: TObject);
begin
  UpdateCloudInstallNotice();
end;

procedure CopyHeroes3DataClick(Sender: TObject);
begin
  CopyHeroes3DataSelected := CopyHeroes3DataCheck.Checked;
  UpdateDiskSpaceLabel();
end;

procedure UpdateHeroes3CopyCheckbox();
var
  Available: Boolean;
begin
  if not Assigned(CopyHeroes3DataCheck) then
    Exit;
  Available := IsHeroes3Installed and IsCopyFilesNeeded;
  if Available and not Heroes3CopyWasAvailable then
    CopyHeroes3DataSelected := True;
  CopyHeroes3DataCheck.Visible := Available;
  if Available then
    CopyHeroes3DataCheck.Checked := CopyHeroes3DataSelected
  else
    CopyHeroes3DataCheck.Checked := False;
  Heroes3CopyWasAvailable := Available;
end;

procedure DataDirEditChange(Sender: TObject);
begin
  UpdateCloudDataNotice();
  UpdateDataFolders(Trim(DataDirEdit.Text));
  UpdateHeroes3CopyCheckbox();
  UpdateDiskSpaceLabel();
end;

procedure ResetDirsClick(Sender: TObject);
begin
  if IsPortableInstall then
  begin
    if not HasCommandLineInstallDir then
      InstallDirEdit.Text := ExpandConstant('{src}\VCMI');
  end
  else if Assigned(InstallModePage) and (InstallModePage.SelectedValueIndex = 1) then
    InstallDirEdit.Text := GlobalUserAppdataFolder + '\{#VCMIFolder}'
  else
    InstallDirEdit.Text := GetCommonProgramFilesDir + '\{#VCMIFolder}';
  if CommandLineUserDataDir <> '' then
    DataDirEdit.Text := CommandLineUserDataDir
  else if IsPortableInstall then
    DataDirEdit.Text := InstallDirEdit.Text + '\VCMI-data'
  else
    DataDirEdit.Text := DefaultDataDir;
end;

function GetDetectedWindowsVersion(Default: String): String;
var
  ProductName, DisplayVersion, BuildNumber: String;
begin
  ProductName := '';
  DisplayVersion := '';
  BuildNumber := '';
  RegQueryStringValue(HKLM,
    'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'ProductName', ProductName);
  RegQueryStringValue(HKLM,
    'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'DisplayVersion', DisplayVersion);
  RegQueryStringValue(HKLM,
    'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'CurrentBuildNumber', BuildNumber);
  Result := Trim(ProductName);
  if DisplayVersion <> '' then
    Result := Result + ' ' + DisplayVersion;
  if BuildNumber <> '' then
    Result := Result + ' (build ' + BuildNumber + ')';
  if Result = '' then
    Result := Default;
end;

function GetProcessorInfo(var ProcessorName: String; var ProcessorMHz: Cardinal): Boolean;
begin
  ProcessorName := '';
  ProcessorMHz := 0;
  RegQueryStringValue(HKLM,
    'HARDWARE\DESCRIPTION\System\CentralProcessor\0',
    'ProcessorNameString', ProcessorName);
  RegQueryDWordValue(HKLM,
    'HARDWARE\DESCRIPTION\System\CentralProcessor\0',
    '~MHz', ProcessorMHz);
  ProcessorName := Trim(ProcessorName);
  Result := ProcessorMHz > 0;
end;

function GetPhysicalMemoryMB(var MemoryMB: Int64): Boolean;
var
  MemoryStatus: TMemoryStatusEx;
begin
  MemoryStatus.Length := 64;
  Result := GlobalMemoryStatusEx(MemoryStatus);
  if Result then
    MemoryMB := MemoryStatus.TotalPhysical div (1024 * 1024)
  else
    MemoryMB := 0;
end;

function CompactDiskSpaceRequirement(const Caption: String): String;
var
  StartPosition, EndPosition: Integer;
  Character: Char;
begin
  StartPosition := 1;
  while (StartPosition <= Length(Caption))
    and not ((Caption[StartPosition] >= '0') and (Caption[StartPosition] <= '9')) do
    StartPosition := StartPosition + 1;
  if StartPosition > Length(Caption) then
  begin
    Result := Caption;
    Exit;
  end;

  EndPosition := StartPosition;
  while EndPosition <= Length(Caption) do
  begin
    Character := Caption[EndPosition];
    if not (((Character >= '0') and (Character <= '9'))
      or (Character = '.') or (Character = ',') or (Character = ' ')
      or (Character = 'K') or (Character = 'M') or (Character = 'G')
      or (Character = 'T') or (Character = 'B')) then
      Break;
    EndPosition := EndPosition + 1;
  end;
  Result := Trim(Copy(Caption, StartPosition, EndPosition - StartPosition));
end;

procedure AddRequirementLine(const Status, Name, RequiredValue, DetectedValue: String);
var
  StatusBitmap: String;
begin
  if RequirementsRowCount > 14 then
    Exit;
  RequirementsComponentLabels[RequirementsRowCount].Caption := '  ' + Name;
  RequirementsRequiredLabels[RequirementsRowCount].Caption := '  ' + RequiredValue;
  RequirementsDetailsLabels[RequirementsRowCount].Caption := '  ' + DetectedValue;
  RequirementsStatusLabels[RequirementsRowCount].Caption := '';
  if CompareText(Status, ExpandConstant('{cm:RequirementFailed}')) = 0 then
  begin
    StatusBitmap := 'requirement-status-fail'
  end
  else if CompareText(Status, ExpandConstant('{cm:RequirementWarning}')) = 0 then
  begin
    StatusBitmap := 'requirement-status-warn'
  end
  else if CompareText(Status, ExpandConstant('{cm:RequirementPassed}')) = 0 then
  begin
    StatusBitmap := 'requirement-status-ok'
  end
  else
  begin
    StatusBitmap := 'requirement-status-info';
  end;
  if (RequirementsRowCount mod 2) <> 0 then
    StatusBitmap := StatusBitmap + '-alternate';
  StatusBitmap := StatusBitmap + '.bmp';
  RequirementsStatusIcons[RequirementsRowCount].Bitmap.LoadFromFile(
    ExpandConstant('{tmp}\' + StatusBitmap));
  RequirementsStatusIcons[RequirementsRowCount].Hint := Status;
  RequirementsStatusIcons[RequirementsRowCount].ShowHint := True;
  RequirementsStatusIcons[RequirementsRowCount].Visible := True;
  RequirementsComponentLabels[RequirementsRowCount].Visible := True;
  RequirementsRequiredLabels[RequirementsRowCount].Visible := True;
  RequirementsDetailsLabels[RequirementsRowCount].Visible := True;
  RequirementsStatusLabels[RequirementsRowCount].Visible := True;
  RequirementsRowCount := RequirementsRowCount + 1;
end;

procedure UpdateRequirementsCheck();
var
  SystemArchitecture, ProbeDirectory, ProcessorName: String;
  Row: Integer;
  InternetFlags: DWord;
  FreeSpace, TotalSpace, HeroesDataSize, MemoryMB: Int64;
  ProcessorMHz: Cardinal;
  InstallWritable, DataWritable, LayoutSafe: Boolean;
begin
  if not Assigned(RequirementsComponentLabels[0]) then
    Exit;

  RequirementsRowCount := 0;
  for Row := 0 to 14 do
  begin
    RequirementsComponentLabels[Row].Visible := False;
    RequirementsRequiredLabels[Row].Visible := False;
    RequirementsDetailsLabels[Row].Visible := False;
    RequirementsStatusLabels[Row].Visible := False;
    RequirementsStatusIcons[Row].Visible := False;
  end;

    AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
      ExpandConstant('{cm:RequirementOperatingSystem}'),
      ExpandConstant('{cm:RequirementOperatingSystemShortValue}'),
      GetDetectedWindowsVersion(ExpandConstant('{cm:RequirementDetectedWindows}')));

    if IsARM64 then
      SystemArchitecture := 'ARM64'
    else if IsWin64 then
      SystemArchitecture := 'x64'
    else
      SystemArchitecture := 'x86';
    AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
      ExpandConstant('{cm:RequirementArchitecture}'),
      '{#InstallerArch}',
      Format('Windows %s', [SystemArchitecture]));

    if GetProcessorInfo(ProcessorName, ProcessorMHz) then
    begin
      if ProcessorMHz >= 1000 then
      AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
          ExpandConstant('{cm:RequirementProcessor}'), '1 GHz',
          Format('%s (%d MHz)', [ProcessorName, ProcessorMHz]))
      else
      begin
        AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
          ExpandConstant('{cm:RequirementProcessor}'), '1 GHz',
          Format('%s (%d MHz)', [ProcessorName, ProcessorMHz]));
      end;
    end
    else
      AddRequirementLine(ExpandConstant('{cm:RequirementInfo}'),
        ExpandConstant('{cm:RequirementProcessor}'), '1 GHz',
        ExpandConstant('{cm:RequirementDetectionUnavailable}'));

    if GetPhysicalMemoryMB(MemoryMB) then
    begin
      if MemoryMB >= 1024 then
        AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
          ExpandConstant('{cm:RequirementMemory}'), '1 GB',
          FormatLocalizedByteMessage(
            ExpandConstant('{cm:RequirementMemoryDetected}'),
            MemoryMB * 1024 * 1024))
      else
      begin
        AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
          ExpandConstant('{cm:RequirementMemory}'), '1 GB',
          FormatLocalizedByteMessage(
            ExpandConstant('{cm:RequirementMemoryDetected}'),
            MemoryMB * 1024 * 1024));
      end;
    end
    else
      AddRequirementLine(ExpandConstant('{cm:RequirementInfo}'),
        ExpandConstant('{cm:RequirementMemory}'), '1 GB',
        ExpandConstant('{cm:RequirementDetectionUnavailable}'));

    if FileExists(ExpandConstant('{sys}\d3d11.dll')) then
      AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
        ExpandConstant('{cm:RequirementDirectX}'), '11',
        ExpandConstant('{cm:RequirementDirectXDetected}'))
    else
    begin
      AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
        ExpandConstant('{cm:RequirementDirectX}'), '11',
        ExpandConstant('{cm:RequirementDirectXMissing}'));
    end;

    { Show the combined installation/import disk requirement with the other
      hardware requirements, before network-related checks. }
    if CopyHeroes3DataSelected and IsCopyFilesNeeded then
    begin
      HeroesDataSize := Heroes3CopySize();
      ProbeDirectory := ExistingDirectoryForWriteTest(DataDirEdit.Text);
      if (ProbeDirectory = '') or
        not GetSpaceOnDisk64(ProbeDirectory, FreeSpace, TotalSpace) then
        AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
          ExpandConstant('{cm:RequirementDiskSpace}'), FormatByteSize(HeroesDataSize),
          ExpandConstant('{cm:RequirementDetectionUnavailable}'))
      else if FreeSpace < HeroesDataSize then
        AddRequirementLine(ExpandConstant('{cm:RequirementFailed}'),
          ExpandConstant('{cm:RequirementDiskSpace}'), FormatByteSize(HeroesDataSize),
          FormatLocalizedByteMessage(
            ExpandConstant('{cm:RequirementFreeSpaceShortValue}'), FreeSpace))
      else
        AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
          ExpandConstant('{cm:RequirementDiskSpace}'), FormatByteSize(HeroesDataSize),
          FormatLocalizedByteMessage(
            ExpandConstant('{cm:RequirementFreeSpaceShortValue}'), FreeSpace));
    end
    else
    begin
      ProbeDirectory := ExistingDirectoryForWriteTest(InstallDirEdit.Text);
      if (ProbeDirectory <> '') and GetSpaceOnDisk64(ProbeDirectory, FreeSpace, TotalSpace) then
      begin
        AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
          ExpandConstant('{cm:RequirementDiskSpace}'),
          CompactDiskSpaceRequirement(BaseDiskSpaceCaption),
          FormatLocalizedByteMessage(
            ExpandConstant('{cm:RequirementFreeSpaceShortValue}'), FreeSpace));
      end;
    end;

    InternetFlags := 0;
    if InternetGetConnectedState(InternetFlags, 0) then
      AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
        ExpandConstant('{cm:RequirementInternet}'),
        ExpandConstant('{cm:RequirementRecommended}'),
        ExpandConstant('{cm:RequirementInternetAvailable}'))
    else
      AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
        ExpandConstant('{cm:RequirementInternet}'),
        ExpandConstant('{cm:RequirementRecommended}'),
        ExpandConstant('{cm:RequirementInternetUnavailable}'));

    if not IsPRInstaller and IsAdminInstallMode and not IsPortableInstall then
    begin
      if WizardIsTaskSelected('firewallrules') then
        AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
          ExpandConstant('{cm:RequirementFirewall}'),
          ExpandConstant('{cm:RequirementMultiplayerGames}'),
          ExpandConstant('{cm:RequirementSelected}'))
      else
        AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
          ExpandConstant('{cm:RequirementFirewall}'),
          ExpandConstant('{cm:RequirementMultiplayerGames}'),
          ExpandConstant('{cm:RequirementNotSelected}'));
    end;

    if not IsCopyFilesNeeded then
      AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
        ExpandConstant('{cm:RequirementHeroesData}'),
        ExpandConstant('{cm:RequirementRequiredToPlay}'),
        ExpandConstant('{cm:RequirementHeroesDataAvailable}'))
    else if Heroes3Path <> '' then
      AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
        ExpandConstant('{cm:RequirementHeroesData}'),
        ExpandConstant('{cm:RequirementRequiredToPlay}'), Heroes3Path)
    else
      AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
        ExpandConstant('{cm:RequirementHeroesData}'),
        ExpandConstant('{cm:RequirementRequiredToPlay}'),
        ExpandConstant('{cm:RequirementHeroesDataMissing}'));

    InstallWritable := IsDirectoryWritable(InstallDirEdit.Text);
    if InstallWritable then
    begin
      if IsCloudStoragePath(InstallDirEdit.Text) then
        AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
          ExpandConstant('{cm:RequirementInstallFolder}'),
          ExpandConstant('{cm:RequirementWritableValue}'),
          ExpandConstant('{cm:RequirementWritableAndSynced}'))
      else
        AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
          ExpandConstant('{cm:RequirementInstallFolder}'),
          ExpandConstant('{cm:RequirementWritableValue}'),
          ExpandConstant('{cm:RequirementWritableValue}'));
    end
    else
    begin
      AddRequirementLine(ExpandConstant('{cm:RequirementFailed}'),
        ExpandConstant('{cm:RequirementInstallFolder}'),
        ExpandConstant('{cm:RequirementWritableValue}'),
        ExpandConstant('{cm:RequirementNotWritable}'));
    end;

    DataWritable := IsDirectoryWritable(DataDirEdit.Text);
    if DataWritable then
    begin
      if IsCloudStoragePath(DataDirEdit.Text) then
        AddRequirementLine(ExpandConstant('{cm:RequirementWarning}'),
          ExpandConstant('{cm:RequirementUserDataFolder}'),
          ExpandConstant('{cm:RequirementWritableValue}'),
          ExpandConstant('{cm:RequirementWritableAndSynced}'))
      else
        AddRequirementLine(ExpandConstant('{cm:RequirementPassed}'),
          ExpandConstant('{cm:RequirementUserDataFolder}'),
          ExpandConstant('{cm:RequirementWritableValue}'),
          ExpandConstant('{cm:RequirementWritableValue}'));
    end
    else
    begin
      AddRequirementLine(ExpandConstant('{cm:RequirementFailed}'),
        ExpandConstant('{cm:RequirementUserDataFolder}'),
        ExpandConstant('{cm:RequirementWritableValue}'),
        ExpandConstant('{cm:RequirementNotWritable}'));
    end;

    LayoutSafe := DirectoryPairIsSafe(InstallDirEdit.Text, DataDirEdit.Text);
    if not LayoutSafe then
    begin
      AddRequirementLine(ExpandConstant('{cm:RequirementFailed}'),
        ExpandConstant('{cm:RequirementDirectoryLayout}'),
        ExpandConstant('{cm:RequirementDirectoryLayoutValue}'),
        ExpandConstant('{cm:DirectoryOverlapError}'));
    end;

end;

function CreateRequirementsPanel(const CaptionText: String;
  LeftPos, TopPos, PanelWidth, PanelHeight, AnchorMode: Integer;
  CenterText, BoldText, Header: Boolean): TPanel;
begin
  Result := TPanel.Create(RequirementsPage);
  Result.Parent := RequirementsPage.Surface;
  Result.Left := LeftPos;
  Result.Top := TopPos;
  Result.Width := PanelWidth;
  Result.Height := PanelHeight;
  Result.Caption := CaptionText;
  Result.BevelOuter := bvNone;
  Result.ParentBackground := False;
  if CenterText then
    Result.Alignment := taCenter
  else
    Result.Alignment := taLeftJustify;
  if BoldText then
    Result.Font.Style := [fsBold];
  if Header then
  begin
    Result.Color := clGray;
    Result.Font.Color := clWhite;
    Result.Font.Size := 8;
  end
  else
    Result.Color := clWhite;
  if AnchorMode = 1 then
    Result.Anchors := [akLeft, akTop, akRight]
  else if AnchorMode = 2 then
    Result.Anchors := [akTop, akRight]
  else
    Result.Anchors := [akLeft, akTop];
end;

function CreateReadyCard(const CaptionText: String; TopPos, CardHeight: Integer;
  var ValueLabel: TNewStaticText): TPanel;
var
  Accent: TPanel;
  CaptionLabel: TNewStaticText;
begin
  Result := TPanel.Create(ReadySummaryPanel);
  Result.Parent := ReadySummaryPanel;
  Result.Left := 0;
  Result.Top := TopPos;
  Result.Width := ReadySummaryPanel.ClientWidth;
  Result.Height := CardHeight;
  Result.BevelOuter := bvNone;
  Result.Color := clWhite;
  Result.Anchors := [akLeft, akTop, akRight];

  Accent := TPanel.Create(Result);
  Accent.Parent := Result;
  Accent.Left := 0;
  Accent.Top := 0;
  Accent.Width := ScaleX(4);
  Accent.Height := Result.ClientHeight;
  Accent.BevelOuter := bvNone;
  Accent.Color := $004A8CC7;
  Accent.Anchors := [akLeft, akTop, akBottom];

  CaptionLabel := TNewStaticText.Create(Result);
  CaptionLabel.Parent := Result;
  CaptionLabel.Left := ScaleX(14);
  CaptionLabel.Top := ScaleY(4);
  CaptionLabel.Width := Result.ClientWidth - ScaleX(24);
  CaptionLabel.Height := ScaleY(14);
  CaptionLabel.AutoSize := False;
  CaptionLabel.Caption := CaptionText;
  CaptionLabel.Font.Style := [fsBold];
  CaptionLabel.Font.Color := $00383838;
  CaptionLabel.Anchors := [akLeft, akTop, akRight];

  ValueLabel := TNewStaticText.Create(Result);
  ValueLabel.Parent := Result;
  ValueLabel.Left := CaptionLabel.Left;
  ValueLabel.Top := ScaleY(18);
  ValueLabel.Width := CaptionLabel.Width;
  ValueLabel.Height := Result.ClientHeight - ValueLabel.Top - ScaleY(2);
  ValueLabel.AutoSize := False;
  ValueLabel.WordWrap := True;
  ValueLabel.Font.Color := $00282828;
  ValueLabel.Anchors := [akLeft, akTop, akRight, akBottom];
end;

procedure InitializeReadySummary();
var
  Gap, PathCardHeight, ModeCardHeight, SummaryOffset, TasksTop: Integer;
begin
  WizardForm.ReadyMemo.Visible := False;
  WizardForm.ReadyLabel.AutoSize := False;
  WizardForm.ReadyLabel.Height := WizardForm.ReadyLabel.Height + ScaleY(4);
  SummaryOffset := ScaleY(7);

  ReadySummaryPanel := TPanel.Create(WizardForm.ReadyPage);
  ReadySummaryPanel.Parent := WizardForm.ReadyPage;
  ReadySummaryPanel.Left := WizardForm.ReadyMemo.Left;
  ReadySummaryPanel.Top := WizardForm.ReadyMemo.Top + SummaryOffset;
  ReadySummaryPanel.Width := WizardForm.ReadyMemo.Width;
  ReadySummaryPanel.Height := WizardForm.ReadyMemo.Height - SummaryOffset;
  ReadySummaryPanel.BevelOuter := bvNone;
  ReadySummaryPanel.Color := $00F0F0F0;
  ReadySummaryPanel.Anchors := [akLeft, akTop, akRight, akBottom];

  Gap := ScaleY(2);
  PathCardHeight := ScaleY(35);
  ModeCardHeight := ScaleY(35);
  ReadyModeCard := CreateReadyCard(
    ExpandConstant('{cm:RequirementInstallationMode}'), 0,
    ModeCardHeight, ReadyModeValue);
  ReadyModeValue.Font.Style := [fsBold];
  ReadyModeValue.Font.Color := clBlue;
  ReadyInstallCard := CreateReadyCard(
    ExpandConstant('{cm:InstallFolderTitle}'), ReadyModeCard.Height + Gap,
    PathCardHeight, ReadyInstallValue);
  ReadyDataCard := CreateReadyCard(
    ExpandConstant('{cm:DataFolderTitle}'),
    ReadyInstallCard.Top + ReadyInstallCard.Height + Gap,
    PathCardHeight, ReadyDataValue);
  TasksTop := ReadyDataCard.Top + ReadyDataCard.Height + Gap;
  ReadyTasksCard := CreateReadyCard(
    SetupMessage(msgReadyMemoTasks), TasksTop,
    ReadySummaryPanel.ClientHeight - TasksTop, ReadyTasksValue);
  ReadyTasksCard.Anchors := [akLeft, akTop, akRight, akBottom];
  ReadyTasksValue.Visible := False;
  ReadyTasksMemo := TNewMemo.Create(ReadyTasksCard);
  ReadyTasksMemo.Parent := ReadyTasksCard;
  ReadyTasksMemo.Left := ReadyTasksValue.Left;
  ReadyTasksMemo.Top := ReadyTasksValue.Top;
  ReadyTasksMemo.Width := ReadyTasksValue.Width;
  ReadyTasksMemo.Height := ReadyTasksValue.Height;
  ReadyTasksMemo.ReadOnly := True;
  ReadyTasksMemo.WordWrap := True;
  ReadyTasksMemo.ScrollBars := ssNone;
  ReadyTasksMemo.BorderStyle := bsNone;
  ReadyTasksMemo.Color := clWhite;
  ReadyTasksMemo.Anchors := [akLeft, akTop, akRight, akBottom];
end;

procedure CreateInstallModeBitmap(Index: Integer; const FileName: String);
begin
  ExtractTemporaryFile(FileName);
  { Use a windowed panel as the image host. The native checklist repaints
    non-windowed graphic children whenever selection or hover changes. }
  InstallModeIconPanels[Index] := TPanel.Create(InstallModePage);
  InstallModeIconPanels[Index].Parent := InstallModeRowPanels[Index];
  InstallModeIconPanels[Index].Left := ScaleX(18);
  InstallModeIconPanels[Index].Top := ScaleY(8);
  InstallModeIconPanels[Index].Width := ScaleX(40);
  InstallModeIconPanels[Index].Height := ScaleY(40);
  InstallModeIconPanels[Index].BevelOuter := bvNone;
  InstallModeIconPanels[Index].Color := clWindow;
  InstallModeBitmaps[Index] := TBitmapImage.Create(InstallModePage);
  InstallModeBitmaps[Index].Parent := InstallModeIconPanels[Index];
  InstallModeBitmaps[Index].Left := 0;
  InstallModeBitmaps[Index].Top := 0;
  InstallModeBitmaps[Index].Width := ScaleX(40);
  InstallModeBitmaps[Index].Height := ScaleY(40);
  InstallModeBitmaps[Index].Stretch := True;
  InstallModeBitmaps[Index].Bitmap.LoadFromFile(
    ExpandConstant('{tmp}\') + FileName);
  InstallModeIconPanels[Index].BringToFront();
end;

procedure SelectInstallMode(Index: Integer);
var
  Choice: Integer;
begin
  if (Index = 0) and not IsAdminInstallMode then
    Exit;
  InstallModePage.SelectedValueIndex := Index;
  for Choice := 0 to 2 do
    InstallModeRadioButtons[Choice].Checked := Choice = Index;
  InstallModePreviewLabel.Caption := InstallModePreview(Index);
end;

procedure InstallModeRadioClick(Sender: TObject);
var
  Choice: Integer;
begin
  for Choice := 0 to 2 do
    if (Sender = InstallModeRowPanels[Choice]) or
      (Sender = InstallModeRadioButtons[Choice]) or
      (Sender = InstallModeIconPanels[Choice]) or
      (Sender = InstallModeBitmaps[Choice]) or
      (Sender = InstallModeTitleLabels[Choice]) or
      (Sender = InstallModeLabels[Choice]) then
    begin
      SelectInstallMode(Choice);
      Exit;
    end;
end;

procedure CreateInstallModeChoice(Index, TopPos: Integer;
  const TitleText, DetailText, FileName: String);
begin
  InstallModeRowPanels[Index] := TPanel.Create(InstallModePage);
  InstallModeRowPanels[Index].Parent := InstallModePage.Surface;
  InstallModeRowPanels[Index].Left := InstallModePage.CheckListBox.Left;
  InstallModeRowPanels[Index].Top := TopPos;
  InstallModeRowPanels[Index].Width := InstallModePage.Surface.ClientWidth -
    InstallModeRowPanels[Index].Left - ScaleX(8);
  InstallModeRowPanels[Index].Height := ScaleY(64);
  InstallModeRowPanels[Index].BevelOuter := bvNone;
  InstallModeRowPanels[Index].Color := InstallModePage.Surface.Color;
  InstallModeRowPanels[Index].OnClick := @InstallModeRadioClick;
  InstallModeRowPanels[Index].Anchors := [akLeft, akTop, akRight];

  InstallModeRadioButtons[Index] := TNewRadioButton.Create(InstallModePage);
  InstallModeRadioButtons[Index].Parent := InstallModeRowPanels[Index];
  InstallModeRadioButtons[Index].Left := ScaleX(4);
  InstallModeRadioButtons[Index].Top := ScaleY(19);
  InstallModeRadioButtons[Index].Width := ScaleX(18);
  InstallModeRadioButtons[Index].Height := ScaleY(18);
  InstallModeRadioButtons[Index].OnClick := @InstallModeRadioClick;

  CreateInstallModeBitmap(Index, FileName);
  InstallModeIconPanels[Index].OnClick := @InstallModeRadioClick;
  InstallModeBitmaps[Index].OnClick := @InstallModeRadioClick;

  InstallModeTitleLabels[Index] := TNewStaticText.Create(InstallModePage);
  InstallModeTitleLabels[Index].Parent := InstallModeRowPanels[Index];
  InstallModeTitleLabels[Index].AutoSize := False;
  InstallModeTitleLabels[Index].Left := ScaleX(60);
  InstallModeTitleLabels[Index].Top := ScaleY(3);
  InstallModeTitleLabels[Index].Width := InstallModeRowPanels[Index].Width - ScaleX(64);
  InstallModeTitleLabels[Index].Height := ScaleY(16);
  InstallModeTitleLabels[Index].Caption := TitleText;
  InstallModeTitleLabels[Index].Font.Style := [fsBold];
  InstallModeTitleLabels[Index].OnClick := @InstallModeRadioClick;
  InstallModeTitleLabels[Index].Anchors := [akLeft, akTop, akRight];

  InstallModeLabels[Index] := TNewStaticText.Create(InstallModePage);
  InstallModeLabels[Index].Parent := InstallModeRowPanels[Index];
  InstallModeLabels[Index].AutoSize := False;
  InstallModeLabels[Index].Left := ScaleX(60);
  InstallModeLabels[Index].Top := ScaleY(19);
  InstallModeLabels[Index].Width := InstallModeRowPanels[Index].Width - ScaleX(64);
  InstallModeLabels[Index].Height := ScaleY(42);
  InstallModeLabels[Index].WordWrap := True;
  InstallModeLabels[Index].Caption := DetailText;
  InstallModeLabels[Index].OnClick := @InstallModeRadioClick;
  InstallModeLabels[Index].Anchors := [akLeft, akTop, akRight];
end;

procedure UpdateInstallModeLayout();
var
  Index: Integer;
begin
  if not Assigned(InstallModePage) then
    Exit;
  for Index := 0 to 2 do
  begin
    InstallModeRowPanels[Index].Width := InstallModePage.Surface.ClientWidth -
      InstallModeRowPanels[Index].Left - ScaleX(8);
    InstallModeTitleLabels[Index].Width := InstallModeRowPanels[Index].ClientWidth -
      InstallModeTitleLabels[Index].Left - ScaleX(4);
    InstallModeLabels[Index].Width := InstallModeRowPanels[Index].ClientWidth -
      InstallModeLabels[Index].Left - ScaleX(4);
  end;
end;

procedure AppendReadyTask(var Tasks: String; const TaskCaption: String);
begin
  if Tasks <> '' then
    Tasks := Tasks + #13#10;
  Tasks := Tasks + #$2022 + '  ' + TaskCaption;
end;

procedure AppendReadyGroupItem(var Items: String; const ItemCaption: String);
begin
  if Items <> '' then
    Items := Items + #13#10;
  Items := Items + '   ' + #$2022 + ' ' + ItemCaption;
end;

procedure AppendReadyGroup(var Tasks: String; const GroupCaption, Items: String);
begin
  if Items = '' then
    Exit;
  if Tasks <> '' then
    Tasks := Tasks + #13#10#13#10;
  Tasks := Tasks + GroupCaption + ':' + #13#10 + Items;
end;

procedure UpdateReadySummary();
var
  Tasks, DataPath, DesktopItems, StartMenuItems, AssociationItems,
    ConfigurationItems: String;
  TaskLineCount: Integer;
begin
  { Inno refreshes and may show its native ReadyMemo again whenever this page
    is entered. Keep only the custom summary visible and above native controls. }
  WizardForm.ReadyMemo.Visible := False;
  ReadySummaryPanel.Visible := True;
  ReadySummaryPanel.BringToFront;

  ReadyInstallValue.Caption := MinimizePathName(
    WizardDirValue, ReadyInstallValue.Font, ReadyInstallValue.Width);

  DataPath := SelectedDataDir;
  if (DataPath = '') and Assigned(DataDirEdit) then
    DataPath := DataDirEdit.Text;
  ReadyDataValue.Caption := MinimizePathName(
    DataPath, ReadyDataValue.Font, ReadyDataValue.Width);

  if IsPortableInstall then
    ReadyModeValue.Caption := ExpandConstant('{cm:InstallPortable}')
  else if Assigned(InstallModePage) and (InstallModePage.SelectedValueIndex = 0) then
    ReadyModeValue.Caption := ExpandConstant('{cm:InstallForAllUsers}')
  else
    ReadyModeValue.Caption := ExpandConstant('{cm:InstallForMeOnly}');

  Tasks := '';
  DesktopItems := '';
  StartMenuItems := '';
  AssociationItems := '';
  ConfigurationItems := '';
  if WizardIsTaskSelected('desktop_launcher') then
    AppendReadyGroupItem(DesktopItems, ExpandConstant('{cm:ShortcutLauncher}'));
  if WizardIsTaskSelected('desktop_mapeditor') then
    AppendReadyGroupItem(DesktopItems, ExpandConstant('{cm:ShortcutMapEditor}'));
  if WizardIsTaskSelected('startmenu_launcher') then
    AppendReadyGroupItem(StartMenuItems, ExpandConstant('{cm:ShortcutLauncher}'));
  if WizardIsTaskSelected('startmenu_mapeditor') then
    AppendReadyGroupItem(StartMenuItems, ExpandConstant('{cm:ShortcutMapEditor}'));
  if WizardIsTaskSelected('startmenu_website') then
    AppendReadyGroupItem(StartMenuItems, ExpandConstant('{cm:ShortcutWebPage}'));
  if WizardIsTaskSelected('startmenu_discord') then
    AppendReadyGroupItem(StartMenuItems, ExpandConstant('{cm:ShortcutDiscord}'));
  if WizardIsTaskSelected('fileassociation_vmap') then
    AppendReadyGroupItem(AssociationItems, ExpandConstant('{cm:VMAPDescription}'));
  if WizardIsTaskSelected('fileassociation_vcmp') then
    AppendReadyGroupItem(AssociationItems, ExpandConstant('{cm:VCMPDescription}'));
  if WizardIsTaskSelected('fileassociation_h3m') then
    AppendReadyGroupItem(AssociationItems, ExpandConstant('{cm:H3MDescription}'));
  if WizardIsTaskSelected('fileassociation_h3c') then
    AppendReadyGroupItem(AssociationItems, ExpandConstant('{cm:H3CDescription}'));
  if WizardIsTaskSelected('firewallrules') then
    AppendReadyGroupItem(ConfigurationItems, ExpandConstant('{cm:AddFirewallRules}'));
  AppendReadyGroup(Tasks, ExpandConstant('{cm:DesktopShortcuts}'), DesktopItems);
  AppendReadyGroup(Tasks, ExpandConstant('{cm:StartMenuShortcuts}'), StartMenuItems);
  AppendReadyGroup(Tasks, ExpandConstant('{cm:FileAssociations}'), AssociationItems);
  AppendReadyGroup(Tasks, ExpandConstant('{cm:VCMISettings}'), ConfigurationItems);
  if CopyHeroes3DataSelected and IsCopyFilesNeeded then
    AppendReadyTask(Tasks, ExpandConstant('{cm:CopyH3Files}'));

  ReadyTasksMemo.Text := Tasks;
  { EM_GETLINECOUNT includes lines created by word wrapping. Only reserve space
    for a scrollbar when the rendered text is taller than the memo. }
  ReadyTasksMemo.ScrollBars := ssNone;
  TaskLineCount := SendMessage(ReadyTasksMemo.Handle, $00BA, 0, 0);
  if (TaskLineCount * ScaleY(14) + ScaleY(2)) > ReadyTasksMemo.ClientHeight then
    ReadyTasksMemo.ScrollBars := ssVertical;
  ReadyTasksCard.Visible := Tasks <> '';
end;

procedure InitializeWizard();
var
  TitleText, SubTitleText, InfoText, WelcomeText, WelcomeSeparator: String;
  LeftCol, TopY, ButtonWidth, RowGap, Row, WelcomeSeparatorPos,
    ContentWidth, DetailsWidth, RequiredWidth, StatusWidth: Integer;
  HeaderComponent, HeaderRequired, HeaderDetails, HeaderStatus: TPanel;
  RequirementMeasureLabel: TNewStaticText;

begin
  WelcomeText := ExpandConstant('{cm:WelcomeDescription}');
  WelcomeSeparator := #13#10#13#10;
  WelcomeSeparatorPos := Pos(WelcomeSeparator, WelcomeText);
  if WelcomeSeparatorPos > 0 then
  begin
    WizardForm.WelcomeLabel2.Caption := Copy(WelcomeText, 1,
      WelcomeSeparatorPos - 1);
    WelcomeInstructionsLabel := TNewStaticText.Create(WizardForm.WelcomePage);
    WelcomeInstructionsLabel.Parent := WizardForm.WelcomePage;
    WelcomeInstructionsLabel.AutoSize := False;
    WelcomeInstructionsLabel.WordWrap := True;
    WelcomeInstructionsLabel.Left := WizardForm.WelcomeLabel2.Left;
    WelcomeInstructionsLabel.Top := WizardForm.WelcomeLabel2.Top + ScaleY(72);
    WelcomeInstructionsLabel.Width := WizardForm.WelcomeLabel2.Width;
    WelcomeInstructionsLabel.Height := ScaleY(110);
    WelcomeInstructionsLabel.Caption := Copy(WelcomeText,
      WelcomeSeparatorPos + Length(WelcomeSeparator), Length(WelcomeText));
  end
  else
    WizardForm.WelcomeLabel2.Caption := WelcomeText;
  WizardForm.WelcomeLabel2.AutoSize := False;
  WizardForm.WelcomeLabel2.WordWrap := True;
  WizardForm.WelcomeLabel2.Height := ScaleY(52);

  if (CompareText('{#InstallerArch}', 'x86') = 0) and not IsX86OS then
  begin
    Log('Installing the x86 VCMI package on a non-x86 Windows system.');
    if not WizardSilent then
    begin
      if IsARM64 then
        MsgBox(ExpandConstant('{cm:X86OnARM64Warning}'), mbInformation, MB_OK)
      else
        MsgBox(ExpandConstant('{cm:X86On64BitWarning}'), mbInformation, MB_OK);
    end;
  end;

  // Check if the application is already installed
  if not IsUpgrade then
  begin
    // Create the install mode selection page only if it's not an upgrade
    InstallModePage := CreateInputOptionPage(
      wpWelcome,
      ExpandConstant('{cm:SelectSetupInstallModeTitle}'),
      ExpandConstant('{cm:SelectSetupInstallModeDesc}'),
      ExpandConstant('{cm:SelectSetupInstallModeSubTitle}'),
      True, False
    );

    InstallModePage.Add(ExpandConstant(#13#10 + '                  {cm:InstallForAllUsers}' + #13#10 + '                   • {cm:InstallForAllUsers1}' + #13#10 + #13#10));
    InstallModePage.Add(ExpandConstant(#13#10 + '                  {cm:InstallForMeOnly}' + #13#10  +  '                   • {cm:InstallForMeOnly1}' + #13#10 + '                   • {cm:InstallForMeOnly2}' + #13#10));
    InstallModePage.Add(ExpandConstant(#13#10 + '                  {cm:InstallPortable}' + #13#10 + '                   • {cm:InstallPortable1}' + #13#10 + '                   • {cm:InstallPortable2}' + #13#10));
    InstallModePage.CheckListBox.Visible := False;
    CreateInstallModeChoice(0, InstallModePage.CheckListBox.Top + ScaleY(4),
      ExpandConstant('{cm:InstallForAllUsers}'),
      ExpandConstant('• {cm:InstallForAllUsers1}'),
      'install-mode-all-users.bmp');
    CreateInstallModeChoice(1, InstallModePage.CheckListBox.Top + ScaleY(68),
      ExpandConstant('{cm:InstallForMeOnly}'),
      ExpandConstant('• {cm:InstallForMeOnly1}' + #13#10 + '• {cm:InstallForMeOnly2}'),
      'install-mode-current-user.bmp');
    CreateInstallModeChoice(2, InstallModePage.CheckListBox.Top + ScaleY(136),
      ExpandConstant('{cm:InstallPortable}'),
      ExpandConstant('• {cm:InstallPortable1} {cm:InstallPortable2}' + #13#10 +
        '• {cm:InstallForMeOnly1}' + #13#10 +
        '• {cm:InstallForMeOnly2}'),
      'install-mode-portable.bmp');

    if CommandLinePortable then
      InstallModePage.SelectedValueIndex := 2
    else if IsAdminInstallMode then
    begin
      // Default to "All Users"
      InstallModePage.SelectedValueIndex := 0;
    end
    else
    begin
      // Default to "Me Only"
      InstallModePage.SelectedValueIndex := 1;

      // Disable the first option ("Install for All Users") for non-admins
      InstallModePage.CheckListBox.ItemEnabled[0] := False;
      InstallModeRadioButtons[0].Enabled := False;
      InstallModeTitleLabels[0].Enabled := False;
      InstallModeLabels[0].Enabled := False;
    end;

    InstallModePreviewPanel := TPanel.Create(InstallModePage);
    InstallModePreviewPanel.Parent := InstallModePage.Surface;
    InstallModePreviewPanel.Left := 0;
    InstallModePreviewPanel.Top := InstallModePage.SurfaceHeight - ScaleY(62);
    InstallModePreviewPanel.Width := InstallModePage.SurfaceWidth;
    InstallModePreviewPanel.Height := ScaleY(58);
    InstallModePreviewPanel.BevelOuter := bvNone;
    InstallModePreviewPanel.Color := $00F3F3F3;
    InstallModePreviewPanel.Anchors := [akLeft, akRight, akBottom];

    InstallModePreviewLabel := TNewStaticText.Create(InstallModePreviewPanel);
    InstallModePreviewLabel.Parent := InstallModePreviewPanel;
    InstallModePreviewLabel.Left := ScaleX(12);
    InstallModePreviewLabel.Top := ScaleY(9);
    InstallModePreviewLabel.Width := InstallModePreviewPanel.ClientWidth - ScaleX(24);
    InstallModePreviewLabel.Height := InstallModePreviewPanel.ClientHeight - ScaleY(16);
    InstallModePreviewLabel.AutoSize := False;
    InstallModePreviewLabel.WordWrap := True;
    InstallModePreviewLabel.Caption :=
      InstallModePreview(InstallModePage.SelectedValueIndex);
    InstallModePreviewLabel.Anchors := [akLeft, akTop, akRight, akBottom];
    SelectInstallMode(InstallModePage.SelectedValueIndex);
  end;

  TitleText := SetupMessage(msgWizardSelectDir);
  SubTitleText := SetupMessage(msgSelectDirDesc);

  DirSelectPage := CreateCustomPage(
    wpLicense, // show right after License
    TitleText,
    SubTitleText
  );

  LeftCol     := ScaleX(50);
  TopY        := ScaleY(6);
  ButtonWidth := ScaleX(85);
  RowGap      := ScaleY(8);

  // Keep each icon visually aligned with the title and the full three-line description.
  InstallDirBitmap := TBitmapImage.Create(DirSelectPage);
  InstallDirBitmap.Parent := DirSelectPage.Surface;
  InstallDirBitmap.Left := ScaleX(0);
  InstallDirBitmap.Top := TopY;
  InstallDirBitmap.Width := ScaleX(40);
  InstallDirBitmap.Height := ScaleY(40);
  InstallDirBitmap.Stretch := True;
  ExtractTemporaryFile('folder-vcmi.bmp');
  InstallDirBitmap.Bitmap.LoadFromFile(ExpandConstant('{tmp}\folder-vcmi.bmp'));

  LabelInstall := TNewStaticText.Create(DirSelectPage);
  LabelInstall.Parent := DirSelectPage.Surface;
  LabelInstall.Left := LeftCol;
  LabelInstall.Top  := TopY;
  LabelInstall.Caption := ExpandConstant('{cm:InstallFolderTitle}');
  LabelInstall.AutoSize := True;
  LabelInstall.Font.Style := [fsBold];

  LabelInstallInfo1 := TNewStaticText.Create(DirSelectPage);
  LabelInstallInfo1.Parent := DirSelectPage.Surface;
  LabelInstallInfo1.Left := LeftCol;
  LabelInstallInfo1.Top := LabelInstall.Top + LabelInstall.Height + ScaleY(2);
  LabelInstallInfo1.Width := DirSelectPage.SurfaceWidth - LeftCol - ScaleX(4);
  LabelInstallInfo1.Height := ScaleY(30);
  LabelInstallInfo1.AutoSize := False;
  LabelInstallInfo1.WordWrap := True;
  LabelInstallInfo1.Anchors := [akLeft, akTop, akRight];
  InfoText := SetupMessage(msgSelectDirLabel3);
  StringChangeEx(InfoText, '[name]', '{#VCMIDisplayName}', True);
  LabelInstallInfo1.Caption := InfoText;

  TopY := LabelInstallInfo1.Top + LabelInstallInfo1.Height + ScaleY(4);

  InstallDirEdit := TEdit.Create(DirSelectPage);
  InstallDirEdit.Parent := DirSelectPage.Surface;
  InstallDirEdit.Left := ScaleX(0);
  InstallDirEdit.Top  := TopY;
  InstallDirEdit.Width := DirSelectPage.SurfaceWidth - ScaleX(91);
  InstallDirEdit.Anchors := [akLeft, akTop, akRight];
  InstallDirEdit.Text := WizardForm.DirEdit.Text;

  InstallDirBrowseBtn := TButton.Create(DirSelectPage);
  InstallDirBrowseBtn.Parent := DirSelectPage.Surface;
  InstallDirBrowseBtn.Left := InstallDirEdit.Left + InstallDirEdit.Width + ScaleX(6);
  InstallDirBrowseBtn.Top  := InstallDirEdit.Top - ScaleY(1);
  InstallDirBrowseBtn.Width := ButtonWidth;
  InstallDirBrowseBtn.Height := ScaleY(23);
  InstallDirBrowseBtn.Anchors := [akTop, akRight];
  InstallDirBrowseBtn.Caption := SetupMessage(msgButtonBrowse);
  InstallDirBrowseBtn.OnClick := @BrowseDirClick;

  CloudInstallNotice := TNewStaticText.Create(DirSelectPage);
  CloudInstallNotice.Parent := DirSelectPage.Surface;
  CloudInstallNotice.Left := InstallDirEdit.Left;
  CloudInstallNotice.Top := InstallDirEdit.Top + InstallDirEdit.Height + ScaleY(4);
  CloudInstallNotice.Width := InstallDirEdit.Width + ScaleX(91);
  CloudInstallNotice.Height := ScaleY(24);
  CloudInstallNotice.AutoSize := False;
  CloudInstallNotice.WordWrap := True;
  CloudInstallNotice.Anchors := [akLeft, akTop, akRight];
  CloudInstallNotice.Font.Color := clMaroon;
  CloudInstallNotice.Caption := ExpandConstant('{cm:CloudInstallNotice}');
  InstallDirEdit.OnChange := @InstallDirEditChange;
  UpdateCloudInstallNotice();

  TopY := CloudInstallNotice.Top + CloudInstallNotice.Height + RowGap;

  DataDirBitmap := TBitmapImage.Create(DirSelectPage);
  DataDirBitmap.Parent := DirSelectPage.Surface;
  DataDirBitmap.Left := ScaleX(0);
  DataDirBitmap.Top := TopY;
  DataDirBitmap.Width := ScaleX(40);
  DataDirBitmap.Height := ScaleY(40);
  DataDirBitmap.Stretch := True;
  ExtractTemporaryFile('folder-user.bmp');
  DataDirBitmap.Bitmap.LoadFromFile(ExpandConstant('{tmp}\folder-user.bmp'));

  LabelData := TNewStaticText.Create(DirSelectPage);
  LabelData.Parent := DirSelectPage.Surface;
  LabelData.Left := LeftCol;
  LabelData.Top  := TopY;
  LabelData.Caption := ExpandConstant('{cm:DataFolderTitle}');
  LabelData.AutoSize := True;
  LabelData.Font.Style := [fsBold];

  LabelDataInfo := TNewStaticText.Create(DirSelectPage);
  LabelDataInfo.Parent := DirSelectPage.Surface;
  LabelDataInfo.Left := LeftCol;
  LabelDataInfo.Top := LabelData.Top + LabelData.Height + ScaleY(2);
  LabelDataInfo.Width := DirSelectPage.SurfaceWidth - LeftCol - ScaleX(4);
  LabelDataInfo.Height := ScaleY(30);
  LabelDataInfo.AutoSize := False;
  LabelDataInfo.WordWrap := True;
  LabelDataInfo.Anchors := [akLeft, akTop, akRight];
  LabelDataInfo.Caption := ExpandConstant('{cm:DataFolderDescription}');

  TopY := LabelDataInfo.Top + LabelDataInfo.Height + ScaleY(4);

  DataDirEdit := TEdit.Create(DirSelectPage);
  DataDirEdit.Parent := DirSelectPage.Surface;
  DataDirEdit.Left := ScaleX(0);
  DataDirEdit.Top  := TopY;
  DataDirEdit.Width := DirSelectPage.SurfaceWidth - ScaleX(91);
  DataDirEdit.Anchors := [akLeft, akTop, akRight];
  if CommandLineUserDataDir <> '' then
    DataDirEdit.Text := CommandLineUserDataDir
  else
    DataDirEdit.Text := ReadUserDataPath(InstallDirEdit.Text, DefaultDataDir);

  DataDirBrowseBtn := TButton.Create(DirSelectPage);
  DataDirBrowseBtn.Parent := DirSelectPage.Surface;
  DataDirBrowseBtn.Left := DataDirEdit.Left + DataDirEdit.Width + ScaleX(6);
  DataDirBrowseBtn.Top  := DataDirEdit.Top - ScaleY(1);
  DataDirBrowseBtn.Width := ButtonWidth;
  DataDirBrowseBtn.Height := ScaleY(23);
  DataDirBrowseBtn.Anchors := [akTop, akRight];
  DataDirBrowseBtn.Caption := SetupMessage(msgButtonBrowse);
  DataDirBrowseBtn.OnClick := @BrowseDirClick;

  CloudDataNotice := TNewStaticText.Create(DirSelectPage);
  CloudDataNotice.Parent := DirSelectPage.Surface;
  CloudDataNotice.Left := DataDirEdit.Left;
  CloudDataNotice.Top := DataDirEdit.Top + DataDirEdit.Height + ScaleY(4);
  CloudDataNotice.Width := DataDirEdit.Width + ScaleX(91);
  CloudDataNotice.Height := ScaleY(24);
  CloudDataNotice.AutoSize := False;
  CloudDataNotice.WordWrap := True;
  CloudDataNotice.Anchors := [akLeft, akTop, akRight];
  CloudDataNotice.Font.Color := clMaroon;
  CloudDataNotice.Caption := ExpandConstant('{cm:CloudDataNotice}');
  DataDirEdit.OnChange := @DataDirEditChange;
  UpdateCloudDataNotice();

  CopyHeroes3DataCheck := TNewCheckBox.Create(DirSelectPage);
  CopyHeroes3DataCheck.Parent := DirSelectPage.Surface;
  CopyHeroes3DataCheck.Left := DataDirEdit.Left;
  CopyHeroes3DataCheck.Top := CloudDataNotice.Top + CloudDataNotice.Height + ScaleY(4);
  CopyHeroes3DataCheck.Width := DirSelectPage.SurfaceWidth - ScaleX(4);
  CopyHeroes3DataCheck.Height := ScaleY(20);
  CopyHeroes3DataCheck.Anchors := [akLeft, akTop, akRight];
  CopyHeroes3DataCheck.Caption := ExpandConstant('{cm:CopyH3Files}');
  CopyHeroes3DataCheck.Checked := CopyHeroes3DataSelected;
  CopyHeroes3DataCheck.OnClick := @CopyHeroes3DataClick;
  UpdateHeroes3CopyCheckbox();

  ResetDirsBtn := TButton.Create(DirSelectPage);
  ResetDirsBtn.Parent := DirSelectPage.Surface;
  ResetDirsBtn.Width := ScaleX(120);
  ResetDirsBtn.Height := ScaleY(23);
  ResetDirsBtn.Left := DirSelectPage.SurfaceWidth - ResetDirsBtn.Width;
  ResetDirsBtn.Top := CopyHeroes3DataCheck.Top + CopyHeroes3DataCheck.Height + ScaleY(4);
  ResetDirsBtn.Anchors := [akTop, akRight];
  ResetDirsBtn.Caption := ExpandConstant('{cm:ResetFoldersToDefault}');
  ResetDirsBtn.OnClick := @ResetDirsClick;

  DiskSpaceLabel := TNewStaticText.Create(DirSelectPage);
  DiskSpaceLabel.Parent := DirSelectPage.Surface;
  DiskSpaceLabel.AutoSize := True;
  // Inno has already calculated the installed size; CI source paths do not exist at runtime.
  BaseDiskSpaceCaption := WizardForm.DiskSpaceLabel.Caption;
  DiskSpaceLabel.Caption := BaseDiskSpaceCaption;
  DiskSpaceLabel.Left := 0; // align with original left margin
  DiskSpaceLabel.Top := DirSelectPage.SurfaceHeight - DiskSpaceLabel.Height - ScaleY(7);
  DiskSpaceLabel.Anchors := [akLeft, akBottom];
  UpdateDiskSpaceLabel();

  RequirementsPage := CreateCustomPage(
    wpSelectTasks,
    ExpandConstant('{cm:RequirementsCheckTitle}'),
    ExpandConstant('{cm:RequirementsCheckDescription}'));

  { Keep the original Component and Status widths. Required is sized from its
    longest normal localized value; Your system receives the remaining width. }
  RequirementMeasureLabel := TNewStaticText.Create(RequirementsPage);
  RequirementMeasureLabel.Parent := RequirementsPage.Surface;
  RequirementMeasureLabel.AutoSize := True;
  RequiredWidth := 0;
  RequirementMeasureLabel.Caption := ExpandConstant('{cm:RequirementOperatingSystemShortValue}');
  if RequirementMeasureLabel.Width > RequiredWidth then RequiredWidth := RequirementMeasureLabel.Width;
  RequirementMeasureLabel.Caption := ExpandConstant('{cm:RequirementRecommended}');
  if RequirementMeasureLabel.Width > RequiredWidth then RequiredWidth := RequirementMeasureLabel.Width;
  RequirementMeasureLabel.Caption := ExpandConstant('{cm:RequirementMultiplayerGames}');
  if RequirementMeasureLabel.Width > RequiredWidth then RequiredWidth := RequirementMeasureLabel.Width;
  RequirementMeasureLabel.Caption := ExpandConstant('{cm:RequirementRequiredToPlay}');
  if RequirementMeasureLabel.Width > RequiredWidth then RequiredWidth := RequirementMeasureLabel.Width;
  RequirementMeasureLabel.Caption := ExpandConstant('{cm:RequirementWritableValue}');
  if RequirementMeasureLabel.Width > RequiredWidth then RequiredWidth := RequirementMeasureLabel.Width;
  RequirementMeasureLabel.Free;
  RequiredWidth := RequiredWidth + ScaleX(16);
  { This is the exact residual width used by the original 22/28/36 layout. }
  StatusWidth := RequirementsPage.SurfaceWidth - ScaleX(8) -
    ((RequirementsPage.SurfaceWidth * 22) div 100) -
    ((RequirementsPage.SurfaceWidth * 28) div 100) -
    ((RequirementsPage.SurfaceWidth * 36) div 100);
  DetailsWidth := RequirementsPage.SurfaceWidth - ScaleX(8) -
    ((RequirementsPage.SurfaceWidth * 22) div 100) - RequiredWidth - StatusWidth;

  ExtractTemporaryFile('requirement-status-ok.bmp');
  ExtractTemporaryFile('requirement-status-ok-alternate.bmp');
  ExtractTemporaryFile('requirement-status-info.bmp');
  ExtractTemporaryFile('requirement-status-info-alternate.bmp');
  ExtractTemporaryFile('requirement-status-fail.bmp');
  ExtractTemporaryFile('requirement-status-fail-alternate.bmp');
  ExtractTemporaryFile('requirement-status-warn.bmp');
  ExtractTemporaryFile('requirement-status-warn-alternate.bmp');

  HeaderComponent := CreateRequirementsPanel(
    ExpandConstant('{cm:RequirementsColumnComponent}'), ScaleX(4), ScaleY(8),
    (RequirementsPage.SurfaceWidth * 22) div 100, ScaleY(28), 0, True, True, True);
  HeaderRequired := CreateRequirementsPanel(
    ExpandConstant('{cm:RequirementsColumnDetails}'),
    HeaderComponent.Left + HeaderComponent.Width, HeaderComponent.Top,
    RequiredWidth, HeaderComponent.Height,
    0, True, True, True);
  HeaderDetails := CreateRequirementsPanel(
    ExpandConstant('{cm:RequirementsColumnDetected}'),
    HeaderRequired.Left + HeaderRequired.Width, HeaderComponent.Top,
    DetailsWidth, HeaderComponent.Height,
    1, True, True, True);
  HeaderStatus := CreateRequirementsPanel(
    ExpandConstant('{cm:RequirementsColumnStatus}'),
    RequirementsPage.SurfaceWidth - StatusWidth - ScaleX(4), HeaderComponent.Top,
    StatusWidth,
    HeaderComponent.Height, 2, True, True, True);

  for Row := 0 to 14 do
  begin
    TopY := HeaderComponent.Top + HeaderComponent.Height + ScaleY(2) + Row * ScaleY(24);
    RequirementsComponentLabels[Row] := CreateRequirementsPanel('',
      HeaderComponent.Left, TopY, HeaderComponent.Width, ScaleY(23), 0, False, False, False);
    RequirementsRequiredLabels[Row] := CreateRequirementsPanel('',
      HeaderRequired.Left, TopY, HeaderRequired.Width, ScaleY(23), 0, False, False, False);
    RequirementsDetailsLabels[Row] := CreateRequirementsPanel('',
      HeaderDetails.Left, TopY, HeaderDetails.Width, ScaleY(23), 1, False, False, False);
    RequirementsStatusLabels[Row] := CreateRequirementsPanel('',
      HeaderStatus.Left, TopY, HeaderStatus.Width, ScaleY(23), 2, True, True, False);
    RequirementsStatusIcons[Row] := TBitmapImage.Create(RequirementsStatusLabels[Row]);
    RequirementsStatusIcons[Row].Parent := RequirementsStatusLabels[Row];
    RequirementsStatusIcons[Row].Width := ScaleX(18);
    RequirementsStatusIcons[Row].Height := ScaleY(18);
    RequirementsStatusIcons[Row].Left :=
      (RequirementsStatusLabels[Row].ClientWidth - RequirementsStatusIcons[Row].Width) div 2;
    RequirementsStatusIcons[Row].Top := ScaleY(2);
    RequirementsStatusIcons[Row].Stretch := True;
    RequirementsStatusIcons[Row].Visible := False;
    if (Row mod 2) <> 0 then
    begin
      RequirementsComponentLabels[Row].Color := $00F5F5F5;
      RequirementsRequiredLabels[Row].Color := $00F5F5F5;
      RequirementsDetailsLabels[Row].Color := $00F5F5F5;
      RequirementsStatusLabels[Row].Color := $00F5F5F5;
    end;
  end;

  WizardForm.TasksList.OnClickCheck := @OnTaskCheck;
  WizardForm.TasksList.Visible := False;
  LeftCol := WizardForm.TasksList.Left;
  TopY := WizardForm.TasksList.Top;
  ContentWidth := WizardForm.SelectTasksPage.ClientWidth - (2 * LeftCol);
  ButtonWidth := (ContentWidth - ScaleX(18)) div 2;

  CustomTaskGroupLabels[0] := CreateCustomTaskGroup(
    ExpandConstant('{cm:StartMenuShortcuts}'), LeftCol, TopY, ButtonWidth);
  CreateCustomTaskOption(0, ExpandConstant('{cm:ShortcutLauncher}'),
    LeftCol, TopY + ScaleY(19), ButtonWidth);
  CreateCustomTaskOption(1, ExpandConstant('{cm:ShortcutMapEditor}'),
    LeftCol, TopY + ScaleY(39), ButtonWidth);
  CreateCustomTaskOption(2, ExpandConstant('{cm:ShortcutWebPage}'),
    LeftCol, TopY + ScaleY(59), ButtonWidth);
  CreateCustomTaskOption(3, ExpandConstant('{cm:ShortcutDiscord}'),
    LeftCol, TopY + ScaleY(79), ButtonWidth);

  CustomTaskGroupLabels[1] := CreateCustomTaskGroup(
    ExpandConstant('{cm:DesktopShortcuts}'),
    LeftCol + ButtonWidth + ScaleX(18), TopY, ButtonWidth);
  CreateCustomTaskOption(4, ExpandConstant('{cm:ShortcutLauncher}'),
    CustomTaskGroupLabels[1].Left, TopY + ScaleY(19), ButtonWidth);
  CreateCustomTaskOption(5, ExpandConstant('{cm:ShortcutMapEditor}'),
    CustomTaskGroupLabels[1].Left, TopY + ScaleY(39), ButtonWidth);

  CustomTaskGroupLabels[2] := CreateCustomTaskGroup(
    ExpandConstant('{cm:FileAssociations}'), LeftCol,
    TopY + ScaleY(105), ButtonWidth);
  CreateCustomTaskOption(6, ExpandConstant('{cm:VMAPDescription}'),
    LeftCol, TopY + ScaleY(124), ButtonWidth);
  CreateCustomTaskOption(7, ExpandConstant('{cm:VCMPDescription}'),
    LeftCol, TopY + ScaleY(144), ButtonWidth);
  CreateCustomTaskOption(8, ExpandConstant('{cm:H3MDescription}'),
    LeftCol, TopY + ScaleY(164), ButtonWidth);
  CreateCustomTaskOption(9, ExpandConstant('{cm:H3CDescription}'),
    LeftCol, TopY + ScaleY(184), ButtonWidth);

  CustomTaskGroupLabels[3] := CreateCustomTaskGroup(
    ExpandConstant('{cm:VCMISettings}'), CustomTaskGroupLabels[1].Left,
    TopY + ScaleY(105), ButtonWidth);
  CreateCustomTaskOption(10, ExpandConstant('{cm:AddFirewallRules}'),
    CustomTaskGroupLabels[1].Left, TopY + ScaleY(124), ButtonWidth);

  TasksPreviewPanel := TPanel.Create(WizardForm.SelectTasksPage);
  TasksPreviewPanel.Parent := WizardForm.TasksList.Parent;
  TasksPreviewPanel.Left := LeftCol;
  TasksPreviewPanel.Top := WizardForm.TasksList.Parent.ClientHeight - ScaleY(62);
  TasksPreviewPanel.Width := ContentWidth;
  TasksPreviewPanel.Height := ScaleY(58);
  TasksPreviewPanel.BevelOuter := bvNone;
  TasksPreviewPanel.Color := $00F3F3F3;
  TasksPreviewPanel.Anchors := [akLeft, akRight, akBottom];

  TasksPreviewLabel := TNewStaticText.Create(TasksPreviewPanel);
  TasksPreviewLabel.Parent := TasksPreviewPanel;
  TasksPreviewLabel.Left := ScaleX(12);
  TasksPreviewLabel.Top := ScaleY(9);
  TasksPreviewLabel.Width := TasksPreviewPanel.ClientWidth - ScaleX(24);
  TasksPreviewLabel.Height := TasksPreviewPanel.ClientHeight - ScaleY(16);
  TasksPreviewLabel.AutoSize := False;
  TasksPreviewLabel.WordWrap := True;
  TasksPreviewLabel.Caption := '';
  TasksPreviewLabel.Anchors := [akLeft, akTop, akRight, akBottom];
  FirewallTaskPreviouslySelected := WizardIsTaskSelected('firewallrules');

  LastInstallModeHover := -1;
  LastTasksHover := -1;
  HoverPreviewTimerID := SetTimer(0, 0, 100,
    CreateCallback(@HoverPreviewTimerTick));

  WizardForm.ReadyMemo.ScrollBars := ssNone;
  WizardForm.ReadyMemo.WordWrap := True;
  InitializeReadySummary();

  FooterLabel := TLabel.Create(WizardForm);
  FooterLabel.Parent := WizardForm;
  FooterLabel.Caption := '{#VCMIDisplayName} v' + '{#AppVersion}' + '.' + '{#AppBuild}';
  FooterLabel.Left := 10;
  FooterLabel.Top := WizardForm.ClientHeight - 30;
  FooterLabel.Width := WizardForm.ClientWidth - 20;
  FooterLabel.Height := 40;

end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False; // Default is not to skip the page

  // The custom page handles both application and user-data locations.
  if PageID = wpSelectDir then
  begin
    Result := True;
    Exit;
  end;

  // An upgrade keeps both paths and the existing dirs.json unchanged.
  if IsUpgrade and Assigned(DirSelectPage) and (PageID = DirSelectPage.ID) then
  begin
    Result := True;
    Exit;
  end;

  if (WizardSilent or IsUpgrade) and Assigned(RequirementsPage)
    and (PageID = RequirementsPage.ID) then
  begin
    Result := True;
    Exit;
  end;

  // PR and portable setups have no system-integration tasks, but still expose
  // the optional Heroes III import when a usable source was detected.
  if (IsPRInstaller or IsPortableInstall) and (PageID = wpSelectTasks) then
  begin
    Result := True;
    Exit;
  end;

  if IsUpgrade then
  begin
    if (PageID = wpLicense) or (PageID = wpSelectTasks) or (PageID = wpReady) then
    begin
      Result := True; // Skip these pages during upgrade
      Exit;
    end;
  end;
end;

procedure DeinitializeSetup();
begin
  if HoverPreviewTimerID <> 0 then
    KillTimer(0, HoverPreviewTimerID);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  // Ensure the footer message is visible on every page
  FooterLabel.Visible := True;
  if Assigned(InstallModePage) and (CurPageID = InstallModePage.ID) then
    UpdateInstallModeLayout();
  if Assigned(RequirementsPage) and (CurPageID = RequirementsPage.ID) then
    UpdateRequirementsCheck();
  if CurPageID = wpSelectTasks then
    MapCustomTaskItems();
  if CurPageID = wpReady then
    UpdateReadySummary();
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  // Skip the custom page on upgrade
  if IsUpgrade and Assigned(InstallModePage) and (CurPageID = InstallModePage.ID) then
  begin
    Result := True;
    Exit;
  end;

  // Handle logic for the custom page if it exists
  if Assigned(InstallModePage) and (CurPageID = InstallModePage.ID) then
  begin
    if (InstallModePage.SelectedValueIndex = 0) and not IsAdminInstallMode then
    begin
      Result := False;
      Exit;
    end;

    if InstallModePage.SelectedValueIndex = 2 then
    begin
      if not HasCommandLineInstallDir then
      begin
        WizardForm.DirEdit.Text := ExpandConstant('{src}\VCMI');
        InstallDirEdit.Text := WizardForm.DirEdit.Text;
      end;
    end
    else if HasCommandLineInstallDir then
    begin
      // /DIR is already expanded and validated by Inno Setup in DirEdit.
      InstallDirEdit.Text := WizardForm.DirEdit.Text;
    end
    else if InstallModePage.SelectedValueIndex = 0 then
    begin
      WizardForm.DirEdit.Text := GetCommonProgramFilesDir + '\{#VCMIFolder}';
      InstallDirEdit.Text := WizardForm.DirEdit.Text;
    end
    else
    begin
      WizardForm.DirEdit.Text := GlobalUserAppdataFolder + '\{#VCMIFolder}';
      InstallDirEdit.Text := WizardForm.DirEdit.Text;
    end;

    // Recalculate both fields when the installation mode changes. Previously
    // only the portable mode updated user data, leaving the prior mode's path
    // in place until Reset to default was clicked.
    if CommandLineUserDataDir <> '' then
      DataDirEdit.Text := CommandLineUserDataDir
    else if IsPortableInstall then
      DataDirEdit.Text := InstallDirEdit.Text + '\VCMI-data'
    else
      DataDirEdit.Text := DefaultDataDir;
  end;

  if Assigned(DirSelectPage) and (CurPageID = DirSelectPage.ID) then
  begin
    // Validate install dir
    if not EnsureNonEmptyDir(SetupMessage(msgSelectDirLabel3), InstallDirEdit.Text) then
    begin
      Result := False;
      Exit;
    end;

    InstallDirEdit.Text := RemoveBackslashUnlessRoot(ExpandFileName(Trim(InstallDirEdit.Text)));

    if not ValidateDirectorySelection(
      InstallDirEdit.Text, ExpandConstant('{cm:InstallFolderTitle}')) then
    begin
      Result := False;
      Exit;
    end;

    if IsInstallPathUsedByRegisteredInstallation(InstallDirEdit.Text) then
    begin
      Result := ReportInvalidDirectory(Format(
        ExpandConstant('{cm:InstallDirectoryUsedByOtherInstallation}'), [InstallDirEdit.Text]));
      Exit;
    end;

    // Push the chosen install dir into the installer (this is what wpSelectDir would do)
    WizardForm.DirEdit.Text := InstallDirEdit.Text;

    if not ConfirmCloudTarget(InstallDirEdit.Text,
      ExpandConstant('{cm:CloudInstallWarning}'), ConfirmedCloudInstallDir) then
    begin
      Result := False;
      Exit;
    end;
    CloudInstallNotice.Visible := ConfirmedCloudInstallDir <> '';

    SelectedDataDir := Trim(DataDirEdit.Text);
    if SelectedDataDir = '' then
      SelectedDataDir := DefaultDataDir;
    SelectedDataDir := RemoveBackslashUnlessRoot(ExpandFileName(SelectedDataDir));

    DataDirEdit.Text := SelectedDataDir;
    if not ValidateDirectorySelection(
      SelectedDataDir, ExpandConstant('{cm:DataFolderTitle}')) then
    begin
      Result := False;
      Exit;
    end;

    if not ValidateDirectoryPair(InstallDirEdit.Text, SelectedDataDir) then
    begin
      Result := False;
      Exit;
    end;

    if not ConfirmCloudTarget(SelectedDataDir,
      ExpandConstant('{cm:CloudDataWarning}'), ConfirmedCloudDataDir) then
    begin
      Result := False;
      Exit;
    end;
    CloudDataNotice.Visible := ConfirmedCloudDataDir <> '';

    UpdateDataFolders(SelectedDataDir);

    Log('Selected installation dir: ' + InstallDirEdit.Text);
    Log('Selected data dir: ' + SelectedDataDir);
  end;

  if Assigned(RequirementsPage) and (CurPageID = RequirementsPage.ID) then
  begin
    UpdateRequirementsCheck();
    if not HasSpaceForHeroes3Import() then
    begin
      if MsgBox(ExpandConstant('{cm:RequirementInsufficientSpace}') + '.' +
        ''#13#10#13#10 + ExpandConstant('{cm:RequirementImportSpaceHelp}') +
        ''#13#10#13#10 + ExpandConstant('{cm:RequirementDisableImportQuestion}'),
        mbConfirmation, MB_YESNO) = IDYES then
      begin
        CopyHeroes3DataSelected := False;
        CopyHeroes3DataCheck.Checked := False;
        UpdateDiskSpaceLabel();
        UpdateRequirementsCheck();
      end
      else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;

  Result := True;
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo,
  MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
begin
  Result := MemoUserInfoInfo + MemoDirInfo;
  if SelectedDataDir <> '' then
    Result := Result + NewLine + NewLine
      + ExpandConstant('{cm:ReadyUserDataLocation}')
      + NewLine + Space + SelectedDataDir + NewLine + NewLine;
  if CopyHeroes3DataSelected and IsCopyFilesNeeded then
    Result := Result + ExpandConstant('{cm:ReadyHeroes3Import}')
      + NewLine + Space + ExpandConstant('{cm:CopyH3Files}') + NewLine + NewLine;
  Result := Result + MemoTypeInfo + MemoComponentsInfo + MemoGroupInfo + MemoTasksInfo;
end;

function TryReadUninstallExeFromRegistry(RootKey: Integer;
  const SubKey: String; var UninstallerPath: String): Boolean;
var
  ClosingQuote, Separator: Integer;
begin
  Result := RegQueryStringValue(RootKey, SubKey, 'UninstallString', UninstallerPath);
  if (not Result) or (Trim(UninstallerPath) = '') then
  begin
    UninstallerPath := '';
    Result := False;
  end;

  UninstallerPath := Trim(UninstallerPath);
  if Copy(UninstallerPath, 1, 1) = '"' then
  begin
    ClosingQuote := Pos('"', Copy(UninstallerPath, 2, Length(UninstallerPath)));
    if ClosingQuote = 0 then
    begin
      UninstallerPath := '';
      Result := False;
      Exit;
    end;
    UninstallerPath := Copy(UninstallerPath, 2, ClosingQuote - 1);
  end
  else if not FileExists(UninstallerPath) then
  begin
    Separator := Pos(' ', UninstallerPath);
    if Separator > 0 then
      UninstallerPath := Copy(UninstallerPath, 1, Separator - 1);
  end;
  Result := FileExists(UninstallerPath);
end;

function GetLegacyUninstallerPath(var UninstallerPath: String): Boolean;
var
  SubKey: String;
begin
  SubKey := 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VCMI';
  Result := False;
  if IsWin64 then
    Result := TryReadUninstallExeFromRegistry(HKLM64, SubKey, UninstallerPath);
  if not Result then
    Result := TryReadUninstallExeFromRegistry(HKLM32, SubKey, UninstallerPath);
end;

function RemoveLegacyInstaller(): Boolean;
var
  AppFolder: String;
  UninstallerPath, FailureText: String;
  ResultCode, Choice: Integer;
begin
  Result := False;
  AppFolder := ExpandConstant('{app}');
  while True do
  begin
    UninstallerPath := '';
    // A generic Uninstall.exe in a user-selected directory is not proof of a
    // legacy VCMI installation. Only the VCMI uninstall registry entry is trusted.
    if not GetLegacyUninstallerPath(UninstallerPath) then
    begin
      Result := True;
      Exit;
    end;

    FailureText := '';
    if not Exec(UninstallerPath, '/S', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
      FailureText := Format(ExpandConstant('{cm:LegacyUninstallStartFailed}'), [UninstallerPath])
    else if ResultCode <> 0 then
      FailureText := Format(ExpandConstant('{cm:LegacyUninstallExitFailed}'), [IntToStr(ResultCode)]);

    if FailureText <> '' then
    begin
      Log(FailureText);
      if WizardSilent then
        Exit;
      Choice := MsgBox(FailureText + #13#10#13#10 +
        ExpandConstant('{cm:LegacyUninstallFailureChoice}'), mbError,
        MB_ABORTRETRYIGNORE);
      if Choice = IDRETRY then
        Continue;
      if Choice = IDIGNORE then
        Result := True;
      Exit;
    end;

    // Only a successfully completed uninstaller may leave safe-to-remove files.
    if DirExists(AppFolder) and (CompareText(ExtractFileDir(UninstallerPath), AppFolder) = 0) then
      if not DelTree(AppFolder, True, True, False) then
        Log('Failed to remove legacy installation leftovers: ' + AppFolder);
    Result := True;
    Exit;
  end;
end;

function ContainsReparsePoint(const FolderPath: String): Boolean;
var
  FindRecord: TFindRec;
  EntryPath: String;
begin
  Result := False;
  if not FindFirst(AddBackslash(FolderPath) + '*', FindRecord) then
    Exit;
  try
    repeat
      if (FindRecord.Name <> '.') and (FindRecord.Name <> '..') then
      begin
        EntryPath := AddBackslash(FolderPath) + FindRecord.Name;
        if (FindRecord.Attributes and FILE_ATTRIBUTE_REPARSE_POINT_VALUE) <> 0 then
        begin
          Result := True;
          Exit;
        end;
        if ((FindRecord.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0)
          and ContainsReparsePoint(EntryPath) then
        begin
          Result := True;
          Exit;
        end;
      end;
    until not FindNext(FindRecord);
  finally
    FindClose(FindRecord);
  end;
end;

procedure PerformHeroes3FileCopy();
var
  OldMaximum, OldPosition: Integer;
  OldStatus, OldFileName: String;
  OldStyle: TNewProgressBarStyle;
  FreeSpace, TotalSpace, RequiredCopySize: Int64;
  SpaceProbe: String;
  SourceMapsValid, SourceDataValid, SourceMp3Valid: Boolean;
  TargetMapsValid, TargetDataValid, TargetMp3Valid: Boolean;
begin
  if CopyHeroes3DataSelected and IsCopyFilesNeeded then
  begin
    // The application payload has already been installed. Checking again here
    // therefore accounts correctly for application and imported data sharing
    // the same volume.
    RequiredCopySize := Heroes3CopySize();
    SpaceProbe := ExistingDirectoryForWriteTest(SelectedDataDir);
    if (RequiredCopySize > 0) and ((SpaceProbe = '')
      or not GetSpaceOnDisk64(SpaceProbe, FreeSpace, TotalSpace)
      or (FreeSpace < RequiredCopySize)) then
      RaiseException(ExpandConstant('{cm:RequirementInsufficientSpace}'));

    OldStyle := WizardForm.ProgressGauge.Style;
    OldStatus := WizardForm.StatusLabel.Caption;
    WizardForm.ProgressGauge.Style := npbstMarquee;
    WizardForm.StatusLabel.Caption := ExpandConstant('{cm:ScanningFiles}');
    WizardForm.Update;
    try
      SourceMapsValid := IsMapsFolderValid(Heroes3MapsFolder);
      SourceDataValid := IsDataFolderValid(Heroes3DataFolder);
      SourceMp3Valid := IsMp3FolderValid(Heroes3Mp3Folder);
      TargetMapsValid := IsMapsFolderValid(VCMIMapsFolder);
      TargetDataValid := IsDataFolderValid(VCMIDataFolder);
      TargetMp3Valid := IsMp3FolderValid(VCMIMp3Folder);
      if (SourceMapsValid and not TargetMapsValid and DirExists(VCMIMapsFolder)
          and ContainsReparsePoint(VCMIMapsFolder))
        or (SourceDataValid and not TargetDataValid and DirExists(VCMIDataFolder)
          and ContainsReparsePoint(VCMIDataFolder))
        or (SourceMp3Valid and not TargetMp3Valid and DirExists(VCMIMp3Folder)
          and ContainsReparsePoint(VCMIMp3Folder)) then
        RaiseException(ExpandConstant('{cm:Heroes3ImportReparsePoint}'));
      CustomProgressTotal := 0;
      if SourceMapsValid and not TargetMapsValid then
        CustomProgressTotal := CustomProgressTotal + Heroes3MapsFiles;
      if SourceDataValid and not TargetDataValid then
        CustomProgressTotal := CustomProgressTotal + Heroes3DataFiles;
      if SourceMp3Valid and not TargetMp3Valid then
        CustomProgressTotal := CustomProgressTotal + Heroes3Mp3Files;
    finally
      WizardForm.ProgressGauge.Style := OldStyle;
      WizardForm.StatusLabel.Caption := OldStatus;
    end;

    if CustomProgressTotal > 0 then
    begin
      OldMaximum := WizardForm.ProgressGauge.Max;
      OldPosition := WizardForm.ProgressGauge.Position;
      OldStatus := WizardForm.StatusLabel.Caption;
      OldFileName := WizardForm.FilenameLabel.Caption;
      CustomProgressPosition := 0;
      WizardForm.ProgressGauge.Max := CustomProgressTotal;
      WizardForm.ProgressGauge.Position := 0;
      WizardForm.StatusLabel.Caption := ExpandConstant('{cm:CopyingHeroes3Data}');
      try
        if (SourceMapsValid and not TargetMapsValid)
          and not CopyFolderContents(Heroes3MapsFolder, VCMIMapsFolder, True) then
          RaiseException(Format(ExpandConstant('{cm:CopyH3FilesError}'), ['Maps']));

        if (SourceDataValid and not TargetDataValid)
          and not CopyFolderContents(Heroes3DataFolder, VCMIDataFolder, True) then
          RaiseException(Format(ExpandConstant('{cm:CopyH3FilesError}'), ['Data']));

        if (SourceMp3Valid and not TargetMp3Valid)
          and not CopyFolderContents(Heroes3Mp3Folder, VCMIMp3Folder, True) then
          RaiseException(Format(ExpandConstant('{cm:CopyH3FilesError}'), ['Mp3']));
      finally
        WizardForm.ProgressGauge.Max := OldMaximum;
        WizardForm.ProgressGauge.Position := OldPosition;
        WizardForm.StatusLabel.Caption := OldStatus;
        WizardForm.FilenameLabel.Caption := OldFileName;
      end;
    end;
  end;
end;

procedure SkipJsonTrivia(const Content: String; var Position: Integer);
begin
  while Position <= Length(Content) do
  begin
    if Content[Position] <= ' ' then
      Position := Position + 1
    else if (Content[Position] = '/') and (Position < Length(Content))
      and (Content[Position + 1] = '/') then
    begin
      Position := Position + 2;
      while (Position <= Length(Content)) and (Content[Position] <> #10) do
        Position := Position + 1;
    end
    else
      Exit;
  end;
end;

function FindTopLevelJsonStringValue(const Content, Key: String;
  var ValueStart, ValueEnd: Integer): Boolean;
var
  Position, Depth, ArrayDepth, KeyStart: Integer;
  Quote: Char;
  Escaped: Boolean;
  ParsedKey: String;
begin
  Result := False;
  Position := 1;
  Depth := 0;
  ArrayDepth := 0;
  while Position <= Length(Content) do
  begin
    if (Content[Position] = '/') and (Position < Length(Content))
      and (Content[Position + 1] = '/') then
    begin
      Position := Position + 2;
      while (Position <= Length(Content)) and (Content[Position] <> #10) do
        Position := Position + 1;
      Continue;
    end;

    if (Content[Position] = '"') or (Content[Position] = '''') then
    begin
      Quote := Content[Position];
      KeyStart := Position + 1;
      Position := KeyStart;
      Escaped := False;
      while Position <= Length(Content) do
      begin
        if Escaped then
          Escaped := False
        else if Content[Position] = '\' then
          Escaped := True
        else if Content[Position] = Quote then
          Break;
        Position := Position + 1;
      end;
      if Position > Length(Content) then
        Exit;

      if (Depth = 1) and (ArrayDepth = 0) then
      begin
        ParsedKey := Copy(Content, KeyStart, Position - KeyStart);
        if CompareText(ParsedKey, Key) = 0 then
        begin
          Position := Position + 1;
          SkipJsonTrivia(Content, Position);
          if (Position <= Length(Content)) and (Content[Position] = ':') then
          begin
            Position := Position + 1;
            SkipJsonTrivia(Content, Position);
            if (Position <= Length(Content)) and (Content[Position] = '"') then
            begin
              ValueStart := Position + 1;
              Position := ValueStart;
              Escaped := False;
              while Position <= Length(Content) do
              begin
                if Escaped then
                  Escaped := False
                else if Content[Position] = '\' then
                  Escaped := True
                else if Content[Position] = '"' then
                begin
                  ValueEnd := Position;
                  Result := True;
                  Exit;
                end;
                Position := Position + 1;
              end;
              Exit;
            end;
          end;
        end;
      end;
    end
    else if Content[Position] = '{' then
      Depth := Depth + 1
    else if Content[Position] = '}' then
      Depth := Depth - 1
    else if Content[Position] = '[' then
      ArrayDepth := ArrayDepth + 1
    else if Content[Position] = ']' then
      ArrayDepth := ArrayDepth - 1;
    Position := Position + 1;
  end;
end;

procedure WriteDirectoriesConfig();
var
  ConfigDir, ConfigFile, JSONContent: String;
begin
  if IsUpgrade then
    Exit;

  ConfigDir := ExpandConstant('{app}\config');
  ConfigFile := ConfigDir + '\dirs.json';
  JSONContent :=
    '{' + #13#10 +
    '  "userDataPath" : "' + EscapeJsonString(SelectedDataDir) + '"' + #13#10 +
    '}' + #13#10;

  if (not DirExists(ConfigDir)) and not ForceDirectories(ConfigDir) then
    RaiseException(Format(ExpandConstant('{cm:DirectoryConfigWriteError}'), [ConfigFile]));
  if not SaveUTF8TextFile(ConfigFile, JSONContent) then
    RaiseException(Format(ExpandConstant('{cm:DirectoryConfigWriteError}'), [ConfigFile]));

  if not IsPortableInstall then
  begin
    if IsWin64 then
      RegDeleteValue(HKCU64, 'Software\VCMI', 'userDataPath');
    RegDeleteValue(HKCU32, 'Software\VCMI', 'userDataPath');
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    WriteDirectoriesConfig();
    PerformHeroes3FileCopy();
  end;
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  Result := '';
  { PrepareToInstall runs before Inno starts copying the new payload. Running a
    legacy uninstaller from a [Files] callback is too late: it may delete files
    or metadata already created by this installation. }
  if not IsPortableInstall and not RemoveLegacyInstaller() then
    Result := ExpandConstant('{cm:LegacyUninstallRequired}');
end;

// Uninstall

var
  DeleteUserDataLabel: TNewStaticText;
  DeleteUserDataDescriptionLabel: TNewStaticText;

function IsReparsePoint(const Path: String): Boolean;
var
  Attributes: Cardinal;
begin
  Attributes := GetFileAttributes(Path);
  Result := (Attributes <> INVALID_FILE_ATTRIBUTES)
    and ((Attributes and FILE_ATTRIBUTE_REPARSE_POINT_VALUE) <> 0);
end;

function RemoveReparsePoint(const Path: String; IsDirectory: Boolean): Boolean;
begin
  // Never follow links or junctions while deleting user data. Remove only the
  // reparse point itself, leaving its target and all target contents untouched.
  if IsDirectory then
    Result := RemoveDir(Path)
  else
    Result := DeleteFile(Path);
end;

function CountDeletionEntries(const FolderPath: String): Integer;
var
  FindResult: TFindRec;
  SubPath: String;
begin
  Result := 0;
  if FindFirst(FolderPath + '\*', FindResult) then
  begin
    try
      repeat
        if (FindResult.Name <> '.') and (FindResult.Name <> '..') then
        begin
          Result := Result + 1;
          if ((FindResult.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0)
            and ((FindResult.Attributes and FILE_ATTRIBUTE_REPARSE_POINT_VALUE) = 0) then
          begin
            SubPath := FolderPath + '\' + FindResult.Name;
            Result := Result + CountDeletionEntries(SubPath);
          end;
        end;
      until not FindNext(FindResult);
    finally
      FindClose(FindResult);
    end;
  end;
end;

procedure UpdateUninstallDeletionProgress(const Path: String);
var
  DisplayPath: String;
begin
  CustomProgressPosition := CustomProgressPosition + 1;
  UninstallProgressForm.ProgressBar.Position := CustomProgressPosition;
  DisplayPath := MinimizePathName(Path, UninstallProgressForm.StatusLabel.Font,
    UninstallProgressForm.StatusLabel.Width);
  UninstallProgressForm.StatusLabel.Caption := CustomUninstallStatusText + ' ' + DisplayPath;
  UninstallProgressForm.Update;
end;

function DeleteFolderContents(const FolderPath, CanonicalRoot: String): Boolean;
var
  FindResult: TFindRec;
  SubPath, CanonicalSubPath: String;
begin
  Result := True;

  if FindFirst(FolderPath + '\*', FindResult) then
  begin
    try
      repeat
        if (FindResult.Name <> '.') and (FindResult.Name <> '..') then
        begin
          SubPath := FolderPath + '\' + FindResult.Name;
          CanonicalSubPath := RemoveBackslashUnlessRoot(ExpandFileName(SubPath));

          // Re-check every entry before touching it. ExpandFileName resolves
          // relative components; refusing anything outside the selected root
          // also protects malformed or manually edited dirs.json paths.
          if not IsSameOrChildPath(CanonicalSubPath, CanonicalRoot) then
          begin
            Log('Refusing to delete path outside user directory: ' + SubPath);
            Result := False;
            Exit;
          end;

          if (FindResult.Attributes and FILE_ATTRIBUTE_REPARSE_POINT_VALUE) <> 0 then
          begin
            if not RemoveReparsePoint(SubPath,
              (FindResult.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) then
            begin
              Result := False;
              Exit;
            end;
            UpdateUninstallDeletionProgress(SubPath);
          end
          else if (FindResult.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
          begin
            if not DeleteFolderContents(SubPath, CanonicalRoot) then
            begin
              Result := False;
              Exit;
            end;
            if not RemoveDir(SubPath) then
            begin
              Result := False;
              Exit;
            end;
            UpdateUninstallDeletionProgress(SubPath);
          end
          else
          begin
            if not DeleteFile(SubPath) then
            begin
              Result := False;
              Exit;
            end;
            UpdateUninstallDeletionProgress(SubPath);
          end;
        end;
      until not FindNext(FindResult);
    finally
      FindClose(FindResult);
    end;
  end;
end;

procedure PerformFileDeletion;
var
  Index: Integer;
  FolderPath, CanonicalRoot: String;
  OldMaximum, OldPosition: Integer;
  OldStatus: String;
  OldStyle: TNewProgressBarStyle;
begin
  OldStyle := UninstallProgressForm.ProgressBar.Style;
  OldStatus := UninstallProgressForm.StatusLabel.Caption;
  UninstallProgressForm.ProgressBar.Style := npbstMarquee;
  UninstallProgressForm.StatusLabel.Caption := ExpandConstant('{cm:ScanningFiles}');
  UninstallProgressForm.Update;
  try
    CustomProgressTotal := 0;
    for Index := 0 to UninstallPathCount - 1 do
      if (DeleteAllUserData or (Assigned(DeletePathsList) and DeletePathsList.Checked[Index]))
        and not UninstallPathProtected[Index] and DirExists(UninstallPaths[Index]) then
      begin
        CustomProgressTotal := CustomProgressTotal + 1;
        if not IsReparsePoint(UninstallPaths[Index]) then
          CustomProgressTotal := CustomProgressTotal + CountDeletionEntries(UninstallPaths[Index]);
      end;
  finally
    UninstallProgressForm.ProgressBar.Style := OldStyle;
    UninstallProgressForm.StatusLabel.Caption := OldStatus;
  end;

  if CustomProgressTotal = 0 then
    Exit;

  OldMaximum := UninstallProgressForm.ProgressBar.Max;
  OldPosition := UninstallProgressForm.ProgressBar.Position;
  OldStatus := UninstallProgressForm.StatusLabel.Caption;
  CustomProgressPosition := 0;
  CustomUninstallStatusText := ExpandConstant('{cm:DeletingUserData}');
  UninstallProgressForm.ProgressBar.Max := CustomProgressTotal;
  UninstallProgressForm.ProgressBar.Position := 0;
  try
    for Index := 0 to UninstallPathCount - 1 do
    begin
      if (DeleteAllUserData or (Assigned(DeletePathsList) and DeletePathsList.Checked[Index]))
        and not UninstallPathProtected[Index] then
      begin
        FolderPath := UninstallPaths[Index];
        CanonicalRoot := RemoveBackslashUnlessRoot(ExpandFileName(FolderPath));
        if DirExists(FolderPath) and IsReparsePoint(FolderPath) then
        begin
          if not RemoveReparsePoint(FolderPath, True) then
            Log('Failed to remove user directory link: ' + FolderPath)
          else
            UpdateUninstallDeletionProgress(FolderPath);
        end
        else if DirExists(FolderPath) and DeleteFolderContents(FolderPath, CanonicalRoot) then
        begin
          if not RemoveDir(FolderPath) then
            Log('Failed to remove user directory: ' + FolderPath)
          else
            UpdateUninstallDeletionProgress(FolderPath);
        end;
      end;
    end;
  finally
    UninstallProgressForm.ProgressBar.Max := OldMaximum;
    UninstallProgressForm.ProgressBar.Position := OldPosition;
    UninstallProgressForm.StatusLabel.Caption := OldStatus;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usUninstall then
    PerformFileDeletion;
  // Repeat delete process after uninstall due logs from killed processes during uninstall
  if CurUninstallStep = usPostUninstall then
  begin
    PerformFileDeletion;
    MaintainFileAssociation('.vmap', 'VCMI.vmap', ExpandConstant('{cm:VMAPDescription}'));
    MaintainFileAssociation('.vcmp', 'VCMI.vcmp', ExpandConstant('{cm:VCMPDescription}'));
    MaintainFileAssociation('.h3m', 'VCMI.h3m', ExpandConstant('{cm:H3MDescription}'));
    MaintainFileAssociation('.h3c', 'VCMI.h3c', ExpandConstant('{cm:H3CDescription}'));
  end;
end;

procedure UninsNextButtonOnClick(Sender: TObject);
begin
  with UninstallProgressForm.InnerNotebook do
  begin
    ActivePage := Pages[ActivePage.PageIndex + 1];
    if ActivePage.PageIndex = PageCount - 1 then
    begin
      TButton(Sender).Hide;
      UninstallProgressForm.Close;
    end;
  end;
end;

procedure UninsCancelButtonOnClick(Sender: TObject);
begin
  // Optionally handle user cancellation
end;

procedure InitializeUninstallProgressForm();
var
  Page: TNewNotebookPage;
  UninsNextButton: TButton;
  Index, ListTop: Integer;
  ItemDescription: String;
begin
  if UninstallSilent then
    Exit;

  with UninstallProgressForm do
  begin
    // -- Create the "Uninstall" button
    UninsNextButton := TButton.Create(UninstallProgressForm);
    with UninsNextButton do
    begin
      Parent := UninstallProgressForm;
      Top := CancelButton.Top;
      Width := CancelButton.Width;
      Height := CancelButton.Height;
      Left := CancelButton.Left - Width - ScaleX(10);
      Caption := ExpandConstant('{cm:Uninstall}');
      OnClick := @UninsNextButtonOnClick;
      TabOrder := 1; // Ensure this button is first in the tab order
      Default := True; // Make it the default button (triggered by Enter key)
    end;

    // -- Configure the Cancel button so it aborts the form
    CancelButton.Enabled := True;
    CancelButton.ModalResult := mrAbort;
    CancelButton.OnClick := @UninsCancelButtonOnClick;

    // -- Create a custom page (as the first page in the notebook)
    Page := TNewNotebookPage.Create(InnerNotebook);
    with Page do
    begin
      Parent := InnerNotebook;
      Notebook := InnerNotebook;
      PageIndex := 0; // first page
    end;

    DeleteUserDataLabel := TNewStaticText.Create(UninstallProgressForm);
    with DeleteUserDataLabel do
    begin
      Parent := Page;
      Top := ScaleX(20);
      Left := ScaleX(20);
      Width := Page.Width - ScaleX(40);
      Caption := ExpandConstant('{cm:DeleteUserData}');
      Font.Style := [fsBold];
    end;

    DeleteUserDataDescriptionLabel := TNewStaticText.Create(UninstallProgressForm);
    with DeleteUserDataDescriptionLabel do
    begin
      Parent := Page;
      Top := DeleteUserDataLabel.Top + DeleteUserDataLabel.Height + ScaleY(4);
      Left := ScaleX(20);
      Width := Page.Width - ScaleX(40);
      Height := ScaleY(32);
      AutoSize := False;
      WordWrap := True;
      Caption := ExpandConstant('{cm:DeleteUserDataDescription}');
    end;

    ListTop := DeleteUserDataDescriptionLabel.Top + DeleteUserDataDescriptionLabel.Height + ScaleY(8);
    DeletePathsList := TNewCheckListBox.Create(UninstallProgressForm);
    with DeletePathsList do
    begin
      Parent := Page;
      Top := ListTop;
      Left := ScaleX(20);
      Width := Page.Width - ScaleX(40);
      Height := Page.Height - ListTop - ScaleY(12);
      Anchors := [akLeft, akTop, akRight, akBottom];
      BorderStyle := bsNone;
      ShowHint := True;
      Hint := ExpandConstant('{cm:UninstallCheckboxesTooltip}');
    end;

    for Index := 0 to UninstallPathCount - 1 do
    begin
      ItemDescription := UninstallPaths[Index];
      if UninstallPathProtected[Index] then
        ItemDescription := ItemDescription + ' — ' + ExpandConstant('{cm:SharedUserDataNotice}');
      DeletePathsList.AddCheckBox(UninstallPathDescriptions[Index], ItemDescription,
        0, False, not UninstallPathProtected[Index], False, False, nil);
    end;

    // -- Activate the first page
    InnerNotebook.ActivePage := Page;

    // -- Make InstallingPage the last page
    InstallingPage.PageIndex := InnerNotebook.PageCount - 1;

    // -- Show the form modally; if user clicks Cancel, ShowModal = mrAbort -> Abort uninstallation
    if ShowModal = mrAbort then
      Abort;
  end;
end;
