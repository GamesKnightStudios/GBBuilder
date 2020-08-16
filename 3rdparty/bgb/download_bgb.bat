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
        set option_clean=true
        set option_uninstall=true
    )
)

:: download file
SET downloadfile=bgb.zip
:: url for downloading bgb
set url=http://bgb.bircd.org/%downloadfile%
:: folder where download is placed
SET downloadfolder=%cd%\bgb
:: full output filepath
SET downloadpath=%downloadfolder%\%downloadfile%

if "%option_clean%"=="true" (
    echo Cleaning directory...
    rmdir /Q /S %downloadfolder%
)

if "%option_uninstall%"=="true" (
    exit /b %ERRORLEVEL%
)

mkdir %downloadfolder%

:: download opencv from url
curl -o "%downloadpath%" -L %url%

cd %downloadfolder%\

echo Extracting bgb...
tar -xf %downloadfile%

:: delete downloaded file
del %downloadfile%
echo bgb install complete.

:: reset working directory
cd %initcwd%

ENDLOCAL