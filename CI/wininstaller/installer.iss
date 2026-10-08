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
WindowResizable=no
CloseApplicationsFilter=*.exe
CloseApplications=force
Compression=lzma2/ultra64
SolidCompression=yes
ArchitecturesAllowed={#AllowedArch}
SetupArchitecture={#SetupArch}
LicenseFile={#LicenseFile}
SetupIconFile={#IconFile}
WizardSmallImageFile={#SmallLogo}
WizardImageFile={#WizardLogo}

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
Source: "{#SourceFilesPath}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pdb,*.lib,*.exp,*.ilk,*.obj,*.tlog,*.log,*.pch,*.idb,*.res,*.tmp,*.bak,*.sdf,*.ipch,*.vc.db,*.iobj,*.ipdb"; BeforeInstall: RunPreInstallTasks
Source: "{#UCRTFilesPath}\{#InstallerArch}\*"; DestDir: "{app}"; Flags: ignoreversion; Check: IsUCRTNeeded

[Icons]
Name: "{group}\{cm:ShortcutLauncher}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_launcher.exe"; Comment: "{cm:ShortcutLauncherComment}{code:GetBranchSuffix}"; Tasks: startmenu; Check: not IsPortableInstall
Name: "{group}\{cm:ShortcutMapEditor}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_mapeditor.exe"; Comment: "{cm:ShortcutMapEditorComment}{code:GetBranchSuffix}"; Tasks: startmenu; Check: not IsPortableInstall
Name: "{group}\{cm:ShortcutWebPage}"; Filename: "{#VCMIHome}"; Comment: "{cm:ShortcutWebPageComment}"; Tasks: startmenu; Check: not IsPortableInstall
Name: "{group}\{cm:ShortcutDiscord}"; Filename: "{#VCMIContact}"; Comment: "{cm:ShortcutDiscordComment}"; Tasks: startmenu; Check: not IsPortableInstall

Name: "{code:GetUserDesktopFolder}\{cm:ShortcutLauncher}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_launcher.exe"; Comment: "{cm:ShortcutLauncherComment}{code:GetBranchSuffix}"; Tasks: desktop; Check: not IsPortableInstall

[Tasks]
Name: "desktop"; Description: "{cm:CreateDesktopShortcuts}"; GroupDescription: "{cm:SystemIntegration}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "startmenu"; Description: "{cm:CreateStartMenuShortcuts}"; GroupDescription: "{cm:SystemIntegration}"; Check: not IsPRInstaller and not IsPortableInstall
Name: "fileassociation_h3m"; Description: "{cm:AssociateH3MFiles}"; GroupDescription: "{cm:SystemIntegration}"; Flags: unchecked; Check: not IsPRInstaller and not IsPortableInstall
Name: "fileassociation_vcmimap"; Description: "{cm:AssociateVCMIMapFiles}"; GroupDescription: "{cm:SystemIntegration}"; Check: not IsPRInstaller and not IsPortableInstall

Name: "firewallrules"; Description: "{cm:AddFirewallRules}"; GroupDescription: "{cm:VCMISettings}"; Check: not IsPRInstaller and IsAdminInstallMode and not IsPortableInstall
Name: "h3copyfiles"; Description: "{cm:CopyH3Files}"; GroupDescription: "{cm:VCMISettings}"; Check: not IsPRInstaller and IsHeroes3Installed and IsCopyFilesNeeded

[Registry]
Root: HKA; Subkey: "Software\{#VCMIFolder}\Installer\{#InstallerArch}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Flags: uninsdeletekey; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\{#VCMIFolder}\Installer\{#InstallerArch}"; ValueType: string; ValueName: "userDataPath"; ValueData: "{code:GetSelectedDataDir}"; Flags: uninsdeletekey; Check: not IsPortableInstall

Root: HKA; Subkey: "Software\Classes\.vmap"; ValueType: string; ValueName: ""; ValueData: "VCMI.vmap"; Tasks: fileassociation_vcmimap; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.vmap"; ValueType: string; ValueName: ""; ValueData: "{cm:VMAPDescription}"; Tasks: fileassociation_vcmimap; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.vmap\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_vcmimap; Check: not IsPortableInstall

Root: HKA; Subkey: "Software\Classes\.vcmp"; ValueType: string; ValueName: ""; ValueData: "VCMI.vcmp"; Tasks: fileassociation_vcmimap; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.vcmp"; ValueType: string; ValueName: ""; ValueData: "{cm:VCMPDescription}"; Tasks: fileassociation_vcmimap; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.vcmp\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_vcmimap; Check: not IsPortableInstall

Root: HKA; Subkey: "Software\Classes\.h3m"; ValueType: string; ValueName: ""; ValueData: "VCMI.h3m"; Tasks: fileassociation_h3m; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.h3m"; ValueType: string; ValueName: ""; ValueData: "{cm:H3MDescription}"; Tasks: fileassociation_h3m; Check: not IsPortableInstall
Root: HKA; Subkey: "Software\Classes\VCMI.h3m\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_h3m; Check: not IsPortableInstall

[Run]
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""VCMI server ({#InstallerArch})"""; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin and not IsPortableInstall
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""VCMI server ({#InstallerArch})"" dir=in action=allow program=""{app}\vcmi_server.exe"" enable=yes profile=public,private"; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin and not IsPortableInstall
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""VCMI client ({#InstallerArch})"""; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin and not IsPortableInstall
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""VCMI client ({#InstallerArch})"" dir=in action=allow program=""{app}\vcmi_client.exe"" enable=yes profile=public,private"; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin and not IsPortableInstall

Filename: "{app}\VCMI_launcher.exe"; Description: "{cm:RunVCMILauncherAfterInstall}"; Flags: nowait postinstall; Check: ShouldRunLauncher

[UninstallRun]
; Remove firewall rules
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""VCMI server ({#InstallerArch})"""; Flags: runhidden; Check: IsAdmin; RunOnceId: "RemoveFirewallVCMIServer"
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""VCMI client ({#InstallerArch})"""; Flags: runhidden; Check: IsAdmin; RunOnceId: "RemoveFirewallVCMIClient"

[Code]
type
  TUninstallPathArray = array[0..4] of String;
  TUninstallPathDescriptionArray = array[0..4] of String;
  TUninstallPathProtectionArray = array[0..4] of Boolean;

const
  MOVEFILE_REPLACE_EXISTING = 1;
  MOVEFILE_WRITE_THROUGH = 8;
  WTS_CURRENT_SERVER_HANDLE = 0;
  WTS_CURRENT_SESSION = -1;
  WTSUserName = 5;
  FILE_ATTRIBUTE_REPARSE_POINT_VALUE = $400;
  INVALID_FILE_ATTRIBUTES = $FFFFFFFF;

var
  InstallModePage: TInputOptionWizardPage;
  FooterLabel: TLabel;
  IsUpgrade: Boolean;
  PreInstallTasksDone: Boolean;
  UninstallPathCount: Integer;
  UninstallPaths: TUninstallPathArray;
  UninstallPathDescriptions: TUninstallPathDescriptionArray;
  UninstallPathProtected: TUninstallPathProtectionArray;
  DeletePathsList: TNewCheckListBox;
  DeleteAllUserData: Boolean;
  Heroes3Path: String;
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

// Keep all imported APIs before the first routine implementation. Pascal Script
// does not allow new external declarations after routine bodies have started.
function WTSQuerySessionInformation(hServer: THandle; SessionId: Cardinal; WTSInfoClass: Integer; var pBuffer: NativeUInt; var BytesReturned: DWord): Boolean;
  external 'WTSQuerySessionInformationW@wtsapi32.dll stdcall';
procedure WTSFreeMemory(pMemory: NativeUInt);
  external 'WTSFreeMemory@wtsapi32.dll stdcall';
procedure RtlMoveMemoryAsString(Dest: string; Source: NativeUInt; Len: Integer);
  external 'RtlMoveMemory@kernel32.dll stdcall';
function ExpandEnvironmentStrings(Source, Destination: String; Size: Cardinal): Cardinal;
  external 'ExpandEnvironmentStringsW@kernel32.dll stdcall';
function MoveFileEx(ExistingFileName, NewFileName: String; Flags: Cardinal): Boolean;
  external 'MoveFileExW@kernel32.dll stdcall';
function PluginIsCloudStoragePath(Path: string): BOOL;
  external 'IsCloudStoragePath@files:installerPlugin.dll stdcall setuponly delayload';
function PluginModerFolderPicker(Owner: HWND; Title, Initial: string; OutPath: string; OutCch: Cardinal): BOOL;
  external 'ModerFolderPicker@files:installerPlugin.dll stdcall setuponly delayload';
function GetFileAttributes(FileName: String): Cardinal;
  external 'GetFileAttributesW@kernel32.dll stdcall';

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
  if RegQueryStringValue(HKLM, Key, ValueName, Result) then
    Exit
  else
    Result := '';
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

function ShouldRunLauncher(): Boolean;
begin
  Result := not WizardSilent or HasCommandLineSwitch('LAUNCH');
end;

function IsCloudTargetAllowed(): Boolean;
begin
  Result := HasCommandLineSwitch('ALLOWCLOUDTARGET');
end;

function FolderSize(FolderPath: String): Int64;
var
  FindRec: TFindRec;
  FileSizeValue: Int64;
begin
  Result := 0;
  if FindFirst(FolderPath + '\*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Attributes and $400) <> 0 then
          Continue
        else if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
        begin
          if FileSize64(FolderPath + '\' + FindRec.Name, FileSizeValue) then
            Result := Result + FileSizeValue;
        end
        else if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
          Result := Result + FolderSize(FolderPath + '\' + FindRec.Name);
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end;
end;

function IsFolderValid(FolderPath: String): Boolean;
begin
  Result := DirExists(FolderPath) and (FolderSize(FolderPath) > 1024 * 1024);
end;

function CountRegularFiles(const FolderPath: String): Integer;
var
  FindRec: TFindRec;
begin
  Result := 0;
  if FindFirst(FolderPath + '\*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Name <> '.') and (FindRec.Name <> '..')
          and ((FindRec.Attributes and $400) = 0) then
        begin
          if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
            Result := Result + CountRegularFiles(FolderPath + '\' + FindRec.Name)
          else
            Result := Result + 1;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end;
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
begin
  Result := False;
  if not DirExists(DestDir) then
    if not ForceDirectories(DestDir) then
      Exit;

  if FindFirst(SourceDir + '\*.*', FindRec) then
  begin
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
            if not FileCopy(SourceFile, DestFile, not Overwrite) then
            begin
              Log('Failed to copy Heroes III file from ' + SourceFile + ' to ' + DestFile);
              Exit;
            end;
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
  Result := '';
  QueryResult := WTSQuerySessionInformation(
    WTS_CURRENT_SERVER_HANDLE, WTS_CURRENT_SESSION, WTSUserName, Buffer, BytesReturned);
  if not QueryResult then
    Exit;

  try
    SetLength(Result, (BytesReturned div 2) - 1);
    RtlMoveMemoryAsString(Result, Buffer, BytesReturned - 2);
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

function SaveUTF8TextFileAtomically(const FileName, Content: String): Boolean;
var
  TemporaryFile: String;
begin
  TemporaryFile := FileName + '.tmp';
  DeleteFile(TemporaryFile);
  Result := SaveUTF8TextFile(TemporaryFile, Content);
  if not Result then
    Exit;

  Result := MoveFileEx(TemporaryFile, FileName,
    MOVEFILE_REPLACE_EXISTING or MOVEFILE_WRITE_THROUGH);
  if not Result then
    DeleteFile(TemporaryFile);
end;

function ReadPathFromConfig(const InstallDir, Key, Fallback: String): String;
var
  Content, ConfigFile, Value, SearchKey: String;
  KeyPosition, ColonPosition, Position: Integer;
  Escaped: Boolean;
begin
  Result := Fallback;
  ConfigFile := AddBackslash(InstallDir) + 'config\dirs.json';
  if not LoadUTF8TextFile(ConfigFile, Content) then
    Exit;

  SearchKey := '"' + Key + '"';
  KeyPosition := Pos(SearchKey, Content);
  if KeyPosition = 0 then
    Exit;

  ColonPosition := Pos(':', Copy(Content, KeyPosition + Length(SearchKey), Length(Content)));
  if ColonPosition = 0 then
    Exit;
  Position := KeyPosition + Length(SearchKey) - 1 + ColonPosition;
  while (Position <= Length(Content)) and (Content[Position] <> '"') do
    Position := Position + 1;
  if Position > Length(Content) then
    Exit;

  Position := Position + 1;
  Escaped := False;
  while Position <= Length(Content) do
  begin
    if Escaped then
    begin
      Value := Value + Content[Position];
      Escaped := False;
    end
    else if Content[Position] = '\' then
      Escaped := True
    else if Content[Position] = '"' then
    begin
      Result := ExpandEnvironmentPath(Value);
      Exit;
    end
    else
      Value := Value + Content[Position];
    Position := Position + 1;
  end;
end;

function GetSelectedDataDir(Default: String): String;
begin
  Result := SelectedDataDir;
end;

function ReadUserDataPath(const InstallDir, Fallback: String): String;
begin
  // Keep the same precedence as VCMIDirsWIN32: the per-user registry is the
  // write fallback when dirs.json cannot be replaced, followed by this
  // installation's config file and finally the platform default.
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
    // Cloud detection is advisory. A missing or incompatible plugin must not
    // prevent setup from running on any supported Windows version.
    Log('Cloud storage detection plugin is unavailable for: ' + Path);
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
  // Check if any of the required folders are not valid
  Result := not (IsFolderValid(VCMIDataFolder) and IsFolderValid(VCMIMapsFolder) and IsFolderValid(VCMIMp3Folder));

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

function InitializeSetup(): Boolean;
var
  InstallPath: String;
begin
  CommandLinePortable := CompareText(ExpandConstant('{param:PORTABLE|0}'), '1') = 0;

  // Check if the application is already installed
  IsUpgrade := ReadArchitectureInstallPath('{#InstallerArch}', InstallPath);
  if CommandLinePortable then
    IsUpgrade := False;

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
  SelectedDataDir := DefaultDataDir;
  UpdateDataFolders(SelectedDataDir);

  // Check for Heroes 3 installation paths
  Heroes3Path := RegistryQueryPath('SOFTWARE\GOG.com\Games\1207658787', 'path');
  if Heroes3Path = '' then
    Heroes3Path := RegistryQueryPath('SOFTWARE\WOW6432Node\GOG.com\Games\1207658787', 'path');
  if Heroes3Path = '' then
    Heroes3Path := RegistryQueryPath('SOFTWARE\New World Computing\Heroes of Might and Magic® III\1.0', 'AppPath');
  if Heroes3Path = '' then
    Heroes3Path := RegistryQueryPath('SOFTWARE\WOW6432Node\New World Computing\Heroes of Might and Magic® III\1.0', 'AppPath');
  if Heroes3Path = '' then
    Heroes3Path := RegistryQueryPath('SOFTWARE\New World Computing\Heroes of Might and Magic III\1.0', 'AppPath');
  if Heroes3Path = '' then
    Heroes3Path := RegistryQueryPath('SOFTWARE\WOW6432Node\New World Computing\Heroes of Might and Magic III\1.0', 'AppPath');

  if (Heroes3Path <> '') then
  begin
    Heroes3MapsFolder := Heroes3Path + '\Maps';
    Heroes3DataFolder := Heroes3Path + '\Data';
    Heroes3Mp3Folder := Heroes3Path + '\Mp3';
  end;

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
  LoadUninstallPaths(ExpandConstant('{app}'), SelectedDataDir);
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
    if Sender = InstallDirBrowseBtn then
    begin
      if IsCloudStoragePath(picked) then
      begin
        if MsgBox(ExpandConstant('{cm:CloudInstallWarning}'), mbConfirmation, MB_YESNO) <> IDYES then
          Exit;
        ConfirmedCloudInstallDir := picked;
      end;
      InstallDirEdit.Text := picked
    end
    else
    begin
      if IsCloudStoragePath(picked) then
      begin
        if MsgBox(ExpandConstant('{cm:CloudDataWarning}'), mbConfirmation, MB_YESNO) <> IDYES then
          Exit;
        ConfirmedCloudDataDir := picked;
      end;
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

procedure DataDirEditChange(Sender: TObject);
begin
  UpdateCloudDataNotice();
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

procedure InitializeWizard();
var
  TitleText, SubTitleText, InfoText: String;
  LeftCol, TopY, ButtonWidth, RowGap: Integer;

  // Disk space line (same wording as the original page)
  DiskSpaceLabel: TNewStaticText;

begin
  if (CompareText('{#InstallerArch}', 'x86') = 0) and not IsX86OS then
  begin
    Log('Installing the x86 VCMI package on a non-x86 Windows system.');
    if not WizardSilent then
      MsgBox(ExpandConstant('{cm:X86On64BitWarning}'), mbInformation, MB_OK);
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

    InstallModePage.Add(ExpandConstant(#13#10 + '  {cm:InstallForAllUsers}' + #13#10 + '   • {cm:InstallForAllUsers1}' + #13#10 + #13#10));
    InstallModePage.Add(ExpandConstant(#13#10 + '  {cm:InstallForMeOnly}' + #13#10  +  '   • {cm:InstallForMeOnly1}' + #13#10 + '   • {cm:InstallForMeOnly2}' + #13#10));
    InstallModePage.Add(ExpandConstant(#13#10 + '  {cm:InstallPortable}' + #13#10 + '   • {cm:InstallPortable1}' + #13#10 + '   • {cm:InstallPortable2}' + #13#10));

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

      // Force a redraw of the CheckListBox to fix appearance
      InstallModePage.CheckListBox.Invalidate();
    end;
  end;

  TitleText := SetupMessage(msgWizardSelectDir);
  SubTitleText := SetupMessage(msgSelectDirDesc);

  DirSelectPage := CreateCustomPage(
    wpLicense, // show right after License
    TitleText,
    SubTitleText
  );

  LeftCol     := ScaleX(44);
  TopY        := ScaleY(6);
  ButtonWidth := ScaleX(85);
  RowGap      := ScaleY(8);

  // Both sections use the same small folder icon and text layout as the standard page.
  InstallDirBitmap := TBitmapImage.Create(DirSelectPage);
  InstallDirBitmap.Parent := DirSelectPage.Surface;
  InstallDirBitmap.Left := ScaleX(0);
  InstallDirBitmap.Top := TopY;
  InstallDirBitmap.Width := ScaleX(32);
  InstallDirBitmap.Height := ScaleY(32);
  InstallDirBitmap.Stretch := True;
  InstallDirBitmap.Bitmap.Assign(WizardForm.SelectDirBitmapImage.Bitmap);

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
  LabelInstallInfo1.Width := DirSelectPage.SurfaceWidth - LeftCol;
  LabelInstallInfo1.Height := ScaleY(28);
  LabelInstallInfo1.AutoSize := False;
  LabelInstallInfo1.WordWrap := True;
  InfoText := SetupMessage(msgSelectDirLabel3);
  StringChangeEx(InfoText, '[name]', '{#VCMIDisplayName}', True);
  LabelInstallInfo1.Caption := InfoText;

  TopY := LabelInstallInfo1.Top + LabelInstallInfo1.Height + ScaleY(4);

  InstallDirEdit := TEdit.Create(DirSelectPage);
  InstallDirEdit.Parent := DirSelectPage.Surface;
  InstallDirEdit.Left := ScaleX(0);
  InstallDirEdit.Top  := TopY;
  InstallDirEdit.Width := DirSelectPage.SurfaceWidth - ScaleX(91);
  InstallDirEdit.Text := WizardForm.DirEdit.Text;

  InstallDirBrowseBtn := TButton.Create(DirSelectPage);
  InstallDirBrowseBtn.Parent := DirSelectPage.Surface;
  InstallDirBrowseBtn.Left := InstallDirEdit.Left + InstallDirEdit.Width + ScaleX(6);
  InstallDirBrowseBtn.Top  := InstallDirEdit.Top - ScaleY(1);
  InstallDirBrowseBtn.Width := ButtonWidth;
  InstallDirBrowseBtn.Height := ScaleY(23);
  InstallDirBrowseBtn.Caption := SetupMessage(msgButtonBrowse);
  InstallDirBrowseBtn.OnClick := @BrowseDirClick;

  CloudInstallNotice := TNewStaticText.Create(DirSelectPage);
  CloudInstallNotice.Parent := DirSelectPage.Surface;
  CloudInstallNotice.Left := InstallDirEdit.Left;
  CloudInstallNotice.Top := InstallDirEdit.Top + InstallDirEdit.Height + ScaleY(4);
  CloudInstallNotice.Width := InstallDirEdit.Width + ScaleX(91);
  CloudInstallNotice.Height := ScaleY(32);
  CloudInstallNotice.AutoSize := False;
  CloudInstallNotice.WordWrap := True;
  CloudInstallNotice.Font.Color := clMaroon;
  CloudInstallNotice.Caption := ExpandConstant('{cm:CloudInstallNotice}');
  InstallDirEdit.OnChange := @InstallDirEditChange;
  UpdateCloudInstallNotice();

  TopY := CloudInstallNotice.Top + CloudInstallNotice.Height + RowGap;

  DataDirBitmap := TBitmapImage.Create(DirSelectPage);
  DataDirBitmap.Parent := DirSelectPage.Surface;
  DataDirBitmap.Left := ScaleX(0);
  DataDirBitmap.Top := TopY;
  DataDirBitmap.Width := ScaleX(32);
  DataDirBitmap.Height := ScaleY(32);
  DataDirBitmap.Stretch := True;
  DataDirBitmap.Bitmap.Assign(WizardForm.SelectDirBitmapImage.Bitmap);

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
  LabelDataInfo.Width := DirSelectPage.SurfaceWidth - LeftCol;
  LabelDataInfo.Height := ScaleY(28);
  LabelDataInfo.AutoSize := False;
  LabelDataInfo.WordWrap := True;
  LabelDataInfo.Caption := ExpandConstant('{cm:DataFolderDescription}');

  TopY := LabelDataInfo.Top + LabelDataInfo.Height + ScaleY(4);

  DataDirEdit := TEdit.Create(DirSelectPage);
  DataDirEdit.Parent := DirSelectPage.Surface;
  DataDirEdit.Left := ScaleX(0);
  DataDirEdit.Top  := TopY;
  DataDirEdit.Width := DirSelectPage.SurfaceWidth - ScaleX(91);
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
  DataDirBrowseBtn.Caption := SetupMessage(msgButtonBrowse);
  DataDirBrowseBtn.OnClick := @BrowseDirClick;

  CloudDataNotice := TNewStaticText.Create(DirSelectPage);
  CloudDataNotice.Parent := DirSelectPage.Surface;
  CloudDataNotice.Left := DataDirEdit.Left;
  CloudDataNotice.Top := DataDirEdit.Top + DataDirEdit.Height + ScaleY(4);
  CloudDataNotice.Width := DataDirEdit.Width + ScaleX(91);
  CloudDataNotice.Height := ScaleY(32);
  CloudDataNotice.AutoSize := False;
  CloudDataNotice.WordWrap := True;
  CloudDataNotice.Font.Color := clMaroon;
  CloudDataNotice.Caption := ExpandConstant('{cm:CloudDataNotice}');
  DataDirEdit.OnChange := @DataDirEditChange;
  UpdateCloudDataNotice();

  ResetDirsBtn := TButton.Create(DirSelectPage);
  ResetDirsBtn.Parent := DirSelectPage.Surface;
  ResetDirsBtn.Width := ScaleX(120);
  ResetDirsBtn.Height := ScaleY(23);
  ResetDirsBtn.Left := DirSelectPage.SurfaceWidth - ResetDirsBtn.Width;
  ResetDirsBtn.Top := CloudDataNotice.Top + CloudDataNotice.Height + ScaleY(2);
  ResetDirsBtn.Caption := ExpandConstant('{cm:ResetFoldersToDefault}');
  ResetDirsBtn.OnClick := @ResetDirsClick;

  DiskSpaceLabel := TNewStaticText.Create(DirSelectPage);
  DiskSpaceLabel.Parent := DirSelectPage.Surface;
  DiskSpaceLabel.AutoSize := True;
  // Inno has already calculated the installed size; CI source paths do not exist at runtime.
  DiskSpaceLabel.Caption := WizardForm.DiskSpaceLabel.Caption;
  DiskSpaceLabel.Left := 0; // align with original left margin
  DiskSpaceLabel.Top := DirSelectPage.SurfaceHeight - DiskSpaceLabel.Height - ScaleY(7);
  DiskSpaceLabel.Anchors := [akLeft, akBottom];

  WizardForm.TasksList.OnClickCheck := @OnTaskCheck;
  FirewallTaskPreviouslySelected := WizardIsTaskSelected('firewallrules');

  WizardForm.ReadyMemo.ScrollBars := ssNone;
  WizardForm.ReadyMemo.WordWrap := True;

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

  // Skip Tasks page if this is a PR build
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

procedure CurPageChanged(CurPageID: Integer);
begin
  // Ensure the footer message is visible on every page
  FooterLabel.Visible := True;
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
      if CommandLineUserDataDir = '' then
        DataDirEdit.Text := InstallDirEdit.Text + '\VCMI-data';
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
  end;

  if Assigned(DirSelectPage) and (CurPageID = DirSelectPage.ID) then
  begin
    // Validate install dir
    if not EnsureNonEmptyDir(SetupMessage(msgSelectDirLabel3), InstallDirEdit.Text) then
    begin
      Result := False;
      Exit;
    end;

    InstallDirEdit.Text := RemoveBackslashUnlessRoot(Trim(InstallDirEdit.Text));

    // Push the chosen install dir into the installer (this is what wpSelectDir would do)
    WizardForm.DirEdit.Text := InstallDirEdit.Text;

    if IsCloudStoragePath(InstallDirEdit.Text) then
    begin
      CloudInstallNotice.Visible := True;
      if CompareText(ConfirmedCloudInstallDir, InstallDirEdit.Text) <> 0 then
      begin
        if WizardSilent and not IsCloudTargetAllowed() then
          RaiseException(ExpandConstant('{cm:CloudTargetSilentError}'));
        if not WizardSilent
          and (MsgBox(ExpandConstant('{cm:CloudInstallWarning}'), mbConfirmation, MB_YESNO) <> IDYES) then
        begin
          Result := False;
          Exit;
        end;
        ConfirmedCloudInstallDir := InstallDirEdit.Text;
      end;
    end
    else
    begin
      CloudInstallNotice.Visible := False;
      ConfirmedCloudInstallDir := '';
    end;

    SelectedDataDir := RemoveBackslashUnlessRoot(Trim(DataDirEdit.Text));

    if Trim(SelectedDataDir) = '' then
      SelectedDataDir := DefaultDataDir;

    if IsCloudStoragePath(SelectedDataDir) then
    begin
      CloudDataNotice.Visible := True;
      if CompareText(ConfirmedCloudDataDir, SelectedDataDir) <> 0 then
      begin
        if WizardSilent and not IsCloudTargetAllowed() then
          RaiseException(ExpandConstant('{cm:CloudTargetSilentError}'));
        if not WizardSilent
          and (MsgBox(ExpandConstant('{cm:CloudDataWarning}'), mbConfirmation, MB_YESNO) <> IDYES) then
        begin
          Result := False;
          Exit;
        end;
        ConfirmedCloudDataDir := SelectedDataDir;
      end;
    end
    else
    begin
      CloudDataNotice.Visible := False;
      ConfirmedCloudDataDir := '';
    end;

    UpdateDataFolders(SelectedDataDir);

    Log('Selected installation dir: ' + InstallDirEdit.Text);
    Log('Selected data dir: ' + SelectedDataDir);
  end;

  Result := True;
end;

function TryReadUninstallExeFromHKLM(const SubKey: String; var UninstallerPath: String): Boolean;
var
  ClosingQuote, Separator: Integer;
begin
  Result := RegQueryStringValue(HKLM, SubKey, 'UninstallString', UninstallerPath);
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
begin
  Result := TryReadUninstallExeFromHKLM('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VCMI', UninstallerPath) or TryReadUninstallExeFromHKLM('SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\VCMI', UninstallerPath);
end;

procedure RemoveLegacyInstaller();
var
  AppFolder: String;
  UninstallerPath: String;
  ResultCode: Integer;
begin
  AppFolder := ExpandConstant('{app}');
  UninstallerPath := '';

  // A generic Uninstall.exe in a user-selected directory is not proof of a
  // legacy VCMI installation. Only the VCMI uninstall registry entry is trusted.
  if not GetLegacyUninstallerPath(UninstallerPath) then
    Exit;

  if (UninstallerPath <> '') and FileExists(UninstallerPath) then
  begin
    if not Exec(UninstallerPath, '/S', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
    begin
      Log('Failed to start legacy uninstaller: ' + UninstallerPath);
      Exit;
    end;
    if ResultCode <> 0 then
    begin
      Log(Format('Legacy uninstaller failed with exit code %d; keeping its files.', [ResultCode]));
      Exit;
    end;

    // Only a successfully completed uninstaller may leave safe-to-remove files.
    if DirExists(AppFolder) and (CompareText(ExtractFileDir(UninstallerPath), AppFolder) = 0) then
      if not DelTree(AppFolder, True, True, False) then
        Log('Failed to remove legacy installation leftovers: ' + AppFolder);
  end;
end;

procedure PerformHeroes3FileCopy();
var
  OldMaximum, OldPosition: Integer;
  OldStatus, OldFileName: String;
  OldStyle: TNewProgressBarStyle;
  SourceMapsValid, SourceDataValid, SourceMp3Valid: Boolean;
  TargetMapsValid, TargetDataValid, TargetMp3Valid: Boolean;
begin
  if WizardIsTaskSelected('h3copyfiles') then
  begin
    OldStyle := WizardForm.ProgressGauge.Style;
    OldStatus := WizardForm.StatusLabel.Caption;
    WizardForm.ProgressGauge.Style := npbstMarquee;
    WizardForm.StatusLabel.Caption := ExpandConstant('{cm:ScanningFiles}');
    WizardForm.Update;
    try
      SourceMapsValid := IsFolderValid(Heroes3MapsFolder);
      SourceDataValid := IsFolderValid(Heroes3DataFolder);
      SourceMp3Valid := IsFolderValid(Heroes3Mp3Folder);
      TargetMapsValid := IsFolderValid(VCMIMapsFolder);
      TargetDataValid := IsFolderValid(VCMIDataFolder);
      TargetMp3Valid := IsFolderValid(VCMIMp3Folder);
      CustomProgressTotal := 0;
      if SourceMapsValid and not TargetMapsValid then
        CustomProgressTotal := CustomProgressTotal + CountRegularFiles(Heroes3MapsFolder);
      if SourceDataValid and not TargetDataValid then
        CustomProgressTotal := CustomProgressTotal + CountRegularFiles(Heroes3DataFolder);
      if SourceMp3Valid and not TargetMp3Valid then
        CustomProgressTotal := CustomProgressTotal + CountRegularFiles(Heroes3Mp3Folder);
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

procedure WriteDirectoriesConfig();
var
  ConfigDir, ConfigFile, JSONContent, EscapedPath, InstallerRegistryKey: String;
  KeyPosition, ColonPosition, Position, ValueStart, ClosingBrace: Integer;
  Escaped, ValueUpdated: Boolean;
begin
  ConfigDir := ExpandConstant('{app}\config');
  ConfigFile := ConfigDir + '\dirs.json';
  EscapedPath := EscapeJsonString(SelectedDataDir);
  InstallerRegistryKey := 'Software\VCMI\Installer\{#InstallerArch}';
  ValueUpdated := False;

  if not IsPortableInstall then
  begin
    if IsAdminInstallMode then
    begin
      if IsWin64 then
      begin
        RegWriteStringValue(HKLM64, InstallerRegistryKey, 'InstallPath', ExpandConstant('{app}'));
        RegWriteStringValue(HKLM64, InstallerRegistryKey, 'userDataPath', SelectedDataDir);
      end;
      RegWriteStringValue(HKLM32, InstallerRegistryKey, 'InstallPath', ExpandConstant('{app}'));
      RegWriteStringValue(HKLM32, InstallerRegistryKey, 'userDataPath', SelectedDataDir);
    end
    else
    begin
      if IsWin64 then
      begin
        RegWriteStringValue(HKCU64, InstallerRegistryKey, 'InstallPath', ExpandConstant('{app}'));
        RegWriteStringValue(HKCU64, InstallerRegistryKey, 'userDataPath', SelectedDataDir);
      end;
      RegWriteStringValue(HKCU32, InstallerRegistryKey, 'InstallPath', ExpandConstant('{app}'));
      RegWriteStringValue(HKCU32, InstallerRegistryKey, 'userDataPath', SelectedDataDir);
    end;
  end;

  if LoadUTF8TextFile(ConfigFile, JSONContent) then
  begin
    KeyPosition := Pos('"userDataPath"', JSONContent);
    if KeyPosition > 0 then
    begin
      ColonPosition := Pos(':', Copy(JSONContent, KeyPosition + 14, Length(JSONContent)));
      if ColonPosition > 0 then
      begin
        Position := KeyPosition + 13 + ColonPosition;
        while (Position <= Length(JSONContent)) and (JSONContent[Position] <> '"') do
          Position := Position + 1;
        ValueStart := Position + 1;
        Position := ValueStart;
        Escaped := False;
        while Position <= Length(JSONContent) do
        begin
          if Escaped then
            Escaped := False
          else if JSONContent[Position] = '\' then
            Escaped := True
          else if JSONContent[Position] = '"' then
          begin
            Delete(JSONContent, ValueStart, Position - ValueStart);
            Insert(EscapedPath, JSONContent, ValueStart);
            ValueUpdated := True;
            Break;
          end;
          Position := Position + 1;
        end;
      end;
    end;
    if not ValueUpdated then
    begin
      ClosingBrace := Length(JSONContent);
      while (ClosingBrace > 0) and (JSONContent[ClosingBrace] <> '}') do
        ClosingBrace := ClosingBrace - 1;
      if ClosingBrace > 0 then
      begin
        if Pos(':', JSONContent) > 0 then
          Insert(',' + #13#10 + '  "userDataPath" : "' + EscapedPath + '"' + #13#10, JSONContent, ClosingBrace)
        else
          Insert(#13#10 + '  "userDataPath" : "' + EscapedPath + '"' + #13#10, JSONContent, ClosingBrace);
      end;
    end;
  end
  else
    JSONContent :=
      '{' + #13#10 +
      '  "userDataPath" : "' + EscapedPath + '"' + #13#10 +
      '}' + #13#10;

  if not DirExists(ConfigDir) then
    ForceDirectories(ConfigDir);
  if SaveUTF8TextFileAtomically(ConfigFile, JSONContent) then
  begin
    if not IsPortableInstall then
    begin
      if IsWin64 then
        RegDeleteValue(HKCU64, 'Software\VCMI', 'userDataPath');
      RegDeleteValue(HKCU32, 'Software\VCMI', 'userDataPath');
    end;
  end
  else
  begin
    Log('Failed to write user data path to ' + ConfigFile);
    if IsPortableInstall
      or (CompareText(GlobalUserName, GetUserNameString) <> 0) then
      RaiseException(Format(ExpandConstant('{cm:DirectoryConfigWriteError}'), [ConfigFile]))
    else if IsWin64 then
    begin
      if not RegWriteStringValue(HKCU64, 'Software\VCMI', 'userDataPath', SelectedDataDir) then
        RegWriteStringValue(HKCU32, 'Software\VCMI', 'userDataPath', SelectedDataDir);
    end
    else
      RegWriteStringValue(HKCU32, 'Software\VCMI', 'userDataPath', SelectedDataDir);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
    WriteDirectoriesConfig();
end;

procedure RunPreInstallTasks();
begin
  // A wildcard [Files] entry invokes BeforeInstall once per matched file.
  if PreInstallTasksDone then
    Exit;
  PreInstallTasksDone := True;

  // Portable setup must not alter any registered installation.
  if not IsPortableInstall then
    RemoveLegacyInstaller();
  // Copy H3 files when needed
  PerformHeroes3FileCopy();
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
    if IsAdminInstallMode then
    begin
      if IsWin64 then
        RegDeleteKeyIncludingSubkeys(HKLM64, 'Software\VCMI\Installer\{#InstallerArch}');
      RegDeleteKeyIncludingSubkeys(HKLM32, 'Software\VCMI\Installer\{#InstallerArch}');
    end
    else
    begin
      if IsWin64 then
        RegDeleteKeyIncludingSubkeys(HKCU64, 'Software\VCMI\Installer\{#InstallerArch}');
      RegDeleteKeyIncludingSubkeys(HKCU32, 'Software\VCMI\Installer\{#InstallerArch}');
    end;
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
