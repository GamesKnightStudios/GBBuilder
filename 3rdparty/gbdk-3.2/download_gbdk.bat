@echo off

SETLOCAL EnableDelayedExpansion
:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%
set "gbdk_version=3.2"

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
        set option_clean=true
        set option_uninstall=true
    )
)

:: download file
SET downloadfile=gbdk-%gbdk_version%-win.zip
:: url for downloading gbdk
set url=https://github.com/Zal0/gbdk-2020/releases/download/v%gbdk_version%/%downloadfile%
:: folder where download is placed
SET downloadfolder=%cd%
:: full output filepath
SET downloadpath=%downloadfolder%\%downloadfile%

if "%option_clean%"=="true" (
    echo Cleaning directory...
    rmdir /Q /S %downloadfolder%\gbdk
)

if "%option_uninstall%"=="true" (
    exit /b %ERRORLEVEL%
)

:: download opencv from url
curl -o "%downloadpath%" -L %url%

cd %downloadfolder%\

echo Extracting gbdk...
tar -xf %downloadfile%

:: delete downloaded file
del %downloadfile%
echo gbdk install complete.

:: reset working directory
cd %initcwd%

ENDLOCAL