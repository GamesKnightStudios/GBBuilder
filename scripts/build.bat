@echo off

SETLOCAL EnableDelayedExpansion
:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: set default option values
set option_clean=false
:: find options in arguments
FOR %%a IN (%*) DO (
    set arg=%%a
    if "!arg!"=="--clean" (
        set option_clean=true
    )
)

::set "gbdk_path=%scriptpath:~0,-1%\..\3rdparty\gbdk-2.95-3\gbdk"
set "gbdk_path=C:\gbdk"
set "src_dir=games\helloworld\src"
set "build_dir=%scriptpath:~0,-1%\..\build"
set "app_name=helloworld"

if "%option_clean%"=="true" (
    rmdir /Q /S %build_dir%
)
mkdir %build_dir%

cd %build_dir%

"%gbdk_path%\bin\lcc" -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o %app_name%.o ..\%src_dir%\%app_name%.c
"%gbdk_path%\bin\lcc" -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o %app_name%.gb %app_name%.o

:: reset working directory
cd %initcwd%

ENDLOCAL