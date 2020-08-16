@echo off

:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

set name=helloworld

echo EMULATOR CONTROLS
echo A: B button
echo S: A button
echo ARROW_LEFT: Joypad Left button
echo ARROW_RIGHT: Joypad Right button
echo ARROW_UP: Joypad Up button
echo ARROW_DOWN: Joypad Down button
echo Shift: Select button
echo Enter: Start button

call bgb.exe -rom %name%.gb