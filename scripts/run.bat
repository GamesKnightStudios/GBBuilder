@echo off

:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

set name=helloworld
call bgb.exe -rom %name%.gb