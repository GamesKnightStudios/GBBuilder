@echo off

SETLOCAL EnableDelayedExpansion
:: set working directory to script directory
SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: set default option values
set option_clean=false
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

if "%option_clean%"=="true" (
    echo Cleaning build...
    rmdir /Q /S %build_dir%
)
mkdir %build_dir%

cd %build_dir%

echo Building...
"%gbdk_path%\bin\lcc" -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o %option_example%.o ..\%src_dir%\%option_example%.c
"%gbdk_path%\bin\lcc" -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o %option_example%.gb %option_example%.o

echo See %build_dir% for results.
:: reset working directory
cd %initcwd%

ENDLOCAL

EXIT /B 0

:Help
echo Optional arguments
echo.
echo --clean: remove build folder before building
echo --example: name of example to build ('helloworld'/'blob')
EXIT /B 0

:BREAK
EXIT /B 2