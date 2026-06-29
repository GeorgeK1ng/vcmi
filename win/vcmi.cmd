@echo off
setlocal EnableExtensions EnableDelayedExpansion

mode con: cols=130 lines=40 >nul 2>nul

::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: VCMI Windows build helper
:: Windows 7 compatible batch syntax
::::::::::::::::::::::::::::::::::::::::::::::::::::::

set "ROOT=%~dp0"
set "VCMI_DIR=%ROOT%VCMI"
set "DOWNLOADS_DIR=%ROOT%downloads"
set "TOOLS_DIR=%ROOT%tools"
set "LOG_FILE=%ROOT%vcmi-build-helper.log"
set "PORTABLE_GIT_DIR=%TOOLS_DIR%\git"
set "PORTABLE_CMAKE_DIR=%TOOLS_DIR%\cmake"

set "VCMI_REPO=https://github.com/vcmi/vcmi.git"
set "VCMI_BRANCH=develop"

set "BUILD_TYPE=Debug"
set "TARGET_PRE_WINDOWS10=1"
set "TARGET_NAME=Windows 7/8/8.1 compatible"
set "RETURN_MENU=PREREQ_MENU"

set "VS_GENERATOR="
set "DEVENV="
set "VS_SELECTED=0"
set "VS_NAME="
set "VS_YEAR="
set "VS_ROOT="
set "MSVC_CL_EXE="
set "MSVC_FULL_VERSION="
set "MSVC_TOOLS_VERSION="
set "CONAN_COMPILER_VERSION="
set "CMAKE_TOOLSET_SPEC="

set "CONAN_EXE="
set "PYTHON_EXE="
set "GIT_EXE="
set "CMAKE_EXE="

set "VS2019_URL=https://aka.ms/vs/16/release/vs_community.exe"
set "VS2022_URL=https://aka.ms/vs/17/release/vs_community.exe"
set "VS2026_URL=https://aka.ms/vs/18/Stable/vs_community.exe"
set "VS2019_INSTALLER=%DOWNLOADS_DIR%\vs_community_2019.exe"
set "VS2022_INSTALLER=%DOWNLOADS_DIR%\vs_community_2022.exe"
set "VS2026_INSTALLER=%DOWNLOADS_DIR%\vs_community_2026.exe"

set "GIT_STATUS=NOT CHECKED"
set "CMAKE_STATUS=NOT CHECKED"
set "PYTHON_STATUS=NOT CHECKED"
set "CONAN_STATUS=NOT CHECKED"
set "VS_STATUS=NOT CHECKED"
set "TOOLSET_STATUS=NOT CHECKED"
set "TOOLS_MISSING=1"
set "ADMIN_LABEL=No"

set "WIN_MAJOR="
set "WIN_MINOR="
set "WIN_BUILD="
set "WINDOWS_NAME="
set "WINDOWS7=0"
set "OS_ARCH=x86"
set "IS_ADMIN=0"

set "PYTHON_URL="
set "PYTHON_INSTALLER="
set "GIT_URL="
set "GIT_INSTALLER="
set "GIT_PORTABLE_URL="
set "GIT_PORTABLE_INSTALLER="
set "CMAKE_URL="
set "CMAKE_INSTALLER="
set "CMAKE_ZIP_URL="
set "CMAKE_ZIP="

set "DEPENDENCIES_TAG="
set "DEPS_BASE_URL="
set "DEP_FILE="

if not exist "%DOWNLOADS_DIR%" md "%DOWNLOADS_DIR%"
if not exist "%TOOLS_DIR%" md "%TOOLS_DIR%"
>"%LOG_FILE%" echo  [%DATE% %TIME%] VCMI build helper started

call :DETECT_SYSTEM
call :REFRESH_TOOL_STATUS

:MENU
call :REFRESH_TOOL_STATUS
cls
echo  =============================
echo  VCMI build helper
echo  =============================
echo.
echo  System: %WINDOWS_NAME%  Arch: %OS_ARCH%  Admin: %ADMIN_LABEL%
if "%WINDOWS7%"=="1" echo  Mode: Windows 7 compatible downloads selected
echo.
echo  Folders:
echo  Source:    %VCMI_DIR%
echo  Downloads: %DOWNLOADS_DIR%
echo  Tools:     %TOOLS_DIR%
echo  Log:       %LOG_FILE%
echo.
echo  Build settings:
echo  Build type: %BUILD_TYPE%
echo  Target:     %TARGET_NAME%
echo.
echo  Tool status:
echo  Git:           %GIT_STATUS%
echo  CMake:         %CMAKE_STATUS%
echo  Python:        %PYTHON_STATUS%
echo  Conan:         %CONAN_STATUS%
echo  Visual Studio: %VS_STATUS%
echo  Toolset:       %TOOLSET_STATUS%
echo.
if "%TOOLS_MISSING%"=="1" (
    echo  1^) Check tools again
    echo  2^) Install missing tools
    echo  3^) Clone or update VCMI source
    echo  4^) Select Visual Studio
    echo  5^) Select build type
    echo  6^) Select target compatibility
    echo  7^) Generate Visual Studio solution
    echo  8^) Build from command line
    echo  9^) Open existing solution
    echo  H^) Help / recommended flow
    echo  A^) Advanced tools menu
    echo  0^) Exit
) else (
    echo  1^) Check tools again
    echo  2^) Clone or update VCMI source
    echo  3^) Select Visual Studio
    echo  4^) Select build type
    echo  5^) Select target compatibility
    echo  6^) Generate Visual Studio solution
    echo  7^) Build from command line
    echo  8^) Open existing solution
    echo  H^) Help / recommended flow
    echo  A^) Advanced tools menu
    echo  0^) Exit
)
echo.

set "CHOICE="
set /p "CHOICE=Choose option [1]: "
if "%CHOICE%"=="" set "CHOICE=1"

if /I "%CHOICE%"=="H" goto HELP_MENU
if /I "%CHOICE%"=="A" goto PREREQ_MENU
if "%CHOICE%"=="1" call :CHECK_ALL_PREREQ & call :REFRESH_TOOL_STATUS & goto MENU
if "%TOOLS_MISSING%"=="1" (
    if "%CHOICE%"=="2" goto INSTALL_MISSING_TOOLS
    if "%CHOICE%"=="3" goto SOURCE_MENU
    if "%CHOICE%"=="4" goto VS_MENU
    if "%CHOICE%"=="5" goto BUILD_TYPE_MENU
    if "%CHOICE%"=="6" goto TARGET_MENU
    if "%CHOICE%"=="7" goto GENERATE_MENU
    if "%CHOICE%"=="8" goto CMD_BUILD_MENU
    if "%CHOICE%"=="9" goto OPEN_MENU
) else (
    if "%CHOICE%"=="2" goto SOURCE_MENU
    if "%CHOICE%"=="3" goto VS_MENU
    if "%CHOICE%"=="4" goto BUILD_TYPE_MENU
    if "%CHOICE%"=="5" goto TARGET_MENU
    if "%CHOICE%"=="6" goto GENERATE_MENU
    if "%CHOICE%"=="7" goto CMD_BUILD_MENU
    if "%CHOICE%"=="8" goto OPEN_MENU
)
if "%CHOICE%"=="0" exit /b 0

echo  Invalid choice.
pause
goto MENU

:HELP_MENU
cls
echo  =============================
echo  Help / recommended flow
echo  =============================
echo.
echo  1. Check tools and install only those that are missing.
echo  2. Clone or update VCMI source.
echo  3. Select Visual Studio 2019, 2022, or 2026.
echo  4. Keep Debug unless you need Release or RelWithDebInfo.
echo  5. Use Windows 7/8/8.1 compatible target for v142 builds.
echo  6. Generate the solution, then open it or build from command line.
echo.
echo  Windows 7 compatible x86/x64 builds require MSVC v142.
echo  Modern Windows 10+ builds use the default installed toolset.
echo.
pause
goto MENU

::::::::::::::::::::::::::::
:: LOGGING
::::::::::::::::::::::::::::

:LOG
>>"%LOG_FILE%" echo.
>>"%LOG_FILE%" echo  [%DATE% %TIME%] %~1
if not "%~2"=="" set "LOG_COMMAND=%~2"
if defined LOG_COMMAND (
    >>"%LOG_FILE%" echo  Command:
    >>"%LOG_FILE%" echo   !LOG_COMMAND!
    set "LOG_COMMAND="
)
exit /b 0

::::::::::::::::::::::::::::
:: SYSTEM DETECTION
::::::::::::::::::::::::::::

:DETECT_SYSTEM
set "WINDOWS7=0"
set "OS_ARCH=x86"

for /f "tokens=4-6 delims=.[] " %%a in ('ver') do (
    set "WIN_MAJOR=%%a"
    set "WIN_MINOR=%%b"
    set "WIN_BUILD=%%c"
)

set "WINDOWS_NAME=Windows %WIN_MAJOR%.%WIN_MINOR%"
if "%WIN_MAJOR%.%WIN_MINOR%"=="10.0" (
    set "WINDOWS_NAME=Windows 10"
    if defined WIN_BUILD (
        if !WIN_BUILD! GEQ 22000 set "WINDOWS_NAME=Windows 11"
    )
)
if "%WIN_MAJOR%.%WIN_MINOR%"=="6.1" set "WINDOWS7=1"

if exist "%WINDIR%\SysWOW64" (
    set "OS_ARCH=x64"
) else (
    set "OS_ARCH=x86"
)

call :CHECK_ADMIN_RIGHTS
call :SELECT_PYTHON_URL
call :SELECT_GIT_URL
call :SELECT_PORTABLE_GIT_URL
call :SELECT_CMAKE_URL

exit /b 0

:CHECK_ADMIN_RIGHTS
set "IS_ADMIN=0"
net session >nul 2>nul
if "%errorlevel%"=="0" set "IS_ADMIN=1"
exit /b 0

:SELECT_PYTHON_URL
if "%WINDOWS7%"=="1" (
    if "%OS_ARCH%"=="x64" (
        set "PYTHON_URL=https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe"
        set "PYTHON_INSTALLER=%DOWNLOADS_DIR%\python-3.8.10-amd64.exe"
    ) else (
        set "PYTHON_URL=https://www.python.org/ftp/python/3.8.10/python-3.8.10.exe"
        set "PYTHON_INSTALLER=%DOWNLOADS_DIR%\python-3.8.10.exe"
    )
) else (
    if "%OS_ARCH%"=="x64" (
        set "PYTHON_URL=https://www.python.org/ftp/python/3.14.0/python-3.14.0-amd64.exe"
        set "PYTHON_INSTALLER=%DOWNLOADS_DIR%\python-3.14.0-amd64.exe"
    ) else (
        set "PYTHON_URL=https://www.python.org/ftp/python/3.14.0/python-3.14.0.exe"
        set "PYTHON_INSTALLER=%DOWNLOADS_DIR%\python-3.14.0.exe"
    )
)
exit /b 0

:SELECT_GIT_URL
if "%OS_ARCH%"=="x64" (
    if "%WIN_MAJOR%.%WIN_MINOR%"=="6.1" (
        set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-64-bit.exe"
        set "GIT_INSTALLER=%DOWNLOADS_DIR%\Git-2.46.0-64-bit.exe"
        exit /b 0
    )

    if "%WIN_MAJOR%.%WIN_MINOR%"=="6.2" (
        set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-64-bit.exe"
        set "GIT_INSTALLER=%DOWNLOADS_DIR%\Git-2.46.0-64-bit.exe"
        exit /b 0
    )

    set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.54.0.windows.1/Git-2.54.0-64-bit.exe"
    set "GIT_INSTALLER=%DOWNLOADS_DIR%\Git-2.54.0-64-bit.exe"
    exit /b 0
) else (
    if "%WIN_MAJOR%.%WIN_MINOR%"=="6.1" (
        set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-32-bit.exe"
        set "GIT_INSTALLER=%DOWNLOADS_DIR%\Git-2.46.0-32-bit.exe"
        exit /b 0
    )

    if "%WIN_MAJOR%.%WIN_MINOR%"=="6.2" (
        set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-32-bit.exe"
        set "GIT_INSTALLER=%DOWNLOADS_DIR%\Git-2.46.0-32-bit.exe"
        exit /b 0
    )

    set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.48.1.windows.1/Git-2.48.1-32-bit.exe"
    set "GIT_INSTALLER=%DOWNLOADS_DIR%\Git-2.48.1-32-bit.exe"
    exit /b 0
)

:SELECT_PORTABLE_GIT_URL
if "%OS_ARCH%"=="x64" (
    if "%WIN_MAJOR%.%WIN_MINOR%"=="6.1" (
        set "GIT_PORTABLE_URL=https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/PortableGit-2.46.0-64-bit.7z.exe"
        set "GIT_PORTABLE_INSTALLER=%DOWNLOADS_DIR%\PortableGit-2.46.0-64-bit.7z.exe"
        exit /b 0
    )

    if "%WIN_MAJOR%.%WIN_MINOR%"=="6.2" (
        set "GIT_PORTABLE_URL=https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/PortableGit-2.46.0-64-bit.7z.exe"
        set "GIT_PORTABLE_INSTALLER=%DOWNLOADS_DIR%\PortableGit-2.46.0-64-bit.7z.exe"
        exit /b 0
    )

    set "GIT_PORTABLE_URL=https://github.com/git-for-windows/git/releases/download/v2.54.0.windows.1/PortableGit-2.54.0-64-bit.7z.exe"
    set "GIT_PORTABLE_INSTALLER=%DOWNLOADS_DIR%\PortableGit-2.54.0-64-bit.7z.exe"
    exit /b 0
) else (
    if "%WIN_MAJOR%.%WIN_MINOR%"=="6.1" (
        set "GIT_PORTABLE_URL=https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/PortableGit-2.46.0-32-bit.7z.exe"
        set "GIT_PORTABLE_INSTALLER=%DOWNLOADS_DIR%\PortableGit-2.46.0-32-bit.7z.exe"
        exit /b 0
    )

    if "%WIN_MAJOR%.%WIN_MINOR%"=="6.2" (
        set "GIT_PORTABLE_URL=https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/PortableGit-2.46.0-32-bit.7z.exe"
        set "GIT_PORTABLE_INSTALLER=%DOWNLOADS_DIR%\PortableGit-2.46.0-32-bit.7z.exe"
        exit /b 0
    )

    set "GIT_PORTABLE_URL=https://github.com/git-for-windows/git/releases/download/v2.48.1.windows.1/PortableGit-2.48.1-32-bit.7z.exe"
    set "GIT_PORTABLE_INSTALLER=%DOWNLOADS_DIR%\PortableGit-2.48.1-32-bit.7z.exe"
    exit /b 0
)

:SELECT_CMAKE_URL
if "%OS_ARCH%"=="x64" (
    set "CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v3.29.9/cmake-3.29.9-windows-x86_64.msi"
    set "CMAKE_INSTALLER=%DOWNLOADS_DIR%\cmake-3.29.9-windows-x86_64.msi"
    set "CMAKE_ZIP_URL=https://github.com/Kitware/CMake/releases/download/v3.29.9/cmake-3.29.9-windows-x86_64.zip"
    set "CMAKE_ZIP=%DOWNLOADS_DIR%\cmake-3.29.9-windows-x86_64.zip"
) else (
    set "CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v3.29.9/cmake-3.29.9-windows-i386.msi"
    set "CMAKE_INSTALLER=%DOWNLOADS_DIR%\cmake-3.29.9-windows-i386.msi"
    set "CMAKE_ZIP_URL=https://github.com/Kitware/CMake/releases/download/v3.29.9/cmake-3.29.9-windows-i386.zip"
    set "CMAKE_ZIP=%DOWNLOADS_DIR%\cmake-3.29.9-windows-i386.zip"
)
exit /b 0

:REFRESH_TOOL_STATUS
call :DETECT_SYSTEM
set "ADMIN_LABEL=No"
if "%IS_ADMIN%"=="1" set "ADMIN_LABEL=Yes"

set "GIT_STATUS=NOT FOUND"
call :FIND_GIT_QUIET
if not errorlevel 1 set "GIT_STATUS=OK - %GIT_EXE%"

set "CMAKE_STATUS=NOT FOUND"
call :FIND_CMAKE_QUIET
if not errorlevel 1 set "CMAKE_STATUS=OK - %CMAKE_EXE%"

set "PYTHON_STATUS=NOT FOUND"
call :FIND_PYTHON_QUIET
if not errorlevel 1 set "PYTHON_STATUS=OK - %PYTHON_EXE%"

set "CONAN_STATUS=NOT FOUND"
call :FIND_CONAN_QUIET
if not errorlevel 1 set "CONAN_STATUS=OK - %CONAN_EXE%"

set "VS_STATUS=NOT SELECTED"
if "%VS_SELECTED%"=="1" set "VS_STATUS=%VS_YEAR%"
if "%VS_SELECTED%"=="0" (
    call :VS_ANY_EXISTS
    if errorlevel 1 (set "VS_STATUS=NOT FOUND") else (set "VS_STATUS=FOUND - select before generating")
)
set "TOOLSET_STATUS=NOT REQUIRED"
if "%VS_SELECTED%"=="1" (
    call :DETECT_DEFAULT_MSVC_TOOLSET_FOR_SELECTED_VS
    if errorlevel 1 (
        set "TOOLSET_STATUS=MSVC toolset NOT FOUND for VS %VS_YEAR%"
    ) else (
        set "TOOLSET_STATUS=Default MSVC %DEFAULT_MSVC_TOOLS_VERSION%"
    )
)
if "%TARGET_PRE_WINDOWS10%"=="1" (
    if "%VS_SELECTED%"=="1" (
        call :HAS_TOOLSET_V142_FOR_VS %VS_YEAR%
        if errorlevel 1 (
            set "TOOLSET_STATUS=!TOOLSET_STATUS!; v142 NOT FOUND for VS %VS_YEAR%"
        ) else (
            set "TOOLSET_STATUS=!TOOLSET_STATUS!; v142 FOUND for VS %VS_YEAR%"
        )
    ) else (
        set "TOOLSET_STATUS=v142 check needs VS selection"
    )
)
set "TOOLS_MISSING=0"
if "%GIT_STATUS%"=="NOT FOUND" set "TOOLS_MISSING=1"
if "%CMAKE_STATUS%"=="NOT FOUND" set "TOOLS_MISSING=1"
if "%PYTHON_STATUS%"=="NOT FOUND" set "TOOLS_MISSING=1"
if "%CONAN_STATUS%"=="NOT FOUND" set "TOOLS_MISSING=1"
if "%VS_STATUS%"=="NOT FOUND" set "TOOLS_MISSING=1"
if "%TARGET_PRE_WINDOWS10%"=="1" (
    echo(!TOOLSET_STATUS! | findstr /C:"v142 NOT FOUND" >nul 2>nul
    if not errorlevel 1 set "TOOLS_MISSING=1"
)
exit /b 0

:SOURCE_MENU
cls
echo  =============================
echo  VCMI source
echo  =============================
echo.
echo  Source folder:
echo  %VCMI_DIR%
echo.
if exist "%VCMI_DIR%\.git" (
    echo  Status: repository exists
    echo.
    echo  1^) Update VCMI develop branch
    echo  2^) Remove VCMI folder and clone again
) else (
    echo  Status: repository not cloned
    echo.
    echo  1^) Clone VCMI develop branch
)
echo  0^) Back
echo.

set "SCHOICE="
set /p "SCHOICE=Choose option [1]: "
if "%SCHOICE%"=="" set "SCHOICE=1"

if exist "%VCMI_DIR%\.git" (
    if "%SCHOICE%"=="1" goto UPDATE_VCMI
    if "%SCHOICE%"=="2" goto REMOVE_AND_CLONE_VCMI
) else (
    if "%SCHOICE%"=="1" goto CLONE_VCMI
)
if "%SCHOICE%"=="0" goto MENU

echo  Invalid choice.
pause
goto SOURCE_MENU

:BUILD_TYPE_MENU
cls
echo  =============================
echo  Select build type
echo  =============================
echo.
echo  Current: %BUILD_TYPE%
echo.
echo  1^) Debug ^(default^)
echo  2^) Release
echo  3^) RelWithDebInfo
echo  0^) Back
echo.
set "BTCHOICE="
set /p "BTCHOICE=Choose build type [1]: "
if "%BTCHOICE%"=="" set "BTCHOICE=1"
if "%BTCHOICE%"=="1" set "BUILD_TYPE=Debug" & goto MENU
if "%BTCHOICE%"=="2" set "BUILD_TYPE=Release" & goto MENU
if "%BTCHOICE%"=="3" set "BUILD_TYPE=RelWithDebInfo" & goto MENU
if "%BTCHOICE%"=="0" goto MENU
echo  Invalid choice.
pause
goto BUILD_TYPE_MENU

:TARGET_MENU
cls
echo  =============================
echo  Select target compatibility
echo  =============================
echo.
echo  Current: %TARGET_NAME%
echo.
echo  1^) Windows 7 / 8 / 8.1 compatible ^(v142, default^)
echo  2^) Windows 10 / 11 only ^(default Visual Studio toolset^)
echo  0^) Back
echo.
set "TCHOICE="
set /p "TCHOICE=Choose target [1]: "
if "%TCHOICE%"=="" set "TCHOICE=1"
if "%TCHOICE%"=="1" set "TARGET_PRE_WINDOWS10=1" & set "TARGET_NAME=Windows 7/8/8.1 compatible" & call :OFFER_V142_INSTALL_FOR_TARGET & goto MENU
if "%TCHOICE%"=="2" set "TARGET_PRE_WINDOWS10=0" & set "TARGET_NAME=Windows 10/11 only" & goto MENU
if "%TCHOICE%"=="0" goto MENU
echo  Invalid choice.
pause
goto TARGET_MENU

:OFFER_V142_INSTALL_FOR_TARGET
call :REFRESH_TOOL_STATUS
if not "%TARGET_PRE_WINDOWS10%"=="1" exit /b 0
if not "%VS_SELECTED%"=="1" exit /b 0
if "%VS_YEAR%"=="2019" exit /b 0
call :HAS_TOOLSET_V142_FOR_VS %VS_YEAR%
if not errorlevel 1 exit /b 0
echo.
echo  Selected target requires MSVC v142, but it is missing for VS %VS_YEAR%.
echo  Install MSVC v142 x86/x64 toolset now?
set "INSTALL_V142_NOW="
set /p "INSTALL_V142_NOW=Install v142 toolset [Y/N]? "
if /I "%INSTALL_V142_NOW%"=="Y" call :INSTALL_V142_TOOLSET_FOR_SELECTED_VS
exit /b 0

:GENERATE_MENU
call :REFRESH_TOOL_STATUS
cls
echo  =============================
echo  Generate Visual Studio solution
echo  =============================
echo.
echo  Build type: %BUILD_TYPE%
echo  Target:     %TARGET_NAME%
echo  Visual Studio: %VS_STATUS%
echo.
echo  1^) x64   ^(recommended^)
echo  2^) x86
echo  3^) ARM64
echo  4^) All platforms
echo  0^) Back
echo.

set "GCHOICE="
set /p "GCHOICE=Choose platform [1]: "
if "%GCHOICE%"=="" set "GCHOICE=1"

if "%GCHOICE%"=="1" goto BUILD_X64
if "%GCHOICE%"=="2" goto BUILD_X86
if "%GCHOICE%"=="3" goto BUILD_ARM64
if "%GCHOICE%"=="4" goto BUILD_ALL
if "%GCHOICE%"=="0" goto MENU

echo  Invalid choice.
pause
goto GENERATE_MENU

:INSTALL_MISSING_TOOLS
set "RETURN_MENU=INSTALL_MISSING_TOOLS"
call :REFRESH_TOOL_STATUS
cls
echo  =============================
echo  Install missing tools
echo  =============================
echo.
echo  Current status:
echo  Git:    %GIT_STATUS%
echo  Python: %PYTHON_STATUS%
echo  Conan:  %CONAN_STATUS%
echo  CMake:  %CMAKE_STATUS%
echo  Visual Studio: %VS_STATUS%
echo.
echo  1^) Install Git / Portable Git
echo  2^) Install Python
echo  3^) Install Conan via Python pip
echo  4^) Install CMake
echo  5^) Install Visual Studio Community
echo  6^) Check tools again
echo  0^) Back
echo.

set "MICHOICE="
set /p "MICHOICE=Choose option [6]: "
if "%MICHOICE%"=="" set "MICHOICE=6"

if "%MICHOICE%"=="1" goto INSTALL_GIT
if "%MICHOICE%"=="2" goto INSTALL_PYTHON
if "%MICHOICE%"=="3" goto INSTALL_CONAN
if "%MICHOICE%"=="4" goto INSTALL_CMAKE
if "%MICHOICE%"=="5" set "RETURN_MENU=INSTALL_MISSING_TOOLS" & goto INSTALL_VISUAL_STUDIO_MENU
if "%MICHOICE%"=="6" call :CHECK_ALL_PREREQ & goto INSTALL_MISSING_TOOLS
if "%MICHOICE%"=="0" goto MENU

echo  Invalid choice.
pause
goto INSTALL_MISSING_TOOLS

:INSTALL_VISUAL_STUDIO_MENU
cls
echo  =============================
echo  Install Visual Studio Community
echo  =============================
echo.
echo  This installer requires admin rights.
echo  Portable Visual Studio / Build Tools installation is not supported here; use the Microsoft installer.
echo.
echo  1^) Visual Studio 2019 Community ^(Windows 7 / 8 / 8.1 compatible host^)
echo  2^) Visual Studio 2022 Community ^(Windows 10 / 11^)
echo  3^) Visual Studio 2026 Community ^(Windows 10 / 11^)
echo  0^) Back
echo.
set "VSINSTALLCHOICE="
set /p "VSINSTALLCHOICE=Choose Visual Studio installer: "
if "%VSINSTALLCHOICE%"=="1" call :INSTALL_VISUAL_STUDIO 2019 "%VS2019_URL%" "%VS2019_INSTALLER%" & goto %RETURN_MENU%
if "%VSINSTALLCHOICE%"=="2" call :INSTALL_VISUAL_STUDIO 2022 "%VS2022_URL%" "%VS2022_INSTALLER%" & goto %RETURN_MENU%
if "%VSINSTALLCHOICE%"=="3" call :INSTALL_VISUAL_STUDIO 2026 "%VS2026_URL%" "%VS2026_INSTALLER%" & goto %RETURN_MENU%
if "%VSINSTALLCHOICE%"=="0" goto %RETURN_MENU%
echo  Invalid choice.
pause
goto INSTALL_VISUAL_STUDIO_MENU

:INSTALL_VISUAL_STUDIO
set "VS_INSTALL_YEAR=%~1"
set "VS_INSTALL_URL=%~2"
set "VS_INSTALLER=%~3"
echo.
echo  Visual Studio %VS_INSTALL_YEAR% Community installer requires admin rights.
echo  Downloading bootstrapper:
echo  %VS_INSTALL_URL%
echo.
if "%IS_ADMIN%"=="0" (
    echo  WARNING: Current shell is not elevated. The installer may prompt for admin credentials or fail.
    echo.
)
call :DOWNLOAD_FILE "%VS_INSTALL_URL%" "%VS_INSTALLER%"
if errorlevel 1 exit /b 1
set "VS_INSTALL_COMPONENTS=--add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended"
if not "%VS_INSTALL_YEAR%"=="2019" set "VS_INSTALL_COMPONENTS=%VS_INSTALL_COMPONENTS% --add Microsoft.VisualStudio.Component.VC.v142.x86.x64"
if not "%VS_INSTALL_YEAR%"=="2019" echo  Adding MSVC v142 x86/x64 toolset for Windows 7/8 compatibility builds.
set "LOG_COMMAND=%VS_INSTALLER% --passive --wait --norestart %VS_INSTALL_COMPONENTS%"
call :LOG "Installing Visual Studio %VS_INSTALL_YEAR% Community"
"%VS_INSTALLER%" --passive --wait --norestart %VS_INSTALL_COMPONENTS% >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo  ERROR: Visual Studio installer failed. Check log:
    echo  %LOG_FILE%
    pause
    exit /b 1
)
echo  Visual Studio installer finished.
call :CHECK_VISUAL_STUDIOS
pause
exit /b 0

::::::::::::::::::::::::::::
:: PREREQUISITES
::::::::::::::::::::::::::::

:PREREQ_MENU
set "RETURN_MENU=PREREQ_MENU"
cls
echo  =============================
echo  Prerequisites
echo  =============================
echo.
echo  Windows: %WINDOWS_NAME%
echo  OS arch: %OS_ARCH%
echo  Admin: %ADMIN_LABEL%
echo.
echo  Python installer:
echo  %PYTHON_URL%
echo.
echo  Git installer:
echo  %GIT_URL%
echo.
echo  Portable Git:
echo  %GIT_PORTABLE_URL%
echo.
echo  CMake installer:
echo  %CMAKE_URL%
echo.
echo  CMake portable zip:
echo  %CMAKE_ZIP_URL%
echo.
echo  1^) Check Python
echo  2^) Check Conan
echo  3^) Install Conan via Python pip
echo  4^) Download and install Python
echo  5^) Check all
echo  6^) Download and install Git / Portable Git
echo  7^) Download and install CMake
echo  0^) Back
echo.

set "PCHOICE="
set /p "PCHOICE=Choose option [5]: "
if "%PCHOICE%"=="" set "PCHOICE=5"

if "%PCHOICE%"=="1" call :FIND_PYTHON & pause & goto %RETURN_MENU%
if "%PCHOICE%"=="2" call :FIND_CONAN & pause & goto %RETURN_MENU%
if "%PCHOICE%"=="3" goto INSTALL_CONAN
if "%PCHOICE%"=="4" goto INSTALL_PYTHON
if "%PCHOICE%"=="5" call :CHECK_ALL_PREREQ & goto PREREQ_MENU
if "%PCHOICE%"=="6" goto INSTALL_GIT
if "%PCHOICE%"=="7" goto INSTALL_CMAKE
if "%PCHOICE%"=="0" goto MENU

echo  Invalid choice.
pause
goto %RETURN_MENU%

:CHECK_ALL_PREREQ
cls
echo  =============================
echo  Prerequisites check
echo  =============================
echo.

call :DETECT_SYSTEM
set "ADMIN_LABEL=No"
if "%IS_ADMIN%"=="1" set "ADMIN_LABEL=Yes"

echo  Windows: %WINDOWS_NAME%
echo  OS arch: %OS_ARCH%
echo  Admin: %ADMIN_LABEL%
echo  Downloads cache:
echo  %DOWNLOADS_DIR%
echo  Tools:
echo  %TOOLS_DIR%
echo.

call :FIND_GIT
echo.

call :FIND_CMAKE
echo.

call :FIND_PYTHON
echo.

call :FIND_CONAN
echo.

call :CHECK_VISUAL_STUDIOS
echo.

if exist "%VCMI_DIR%\CI\install_conan_dependencies.sh" (
    call :READ_DEPENDENCIES_TAG
    echo.
)

echo  =============================
echo  Check finished.
echo  =============================
pause
exit /b 0

:INSTALL_PYTHON
cls
echo  =============================
echo  Install Python
echo  =============================
echo.
echo  Downloading to cache:
echo  %PYTHON_INSTALLER%
echo.

if not exist "%PYTHON_INSTALLER%" (
    call :DOWNLOAD_FILE "%PYTHON_URL%" "%PYTHON_INSTALLER%"
    if errorlevel 1 (
        echo  ERROR: Python download failed.
        pause
        goto %RETURN_MENU%
    )
) else (
    echo  Python installer already exists:
    echo  %PYTHON_INSTALLER%
)

echo.
echo  Installing Python silently for current user...
echo.

"%PYTHON_INSTALLER%" /quiet InstallAllUsers=0 PrependPath=1 Include_pip=1 Include_launcher=1 Include_test=0

if errorlevel 1 (
    echo  ERROR: Python installation failed.
    pause
    goto %RETURN_MENU%
)

echo.
call :FIND_PYTHON
pause
goto %RETURN_MENU%

:INSTALL_CONAN
cls
echo  =============================
echo  Install Conan
echo  =============================
echo.

call :FIND_PYTHON
if errorlevel 1 (
    echo  ERROR: Python was not found. Install Python first.
    pause
    goto %RETURN_MENU%
)

echo.
echo  Installing Conan using pip...
echo.

set "LOG_COMMAND=%PYTHON_EXE% -m pip install --user conan"
call :LOG "Installing Conan via pip"
"%PYTHON_EXE%" -m pip install --user conan >>"%LOG_FILE%" 2>&1

if errorlevel 1 (
    echo  ERROR: Conan installation failed.
    pause
    goto %RETURN_MENU%
)

echo.
call :FIND_CONAN
pause
goto %RETURN_MENU%

:INSTALL_GIT
call :FIND_GIT
if not errorlevel 1 (
    echo.
    echo  Git is already available.
    pause
    goto %RETURN_MENU%
)

call :CHECK_ADMIN_RIGHTS

if "%IS_ADMIN%"=="0" (
    echo.
    echo  No admin rights detected.
    echo  Installing Portable Git instead.
    pause
    goto INSTALL_PORTABLE_GIT
)

cls
echo  =============================
echo  Install Git for Windows
echo  =============================
echo.
echo  Downloading to cache:
echo  %GIT_INSTALLER%
echo.

if not exist "%GIT_INSTALLER%" (
    call :DOWNLOAD_FILE "%GIT_URL%" "%GIT_INSTALLER%"
    if errorlevel 1 (
        echo  ERROR: Git download failed.
        pause
        goto %RETURN_MENU%
    )
) else (
    echo  Git installer already exists:
    echo  %GIT_INSTALLER%
)

echo.
echo  Installing Git silently...
echo.

set "LOG_COMMAND=%GIT_INSTALLER% /VERYSILENT /NORESTART /SP-"
call :LOG "Installing Git for Windows"
"%GIT_INSTALLER%" /VERYSILENT /NORESTART /SP- >>"%LOG_FILE%" 2>&1

if errorlevel 1 (
    echo  ERROR: Git installation failed.
    pause
    goto %RETURN_MENU%
)

echo.
call :FIND_GIT
pause
goto %RETURN_MENU%

:INSTALL_PORTABLE_GIT
cls
echo  =============================
echo  Install Portable Git
echo  =============================
echo.
echo  Downloading to cache:
echo  %GIT_PORTABLE_INSTALLER%
echo.

if not exist "%GIT_PORTABLE_INSTALLER%" (
    call :DOWNLOAD_FILE "%GIT_PORTABLE_URL%" "%GIT_PORTABLE_INSTALLER%"
    if errorlevel 1 (
        echo  ERROR: Portable Git download failed.
        pause
        goto %RETURN_MENU%
    )
) else (
    echo  Portable Git archive already exists:
    echo  %GIT_PORTABLE_INSTALLER%
)

if exist "%PORTABLE_GIT_DIR%" rd /q /s "%PORTABLE_GIT_DIR%"
md "%PORTABLE_GIT_DIR%"

echo.
echo  Extracting Portable Git...
echo.

set "LOG_COMMAND=%GIT_PORTABLE_INSTALLER% -y -o%PORTABLE_GIT_DIR%"
call :LOG "Extracting Portable Git"
"%GIT_PORTABLE_INSTALLER%" -y -o"%PORTABLE_GIT_DIR%" >>"%LOG_FILE%" 2>&1

if errorlevel 1 (
    echo  ERROR: Portable Git extraction failed.
    pause
    goto %RETURN_MENU%
)

echo.
call :FIND_GIT
pause
goto %RETURN_MENU%

:INSTALL_CMAKE
call :FIND_CMAKE
if not errorlevel 1 (
    echo.
    echo  CMake is already available.
    pause
    goto %RETURN_MENU%
)

call :CHECK_ADMIN_RIGHTS

if "%IS_ADMIN%"=="0" (
    echo.
    echo  No admin rights detected.
    echo  Installing Portable CMake instead.
    pause
    goto INSTALL_PORTABLE_CMAKE
)

cls
echo  =============================
echo  Install CMake
echo  =============================
echo.
echo  Windows 7 compatible CMake 3.29.9 installer:
echo  %CMAKE_URL%
echo.
echo  Downloading to cache:
echo  %CMAKE_INSTALLER%
echo.

if not exist "%CMAKE_INSTALLER%" (
    call :DOWNLOAD_FILE "%CMAKE_URL%" "%CMAKE_INSTALLER%"
    if errorlevel 1 (
        echo  ERROR: CMake download failed.
        pause
        goto %RETURN_MENU%
    )
) else (
    echo  CMake installer already exists:
    echo  %CMAKE_INSTALLER%
)

echo.
echo  Installing CMake silently...
echo.

set "LOG_COMMAND=msiexec /i %CMAKE_INSTALLER% /qn /norestart ADD_CMAKE_TO_PATH=System"
call :LOG "Installing CMake"
msiexec /i "%CMAKE_INSTALLER%" /qn /norestart ADD_CMAKE_TO_PATH=System >>"%LOG_FILE%" 2>&1

if errorlevel 1 (
    echo  ERROR: CMake installation failed.
    pause
    goto %RETURN_MENU%
)

echo.
call :FIND_CMAKE
pause
goto %RETURN_MENU%

:INSTALL_PORTABLE_CMAKE
cls
echo  =============================
echo  Install Portable CMake
echo  =============================
echo.
echo  Windows 7 compatible CMake 3.29.9 zip:
echo  %CMAKE_ZIP_URL%
echo.
echo  Downloading to cache:
echo  %CMAKE_ZIP%
echo.

if not exist "%CMAKE_ZIP%" (
    call :DOWNLOAD_FILE "%CMAKE_ZIP_URL%" "%CMAKE_ZIP%"
    if errorlevel 1 (
        echo  ERROR: Portable CMake download failed.
        pause
        goto %RETURN_MENU%
    )
) else (
    echo  Portable CMake archive already exists:
    echo  %CMAKE_ZIP%
)

if exist "%PORTABLE_CMAKE_DIR%" rd /q /s "%PORTABLE_CMAKE_DIR%"
md "%PORTABLE_CMAKE_DIR%"

echo.
echo  Extracting Portable CMake...
echo.

set "CMAKE_UNZIP_PS1=%TEMP%\vcmi-unzip-cmake.ps1"
>"%CMAKE_UNZIP_PS1%" echo  $shell = New-Object -ComObject Shell.Application
>>"%CMAKE_UNZIP_PS1%" echo  $zip = $shell.NameSpace('%CMAKE_ZIP%')
>>"%CMAKE_UNZIP_PS1%" echo  $dst = $shell.NameSpace('%PORTABLE_CMAKE_DIR%')
>>"%CMAKE_UNZIP_PS1%" echo  if ($zip -eq $null -or $dst -eq $null) { exit 1 }
>>"%CMAKE_UNZIP_PS1%" echo  $dst.CopyHere($zip.Items(), 16)
>>"%CMAKE_UNZIP_PS1%" echo  Start-Sleep -Seconds 5

set "LOG_COMMAND=powershell -NoProfile -ExecutionPolicy Bypass -File %CMAKE_UNZIP_PS1%"
call :LOG "Extracting Portable CMake"
powershell -NoProfile -ExecutionPolicy Bypass -File "%CMAKE_UNZIP_PS1%" >>"%LOG_FILE%" 2>&1
if exist "%CMAKE_UNZIP_PS1%" del /q "%CMAKE_UNZIP_PS1%"

if errorlevel 1 (
    echo  ERROR: Portable CMake extraction failed.
    pause
    goto %RETURN_MENU%
)

echo.
call :FIND_CMAKE
pause
goto %RETURN_MENU%

:FIND_GIT_QUIET
set "GIT_EXE="
where git.exe >nul 2>nul
if not errorlevel 1 (
    for /f "delims=" %%I in ('where git.exe 2^>nul') do (
        set "GIT_EXE=%%I"
        exit /b 0
    )
)
if exist "%PORTABLE_GIT_DIR%\cmd\git.exe" (
    set "GIT_EXE=%PORTABLE_GIT_DIR%\cmd\git.exe"
    exit /b 0
)
if exist "%PORTABLE_GIT_DIR%\bin\git.exe" (
    set "GIT_EXE=%PORTABLE_GIT_DIR%\bin\git.exe"
    exit /b 0
)
exit /b 1

:FIND_CMAKE_QUIET
set "CMAKE_EXE="
where cmake.exe >nul 2>nul
if not errorlevel 1 (
    for /f "delims=" %%I in ('where cmake.exe 2^>nul') do (
        set "CMAKE_EXE=%%I"
        exit /b 0
    )
)
for /d %%D in ("%PORTABLE_CMAKE_DIR%\cmake-*") do (
    if exist "%%D\bin\cmake.exe" (
        set "CMAKE_EXE=%%D\bin\cmake.exe"
        exit /b 0
    )
)
if exist "%PORTABLE_CMAKE_DIR%\bin\cmake.exe" (
    set "CMAKE_EXE=%PORTABLE_CMAKE_DIR%\bin\cmake.exe"
    exit /b 0
)
exit /b 1

:FIND_PYTHON_QUIET
set "PYTHON_EXE="
where python.exe >nul 2>nul
if not errorlevel 1 (
    for /f "delims=" %%I in ('where python.exe 2^>nul') do (
        set "PYTHON_EXE=%%I"
        exit /b 0
    )
)
for /d %%D in ("%LOCALAPPDATA%\Python\pythoncore-*") do (
    if exist "%%D\python.exe" (
        set "PYTHON_EXE=%%D\python.exe"
        exit /b 0
    )
)
for /d %%D in ("%LOCALAPPDATA%\Programs\Python\Python*") do (
    if exist "%%D\python.exe" (
        set "PYTHON_EXE=%%D\python.exe"
        exit /b 0
    )
)
for /d %%D in ("C:\Python*") do (
    if exist "%%D\python.exe" (
        set "PYTHON_EXE=%%D\python.exe"
        exit /b 0
    )
)
exit /b 1

:FIND_CONAN_QUIET
set "CONAN_EXE="
where conan.exe >nul 2>nul
if not errorlevel 1 (
    for /f "delims=" %%I in ('where conan.exe 2^>nul') do (
        set "CONAN_EXE=%%I"
        exit /b 0
    )
)
for /d %%D in ("%LOCALAPPDATA%\Python\pythoncore-*") do (
    if exist "%%D\Scripts\conan.exe" (
        set "CONAN_EXE=%%D\Scripts\conan.exe"
        exit /b 0
    )
)
for /d %%D in ("%LOCALAPPDATA%\Programs\Python\Python*") do (
    if exist "%%D\Scripts\conan.exe" (
        set "CONAN_EXE=%%D\Scripts\conan.exe"
        exit /b 0
    )
)
for /d %%D in ("%APPDATA%\Python\Python*") do (
    if exist "%%D\Scripts\conan.exe" (
        set "CONAN_EXE=%%D\Scripts\conan.exe"
        exit /b 0
    )
)
for /d %%D in ("C:\Python*") do (
    if exist "%%D\Scripts\conan.exe" (
        set "CONAN_EXE=%%D\Scripts\conan.exe"
        exit /b 0
    )
)
exit /b 1

::::::::::::::::::::::::::::
:: TOOL DETECTION
::::::::::::::::::::::::::::

:CHECK_REQUIRED_TOOLS
call :FIND_GIT
if errorlevel 1 exit /b 1

call :FIND_CMAKE
if errorlevel 1 exit /b 1

call :FIND_CONAN
if errorlevel 1 exit /b 1

call :ENSURE_VISUAL_STUDIO_SELECTED
if errorlevel 1 exit /b 1


exit /b 0

:FIND_GIT
set "GIT_EXE="

where git.exe >nul 2>nul
if not errorlevel 1 (
    for /f "delims=" %%I in ('where git.exe 2^>nul') do (
        set "GIT_EXE=%%I"
        goto GIT_FOUND
    )
)

if exist "%PORTABLE_GIT_DIR%\cmd\git.exe" (
    set "GIT_EXE=%PORTABLE_GIT_DIR%\cmd\git.exe"
    goto GIT_FOUND
)

if exist "%PORTABLE_GIT_DIR%\bin\git.exe" (
    set "GIT_EXE=%PORTABLE_GIT_DIR%\bin\git.exe"
    goto GIT_FOUND
)

echo  Git: NOT FOUND
exit /b 1

:GIT_FOUND
echo  Git: %GIT_EXE%
"%GIT_EXE%" --version
exit /b 0

:FIND_CMAKE
set "CMAKE_EXE="
call :FIND_CMAKE_QUIET
if errorlevel 1 (
    echo  CMake: NOT FOUND
    exit /b 1
)

echo  CMake: %CMAKE_EXE%
"%CMAKE_EXE%" --version
exit /b 0

:FIND_PYTHON
set "PYTHON_EXE="

where python.exe >nul 2>nul
if not errorlevel 1 (
    for /f "delims=" %%I in ('where python.exe 2^>nul') do (
        set "PYTHON_EXE=%%I"
        goto PYTHON_FOUND
    )
)

for /d %%D in ("%LOCALAPPDATA%\Python\pythoncore-*") do (
    if exist "%%D\python.exe" (
        set "PYTHON_EXE=%%D\python.exe"
        goto PYTHON_FOUND
    )
)

for /d %%D in ("%LOCALAPPDATA%\Programs\Python\Python*") do (
    if exist "%%D\python.exe" (
        set "PYTHON_EXE=%%D\python.exe"
        goto PYTHON_FOUND
    )
)

for /d %%D in ("C:\Python*") do (
    if exist "%%D\python.exe" (
        set "PYTHON_EXE=%%D\python.exe"
        goto PYTHON_FOUND
    )
)

echo  Python: NOT FOUND
exit /b 1

:PYTHON_FOUND
echo  Python: %PYTHON_EXE%
"%PYTHON_EXE%" --version
exit /b 0

:FIND_CONAN
set "CONAN_EXE="

where conan.exe >nul 2>nul
if not errorlevel 1 (
    for /f "delims=" %%I in ('where conan.exe 2^>nul') do (
        set "CONAN_EXE=%%I"
        goto CONAN_FOUND
    )
)

for /d %%D in ("%LOCALAPPDATA%\Python\pythoncore-*") do (
    if exist "%%D\Scripts\conan.exe" (
        set "CONAN_EXE=%%D\Scripts\conan.exe"
        goto CONAN_FOUND
    )
)

for /d %%D in ("%LOCALAPPDATA%\Programs\Python\Python*") do (
    if exist "%%D\Scripts\conan.exe" (
        set "CONAN_EXE=%%D\Scripts\conan.exe"
        goto CONAN_FOUND
    )
)

for /d %%D in ("%APPDATA%\Python\Python*") do (
    if exist "%%D\Scripts\conan.exe" (
        set "CONAN_EXE=%%D\Scripts\conan.exe"
        goto CONAN_FOUND
    )
)

for /d %%D in ("C:\Python*") do (
    if exist "%%D\Scripts\conan.exe" (
        set "CONAN_EXE=%%D\Scripts\conan.exe"
        goto CONAN_FOUND
    )
)

echo  Conan: NOT FOUND
exit /b 1

:CONAN_FOUND
echo  Conan: %CONAN_EXE%
"%CONAN_EXE%" --version
exit /b 0

:HAS_TOOLSET_V142_FOR_VS
set "TOOLSET_VS_YEAR=%~1"
if not defined TOOLSET_VS_YEAR exit /b 1
for %%E in (Community Professional Enterprise BuildTools) do (
    for %%M in (v160 v170 v180) do (
        if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\%TOOLSET_VS_YEAR%\%%E\MSBuild\Microsoft\VC\%%M\Platforms\x64\PlatformToolsets\v142" exit /b 0
        if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\%TOOLSET_VS_YEAR%\%%E\MSBuild\Microsoft\VC\%%M\Platforms\x64\PlatformToolsets\v142" exit /b 0
    )
)
exit /b 1

:HAS_TOOLSET_V142
call :HAS_TOOLSET_V142_FOR_VS 2019
if not errorlevel 1 exit /b 0
call :HAS_TOOLSET_V142_FOR_VS 2022
if not errorlevel 1 exit /b 0
call :HAS_TOOLSET_V142_FOR_VS 2026
if not errorlevel 1 exit /b 0
exit /b 1

:DETECT_DEFAULT_MSVC_TOOLSET_FOR_SELECTED_VS
set "DEFAULT_MSVC_TOOLS_VERSION="
if not defined VS_ROOT exit /b 1
for /d %%D in ("%VS_ROOT%\VC\Tools\MSVC\*") do (
    if /I "%ARCH%"=="ARM64" (
        if exist "%%D\bin\Hostx64\ARM64\cl.exe" set "DEFAULT_MSVC_TOOLS_VERSION=%%~nxD"
    ) else (
        if exist "%%D\bin\Hostx64\x64\cl.exe" set "DEFAULT_MSVC_TOOLS_VERSION=%%~nxD"
    )
)
if not defined DEFAULT_MSVC_TOOLS_VERSION exit /b 1
exit /b 0

:PRINT_V142_FOR_VS
call :HAS_TOOLSET_V142_FOR_VS %~1
if errorlevel 1 (
    echo  v142 toolset: Not found ^(install via Visual Studio Installer; admin rights required^)
) else (
    echo  v142 toolset: Found
)
exit /b 0

:FIND_MSVC_CL_FOR_SELECTED_VS
set "MSVC_CL_EXE="
set "MSVC_TOOLS_VERSION="
if not defined VS_ROOT exit /b 1
if "%TARGET_PRE_WINDOWS10%"=="1" (
    for /d %%D in ("%VS_ROOT%\VC\Tools\MSVC\14.2*") do (
        if /I "%ARCH%"=="ARM64" (
            if exist "%%D\bin\Hostx64\ARM64\cl.exe" (
                set "MSVC_CL_EXE=%%D\bin\Hostx64\ARM64\cl.exe"
                set "MSVC_TOOLS_VERSION=%%~nxD"
            )
        ) else (
            if exist "%%D\bin\Hostx64\x64\cl.exe" (
                set "MSVC_CL_EXE=%%D\bin\Hostx64\x64\cl.exe"
                set "MSVC_TOOLS_VERSION=%%~nxD"
            )
        )
    )
) else (
    for /d %%D in ("%VS_ROOT%\VC\Tools\MSVC\*") do (
        if /I "%ARCH%"=="ARM64" (
            if exist "%%D\bin\Hostx64\ARM64\cl.exe" (
                set "MSVC_CL_EXE=%%D\bin\Hostx64\ARM64\cl.exe"
                set "MSVC_TOOLS_VERSION=%%~nxD"
            )
        ) else (
            if exist "%%D\bin\Hostx64\x64\cl.exe" (
                set "MSVC_CL_EXE=%%D\bin\Hostx64\x64\cl.exe"
                set "MSVC_TOOLS_VERSION=%%~nxD"
            )
        )
    )
)
if not defined MSVC_CL_EXE exit /b 1
exit /b 0

:DETECT_CONAN_COMPILER_VERSION
set "MSVC_FULL_VERSION="
set "MSVC_MAJOR_VERSION="
set "MSVC_MINOR_VERSION="
set "MSVC_TOOLS_VERSION="
set "CONAN_COMPILER_VERSION="
set "CMAKE_TOOLSET_SPEC="
call :FIND_MSVC_CL_FOR_SELECTED_VS
if errorlevel 1 exit /b 1
for /f "tokens=1-12" %%a in ('"%MSVC_CL_EXE%" 2^>^&1') do (
    for %%T in (%%a %%b %%c %%d %%e %%f %%g %%h %%i %%j %%k %%l) do (
        echo  %%T | findstr /R "^19\.[0-9][0-9]" >nul 2>nul
        if not errorlevel 1 set "MSVC_FULL_VERSION=%%T"
    )
)
if not defined MSVC_FULL_VERSION exit /b 1
for /f "tokens=1,2 delims=." %%a in ("%MSVC_FULL_VERSION%") do (
    set "MSVC_MAJOR_VERSION=%%a"
    set "MSVC_MINOR_VERSION=%%b"
    set "CONAN_COMPILER_VERSION=%%a%%b"
)
set "CONAN_COMPILER_VERSION=!CONAN_COMPILER_VERSION:~0,3!"
if "%TARGET_PRE_WINDOWS10%"=="0" (
    :: VS 2022 17.10 and newer use MSVC 19.4x, which maps to Conan compiler.version 194.
    if "%VS_YEAR%"=="2019" set "CONAN_COMPILER_VERSION=192"
    if "%VS_YEAR%"=="2022" (
        set "CONAN_COMPILER_VERSION=193"
        if !MSVC_MINOR_VERSION! GEQ 40 set "CONAN_COMPILER_VERSION=194"
    )
    if "%VS_YEAR%"=="2026" set "CONAN_COMPILER_VERSION=195"
)
call :LOG "Detected MSVC %MSVC_FULL_VERSION% from %MSVC_CL_EXE%; VS=%VS_YEAR%; VCTools=%MSVC_TOOLS_VERSION%; Conan compiler.version=%CONAN_COMPILER_VERSION%"
exit /b 0

:SET_CMAKE_TOOLSET_SPEC
set "CMAKE_TOOLSET_SPEC="
if not defined MSVC_TOOLS_VERSION exit /b 1
if "%TARGET_PRE_WINDOWS10%"=="1" set "CMAKE_TOOLSET_SPEC=v142,version=%MSVC_TOOLS_VERSION%"
if "%TARGET_PRE_WINDOWS10%"=="0" (
    if "%VS_YEAR%"=="2019" set "CMAKE_TOOLSET_SPEC=v142,version=%MSVC_TOOLS_VERSION%"
    if "%VS_YEAR%"=="2022" set "CMAKE_TOOLSET_SPEC=v143,version=%MSVC_TOOLS_VERSION%"
    if "%VS_YEAR%"=="2026" set "CMAKE_TOOLSET_SPEC=v145,version=%MSVC_TOOLS_VERSION%"
)
if not defined CMAKE_TOOLSET_SPEC exit /b 1
exit /b 0

:FIX_CONAN_TOOLCHAIN_TOOLSET
if not defined CMAKE_TOOLSET_SPEC exit /b 0
if not exist "%CONAN_OUTPUT%\conan_toolchain.cmake" exit /b 0
set "LOG_COMMAND=powershell -NoProfile -ExecutionPolicy Bypass -Command patch conan_toolchain.cmake toolset to %CMAKE_TOOLSET_SPEC%"
call :LOG "Patching Conan toolchain generator toolset to %CMAKE_TOOLSET_SPEC%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='%CONAN_OUTPUT%\conan_toolchain.cmake'; $s='%CMAKE_TOOLSET_SPEC%'; $c=Get-Content -Raw $p; $c=$c -replace 'v14[0-9],version=14(\.[0-9]+)+',$s; Set-Content -Path $p -Value $c -NoNewline" >>"%LOG_FILE%" 2>&1
exit /b 0

::::::::::::::::::::::::::::
:: VISUAL STUDIO
::::::::::::::::::::::::::::

:CHECK_VISUAL_STUDIOS
echo  Visual Studio detection:

call :VS_EXISTS_2019
if not errorlevel 1 (
    echo  VS 2019: FOUND
    call :PRINT_V142_FOR_VS 2019
)

call :VS_EXISTS_2022
if not errorlevel 1 (
    echo  VS 2022: FOUND
    call :PRINT_V142_FOR_VS 2022
)

call :VS_EXISTS_2026
if not errorlevel 1 (
    echo  VS 2026: FOUND
    call :PRINT_V142_FOR_VS 2026
)

call :VS_ANY_EXISTS
if errorlevel 1 echo  Visual Studio: NOT FOUND

exit /b 0

:VS_ANY_EXISTS
call :VS_EXISTS_2019
if not errorlevel 1 exit /b 0
call :VS_EXISTS_2022
if not errorlevel 1 exit /b 0
call :VS_EXISTS_2026
if not errorlevel 1 exit /b 0
exit /b 1

:VS_EXISTS_2019
if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\BuildTools\Common7\IDE\devenv.exe" exit /b 0
exit /b 1

:VS_EXISTS_2022
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\devenv.exe" exit /b 0
exit /b 1

:VS_EXISTS_2026
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Community\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Professional\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Enterprise\Common7\IDE\devenv.exe" exit /b 0
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\BuildTools\Common7\IDE\devenv.exe" exit /b 0
exit /b 1

:ENSURE_VISUAL_STUDIO_SELECTED
if "%VS_SELECTED%"=="1" exit /b 0

call :VS_ANY_EXISTS
if errorlevel 1 (
    echo  ERROR: Visual Studio was not found.
    echo  Supported: 2019, 2022, 2026.
    pause
    exit /b 1
)

goto VS_MENU

:VS_MENU
cls
echo  =============================
echo  Select Visual Studio
echo  =============================
echo.
echo  1^) Visual Studio 2019
call :VS_EXISTS_2019
if errorlevel 1 (echo    Not found) else (echo    Found & call :PRINT_V142_FOR_VS 2019)
echo.
echo  2^) Visual Studio 2022
call :VS_EXISTS_2022
if errorlevel 1 (echo    Not found) else (echo    Found & call :PRINT_V142_FOR_VS 2022)
echo.
echo  3^) Visual Studio 2026
call :VS_EXISTS_2026
if errorlevel 1 (echo    Not found) else (echo    Found & call :PRINT_V142_FOR_VS 2026)
echo.
if "%VS_SELECTED%"=="1" (
    if not "%VS_YEAR%"=="2019" (
        call :HAS_TOOLSET_V142_FOR_VS %VS_YEAR%
        if errorlevel 1 echo  T^) Install MSVC v142 toolset for selected VS %VS_YEAR%
    )
)
echo  I^) Install Visual Studio Community
echo  0^) Back
echo.

set "VSCHOICE="
set /p "VSCHOICE=Choose Visual Studio: "

if "%VSCHOICE%"=="1" call :SELECT_VS_2019 & goto MENU
if "%VSCHOICE%"=="2" call :SELECT_VS_2022 & goto MENU
if "%VSCHOICE%"=="3" call :SELECT_VS_2026 & goto MENU
if /I "%VSCHOICE%"=="T" goto INSTALL_V142_TOOLSET_FOR_SELECTED_VS
if /I "%VSCHOICE%"=="I" set "RETURN_MENU=VS_MENU" & goto INSTALL_VISUAL_STUDIO_MENU
if "%VSCHOICE%"=="0" goto MENU

echo  Invalid choice.
pause
goto VS_MENU

:INSTALL_V142_TOOLSET_FOR_SELECTED_VS
if not "%VS_SELECTED%"=="1" (
    echo  Select Visual Studio 2022 or 2026 first.
    pause
    goto VS_MENU
)
if "%VS_YEAR%"=="2019" (
    echo  VS 2019 already uses the v142 generation.
    pause
    goto VS_MENU
)
call :HAS_TOOLSET_V142_FOR_VS %VS_YEAR%
if not errorlevel 1 (
    echo  MSVC v142 toolset is already installed for VS %VS_YEAR%.
    pause
    goto VS_MENU
)
if not defined VS_ROOT (
    echo  ERROR: Selected Visual Studio root was not detected.
    pause
    goto VS_MENU
)
set "VS_TOOLSET_INSTALLER="
set "VS_TOOLSET_URL="
if "%VS_YEAR%"=="2022" set "VS_TOOLSET_URL=%VS2022_URL%" & set "VS_TOOLSET_INSTALLER=%VS2022_INSTALLER%"
if "%VS_YEAR%"=="2026" set "VS_TOOLSET_URL=%VS2026_URL%" & set "VS_TOOLSET_INSTALLER=%VS2026_INSTALLER%"
if not defined VS_TOOLSET_INSTALLER (
    echo  ERROR: v142 toolset installation is supported only for VS 2022 / 2026 here.
    pause
    goto VS_MENU
)
echo.
echo  Installing MSVC v142 x86/x64 toolset into VS %VS_YEAR%:
echo  %VS_ROOT%
echo.
echo  This operation requires admin rights.
if "%IS_ADMIN%"=="0" echo  WARNING: Current shell is not elevated. The installer may prompt for admin credentials or fail.
echo.
call :DOWNLOAD_FILE "%VS_TOOLSET_URL%" "%VS_TOOLSET_INSTALLER%"
if errorlevel 1 goto VS_MENU
set "LOG_COMMAND=%VS_TOOLSET_INSTALLER% modify --installPath %VS_ROOT% --passive --wait --norestart --add Microsoft.VisualStudio.Component.VC.v142.x86.x64"
call :LOG "Installing MSVC v142 toolset for VS %VS_YEAR%"
"%VS_TOOLSET_INSTALLER%" modify --installPath "%VS_ROOT%" --passive --wait --norestart --add Microsoft.VisualStudio.Component.VC.v142.x86.x64 >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo  ERROR: v142 toolset installation failed. Check log:
    echo  %LOG_FILE%
    pause
    goto VS_MENU
)
call :REFRESH_TOOL_STATUS
echo  v142 toolset installation finished.
echo  Toolset: %TOOLSET_STATUS%
pause
goto VS_MENU

:SELECT_VS_2019
call :VS_EXISTS_2019
if errorlevel 1 (
    echo  VS 2019 not found.
    pause
    exit /b 1
)

set "VS_NAME=Visual Studio 2019"
set "VS_YEAR=2019"
set "VS_GENERATOR=Visual Studio 16 2019"
set "VS_SELECTED=1"

if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Community" set "VS_ROOT=%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Community"
if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Professional" set "VS_ROOT=%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Professional"
if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Enterprise" set "VS_ROOT=%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Enterprise"

if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"
if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe"
if exist "%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~2\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\devenv.exe"

call :REFRESH_TOOL_STATUS
echo  Selected: %VS_NAME%
echo  Toolset: %TOOLSET_STATUS%
exit /b 0

:SELECT_VS_2022
call :VS_EXISTS_2022
if errorlevel 1 (
    echo  VS 2022 not found.
    pause
    exit /b 1
)

set "VS_NAME=Visual Studio 2022"
set "VS_YEAR=2022"
set "VS_GENERATOR=Visual Studio 17 2022"
set "VS_SELECTED=1"

if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Community" set "VS_ROOT=%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Community"
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Professional" set "VS_ROOT=%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Professional"
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Enterprise" set "VS_ROOT=%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Enterprise"

if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe"
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe"
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~1\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe"

call :REFRESH_TOOL_STATUS
echo  Selected: %VS_NAME%
echo  Toolset: %TOOLSET_STATUS%
exit /b 0

:SELECT_VS_2026
call :VS_EXISTS_2026
if errorlevel 1 (
    echo  VS 2026 not found.
    pause
    exit /b 1
)

set "VS_NAME=Visual Studio 2026"
set "VS_YEAR=2026"
set "VS_GENERATOR=Visual Studio 18 2026"
set "VS_SELECTED=1"

if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Community" set "VS_ROOT=%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Community"
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Professional" set "VS_ROOT=%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Professional"
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Enterprise" set "VS_ROOT=%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Enterprise"

if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Community\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Community\Common7\IDE\devenv.exe"
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Professional\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Professional\Common7\IDE\devenv.exe"
if exist "%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Enterprise\Common7\IDE\devenv.exe" set "DEVENV=%SystemDrive%\Progra~1\Microsoft Visual Studio\2026\Enterprise\Common7\IDE\devenv.exe"

call :REFRESH_TOOL_STATUS
echo  Selected: %VS_NAME%
echo  Toolset: %TOOLSET_STATUS%
exit /b 0

::::::::::::::::::::::::::::
:: GIT
::::::::::::::::::::::::::::

:CLONE_VCMI
cls
echo  =============================
echo  Clone VCMI develop branch
echo  =============================
echo.

call :FIND_GIT
if errorlevel 1 (
    echo  ERROR: git.exe was not found.
    echo  Use Prerequisites menu to install Git or Portable Git.
    pause
    goto MENU
)

if exist "%VCMI_DIR%\.git" (
    echo  VCMI repository already exists:
    echo  %VCMI_DIR%
    pause
    goto MENU
)

if exist "%VCMI_DIR%" (
    echo  Folder already exists but is not a Git repository:
    echo  %VCMI_DIR%
    pause
    goto MENU
)

cd /d "%ROOT%"

set "LOG_COMMAND=%GIT_EXE% clone --branch %VCMI_BRANCH% --single-branch --recursive %VCMI_REPO% %VCMI_DIR%"
call :LOG "Cloning VCMI"
"%GIT_EXE%" clone --branch %VCMI_BRANCH% --single-branch --recursive %VCMI_REPO% "%VCMI_DIR%" >>"%LOG_FILE%" 2>&1
if errorlevel 1 goto FAILED

pause
goto MENU

:UPDATE_VCMI
cls
echo  =============================
echo  Update VCMI develop branch
echo  =============================
echo.

call :FIND_GIT
if errorlevel 1 (
    echo  ERROR: git.exe was not found.
    pause
    goto MENU
)

cd /d "%VCMI_DIR%" || goto NO_VCMI

set "LOG_COMMAND=%GIT_EXE% checkout %VCMI_BRANCH%"
call :LOG "Updating VCMI checkout"
"%GIT_EXE%" checkout %VCMI_BRANCH% >>"%LOG_FILE%" 2>&1
if errorlevel 1 goto FAILED

set "LOG_COMMAND=%GIT_EXE% pull"
call :LOG "Pulling VCMI checkout"
"%GIT_EXE%" pull >>"%LOG_FILE%" 2>&1
if errorlevel 1 goto FAILED

set "LOG_COMMAND=%GIT_EXE% submodule sync --recursive"
call :LOG "Synchronizing VCMI submodules"
"%GIT_EXE%" submodule sync --recursive >>"%LOG_FILE%" 2>&1
if errorlevel 1 goto FAILED

set "LOG_COMMAND=%GIT_EXE% submodule update --init --recursive"
call :LOG "Updating VCMI submodules"
"%GIT_EXE%" submodule update --init --recursive >>"%LOG_FILE%" 2>&1
if errorlevel 1 goto FAILED

pause
goto MENU

:REMOVE_AND_CLONE_VCMI
cls
echo  =============================
echo  Remove and clone VCMI develop branch
echo  =============================
echo.
echo  This will delete:
echo  %VCMI_DIR%
echo.
set "CONFIRM_REMOVE="
set /p "CONFIRM_REMOVE=Type YES to continue: "
if /I not "%CONFIRM_REMOVE%"=="YES" goto SOURCE_MENU
if exist "%VCMI_DIR%" rd /q /s "%VCMI_DIR%"
goto CLONE_VCMI

:NO_VCMI
echo  ERROR: VCMI folder does not exist:
echo  %VCMI_DIR%
pause
goto MENU

:SELECT_BUILD_DIR
set "SELECTED_BUILD_DIR=%~2"
if "%TARGET_PRE_WINDOWS10%"=="0" set "SELECTED_BUILD_DIR=%~2-win10"
exit /b 0

::::::::::::::::::::::::::::
:: BUILD TARGETS
::::::::::::::::::::::::::::

:BUILD_X64
call :SELECT_BUILD_DIR x64 build-x64
call :GENERATE_ONE x64 "%SELECTED_BUILD_DIR%" dependencies\conan_profiles\msvc-x64 dependencies-windows-x64.txz
goto OPEN_AFTER_BUILD

:BUILD_X86
call :SELECT_BUILD_DIR x86 build-x86
call :GENERATE_ONE Win32 "%SELECTED_BUILD_DIR%" dependencies\conan_profiles\msvc-x86 dependencies-windows-x86.txz
goto OPEN_AFTER_BUILD

:BUILD_ARM64
call :SELECT_BUILD_DIR arm64 build-arm64
call :GENERATE_ONE ARM64 "%SELECTED_BUILD_DIR%" dependencies\conan_profiles\msvc-arm64 dependencies-windows-arm64.txz
goto OPEN_AFTER_BUILD

:BUILD_ALL
call :SELECT_BUILD_DIR x64 build-x64
call :GENERATE_ONE x64 "%SELECTED_BUILD_DIR%" dependencies\conan_profiles\msvc-x64 dependencies-windows-x64.txz
if errorlevel 1 goto FAILED

call :SELECT_BUILD_DIR x86 build-x86
call :GENERATE_ONE Win32 "%SELECTED_BUILD_DIR%" dependencies\conan_profiles\msvc-x86 dependencies-windows-x86.txz
if errorlevel 1 goto FAILED

call :SELECT_BUILD_DIR arm64 build-arm64
call :GENERATE_ONE ARM64 "%SELECTED_BUILD_DIR%" dependencies\conan_profiles\msvc-arm64 dependencies-windows-arm64.txz
if errorlevel 1 goto FAILED

goto OPEN_MENU

::::::::::::::::::::::::::::
:: CONAN / CMAKE
::::::::::::::::::::::::::::

:PREPARE_CONAN
echo.
echo  Cleaning Conan cache/profiles...
echo.

set "LOG_COMMAND=%CONAN_EXE% remove * -c"
call :LOG "Removing Conan cache packages"
"%CONAN_EXE%" remove "*" -c >>"%LOG_FILE%" 2>&1
set "LOG_COMMAND=%CONAN_EXE% cache clean"
call :LOG "Cleaning Conan cache"
"%CONAN_EXE%" cache clean >>"%LOG_FILE%" 2>&1
set "LOG_COMMAND=%CONAN_EXE% cache clean -s -b -d -t"
call :LOG "Cleaning Conan source/build/download/temp folders"
"%CONAN_EXE%" cache clean -s -b -d -t >>"%LOG_FILE%" 2>&1

if exist "%USERPROFILE%\.conan2\profiles" rd /q /s "%USERPROFILE%\.conan2\profiles"

set "LOG_COMMAND=%CONAN_EXE% profile detect"
call :LOG "Detecting Conan profile"
"%CONAN_EXE%" profile detect >>"%LOG_FILE%" 2>&1
if errorlevel 1 exit /b 1

exit /b 0

:GENERATE_ONE
set "ARCH=%~1"
set "BUILD_DIR=%~2"
set "CONAN_PROFILE=%~3"
set "DEP_NAME=%~4"

set "CONAN_OUTPUT=conan-%BUILD_DIR%"
set "DEP_FILE="
set "CMAKE_TOOLSET_ARG="

cls
echo  =============================
echo  Generate %BUILD_DIR%
echo  =============================
echo.
echo  Platform:      %ARCH%
echo  Build folder:  %BUILD_DIR%
echo  Conan profile: %CONAN_PROFILE%
echo  Dependency:    %DEP_NAME%
echo.

cd /d "%VCMI_DIR%" || exit /b 1

call :CHECK_REQUIRED_TOOLS
if errorlevel 1 exit /b 1

if "%TARGET_PRE_WINDOWS10%"=="1" (
    if /I not "%ARCH%"=="ARM64" (
        call :HAS_TOOLSET_V142_FOR_VS %VS_YEAR%
        if errorlevel 1 (
            echo  ERROR: MSVC v142 toolset was not found for %VS_NAME%.
            echo  Install "MSVC v142 - VS 2019 C++ x64/x86 build tools" for this Visual Studio in Visual Studio Installer.
            echo  Admin rights are required to modify Visual Studio components.
            pause
            exit /b 1
        )
    )
)

set "CONAN_COMPILER_VERSION="
set "CMAKE_TOOLSET_SPEC="
call :DETECT_CONAN_COMPILER_VERSION
if errorlevel 1 (
    echo  ERROR: Unable to detect compiler.version from selected cl.exe.
    echo  Select a Visual Studio installation with a usable C++ compiler installed.
    call :LOG "Unable to detect compiler.version from selected cl.exe"
    pause
    exit /b 1
)
call :SET_CMAKE_TOOLSET_SPEC
if errorlevel 1 exit /b 1
set "CMAKE_TOOLSET_ARG=-T %CMAKE_TOOLSET_SPEC%"

call :READ_DEPENDENCIES_TAG
if errorlevel 1 exit /b 1

call :PREPARE_CONAN
if errorlevel 1 exit /b 1

call :ENSURE_DEPENDENCIES "%DEP_NAME%"
if errorlevel 1 exit /b 1

echo.
echo  Restoring Conan cache:
echo  %DEP_FILE%
echo.

set "LOG_COMMAND=%CONAN_EXE% cache restore %DEP_FILE%"
call :LOG "Restoring Conan cache %DEP_FILE%"
"%CONAN_EXE%" cache restore "%DEP_FILE%" >>"%LOG_FILE%" 2>&1
if errorlevel 1 exit /b 1

if exist "%BUILD_DIR%" rd /q /s "%BUILD_DIR%"
if exist "%CONAN_OUTPUT%" rd /q /s "%CONAN_OUTPUT%"

echo.
echo  Running Conan install...
echo.

if "%TARGET_PRE_WINDOWS10%"=="1" (
    set "LOG_COMMAND=%CONAN_EXE% install . --output-folder=%CONAN_OUTPUT% --build=never --profile=%CONAN_PROFILE% -s &:compiler.version=%CONAN_COMPILER_VERSION% -s &:build_type=%BUILD_TYPE% -o &:target_pre_windows10=True"
    call :LOG "Running Conan install %BUILD_DIR% pre-Windows10"
    "%CONAN_EXE%" install . ^
        --output-folder="%CONAN_OUTPUT%" ^
        --build=never ^
        --profile="%CONAN_PROFILE%" ^
        -s "&:compiler.version=%CONAN_COMPILER_VERSION%" ^
        -s "&:build_type=%BUILD_TYPE%" ^
        -o "&:target_pre_windows10=True" >>"%LOG_FILE%" 2>&1
) else (
    set "LOG_COMMAND=%CONAN_EXE% install . --output-folder=%CONAN_OUTPUT% --build=never --profile=%CONAN_PROFILE% -s &:compiler.version=%CONAN_COMPILER_VERSION% -s &:build_type=%BUILD_TYPE%"
    call :LOG "Running Conan install %BUILD_DIR%"
    "%CONAN_EXE%" install . ^
        --output-folder="%CONAN_OUTPUT%" ^
        --build=never ^
        --profile="%CONAN_PROFILE%" ^
        -s "&:compiler.version=%CONAN_COMPILER_VERSION%" ^
        -s "&:build_type=%BUILD_TYPE%" >>"%LOG_FILE%" 2>&1
)

if errorlevel 1 exit /b 1

call :FIX_CONAN_TOOLCHAIN_TOOLSET
if errorlevel 1 exit /b 1

echo.
echo  Running CMake configure...
echo.

set "LOG_COMMAND=cmake -S . -B %BUILD_DIR% -G %VS_GENERATOR% -A %ARCH% %CMAKE_TOOLSET_ARG% --toolchain %CONAN_OUTPUT%\conan_toolchain.cmake"
call :LOG "Configuring CMake %BUILD_DIR%"
cmake -S . -B "%BUILD_DIR%" ^
    -G "%VS_GENERATOR%" ^
    -A %ARCH% ^
    %CMAKE_TOOLSET_ARG% ^
    --toolchain "%CONAN_OUTPUT%\conan_toolchain.cmake" >>"%LOG_FILE%" 2>&1

if errorlevel 1 exit /b 1

echo.
echo  Done:
echo  %VCMI_DIR%\%BUILD_DIR%\VCMI.sln
echo.

exit /b 0

::::::::::::::::::::::::::::
:: DEPENDENCIES RELEASE TAG
::::::::::::::::::::::::::::

:READ_DEPENDENCIES_TAG
set "DEPENDENCIES_TAG="
set "DEPS_BASE_URL="

if not exist "%VCMI_DIR%\CI\install_conan_dependencies.sh" (
    echo  ERROR: Missing file:
    echo  %VCMI_DIR%\CI\install_conan_dependencies.sh
    exit /b 1
)

for /f "tokens=2 delims==" %%A in ('findstr /B "RELEASE_TAG=" "%VCMI_DIR%\CI\install_conan_dependencies.sh"') do (
    set "DEPENDENCIES_TAG=%%~A"
)

set "DEPENDENCIES_TAG=%DEPENDENCIES_TAG:"=%"

if not defined DEPENDENCIES_TAG (
    echo  ERROR: Unable to read RELEASE_TAG from:
    echo  %VCMI_DIR%\CI\install_conan_dependencies.sh
    exit /b 1
)

set "DEPS_BASE_URL=https://github.com/vcmi/vcmi-dependencies/releases/download/%DEPENDENCIES_TAG%"

echo  Dependencies release tag: %DEPENDENCIES_TAG%
echo  Dependencies base URL:   %DEPS_BASE_URL%

exit /b 0

::::::::::::::::::::::::::::
:: DEPENDENCIES DOWNLOAD
::::::::::::::::::::::::::::

:ENSURE_DEPENDENCIES
set "DEP_NAME=%~1"
set "DEP_FILE=%DOWNLOADS_DIR%\%DEPENDENCIES_TAG%-%DEP_NAME%"
set "DEP_URL=%DEPS_BASE_URL%/%DEP_NAME%"

if exist "%DEP_FILE%" (
    echo  Dependencies already exist for tag %DEPENDENCIES_TAG%:
    echo  %DEP_FILE%
    exit /b 0
)

echo.
echo  Downloading dependency archive:
echo  %DEP_URL%
echo.

call :DOWNLOAD_FILE "%DEP_URL%" "%DEP_FILE%"
if errorlevel 1 (
    echo.
    echo  ERROR: Failed to download dependencies.
    echo  URL:
    echo  %DEP_URL%
    echo.
    exit /b 1
)

exit /b 0

:DOWNLOAD_FILE
set "URL=%~1"
set "OUT=%~2"

echo.
echo  Downloading:
echo  %URL%
echo.
echo  To:
echo  %OUT%
echo.

if exist "%OUT%" del /q "%OUT%"

bitsadmin /reset /allusers >nul 2>nul
set "LOG_COMMAND=bitsadmin /transfer VCMIDeps /download /priority normal %URL% %OUT%"
call :LOG "Downloading %URL% to %OUT%"
bitsadmin /transfer VCMIDeps /download /priority normal "%URL%" "%OUT%"

if errorlevel 1 (
    if exist "%OUT%" del /q "%OUT%"
    echo  Download failed.
    exit /b 1
)

if not exist "%OUT%" (
    echo  Download finished but output file does not exist:
    echo  %OUT%
    exit /b 1
)

exit /b 0

:MAKE_BUILD_LIST
set "LIST_COUNT=0"
set "LIST1="
set "LIST2="
set "LIST3="
call :SELECT_BUILD_DIR x64 build-x64
if exist "%VCMI_DIR%\%SELECTED_BUILD_DIR%\VCMI.sln" (
    set /a LIST_COUNT+=1
    set "LIST!LIST_COUNT!=%SELECTED_BUILD_DIR%"
    echo  !LIST_COUNT!^) %SELECTED_BUILD_DIR%
)
call :SELECT_BUILD_DIR x86 build-x86
if exist "%VCMI_DIR%\%SELECTED_BUILD_DIR%\VCMI.sln" (
    set /a LIST_COUNT+=1
    set "LIST!LIST_COUNT!=%SELECTED_BUILD_DIR%"
    echo  !LIST_COUNT!^) %SELECTED_BUILD_DIR%
)
call :SELECT_BUILD_DIR arm64 build-arm64
if exist "%VCMI_DIR%\%SELECTED_BUILD_DIR%\VCMI.sln" (
    set /a LIST_COUNT+=1
    set "LIST!LIST_COUNT!=%SELECTED_BUILD_DIR%"
    echo  !LIST_COUNT!^) %SELECTED_BUILD_DIR%
)
exit /b 0

:CMD_BUILD_MENU
cls
echo  =============================
echo  Build from command line
echo  =============================
echo.
echo  Build type: %BUILD_TYPE%
echo  Target:     %TARGET_NAME%
echo.
call :MAKE_BUILD_LIST
if "%LIST_COUNT%"=="0" (
    echo  No generated solutions found for this target.
    echo  Generate a solution first.
    pause
    goto MENU
)
echo  0^) Back
echo.
set "BCOICE="
set /p "BCOICE=Choose build dir [1]: "
if "%BCOICE%"=="" set "BCOICE=1"
if "%BCOICE%"=="1" (
    if defined LIST1 (
        call :BUILD_FROM_CMD "%LIST1%"
        goto MENU
    )
)
if "%BCOICE%"=="2" (
    if defined LIST2 (
        call :BUILD_FROM_CMD "%LIST2%"
        goto MENU
    )
)
if "%BCOICE%"=="3" (
    if defined LIST3 (
        call :BUILD_FROM_CMD "%LIST3%"
        goto MENU
    )
)
if "%BCOICE%"=="0" goto MENU
echo  Invalid choice.
pause
goto CMD_BUILD_MENU

:BUILD_FROM_CMD
set "CMD_BUILD_DIR=%~1"
cd /d "%VCMI_DIR%" || exit /b 1
call :FIND_CMAKE
if errorlevel 1 exit /b 1
if not exist "%CMD_BUILD_DIR%\VCMI.sln" (
    echo  ERROR: Solution does not exist:
    echo  %VCMI_DIR%\%CMD_BUILD_DIR%\VCMI.sln
    pause
    exit /b 1
)
set "LOG_COMMAND=%CMAKE_EXE% --build %CMD_BUILD_DIR% --config %BUILD_TYPE%"
call :LOG "Building %CMD_BUILD_DIR% %BUILD_TYPE%"
"%CMAKE_EXE%" --build "%CMD_BUILD_DIR%" --config %BUILD_TYPE% >>"%LOG_FILE%" 2>&1
if errorlevel 1 goto FAILED
pause
exit /b 0

::::::::::::::::::::::::::::
:: OPEN SLN
::::::::::::::::::::::::::::

:OPEN_AFTER_BUILD
if errorlevel 1 goto FAILED

echo.
set "OPENSLN="
set /p "OPENSLN=Open generated SLN now? [Y/n]: "

if /I "%OPENSLN%"=="n" goto MENU

call :OPEN_SOLUTION "%BUILD_DIR%"
goto MENU

:OPEN_MENU
cls
echo  =============================
echo  Open existing SLN
echo  =============================
echo.
echo  Target: %TARGET_NAME%
echo.
call :MAKE_BUILD_LIST
if "%LIST_COUNT%"=="0" (
    echo  No generated solutions found for this target.
    echo  Generate a solution first.
    pause
    goto MENU
)
echo  0^) Back
echo.
set "OPEN_CHOICE="
set /p "OPEN_CHOICE=Choose SLN [1]: "
if "%OPEN_CHOICE%"=="" set "OPEN_CHOICE=1"
if "%OPEN_CHOICE%"=="1" (
    if defined LIST1 (
        call :OPEN_SOLUTION "%LIST1%"
        goto MENU
    )
)
if "%OPEN_CHOICE%"=="2" (
    if defined LIST2 (
        call :OPEN_SOLUTION "%LIST2%"
        goto MENU
    )
)
if "%OPEN_CHOICE%"=="3" (
    if defined LIST3 (
        call :OPEN_SOLUTION "%LIST3%"
        goto MENU
    )
)
if "%OPEN_CHOICE%"=="0" goto MENU
echo  Invalid choice.
pause
goto OPEN_MENU

:OPEN_SOLUTION
set "SLN_DIR=%~1"
set "SLN_PATH=%VCMI_DIR%\%SLN_DIR%\VCMI.sln"

if "%VS_SELECTED%"=="0" (
    call :ENSURE_VISUAL_STUDIO_SELECTED
)

if not exist "%SLN_PATH%" (
    echo.
    echo  ERROR: Solution does not exist:
    echo  %SLN_PATH%
    pause
    exit /b 1
)

if not exist "%DEVENV%" (
    echo.
    echo  ERROR: Visual Studio devenv.exe not found:
    echo  %DEVENV%
    pause
    exit /b 1
)

echo  Opening:
echo  %SLN_PATH%

call "%DEVENV%" "%SLN_PATH%"
exit /b 0

:FAILED
echo.
echo  ERROR: Operation failed.
pause
goto MENU