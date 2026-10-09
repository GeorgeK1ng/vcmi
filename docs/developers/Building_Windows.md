# Building VCMI on Windows

VCMI supports two Windows build environments:

| Build environment | Dependency manager |
| --- | --- |
| [**Visual Studio / MSVC**](#visual-studio-and-conan-recommended) | **Conan 2 — recommended and used by CI** |
| [MSYS2 / MinGW](#msys2-and-mingw-alternative) | MSYS2 packages |

This guide focuses on generating a Visual Studio solution and then building VCMI from the IDE. Command-line builds are also available for automation.

If you only want to install and play VCMI, see the [Windows installation guide](../players/Installation_Windows.md) instead.

## Supported Windows and Visual Studio versions

VCMI supports Visual Studio 2019 and newer, including Visual Studio 2022 and Visual Studio 2026.

For x86 and x64 builds, choose the compiler toolset according to the oldest Windows version that must run the resulting build:

- **Windows 7 SP1, Windows 8, or Windows 8.1:** use **MSVC v142 - VS 2019 C++ x64/x86 build tools** and the Conan option `-o "&:target_pre_windows10=True"`.
- **Windows 10 or Windows 11 only:** the latest MSVC toolset installed with Visual Studio may be used; omit `target_pre_windows10`.
- **Windows ARM64:** use the current ARM64 toolset. ARM64 builds target Windows 10 or newer.

Visual Studio 2019 itself can run on Windows 7 SP1 and Windows 8.1. Newer Visual Studio versions require a newer Windows host, but can install the v142 toolset and use it to produce pre-Windows 10 compatible VCMI builds. VCMI CI uses this approach with Visual Studio 2026.

> [!TIP]
> If you are unsure which configuration to use, follow the x64 Debug examples with v142 and `target_pre_windows10=True`. This is the most compatible local development setup.

## Visual Studio and Conan (recommended)

### 1. Install the required tools

Open **Visual Studio Installer**, select the **Desktop development with C++** workload, and verify these individual components:

- **MSVC compiler and Windows SDK**
- **MSVC v142 - VS 2019 C++ x64/x86 build tools** when targeting Windows 7, 8, or 8.1
- **C++ CMake tools for Windows**
- **Git for Windows**

Visual Studio Installer can install both CMake and Git. Their standalone installers are also supported:

- [Git for Windows](https://git-scm.com/download/win)
- [CMake](https://cmake.org/download/) - enable **Add CMake to the system PATH** during installation.

Also install [Python 3](https://www.python.org/downloads/windows/) and enable **Add Python to PATH** during installation.

Install Conan 2 through Python:

```batchfile
python -m pip install --upgrade conan
```

Open an **elevated Command Prompt** by selecting **Run as administrator**. Use it for the setup and CMake commands in this guide.

Verify the tools before continuing:

```batchfile
git --version
python --version
conan --version
cmake --version
```

> [!IMPORTANT]
> `conan --version` must report Conan 2.x.

### 2. Install a compiler cache (strongly recommended)

A compiler cache considerably reduces rebuild times. For the Visual Studio solution workflow in this guide, install [ccache](https://github.com/ccache/ccache/releases). VCMI's CMake configuration creates the compiler shim required by the Visual Studio generator.

Download and extract `ccache.exe`. Then either:

- place it in a permanent directory and add that directory to the system `PATH`; or
- copy it to `%WinDir%\System32`, which keeps it permanently available on `PATH`.

Open a new Command Prompt and verify the installation:

```batchfile
ccache --version
```

Enable it when generating the Visual Studio solution by passing `-D ENABLE_CCACHE=ON` to CMake.

> [!TIP]
> VCMI also supports [sccache](https://github.com/mozilla/sccache/releases) and uses it in Windows CI with the Ninja generator. Its executable can likewise be added to `PATH` or copied to `%WinDir%\System32`. For the Visual Studio generator documented here, use ccache and do not make sccache available on `PATH`, because VCMI prefers sccache when both are found.

### 3. Clone VCMI

Use a short, writable path containing only ASCII characters. Avoid protected directories such as `C:\Program Files`.

The Conan and CMake commands in this guide **must be run from the VCMI source root**: the directory containing `CMakeLists.txt`, `conanfile.py`, and the `dependencies` submodule. This guide uses `C:\VCMI`.

```batchfile
cd /d C:\
git clone --recursive https://github.com/vcmi/vcmi.git VCMI
cd /d C:\VCMI
```

If VCMI was cloned without submodules, initialize them before continuing:

```batchfile
git submodule update --init --recursive
```

> [!IMPORTANT]
> Before running any later Conan or CMake command, confirm that the prompt is in `C:\VCMI` or your chosen VCMI source root.

### 4. Restore the prebuilt dependencies

Download the dependency archive matching both the VCMI branch/release and target architecture from the [vcmi-dependencies releases page](https://github.com/vcmi/vcmi-dependencies/releases):

- `dependencies-windows-x64.txz` for 64-bit x86 Windows
- `dependencies-windows-x86.txz` for 32-bit x86 Windows
- `dependencies-windows-arm64.txz` for Windows on ARM

Use the pre-release dependency archive for VCMI's current development branch and the corresponding release archive for a released VCMI version.

For example, restore x64 dependencies from the VCMI source root:

```batchfile
cd /d C:\VCMI
conan profile detect
conan cache restore "%USERPROFILE%\Downloads\dependencies-windows-x64.txz"
```

### 5. Generate the Conan toolchain

#### Choosing `compiler.version`

Conan's `compiler.version` is an MSVC binary-compatibility version, not the Visual Studio year or the `v142` toolset number. It is derived from the beginning of the compiler's `19.xx` version number. Common values are:

| Conan `compiler.version` | MSVC compiler version | Visual Studio toolset |
| --- | --- | --- |
| `192` | 19.2x | Visual Studio 2019, v142 |
| `193` | 19.3x | Visual Studio 2022, v143 |
| `194` | 19.4x | Visual Studio 2022 17.10 and newer, v143 |
| `195` | 19.5x | Visual Studio 2026, v145 |

For example, compiler version `19.29` uses Conan value `192`. Conan uses these shortened values to identify compatible binary packages without tying them to a specific compiler patch release. See the official [Conan reference](https://docs.conan.io/2/reference/config_files/settings.html#msvc) and [CMake MSVC version table](https://cmake.org/cmake/help/latest/variable/MSVC_VERSION.html) for the complete mappings.

To find the compiler version detected on your system, run `conan profile detect`, then inspect the generated profile:

```batchfile
conan profile detect
type "%USERPROFILE%\.conan2\profiles\default"
```

Look for these lines:

```text
compiler=msvc
compiler.version=192
```

You can also run `cl` from a Visual Studio Developer Command Prompt and map its displayed `19.xx` version using the table above. The `compiler.version` passed to `conan install` must match the toolset selected when generating the Visual Studio solution.

> [!TIP]
> The VCMI prebuilt x86 and x64 dependencies use `compiler.version=192` and the v142 toolset for compatibility with Windows versions before Windows 10. Keep `192` unless you intentionally want to use a newer compiler and are prepared to build missing dependencies locally.

The examples below generate Debug dependencies in `conan-msvc`. Most developers should use the first command.

#### x64 Debug, compatible with Windows 7 and newer

```batchfile
cd /d C:\VCMI
conan install . ^
  --output-folder=conan-msvc ^
  --build=never ^
  --profile=dependencies\conan_profiles\msvc-x64 ^
  -s "&:compiler.version=192" ^
  -s "&:build_type=Debug" ^
  -o "&:target_pre_windows10=True"
```

#### x86 Debug, compatible with Windows 7 and newer

```batchfile
cd /d C:\VCMI
conan install . ^
  --output-folder=conan-msvc ^
  --build=never ^
  --profile=dependencies\conan_profiles\msvc-x86 ^
  -s "&:compiler.version=192" ^
  -s "&:build_type=Debug" ^
  -o "&:target_pre_windows10=True"
```

#### ARM64 Debug

```batchfile
cd /d C:\VCMI
conan install . ^
  --output-folder=conan-msvc ^
  --build=never ^
  --profile=dependencies\conan_profiles\msvc-arm64 ^
  -s "&:build_type=Debug" ^
  -o "&:lua_lib=lua"
```

> [!TIP]
> To target only Windows 10 and Windows 11 with a newer MSVC toolset, replace `192` with that compiler's Conan version and omit `-o "&:target_pre_windows10=True"`. Check `%USERPROFILE%\.conan2\profiles\default` after `conan profile detect` for the detected compiler version. If no matching prebuilt dependency exists, use `--build=missing`.

If a compatible prebuilt dependency is unavailable, replace `--build=never` with `--build=missing` to build missing packages locally. This is much slower and may require additional tools.

### 6. Generate the Visual Studio solution

Run the command matching the installed Visual Studio version. These examples generate an x64 solution with compiler caching enabled.

#### Visual Studio 2019

```batchfile
cd /d C:\VCMI
cmake -S . -B build -G "Visual Studio 16 2019" -A x64 --toolchain conan-msvc\conan_toolchain.cmake -D ENABLE_CCACHE=ON
```

#### Visual Studio 2022

```batchfile
cd /d C:\VCMI
cmake -S . -B build -G "Visual Studio 17 2022" -A x64 -T v142 --toolchain conan-msvc\conan_toolchain.cmake -D ENABLE_CCACHE=ON
```

#### Visual Studio 2026

```batchfile
cd /d C:\VCMI
cmake -S . -B build -G "Visual Studio 18 2026" -A x64 -T v142 --toolchain conan-msvc\conan_toolchain.cmake -D ENABLE_CCACHE=ON
```

- For x86, replace `-A x64` with `-A Win32`.
- For ARM64, use `-A ARM64`, omit `-T v142`, and use the ARM64 Conan toolchain generated above.
- When targeting only Windows 10 and Windows 11 with the latest compiler, omit `-T v142`.

The generated solution is `build\VCMI.sln`.

### 7. Build in Visual Studio

1. Open `build\VCMI.sln`.
2. Select the **Debug** configuration and the intended platform.
3. In Solution Explorer, build `ALL_BUILD` or an individual target.
4. Find the compiled programs in `build\bin\Debug`.

> [!TIP]
> `RelWithDebInfo` enables optimizations while retaining debug information and is useful for performance-sensitive debugging. Rerun `conan install` with `-s "&:build_type=RelWithDebInfo"`, select **RelWithDebInfo** in Visual Studio, and ensure the Conan build type and Visual Studio configuration match.

#### Optional: build from Command Prompt

For automation or a quick full build, the generated solution can also be built without opening Visual Studio:

```batchfile
cd /d C:\VCMI
cmake --build build --config Debug
```

## Updating an existing checkout

For normal day-to-day updates, keep the Conan cache and existing solution:

```batchfile
cd /d C:\VCMI
git pull
git submodule update --init --recursive
conan install . ^
  --output-folder=conan-msvc ^
  --build=never ^
  --profile=dependencies\conan_profiles\msvc-x64 ^
  -s "&:compiler.version=192" ^
  -s "&:build_type=Debug" ^
  -o "&:target_pre_windows10=True"
cmake -S . -B build -G "Visual Studio 16 2019" -A x64 --toolchain conan-msvc\conan_toolchain.cmake -D ENABLE_CCACHE=ON
```

Reopen `build\VCMI.sln` and continue building in Visual Studio. If dependencies changed, download and restore the matching dependency archive before running `conan install`.

## Run VCMI

VCMI requires data files from an installed copy of Heroes of Might and Magic III. Copy the `Data`, `Maps`, and `Mp3` directories to:

```text
%USERPROFILE%\Documents\My Games\vcmi\
```

Then run `build\bin\Debug\VCMI_launcher.exe`, or the launcher from the matching build configuration.

## Building the Windows installer

The installer is built with Inno Setup 7 after the VCMI Release payload and its
small native helper plugin have been built. Install these prerequisites:

- Inno Setup 7, including the `ISCC.exe` command-line compiler;
- CMake 3.20 or newer and Visual Studio with the MSVC C++ tools;
- a Windows 10 SDK containing the Universal CRT redistributable files.

First build VCMI in the Release configuration. By default, the installer script
expects the complete distributable payload in `bin\Release`. It must include
`VCMI_launcher.exe` and all files which are to be installed.

Build `installerPlugin.dll` for the architecture of the Setup executable:

```batchfile
cd /d C:\VCMI
cmake -S CI\wininstaller\plugins -B CI\wininstaller\plugins\build -A x64
cmake --build CI\wininstaller\plugins\build --config Release --target installerPlugin
```

Use `-A Win32` for an x86 installer. The ARM64 package also uses a Win32 Setup
executable and therefore a Win32 plugin; only its VCMI payload is ARM64. The
plugin is statically linked to the MSVC runtime and implements the modern folder
picker and cloud-storage detection used by Setup.

Run the wrapper from a regular Command Prompt:

```batchfile
CI\wininstaller\build_installer.cmd 1.7.0 local x64 VCMI VCMI-Windows
```

Its positional arguments are:

1. application version;
2. build identifier;
3. payload architecture: `x86`, `x64`, or `arm64`;
4. VCMI payload subdirectory name;
5. output installer name;
6. optional payload directory (defaults to `bin\Release`);
7. optional UCRT redistributable directory;
8. optional directory containing `installerPlugin.dll`.

For example, an ARM64 package with explicit input paths can be built as follows
after compiling a Win32 plugin:

```batchfile
CI\wininstaller\build_installer.cmd 1.7.0 local arm64 VCMI VCMI-Windows-ARM64 C:\VCMI\package C:\SDK\ucrt\DLLs C:\VCMI\CI\wininstaller\plugins\build\bin\Release
```

If argument 7 is omitted, the wrapper selects the newest UCRT directory found
in the installed Windows 10 SDK. The generated executable is written to
`CI\wininstaller\Output`.

The wrapper also downloads the Inno Setup 7.1.0 community language files that
are not shipped with the compiler. They are cached in
`%TEMP%\vcmi-inno-languages-7.1.0`; standard official translations are read
directly from the installed Inno Setup compiler. The files in
`CI\wininstaller\lang` contain only VCMI-specific overrides and custom messages.

### Installer command-line interface

Run the generated installer with `/HELP` or `/?` for the standard Inno Setup
parameters and the localized VCMI-specific additions. `HelpTextNote` appends the
VCMI section to Inno Setup's built-in help; it does not replace that help.

VCMI adds the following Setup parameters. Parameter names are case-insensitive;
quote values that contain spaces.

| Parameter | Accepted value | Behavior |
| --- | --- | --- |
| `/USERDATADIR=<path>` | Directory path | Selects the VCMI user-data root. Prefix the value with `expand:` to expand Inno Setup constants, for example `/USERDATADIR="expand:{localappdata}\\VCMI"`. |
| `/ALLOWCLOUDTARGET=1` | `1` | Permits a cloud-synchronized installation or user-data directory during silent Setup. Without it, silent Setup rejects a detected cloud target because it cannot display the interactive confirmation. |
| `/PORTABLE=1` | `1` | Selects Portable installation. The application and `VCMI-data` remain together; Setup creates no uninstaller, registry values, shortcuts, file associations, or firewall rules. |
| `/LAUNCH[=1]` | no value or `1` | Launches VCMI after Setup. This is required to launch it after `/SILENT` or `/VERYSILENT`; interactive Setup instead displays the normal post-install checkbox. |
| `/COPYH3DATA=0\|1` | `0` or `1` | Disables or enables copying automatically detected Heroes III files to the VCMI data directory. The default is `1` when a usable source was found. |

The generated uninstaller additionally accepts `/DELETEUSERDATA=1`. This is a
destructive option: it permanently removes all configured VCMI user directories
and is deliberately honored only together with `/SILENT` or `/VERYSILENT`.

The most relevant standard Inno Setup parameters are `/DIR=<path>`,
`/CURRENTUSER`, `/ALLUSERS`, `/LANG=<id>`, `/TASKS=<list>`,
`/MERGETASKS=<list>`, `/SILENT`, `/VERYSILENT`, `/SUPPRESSMSGBOXES`,
`/NORESTART`, and `/LOG[=<file>]`. `/DIR` selects the application directory and
is also honored by VCMI's combined directory page. Consult `/HELP` for the full
standard parameter list.

Supported `/LANG` IDs are `english`, `belarusian`, `bulgarian`, `czech`,
`chinese`, `tchinese`, `dutch`, `finnish`, `french`, `german`, `greek`,
`hungarian`, `italian`, `japanese`, `korean`, `latvian`, `norwegian`, `polish`,
`portuguese`, `romanian`, `russian`, `serbian`, `spanish`, `swedish`, `turkish`,
`ukrainian`, and `vietnamese`.

#### Task IDs

Use the following stable IDs with `/TASKS` and `/MERGETASKS`:

| Task ID | Installer option | Default | Availability |
| --- | --- | --- | --- |
| `startmenu_launcher` | Start Menu shortcut: VCMI Launcher | Selected | Normal releases; non-portable |
| `startmenu_mapeditor` | Start Menu shortcut: VCMI Map Editor | Selected | Normal releases; non-portable |
| `startmenu_website` | Start Menu shortcut: VCMI Website | Selected | Normal releases; non-portable |
| `startmenu_discord` | Start Menu shortcut: VCMI Discord | Selected | Normal releases; non-portable |
| `desktop_launcher` | Desktop shortcut: VCMI Launcher | Selected | Normal releases; non-portable |
| `desktop_mapeditor` | Desktop shortcut: VCMI Map Editor | Not selected | Normal releases; non-portable |
| `fileassociation_vmap` | VCMI Map (`.vmap`) association | Selected | Normal releases; non-portable |
| `fileassociation_vcmp` | VCMI Campaign (`.vcmp`) association | Selected | Normal releases; non-portable |
| `fileassociation_h3m` | Heroes III Map (`.h3m`) association | Not selected | Normal releases; non-portable |
| `fileassociation_h3c` | Heroes III Campaign (`.h3c`) association | Not selected | Normal releases; non-portable |
| `firewallrules` | Multiplayer firewall rules | Selected | Normal releases; All users only; non-portable |

`/TASKS="id1,id2"` replaces the default selection with the listed tasks.
`/MERGETASKS="id1,!id2"` modifies the defaults: a plain ID selects a task and
an ID prefixed with `!` clears it. Tasks unavailable for the selected build or
installation mode are not performed even if their IDs are supplied.

For example, this installs for all users, disables automatic Heroes III import,
and selects only the two application shortcuts and the firewall rule:

```batchfile
VCMI-Windows.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /ALLUSERS /DIR="C:\Program Files\VCMI" /USERDATADIR="C:\Users\Public\Documents\VCMI" /COPYH3DATA=0 /TASKS="startmenu_launcher,desktop_launcher,firewallrules"
```

This keeps all defaults, adds the Map Editor desktop shortcut, and removes the
Discord shortcut:

```batchfile
VCMI-Windows.exe /SILENT /MERGETASKS="desktop_mapeditor,!startmenu_discord"
```

A minimal unattended portable installation can be invoked as follows:

```batchfile
VCMI-Windows.exe /VERYSILENT /PORTABLE=1 /DIR="D:\Games\VCMI" /COPYH3DATA=0
```

### Installer directory and architecture behavior

The normal user-data default is `Documents\My Games\VCMI`. When Documents is
cloud synchronized, Setup uses `Local AppData\VCMI` instead. A manually selected
cloud directory remains allowed after an explicit warning.

The x64 package uses x64 Setup and an x64 plugin. The x86 and ARM64 packages use
x86 Setup and an x86 plugin. Older x64 packages used x86 Setup; their uninstall
records are therefore searched in both registry views during upgrade and when
protecting directories shared by multiple installed architectures.

Fresh Setup writes the selected user-data directory to
`{app}\config\dirs.json`. Values below
`Software\VCMI\Installer\<architecture>` in the installation's per-user or
machine registry hive provide ownership metadata. During uninstall, the data,
cache, config, logs, and saves paths are
loaded from the runtime configuration and installer metadata, grouped by
directory tree, and offered separately.
Directories used by another installed VCMI architecture cannot be deleted.

### Setup modes and page flow

Interactive fresh Setup offers three modes:

- **All users** installs into Program Files, enables system integration, and
  requires administrative privileges.
- **Current user** installs below the interactive user's Local AppData and does
  not require elevation. Paths are resolved for the user who started Setup even
  when over-the-shoulder elevation uses another administrator account.
- **Portable** keeps the application and `VCMI-data` below one application
  directory. It creates no uninstaller, installer registry metadata, shortcuts,
  file associations, or firewall rules.

The combined directory page selects both the application directory and the
user-data root. If usable Heroes III data were detected and are missing from the
selected user-data root, this page also displays an optional copy checkbox.
The checkbox is recalculated whenever the user-data path changes.

The System Requirements Check is a deliberately informational, nostalgic page.
It is shown for interactive fresh and portable installations, but skipped for
upgrades, `/SILENT`, and `/VERYSILENT`. It reports Windows version and
architecture, processor speed, physical memory, DirectX 11 runtime availability,
internet connectivity, Heroes III data, directory writability/cloud status, and
free disk space. PASS, WARN, FAIL, and INFO on this page never block Next by
themselves; authoritative safety checks run separately as described below.

Upgrades reuse the registered application and user-data directories, leave the
existing `dirs.json` unchanged, and skip the mode, license, directory, task,
requirements, and Ready pages that do not require another decision. Changing an
upgrade's directories requires first uninstalling the previous version.

### Authoritative validation and warnings

Before payload copying, Setup validates the selected directories independently
of the informational requirements table:

- both paths must be non-empty and their nearest existing parents writable;
- a filesystem root cannot be selected;
- normal application and user-data trees cannot overlap;
- portable user data may be below its application directory;
- an application directory cannot overlap a registered x86, x64, or ARM64
  installation;
- selected Heroes III import data must fit on the destination volume;
- import sources containing junctions or other reparse points are rejected.

Cloud classification uses the dynamically loaded Windows Cloud Files API when
available and OneDrive environment/registry locations as a specific fallback.
Selecting a synchronized application or data directory shows a warning but the
user may continue. Unattended Setup cannot answer that warning and therefore
requires `/ALLOWCLOUDTARGET=1` for such a target.

Low processor speed, low memory, missing DirectX 11, no detected internet
connection, and missing Heroes III data are advisory only. Installation remains
possible because data or runtime support may be supplied later and VCMI can be
used offline.

### Installation order and Heroes III import

Setup performs state-changing operations in this order:

1. validate mode, directories, architecture coexistence, and cloud consent;
2. run a detected legacy VCMI uninstaller before writing the new payload;
3. let Inno Setup copy the application and UCRT files when required, install the
   cloud-detection helper, and apply the selected system-integration tasks;
4. on a fresh installation, write a new `{app}\config\dirs.json` directly and
   remove the obsolete global `userDataPath` registry value;
5. optionally copy the detected Heroes III `Data`, `Maps`, and `Mp3` contents;
6. optionally launch VCMI.

Heroes III discovery checks known GOG and original CD registry entries, Ubisoft
Connect, and Steam. Every candidate is validated before it is accepted, so a
stale registry entry does not prevent later candidates from being considered.
Import merges regular directories and files without following junctions or
symbolic links. Invalid destination trees are repaired by copying with overwrite
enabled; already valid Heroes III trees are left untouched. The source
installation is never modified. Copy progress is included
in Setup's progress page; a failure reports that a partial copy may remain and
that retrying is safe.

### Architecture coexistence and registry metadata

The x86, x64, and ARM64 packages have separate AppIds and registry metadata
below `Software\VCMI\Installer\<architecture>`. Installations may coexist only
in non-overlapping application directories. The x86 package is allowed on x64
and ARM64 Windows after an informational native-architecture recommendation.

Per-architecture metadata stores the application path, user-data path, and a
protected cloud root. The installer searches both 32-bit and 64-bit registry
views where legacy packages may have written their uninstall data. File
associations are repaired rather than blindly removed when another architecture
still owns a usable installation.

### Uninstall safety

Interactive uninstall presents each distinct configured user-data tree as an
unchecked option with a description. Silent uninstall preserves all user data
unless `/DELETEUSERDATA=1` is explicitly supplied.

Before deletion, every candidate is normalized and rejected if it is a drive
root, Windows or Program Files tree, user-profile root, Documents, Desktop,
AppData, Downloads, Music, Pictures, Videos, a detected cloud root, the
application directory, or a directory used by another VCMI architecture.
Nested configured paths are collapsed into independent parent trees. Recursive
deletion verifies that every resolved child remains inside its selected root;
junctions and symbolic links are removed as links and are never followed. The
installed cloud helper is unloaded before Inno removes the application files.

### Maintenance checks

Before committing installer changes, run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File CI\wininstaller\validate_installer_languages.ps1
```

Then build all applicable x86, x64, and ARM64 packages with
`build_installer.cmd`. Language validation requires every VCMI custom message to
exist in all installer overlays. A local design-only package may use a minimal
payload, but release validation must use the real packaged VCMI binaries, the
matching architecture plugin, UCRT inputs, and Inno Setup 7.

## Troubleshooting MSVC builds

### Conan cannot find a compatible binary package

Confirm that the restored dependency archive matches the VCMI branch, target architecture, compiler settings, and build type. If no compatible prebuilt package exists, use `--build=missing` instead of `--build=never`.

### CMake cannot find v142

Open Visual Studio Installer, modify the installed Visual Studio version, and add **MSVC v142 - VS 2019 C++ x64/x86 build tools**. Newer Visual Studio installations do not necessarily include v142 by default.

### Compiler cache is not used

Confirm that `ccache --version` works in the same Command Prompt used to configure VCMI. Delete `build`, then rerun CMake with `-D ENABLE_CCACHE=ON`. During configuration, CMake should report that the ccache compiler launcher is enabled.

### Build succeeds, but starting a game fails

Confirm that the original Heroes III `Data`, `Maps`, and `Mp3` directories exist in `%USERPROFILE%\Documents\My Games\vcmi\`.

For additional Conan options and platform details, see [Conan dependencies](Conan.md). For general CMake options, see [CMake options](CMake.md).

## MSYS2 and MinGW (alternative)

Use this setup only if you specifically need a MinGW build. It does not use Conan. Do not mix commands or packages between MSYS2 environments.

1. Install [MSYS2](https://www.msys2.org/).
2. Open **MSYS2 UCRT64** and confirm that `echo $MSYSTEM` prints `UCRT64`.
3. Update MSYS2 with `pacman -Syu`. If requested, close the terminal, reopen **MSYS2 UCRT64**, and run it again.
4. Install the compiler, build tools, and dependencies:

   ```sh
   pacman -S --needed \
     git \
     mingw-w64-ucrt-x86_64-cmake \
     mingw-w64-ucrt-x86_64-gcc \
     mingw-w64-ucrt-x86_64-ninja \
     mingw-w64-ucrt-x86_64-ccache \
     mingw-w64-ucrt-x86_64-boost \
     mingw-w64-ucrt-x86_64-zlib \
     mingw-w64-ucrt-x86_64-minizip \
     mingw-w64-ucrt-x86_64-ffmpeg \
     mingw-w64-ucrt-x86_64-SDL2 \
     mingw-w64-ucrt-x86_64-SDL2_image \
     mingw-w64-ucrt-x86_64-SDL2_mixer \
     mingw-w64-ucrt-x86_64-SDL2_ttf \
     mingw-w64-ucrt-x86_64-qt5-static \
     mingw-w64-ucrt-x86_64-tbb \
     mingw-w64-ucrt-x86_64-luajit \
     mingw-w64-ucrt-x86_64-xz \
     mingw-w64-ucrt-x86_64-sqlite3 \
     mingw-w64-ucrt-x86_64-libsquish \
     mingw-w64-ucrt-x86_64-fmt \
     mingw-w64-ucrt-x86_64-libiconv \
     mingw-w64-ucrt-x86_64-onnx \
     mingw-w64-ucrt-x86_64-onnxruntime
   ```

5. Clone and build VCMI from the UCRT64 shell:

   ```sh
   cd /c
   git clone --recursive https://github.com/vcmi/vcmi.git VCMI
   cd VCMI
   cmake --preset windows-mingw-release
   cmake --build --preset windows-mingw-release
   ```

> [!TIP]
> The installed MSYS2 ccache package can be enabled by adding `-D ENABLE_CCACHE=ON` to the configure command.

## Legacy vcpkg builds

VCMI switched from vcpkg to Conan in version 1.7. The old vcpkg integration is unsupported. Use Conan for Visual Studio builds or MSYS2 packages for MinGW builds.
