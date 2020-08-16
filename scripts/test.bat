@echo off

:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

set "rom_path=%scriptpath:~0,-1%\..\build\main.gb"
set "bgb_path=%scriptpath:~0,-1%\..\3rdparty\bgb\bgb\bgb.exe"

call %bgb_path% -rom %rom_path%

:: reset working directory
cd %initcwd%