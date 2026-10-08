; ============================================================================
; VCMI Installer – Adding a New Translation
; ============================================================================
;
; 1. Download the base ISL file for your language:
;    - Get the appropriate .isl file from the official Inno Setup repository:
;      https://github.com/jrsoftware/issrc/tree/main/Files/Languages
;
; 2. Add VCMI custom messages:
;    - Open the downloaded .isl file and insert all VCMI-specific messages.
;    - Use English.isl (VCMI version) as a reference.
;    - Ensure translations keep placeholders (%1, %2, etc.) intact and match
;      the format of the English version exactly.
;
; 3. Update/translate the following modified messages:
;    These differ from the default Inno Setup language files and are required
;    for VCMI's custom installer functionality.
;
;    ------------------------------------------------------------------------
;    WindowsVersionNotSupported
;    ------------------------------------------------------------------------
;    Why: VCMI adds a more descriptive message for unsupported Windows versions.
;    Original:
;      WindowsVersionNotSupported=This program does not support the version of Windows your computer is running.
;    VCMI version:
;      WindowsVersionNotSupported=This program cannot run on your version of Windows. Please ensure you are using the correct Windows version.
;
;    ------------------------------------------------------------------------
;    PrivilegesRequiredOverride* messages
;    ------------------------------------------------------------------------
;    Why: VCMI customizes privilege escalation messages to clarify installation
;         for all users vs. current user and highlight administrative rights.
;    Messages to add/update:
;      PrivilegesRequiredOverrideTitle
;      PrivilegesRequiredOverrideInstruction
;      PrivilegesRequiredOverrideText1
;      PrivilegesRequiredOverrideText2
;      PrivilegesRequiredOverrideAllUsers
;      PrivilegesRequiredOverrideAllUsersRecommended
;      PrivilegesRequiredOverrideCurrentUser
;      PrivilegesRequiredOverrideCurrentUserRecommended
;
;    Example (VCMI English):
;      PrivilegesRequiredOverrideTitle=Administrator Privileges Required
;      PrivilegesRequiredOverrideInstruction=Choose how to run the installer
;      PrivilegesRequiredOverrideText1=%1 requires administrative rights to install for all users. You can also install just for your account (no administrative rights required) or for all users (administrator rights required).
;      PrivilegesRequiredOverrideText2=%1 can be installed only for your account (no administrative rights required) or for all users (administrator rights required).
;      PrivilegesRequiredOverrideAllUsers=Run as &Administrator (install for all users)
;      PrivilegesRequiredOverrideAllUsersRecommended=Run as &Administrator (recommended)
;      PrivilegesRequiredOverrideCurrentUser=Run as &Standard User (install for me only)
;      PrivilegesRequiredOverrideCurrentUserRecommended=Run as &Standard User (recommended)
;
;    ------------------------------------------------------------------------
;    ConfirmUninstall
;    ------------------------------------------------------------------------
;    Why: VCMI uses a custom uninstall wizard. The message must reflect this.
;    Original:
;      ConfirmUninstall=Are you sure you want to completely remove %1 and all of its components?
;    VCMI version:
;      ConfirmUninstall=Are you sure you want to run the %1 uninstall wizard?
;
;    ------------------------------------------------------------------------
;    Directory selection and cloud-storage messages
;    ------------------------------------------------------------------------
;    These entries are required in every language file. Keep %n%n in the
;    warning messages; Inno Setup expands it to a blank line.
;      InstallFolderTitle
;      DataFolderTitle
;      CloudDataWarning
;      CloudDataNotice
;      CloudInstallWarning
;      CloudInstallNotice
;      SharedUserDataNotice
;
;    CloudDataWarning and CloudInstallWarning are confirmation dialogs.
;    CloudDataNotice and CloudInstallNotice are displayed below the matching
;    directory editor. SharedUserDataNotice explains why uninstall cannot
;    delete a directory which is still used by another VCMI architecture.
;
; 4. Add the new language to the installer:
;    - In the [Languages] section of the script, register your translation:
;      Name: "YourLanguage"; MessagesFile: "{#LangPath}\YourLanguage.isl"
;
; 5. Verify consistency:
;    - Check all custom messages against the English VCMI ISL file.
;    - Test the installer to confirm all messages appear correctly.


; ============================================================================
; Installer plugin and directory handling
; ============================================================================
;
; CI/wininstaller/plugins builds installerPlugin.dll for the bitness of Setup.
; The installer is compiled by Inno Setup 7 and requires Windows 7 SP1 or newer.
; The DLL exports:
;   ModerFolderPicker  - Unicode IFileDialog folder picker for Windows 7+
;   IsCloudStoragePath - OneDrive environment check plus the dynamically
;                        loaded Windows Cloud Files API
;
; The x64 package uses an x64 Setup and plugin. The x86 and ARM64 packages use
; an x86 Setup and plugin because Inno Setup has no ARM64 SetupArchitecture;
; the application payload in the ARM64 package remains native ARM64.
; Older x64 packages used an x86 Setup process. Their architecture-specific
; Inno uninstall records are searched in both 32-bit and 64-bit registry views
; so they can be upgraded and protected during another architecture's uninstall.
;
; Documents\My Games\VCMI is the normal user-data default. If Documents is
; cloud synchronized, Local AppData\VCMI is used instead. A manually selected
; cloud installation or user-data directory remains allowed after an explicit
; warning and is marked on the directory page.
;
; The selected user-data path is stored in {app}\config\dirs.json. Registry
; values under HKCU\Software\VCMI\Installer\<architecture> store per-installer
; fallback metadata. The global HKCU\Software\VCMI\userDataPath value is only
; the runtime fallback used when dirs.json cannot be written.
;
; During uninstall, all five managed paths (data, cache, config, logs, saves)
; are resolved from dirs.json and registry fallbacks. Paths below the same
; selected root are collapsed into one item; paths in different trees are
; presented as separate checkboxes. Deletion is disabled for any path also
; used by another installed VCMI architecture.


; Manual preprocessor definitions are provided using ISCC.exe parameters.
; build_installer.cmd supplies all values in CI. InstallerArch is the payload
; architecture (x86, x64, or arm64); SetupArch is limited to x86 or x64.

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
UninstallDisplayIcon={app}\VCMI_launcher.exe
OutputBaseFilename={#InstallerName}
PrivilegesRequiredOverridesAllowed=commandline dialog
ShowLanguageDialog=yes
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

; Version informations
MinVersion=6.1sp1
VersionInfoCompany={#VCMITeam}
VersionInfoDescription={#VCMIDisplayName} {#AppVersion} Setup (Build {#AppBuild})
VersionInfoProductName={#VCMIDisplayName}
VersionInfoCopyright={#VCMICopyright}
VersionInfoVersion={#AppVersion}
VersionInfoOriginalFileName={#InstallerName}.exe


[Languages]
Name: "english"; MessagesFile: "{#LangPath}\English.isl"
Name: "czech"; MessagesFile: "{#LangPath}\Czech.isl"
Name: "chinese"; MessagesFile: "{#LangPath}\ChineseSimplified.isl"
Name: "finnish"; MessagesFile: "{#LangPath}\Finnish.isl"
Name: "french"; MessagesFile: "{#LangPath}\French.isl"
Name: "german"; MessagesFile: "{#LangPath}\German.isl"
Name: "hungarian"; MessagesFile: "{#LangPath}\Hungarian.isl"
Name: "italian"; MessagesFile: "{#LangPath}\Italian.isl"
Name: "korean"; MessagesFile: "{#LangPath}\Korean.isl"
Name: "polish"; MessagesFile: "{#LangPath}\Polish.isl"
Name: "portuguese"; MessagesFile: "{#LangPath}\BrazilianPortuguese.isl"
Name: "russian"; MessagesFile: "{#LangPath}\Russian.isl"
Name: "spanish"; MessagesFile: "{#LangPath}\Spanish.isl"
Name: "swedish"; MessagesFile: "{#LangPath}\Swedish.isl"
Name: "turkish"; MessagesFile: "{#LangPath}\Turkish.isl"
Name: "ukrainian"; MessagesFile: "{#LangPath}\Ukrainian.isl"
Name: "vietnamese"; MessagesFile: "{#LangPath}\Vietnamese.isl"

[Files]
Source: "{#InstallerPluginPath}\installerPlugin.dll"; Flags: dontcopy noencryption
Source: "{#SourceFilesPath}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pdb,*.lib,*.exp,*.ilk,*.obj,*.tlog,*.log,*.pch,*.idb,*.res,*.tmp,*.bak,*.sdf,*.ipch,*.vc.db,*.iobj,*.ipdb"; BeforeInstall: RunPreInstallTasks
Source: "{#UCRTFilesPath}\{#InstallerArch}\*"; DestDir: "{app}"; Flags: ignoreversion; Check: IsUCRTNeeded

[Icons]
Name: "{group}\{cm:ShortcutLauncher}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_launcher.exe"; Comment: "{cm:ShortcutLauncherComment}{code:GetBranchSuffix}";  Tasks: startmenu
Name: "{group}\{cm:ShortcutMapEditor}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_mapeditor.exe"; Comment: "{cm:ShortcutMapEditorComment}{code:GetBranchSuffix}";  Tasks: startmenu
Name: "{group}\{cm:ShortcutWebPage}"; Filename: "{#VCMIHome}"; Comment: "{cm:ShortcutWebPageComment}";  Tasks: startmenu
Name: "{group}\{cm:ShortcutDiscord}"; Filename: "{#VCMIContact}"; Comment: "{cm:ShortcutDiscordComment}";  Tasks: startmenu

Name: "{code:GetUserDesktopFolder}\{cm:ShortcutLauncher}{code:GetBranchSuffix}"; Filename: "{app}\VCMI_launcher.exe"; Comment: "{cm:ShortcutLauncherComment}{code:GetBranchSuffix}"; Tasks: desktop


[Tasks]
Name: "desktop"; Description: "{cm:CreateDesktopShortcuts}"; GroupDescription: "{cm:SystemIntegration}"; Check: not IsPRInstaller
Name: "startmenu"; Description: "{cm:CreateStartMenuShortcuts}"; GroupDescription: "{cm:SystemIntegration}"; Check: not IsPRInstaller
Name: "fileassociation_h3m"; Description: "{cm:AssociateH3MFiles}"; GroupDescription: "{cm:SystemIntegration}"; Flags: unchecked; Check: not IsPRInstaller
Name: "fileassociation_vcmimap"; Description: "{cm:AssociateVCMIMapFiles}"; GroupDescription: "{cm:SystemIntegration}"; Check: not IsPRInstaller

Name: "firewallrules"; Description: "{cm:AddFirewallRules}"; GroupDescription: "{cm:VCMISettings}"; Check: not IsPRInstaller and IsAdminInstallMode
Name: "h3copyfiles"; Description: "{cm:CopyH3Files}"; GroupDescription: "{cm:VCMISettings}"; Check: not IsPRInstaller and IsHeroes3Installed and IsCopyFilesNeeded

[Registry]
Root: HKCU; Subkey: "Software\{#VCMIFolder}\Installer\{#InstallerArch}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\{#VCMIFolder}\Installer\{#InstallerArch}"; ValueType: string; ValueName: "userDataPath"; ValueData: "{code:GetSelectedDataDir}"; Flags: uninsdeletekey

Root: HKCU; Subkey: "Software\Classes\.vmap"; ValueType: string; ValueName: ""; ValueData: "VCMI.vmap"; Flags: uninsdeletevalue; Tasks: fileassociation_vcmimap
Root: HKCU; Subkey: "Software\Classes\VCMI.vmap"; ValueType: string; ValueName: ""; ValueData: "{cm:VMAPDescription}"; Flags: uninsdeletekey; Tasks: fileassociation_vcmimap
Root: HKCU; Subkey: "Software\Classes\VCMI.vmap\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_vcmimap

Root: HKCU; Subkey: "Software\Classes\.vcmp"; ValueType: string; ValueName: ""; ValueData: "VCMI.vcmp"; Flags: uninsdeletevalue; Tasks: fileassociation_vcmimap
Root: HKCU; Subkey: "Software\Classes\VCMI.vcmp"; ValueType: string; ValueName: ""; ValueData: "{cm:VCMPDescription}"; Flags: uninsdeletekey; Tasks: fileassociation_vcmimap
Root: HKCU; Subkey: "Software\Classes\VCMI.vcmp\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_vcmimap

Root: HKCU; Subkey: "Software\Classes\.h3m"; ValueType: string; ValueName: ""; ValueData: "VCMI.h3m"; Flags: uninsdeletevalue; Tasks: fileassociation_h3m
Root: HKCU; Subkey: "Software\Classes\VCMI.h3m"; ValueType: string; ValueName: ""; ValueData: "{cm:H3MDescription}"; Flags: uninsdeletekey; Tasks: fileassociation_h3m
Root: HKCU; Subkey: "Software\Classes\VCMI.h3m\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\VCMI_mapeditor.exe"" ""%1"""; Tasks: fileassociation_h3m


[Run]
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=vcmi_server dir=in action=allow program=""{app}\vcmi_server.exe"" enable=yes profile=public,private"; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=vcmi_client dir=in action=allow program=""{app}\vcmi_client.exe"" enable=yes profile=public,private"; Flags: runhidden; Tasks: firewallrules; Check: IsAdmin

Filename: "{app}\VCMI_launcher.exe"; Description: "{cm:RunVCMILauncherAfterInstall}"; Flags: nowait postinstall; Check: ShouldRunLauncher


[UninstallRun]
; Kill VCMI processes
Filename: "taskkill.exe"; Parameters: "/F /IM VCMI_client.exe"; Flags: runhidden; RunOnceId: "KillVCMIClient"
Filename: "taskkill.exe"; Parameters: "/F /IM VCMI_server.exe"; Flags: runhidden; RunOnceId: "KillVCMIServer"
Filename: "taskkill.exe"; Parameters: "/F /IM VCMI_launcher.exe"; Flags: runhidden; RunOnceId: "KillVCMILauncher"
Filename: "taskkill.exe"; Parameters: "/F /IM VCMI_mapeditor.exe"; Flags: runhidden; RunOnceId: "KillVCMIMapEditor"

; Remove firewall rules
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=vcmi_server"; Flags: runhidden; Check: IsAdmin; RunOnceId: "RemoveFirewallVCMIServer"
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=vcmi_client"; Flags: runhidden; Check: IsAdmin; RunOnceId: "RemoveFirewallVCMIClient"


[Code]
type
  TUninstallPathArray = array[0..4] of String;
  TUninstallPathProtectionArray = array[0..4] of Boolean;
  TUninstallCheckboxArray = array[0..4] of TNewCheckBox;

var
  InstallModePage: TInputOptionWizardPage;
  FooterLabel: TLabel;
  IsUpgrade: Boolean;
  PreInstallTasksDone: Boolean;
  UninstallPathCount: Integer;
  UninstallPaths: TUninstallPathArray;
  UninstallPathProtected: TUninstallPathProtectionArray;
  DeletePathCheckboxes: TUninstallCheckboxArray;
  Heroes3Path: String;
  GlobalUserName: String;
  GlobalUserDocsFolder: String;
  GlobalUserAppdataFolder: String;
  DefaultDataDir: String;

  VCMIMapsFolder, VCMIDataFolder, VCMIMp3Folder: String;
  Heroes3MapsFolder, Heroes3DataFolder, Heroes3Mp3Folder: String;




  // Our combined page that replaces wpSelectDir
  DirSelectPage: TWizardPage;

  // Left bitmap (clone of the default page’s image)
  DirPageBitmap: TBitmapImage;

  // Controls for INSTALLATION folder (program files)

  LabelInstallInfo1: TNewStaticText;
  LabelInstallInfo2: TNewStaticText;

  LabelInstall: TNewStaticText;
  CloudInstallNotice: TNewStaticText;
  InstallDirEdit: TEdit;
  InstallDirBrowseBtn: TButton;

  // Controls for DATA folder (user data: mods, maps, saves)
  LabelData: TNewStaticText;
  CloudDataNotice: TNewStaticText;
  DataDirEdit: TEdit;
  DataDirBrowseBtn: TButton;

  SelectedDataDir: String;
  ConfirmedCloudInstallDir: String;
  ConfirmedCloudDataDir: String;

  // Visibility behavior toggles (adjust to your liking)
  ShowOurDirPage: Boolean;
  ShowDataPickerOnOurPage: Boolean;


// Standard folder picker
// procedure BrowseDirClick(Sender: TObject);
// var
//   Dir: String;
// begin
//   Dir := '';
//   if BrowseForFolder(SetupMessage(msgSelectDirLabel3), Dir, True) then
//   begin
//     if Sender = InstallDirBrowseBtn then
//       InstallDirEdit.Text := Dir
//     else if Sender = DataDirBrowseBtn then
//       DataDirEdit.Text := Dir;
//   end;
// end;





// Minimal validation; you can tighten as needed
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


function ShouldRunLauncher(): Boolean;
begin
  Result := True;

  if Pos('SILENT', UpperCase(GetCmdTail())) > 0 then
    Result := False;

  if Pos('LAUNCH', UpperCase(GetCmdTail())) > 0 then
    Result := True;
end;


function FolderSize(FolderPath: String): Int64;
var
  FindRec: TFindRec;
begin
  Result := 0;
  if FindFirst(FolderPath + '\*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
          Result := Result + FindRec.SizeLow
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


procedure CopyFolderContents(SourceDir, DestDir: String; Overwrite: Boolean);
var
  FindRec: TFindRec;
  SourceFile, DestFile: String;
begin
  // Ensure the destination directory exists
  if not DirExists(DestDir) then
    if not ForceDirectories(DestDir) then
    begin
      //MsgBox('Failed to create destination directory: ' + DestDir, mbError, MB_OK);
      Exit;
    end;

  // Start file copying
  if FindFirst(SourceDir + '\*.*', FindRec) then
  begin
    try
      repeat
        SourceFile := SourceDir + '\' + FindRec.Name;
        DestFile := DestDir + '\' + FindRec.Name;

        if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
        begin
          if Overwrite or not FileExists(DestFile) then
          begin
            if not FileCopy(SourceFile, DestFile, False) then
              //MsgBox('Failed to copy file: ' + SourceFile + ' to ' + DestFile, mbError, MB_OK);
          end;
        end
        else if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          // Copy subdirectories recursively
          CopyFolderContents(SourceFile, DestFile, Overwrite);
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end
  //else
  //  MsgBox('No files found in directory: ' + SourceDir, mbError, MB_OK);
end;


// A huge workaround to get non-admin profile name on elevated installer as admin
function WTSQuerySessionInformation(hServer: THandle; SessionId: Cardinal; WTSInfoClass: Integer; var pBuffer: DWord; var BytesReturned: DWord): Boolean;
  external 'WTSQuerySessionInformationW@wtsapi32.dll stdcall';

procedure WTSFreeMemory(pMemory: DWord);
  external 'WTSFreeMemory@wtsapi32.dll stdcall';

procedure RtlMoveMemoryAsString(Dest: string; Source: DWord; Len: Integer);
  external 'RtlMoveMemory@kernel32.dll stdcall';

const
  WTS_CURRENT_SERVER_HANDLE = 0;
  WTS_CURRENT_SESSION = -1;
  WTSUserName = 5;

function GetCurrentSessionUserName: string;
var
  Buffer: DWord;
  BytesReturned: DWord;
  QueryResult: Boolean;
begin
  // Initialize Result to an empty string
  Result := '';

  // Query the username for the current session
  QueryResult := WTSQuerySessionInformation(
    WTS_CURRENT_SERVER_HANDLE, WTS_CURRENT_SESSION, WTSUserName, Buffer, BytesReturned);

  if not QueryResult then
  begin
    // Error if the query fails
    Exit;
  end;

  try
    // Set the length of the result string (BytesReturned includes null terminator)
    SetLength(Result, (BytesReturned div 2) - 1); // Divide by 2 for Unicode and exclude null terminator

    // Copy the buffer contents into the result string
    RtlMoveMemoryAsString(Result, Buffer, BytesReturned - 2); // Exclude null terminator
  finally
    // Free the allocated memory
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
  if IsAdmin then
    // Default to Program Files for admins
    Result := GetCommonProgramFilesDir + '\{#VCMIFolder}'
  else
    // Default to User AppData for non-admin users
    Result := GlobalUserAppdataFolder + '\{#VCMIFolder}';
end;


function GetUserFolderPath(Constant: String): String;
var
  FolderPath: String;
  OriginalUserName: String;
  CurrentSessionUserName: String;
begin
  // Retrieve the current username from the session
  CurrentSessionUserName := '\' + GlobalUserName + '\';

  // Retrieve the original username
  OriginalUserName := '\' + GetUserNameString + '\';

  // Expand the specified constant
  FolderPath := ExpandConstant(Constant);

  // Replace the original username with the current session username in the path
  StringChangeEx(FolderPath, OriginalUserName, CurrentSessionUserName, True);

  // Return the modified folder path
  Result := FolderPath;
end;


procedure OnTaskCheck(Sender: TObject);
var
  idx: Integer;
begin
  // Get the index of the currently clicked task
  idx := WizardForm.TasksList.ItemIndex;

  // Check if the clicked task is the "AddFirewallRules" one
  if WizardForm.TasksList.Items[idx] = ExpandConstant('{cm:AddFirewallRules}') then
  begin
    // If it was just unchecked, show the warning
    if not WizardForm.TasksList.Checked[idx] then
    begin
      MsgBox(ExpandConstant('{cm:Warning}') + '!' + #13#10 + #13#10 + ExpandConstant('{cm:InstallForMeOnly1}') + #13#10 + ExpandConstant('{cm:InstallForMeOnly2}'), mbError, MB_OK);
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
      Result := Value;
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


procedure AddUninstallPath(const Path: String);
var
  Index: Integer;
  NormalizedPath: String;
begin
  NormalizedPath := RemoveBackslashUnlessRoot(Path);
  if NormalizedPath = '' then
    Exit;
  for Index := 0 to UninstallPathCount - 1 do
    if IsSameOrChildPath(NormalizedPath, UninstallPaths[Index]) then
      Exit;
  if UninstallPathCount > 4 then
    Exit;

  UninstallPaths[UninstallPathCount] := NormalizedPath;
  UninstallPathProtected[UninstallPathCount] := IsPathUsedByOtherInstallation(NormalizedPath);
  UninstallPathCount := UninstallPathCount + 1;
end;


procedure LoadUninstallPaths(const InstallDir, DataPath: String);
var
  CachePath: String;
begin
  UninstallPathCount := 0;
  CachePath := ReadRuntimePath(InstallDir, 'userCachePath', DataPath + '\cache');
  AddUninstallPath(DataPath);
  AddUninstallPath(CachePath);
  AddUninstallPath(ReadRuntimePath(InstallDir, 'userConfigPath', DataPath + '\config'));
  AddUninstallPath(ReadRuntimePath(InstallDir, 'userLogsPath', DataPath + '\logs'));
  AddUninstallPath(ReadRuntimePath(InstallDir, 'userSavePath', DataPath + '\saves'));
end;


// BOOL __stdcall IsCloudStoragePath(LPCWSTR)
function IsCloudStoragePath(Path: string): BOOL;
  external 'IsCloudStoragePath@files:installerPlugin.dll stdcall setuponly delayload';


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
      if ExpandConstant('{#InstallerArch}') = 'x64' then
        // For 64-bit installer on 64-bit OS, check System32
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


function InitializeSetup(): Boolean;
var
  InstallPath: String;
begin
  // Check if the application is already installed
  IsUpgrade := ReadArchitectureInstallPath('{#InstallerArch}', InstallPath);

  // Initialize the global variable during setup
  GlobalUserName := GetCurrentSessionUserName();
  GlobalUserDocsFolder := GetUserDocsFolder();
  GlobalUserAppdataFolder := GetUserAppdataFolder();

  // Cloud sync clients can temporarily lock files while VCMI is writing them.
  // Prefer Local AppData whenever Documents belongs to OneDrive or another registered provider.
  if IsCloudStoragePath(GlobalUserDocsFolder) then
    DefaultDataDir := GlobalUserAppdataFolder + '\VCMI'
  else
    DefaultDataDir := GlobalUserDocsFolder + '\' + '{#VCMIFilesFolder}';
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

  Result := True;
end;


// Binary size constants as floating-point to force real division
const
  ONE_KIB = 1024.0;
  ONE_MIB = 1024.0 * 1024.0;
  ONE_GIB = 1024.0 * 1024.0 * 1024.0;

// Picks unit (MB/GB) and returns the numeric value for that unit (as Extended)
procedure PickUnit(const Bytes: Int64; var UseGB: Boolean; var Value: Extended);
begin
  if Bytes >= Trunc(ONE_GIB) then
  begin
    UseGB := True;
    Value := Bytes / ONE_GIB;   // GiB, real division
  end
  else
  begin
    UseGB := False;
    Value := Bytes / ONE_MIB;   // MiB, real division
  end;
end;


// Formats localized "At least X MB/GB of free disk space is required."
function BuildDiskSpaceText(const Bytes: Int64): String;
var
  useGB: Boolean;
  val: Extended;
  txt, num: String;
begin
  PickUnit(Bytes, useGB, val);
  num := Format('%.1f', [val]); // one decimal place

  if useGB then
  begin
    // msgDiskSpaceGBLabel expects [gb]
    txt := SetupMessage(msgDiskSpaceGBLabel);
    StringChangeEx(txt, '[gb]', num, True);
  end
  else
  begin
    // msgDiskSpaceMBLabel expects [mb]
    txt := SetupMessage(msgDiskSpaceMBLabel);
    StringChangeEx(txt, '[mb]', num, True);
  end;

  Result := txt;
end;


// BOOL __stdcall ModerFolderPicker(HWND, LPCWSTR, LPCWSTR, LPWSTR, DWORD)
function ModerFolderPicker(Owner: HWND; Title, Initial: string; OutPath: string; OutCch: Cardinal): BOOL;
  external 'ModerFolderPicker@files:installerPlugin.dll stdcall setuponly delayload';

function PickFolderModern(const Title, Initial: string): string;
var
  buf: string;
  ok: BOOL;
  n: Integer;
begin
  // Large buffer (counted in UTF-16 code units)
  SetLength(buf, 32768);
  ok := ModerFolderPicker(WizardForm.Handle, Title, Initial, buf, Length(buf));
  if not ok then Exit;

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
      InstallDirEdit.Text := picked
    else
      DataDirEdit.Text := picked;
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


procedure InitializeWizard();
var
  TitleText, SubTitleText, InfoText: String;
  LeftCol, TopY, EditWidth, ButtonWidth, RowGap: Integer;

  // Disk space line (same wording as the original page)
  DiskSpaceLabel: TNewStaticText;
  RequiredBytes: Int64;

begin
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

    // Option 0
    InstallModePage.Add(ExpandConstant(#13#10 + '  {cm:InstallForAllUsers}' + #13#10 + '   • {cm:InstallForAllUsers1}' + #13#10 + #13#10));
    // Option 1
    InstallModePage.Add(ExpandConstant(#13#10 + '  {cm:InstallForMeOnly}' + #13#10  +  '   • {cm:InstallForMeOnly1}' + #13#10 + '   • {cm:InstallForMeOnly2}' + #13#10));

    if IsAdmin then
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



  // --- Decide visibility policy for this page --------------------------------
  // Replace wpSelectDir entirely:
  // - Hide for upgrades? (example below keeps it visible for full control)
  ShowOurDirPage := True;
  if IsUpgrade then
  begin
    // Example: hide page on upgrade (flip to False if you want to skip)
    // ShowOurDirPage := False;
  end;

  // Example: show/hide the DATA picker per scenario
  ShowDataPickerOnOurPage := True;
  if IsPRInstaller then
  begin
    // For PR builds you might want to hide the data picker:
    // ShowDataPickerOnOurPage := False;
  end;

  // If we don’t want to show our page, just exit (wpSelectDir will still be skipped below)
  if not ShowOurDirPage then
    Exit;

  // --- Create custom page after License --------------------------------------
  //TitleText := ExpandConstant('{cm:SelectSetupInstallModeTitle}'); // SelectDirLabel3

  //SubTitleText := 'Choose where to install VCMI and where to store user data.';  //SelectDirBrowseLabel

  TitleText := SetupMessage(msgWizardSelectDir);  // same title as wpSelectDir
  SubTitleText := SetupMessage(msgSelectDirDesc); // same subtitle as wpSelectDir

  DirSelectPage := CreateCustomPage(
    wpLicense, // show right after License
    TitleText,
    SubTitleText
  );

  // --- Layout metrics ---------------------------------------------------------
  LeftCol     := ScaleX(0); // leave space for the left bitmap
  TopY        := ScaleY(40);
  EditWidth   := DirSelectPage.SurfaceWidth - LeftCol - ScaleX(90);
  ButtonWidth := ScaleX(85);
  RowGap      := ScaleY(12);

  // --- Clone the left bitmap from the default dir page -----------------------
  DirPageBitmap := TBitmapImage.Create(DirSelectPage);
  DirPageBitmap.Parent := DirSelectPage.Surface;
  DirPageBitmap.Left := ScaleX(0);
  DirPageBitmap.Top  := ScaleY(0);
  DirPageBitmap.AutoSize := True;
  // assign the same bitmap used by the original SelectDir page
  DirPageBitmap.Bitmap.Assign(WizardForm.SelectDirBitmapImage.Bitmap);



  // --- INSTALLATION FOLDER CONTROLS (program files) --------------------------

  LabelInstallInfo1 := TNewStaticText.Create(DirSelectPage);
  LabelInstallInfo1.Parent := DirSelectPage.Surface;
  LabelInstallInfo1.Left := 44;
  LabelInstallInfo1.Top  := 9;

  // Make sure this message looks same as SetupMessage(msgSelectDirLabel3) on wpSelectDir
  InfoText := SetupMessage(msgSelectDirLabel3);
  StringChangeEx(InfoText, '[name]', '{#VCMIFolder}', True);

  LabelInstallInfo1.Caption := InfoText;
  LabelInstallInfo1.AutoSize := True;


  LabelInstall := TNewStaticText.Create(DirSelectPage);
  LabelInstall.Parent := DirSelectPage.Surface;
  LabelInstall.Left := LeftCol;
  LabelInstall.Top  := TopY;
  LabelInstall.Caption := ExpandConstant('{cm:InstallFolderTitle}');
  LabelInstall.AutoSize := True;
  //LabelInstall.Font.Style := [fsBold];

  TopY := LabelInstall.Top + LabelInstall.Height + ScaleY(6);

  InstallDirEdit := TEdit.Create(DirSelectPage);
  InstallDirEdit.Parent := DirSelectPage.Surface;
  InstallDirEdit.Left := LeftCol;
  InstallDirEdit.Top  := TopY;
  InstallDirEdit.Width := EditWidth;
  // default like current logic (admin vs non-admin)
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

  // --- DATA FOLDER CONTROLS (user files: mods, maps, saves) ------------------
  LabelData := TNewStaticText.Create(DirSelectPage);
  LabelData.Parent := DirSelectPage.Surface;
  LabelData.Left := LeftCol;
  LabelData.Top  := TopY;
  LabelData.Caption := ExpandConstant('{cm:DataFolderTitle}');
  LabelData.AutoSize := True;
  //LabelData.Font.Style := [fsBold];

  TopY := LabelData.Top + LabelData.Height + ScaleY(6);

  DataDirEdit := TEdit.Create(DirSelectPage);
  DataDirEdit.Parent := DirSelectPage.Surface;
  DataDirEdit.Left := LeftCol;
  DataDirEdit.Top  := TopY;
  DataDirEdit.Width := EditWidth;
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

  // Visibility per scenario
  LabelData.Visible := ShowDataPickerOnOurPage;
  DataDirEdit.Visible := ShowDataPickerOnOurPage;
  DataDirBrowseBtn.Visible := ShowDataPickerOnOurPage;
  CloudDataNotice.Visible := ShowDataPickerOnOurPage and CloudDataNotice.Visible;

  // --- Disk space line (same position as original) ---------------------------
  // Compute required size based on packaged sources; add other sources if needed.
  RequiredBytes := FolderSize(ExpandConstant('{#SourceFilesPath}')) + FolderSize(ExpandConstant('{#UCRTFilesPath}\{#InstallerArch}'));

  //DiskSpaceLabel := TNewStaticText.Create(DirSelectPage);
  //DiskSpaceLabel.Parent := DirSelectPage.Surface;
  //DiskSpaceLabel.Left := 0;  // align with original left margin
  //DiskSpaceLabel.Top := DataDirEdit.Top + DataDirEdit.Height + RowGap;
  //DiskSpaceLabel.AutoSize := True;
  //DiskSpaceLabel.Caption := BuildDiskSpaceText(RequiredBytes);

  DiskSpaceLabel := TNewStaticText.Create(DirSelectPage);
  DiskSpaceLabel.Parent := DirSelectPage.Surface;
  DiskSpaceLabel.AutoSize := True;
  DiskSpaceLabel.Caption := BuildDiskSpaceText(RequiredBytes);
  DiskSpaceLabel.Left := 0; // align with original left margin
  DiskSpaceLabel.Top := DirSelectPage.SurfaceHeight - DiskSpaceLabel.Height - ScaleY(7);
  DiskSpaceLabel.Anchors := [akLeft, akBottom];

    // Attach an OnClick event handler to the tasks list
  WizardForm.TasksList.OnClickCheck := @OnTaskCheck;

    // Enable word wrap for the ReadyMemo
  WizardForm.ReadyMemo.ScrollBars := ssNone; // No scrollbars
  WizardForm.ReadyMemo.WordWrap := True;

  // Create a custom label for the footer message
  FooterLabel := TLabel.Create(WizardForm);
  FooterLabel.Parent := WizardForm;
  FooterLabel.Caption := '{#VCMIDisplayName} v' + '{#AppVersion}' + '.' + '{#AppBuild}';
  // Padding from the left edge
  FooterLabel.Left := 10;
  // Adjust to leave space for multiple lines
  FooterLabel.Top := WizardForm.ClientHeight - 30;
  // Adjust for padding
  FooterLabel.Width := WizardForm.ClientWidth - 20;
  // Adjust height to accommodate multiple lines
  FooterLabel.Height := 40;
end;





function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False; // Default is not to skip the page

  // Don't skip Target page if this is a PR build and upgrade
  if IsPRInstaller and IsUpgrade and (PageID = wpSelectDir) then
  begin
    Result := False;
    Exit;
  end;

  // Skip Tasks page if this is a PR build
  if IsPRInstaller and (PageID = wpSelectTasks) then
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
    if (InstallModePage.SelectedValueIndex = 0) and not IsAdmin then
    begin
      Result := False;
      Exit;
    end;

    if InstallModePage.SelectedValueIndex = 0 then
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
        if MsgBox(ExpandConstant('{cm:CloudInstallWarning}'), mbConfirmation, MB_YESNO) <> IDYES then
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

    // Capture data dir (if visible) or fallback to default
    if ShowDataPickerOnOurPage and DataDirEdit.Visible then
      SelectedDataDir := RemoveBackslashUnlessRoot(Trim(DataDirEdit.Text))
    else
      SelectedDataDir := DefaultDataDir;

    if Trim(SelectedDataDir) = '' then
      SelectedDataDir := DefaultDataDir;

    if IsCloudStoragePath(SelectedDataDir) then
    begin
      CloudDataNotice.Visible := True;
      if CompareText(ConfirmedCloudDataDir, SelectedDataDir) <> 0 then
      begin
        if MsgBox(ExpandConstant('{cm:CloudDataWarning}'), mbConfirmation, MB_YESNO) <> IDYES then
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
begin
  Result := RegQueryStringValue(HKLM, SubKey, 'UninstallString', UninstallerPath);
  if (not Result) or (Trim(UninstallerPath) = '') then
  begin
    UninstallerPath := '';
    Result := False;
  end;

  UninstallerPath := RemoveQuotes(Trim(UninstallerPath));
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

  // 1) Prefer uninstall path from registry (full path)
  if not GetLegacyUninstallerPath(UninstallerPath) then
  begin
    // 2) Fallback: uninstall.exe in current target dir
    UninstallerPath := AppFolder + '\Uninstall.exe';
  end;

  if (UninstallerPath <> '') and FileExists(UninstallerPath) then
  begin
    Exec(UninstallerPath, '/S', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

    // Clean leftovers only if uninstall.exe is in current {app} folder
    if DirExists(AppFolder) and (CompareText(ExtractFileDir(UninstallerPath), AppFolder) = 0) then
      DelTree(AppFolder, True, True, False);
  end;
end;


procedure PerformHeroes3FileCopy();
var
  i: Integer;
begin
  // Loop through all tasks to find the "h3copyfiles" task
  for i := 0 to WizardForm.TasksList.Items.Count - 1 do
  begin
    // Check if the current task is "h3copyfiles"
    if WizardForm.TasksList.Items[i] = ExpandConstant('{cm:CopyH3Files}') then
    begin
      // Check if the "h3copyfiles" task is checked
      if WizardForm.TasksList.Checked[i] then
      begin

        if IsCopyFilesNeeded then
        begin
          // Copy folders if conditions are met
          if (IsFolderValid(Heroes3MapsFolder) and not IsFolderValid(VCMIMapsFolder)) then
            CopyFolderContents(Heroes3MapsFolder, VCMIMapsFolder, True);

          if (IsFolderValid(Heroes3DataFolder) and not IsFolderValid(VCMIDataFolder)) then
            CopyFolderContents(Heroes3DataFolder, VCMIDataFolder, True);

          if (IsFolderValid(Heroes3Mp3Folder) and not IsFolderValid(VCMIMp3Folder)) then
            CopyFolderContents(Heroes3Mp3Folder, VCMIMp3Folder, True);
        end;
      end;
      Exit; // Task found, exit the loop
    end;
  end;
end;


procedure CreateDefaultSettingsFile();
var
  ConfigDir, SettingsFile, Language, JSONContent: String;
begin
  ConfigDir := SelectedDataDir + '\config';
  SettingsFile := ConfigDir + '\settings.json';

  if not FileExists(SettingsFile) then
  begin
    Language := ActiveLanguage;
    if Language = '' then
      Language := 'english';

      JSONContent :=
        '{' + #13#10 +
        Chr(9) + '"general" : {' + #13#10 +
        Chr(9) + Chr(9) + '"language" : "' + Language + '"' + #13#10 +
        Chr(9) + '}' + #13#10 +
        '}';

    if not DirExists(ConfigDir) then
      ForceDirectories(ConfigDir);

    SaveUTF8TextFile(SettingsFile, JSONContent);
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

  if IsWin64 then
  begin
    RegWriteStringValue(HKCU64, InstallerRegistryKey, 'InstallPath', ExpandConstant('{app}'));
    RegWriteStringValue(HKCU64, InstallerRegistryKey, 'userDataPath', SelectedDataDir);
  end;
  RegWriteStringValue(HKCU32, InstallerRegistryKey, 'InstallPath', ExpandConstant('{app}'));
  RegWriteStringValue(HKCU32, InstallerRegistryKey, 'userDataPath', SelectedDataDir);

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
  if SaveUTF8TextFile(ConfigFile, JSONContent) then
  begin
    if IsWin64 then
      RegDeleteValue(HKCU64, 'Software\VCMI', 'userDataPath');
    RegDeleteValue(HKCU32, 'Software\VCMI', 'userDataPath');
  end
  else
  begin
    Log('Failed to write user data path to ' + ConfigFile);
    if IsWin64 then
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

  // Remove Legacy installer when needed
  RemoveLegacyInstaller();
  // Copy H3 files when needed
  PerformHeroes3FileCopy();
  // Create default language JSON - for future use
  // CreateDefaultSettingsFile();
end;


/// Uninstall ///////////////////////////////////////////////////////////////////////////////////////////////////////////////


var
  DeleteUserDataLabel: TLabel;


function DeleteFolderContents(const FolderPath: String): Boolean;
var
  FindResult: TFindRec;
  SubPath: String;
begin
  Result := True;

  if FindFirst(FolderPath + '\*', FindResult) then
  begin
    try
      repeat
        if (FindResult.Name <> '.') and (FindResult.Name <> '..') then
        begin
          SubPath := FolderPath + '\' + FindResult.Name;

          if (FindResult.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
          begin
            if not DeleteFolderContents(SubPath) then
            begin
              Result := False;
              Exit;
            end;
            if not RemoveDir(SubPath) then
            begin
              Result := False;
              Exit;
            end;
          end
          else
          begin
            if not DeleteFile(SubPath) then
            begin
              Result := False;
              Exit;
            end;
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
  FolderPath: String;
begin
  for Index := 0 to UninstallPathCount - 1 do
  begin
    if (DeletePathCheckboxes[Index] <> nil) and DeletePathCheckboxes[Index].Checked
      and not UninstallPathProtected[Index] then
    begin
      FolderPath := UninstallPaths[Index];
      if DirExists(FolderPath) and DeleteFolderContents(FolderPath) then
      begin
        if not RemoveDir(FolderPath) then
          Log('Failed to remove user directory: ' + FolderPath);
      end;
    end;
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
    if IsWin64 then
      RegDeleteKeyIncludingSubkeys(HKCU64, 'Software\VCMI\Installer\{#InstallerArch}');
    RegDeleteKeyIncludingSubkeys(HKCU32, 'Software\VCMI\Installer\{#InstallerArch}');
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
  Index, CheckboxTop: Integer;
begin
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

    DeleteUserDataLabel := TLabel.Create(UninstallProgressForm);
    with DeleteUserDataLabel do
    begin
      Parent := Page;
      Top := ScaleX(20);
      Left := ScaleX(20);
      Width := ScaleX(400);
      Caption := ExpandConstant('{cm:DeleteUserData}');
    end;

    CheckboxTop := DeleteUserDataLabel.Top + ScaleY(24);
    for Index := 0 to UninstallPathCount - 1 do
    begin
      DeletePathCheckboxes[Index] := TNewCheckBox.Create(UninstallProgressForm);
      with DeletePathCheckboxes[Index] do
      begin
        Parent := Page;
        Top := CheckboxTop;
        Left := ScaleX(20);
        Width := ScaleX(400);
        Height := ScaleY(34);
        Checked := False;
        Enabled := not UninstallPathProtected[Index];
        if UninstallPathProtected[Index] then
          Caption := UninstallPaths[Index] + #13#10 + ExpandConstant('{cm:SharedUserDataNotice}')
        else
          Caption := UninstallPaths[Index];
        TabOrder := Index;
      end;
      CheckboxTop := CheckboxTop + ScaleY(38);
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
