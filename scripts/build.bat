@echo off

SETLOCAL EnableDelayedExpansion
:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: set default option values
set option_clean=false
set option_installer=false
set "option_example=helloworld"

set "gbdk_version=3.2"

:: find options in arguments
set /a arg_count=0
FOR %%a IN (%*) DO (
    set /a arg_count+=1
    set arg=%%a
    if "!arg!"=="--clean" (
        set option_clean=true
    )
    if "!arg!"=="--installer" (
        set option_installer=true
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

::set "gbdk_path=C:\gbdk"
set "gbdk_path=%scriptpath:~0,-1%\..\3rdparty\gbdk-%gbdk_version%\gbdk"
set "src_dir=examples\%option_example%"
set "build_dir=%scriptpath:~0,-1%\..\build"
set "installer_dir=%scriptpath:~0,-1%\..\installer"

if "%option_clean%"=="true" (
    echo Cleaning build...
    rmdir /Q /S %build_dir%
    rmdir /Q /S %installer_dir%
)
mkdir %build_dir%

cd %build_dir%

::set "addition_obj_files="
::if "%option_example%"=="blob" (
::    set "addition_obj_files=blob_sprite.o"
::    "%gbdk_path%\bin\lcc" -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o blob_sprite.o ..\%src_dir%\blob_sprite.c ..\%src_dir%\blob_sprite.h
::)

::echo Building...
::"%gbdk_path%\bin\lcc" -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o %option_example%.o ..\%src_dir%\%option_example%.c 
::"%gbdk_path%\bin\lcc" -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o %option_example%.gb %option_example%.o %addition_obj_files%
"%gbdk_path%\bin\lcc" -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o %option_example%.gb ..\%src_dir%\%option_example%.c

echo See %build_dir% for build results.

if "%option_installer%"=="true" (
    echo Building installer...
    mkdir %installer_dir%
    mkdir %installer_dir%\%option_example%

    copy "%scriptpath:~0,-1%\run.bat" "%installer_dir%\%option_example%\run.bat"
    copy "%scriptpath:~0,-1%\..\build\%option_example%.gb" "%installer_dir%\%option_example%\%option_example%.gb"
    copy "%scriptpath:~0,-1%\..\3rdparty\bgb\bgb\bgb.exe" "%installer_dir%\%option_example%\bgb.exe"

    CALL :edit_line "%installer_dir%\%option_example%\run.bat", 8 , "set name=%option_example%"

    powershell "Compress-Archive %installer_dir%\%option_example%\* %installer_dir%\%option_example%.zip"

    echo See %installer_dir% for installer results.
)

:: reset working directory
cd %initcwd%

ENDLOCAL

EXIT /B 0

:Help
echo Optional arguments
echo.
echo --clean: remove build folder before building
echo --installer: create zip file containing build gb file, bgb emulator, and batch script to quickly run it.
echo --example: name of example to build ('helloworld'/'draw')
EXIT /B 0

:BREAK
EXIT /B 2

:edit_line
set InputFile=%~1
set OutputFile=%InputFile%.tmp
set insertline=%~2
set newline=%~3
(for /f "tokens=1* delims=[]" %%a in ('find /n /v "##" ^< "%InputFile%"') do (
    if "%%~a"=="%insertline%" (
        echo %newline%
        REM ECHO.%%b
    ) ELSE (
        echo.%%b
    )
)) > %OutputFile%
::overwrite input with temp
copy /y %OutputFile% %InputFile%
del %OutputFile%
EXIT /B 0