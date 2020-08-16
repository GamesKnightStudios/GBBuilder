@echo off

SETLOCAL EnableDelayedExpansion
:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: set default option values
set "option_example=helloworld"
set option_screenshot=false

:: find options in arguments
set /a arg_count=0
FOR %%a IN (%*) DO (
    set /a arg_count+=1
    set arg=%%a
    if "!arg!"=="--screenshot" (
        set option_screenshot=true
    )
    if "!arg!"=="--example" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_example=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --example
            exit /b 1
        )
    )
    if "!arg!"=="--help" (
        call :help
        EXIT /B 0
    )
)

set "rom_path=%scriptpath:~0,-1%\..\build\%option_example%.gb"

set "bgb_options="
if "%option_screenshot%"=="true" (
    echo Will save screenshot on exit
    set "bgb_options=%bgb_options%-screenonexit %initcwd%\screenshot.png "
)

set "bgb_path=%scriptpath:~0,-1%\..\3rdparty\bgb\bgb\bgb.exe"

echo Running emulator...
call %bgb_path% -rom %rom_path% %bgb_options%

:: reset working directory
cd %initcwd%

ENDLOCAL

EXIT /B 0

:Help
echo Optional arguments
echo.
echo --screenshot: save a screenshot on exiting emulation
echo --example: name of example to build ('helloworld'/'blob')
EXIT /B 0

:BREAK
EXIT /B 2