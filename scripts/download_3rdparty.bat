@echo off

SETLOCAL EnableDelayedExpansion
:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: set default option values
set option_clean=false
set option_uninstall=false
:: find options in arguments
FOR %%a IN (%*) DO (
    set arg=%%a
    if "!arg!"=="--clean" (
        set option_clean=true
    )
    if "!arg!"=="--uninstall" (
        set option_uninstall=true
    )
)

set script_params=""
if "%option_clean%"=="true" (
    set "script_params=--clean"
)
if "%option_uninstall%"=="true" (
    set "script_params=--uninstall"
)

call ..\3rdparty\gbdk-2.95-3\download_gbdk.bat %script_params% --mirror vorboss

:: reset working directory
cd %initcwd%

ENDLOCAL