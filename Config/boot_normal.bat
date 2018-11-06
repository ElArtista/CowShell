@echo off

:: Set clink arguments
set CLINK_ARGS= --profile "%APPDATA%\clink_profile"

::
:: Inject clink to cmd
::

:: Pass through to appropriate loader.
if /i "%PROCESSOR_ARCHITECTURE%"=="x86" (
    "%CLINK_PATH%\clink_x86.exe" inject %CLINK_ARGS%
) else if /i "%PROCESSOR_ARCHITECTURE%"=="amd64" (
    "%CLINK_PATH%\clink_x64.exe" inject %CLINK_ARGS%
)

:: Append AutoJump to PATH
set PATH=%PATH%;%VENDOR_ROOT%\AutoJump\bin

::
:: Set usefull enviroment variables
::

:: Set the home folder for cygwin like enviroments (e.g. ssh)
set HOME=%USERPROFILE%

:: Set x86 Program Files path
set PF32=C:\Program Files (x86)

:: Set x64 Program Files path
set PF64=C:\Program Files

:: Set init dir
cd "%USERPROFILE%\Workdir"

:: Load user init script
set USERBOOTSCRIPT=%APPDATA%\CowShell\init.bat
if exist "%USERBOOTSCRIPT%" (
  call "%USERBOOTSCRIPT%"
)

::
:: Form the command prompt
::
:: This will start prompt with `User@PC `
set ConEmuPrompt0=$E[32m$E]9;8;"USERNAME"$E\@$E]9;8;"COMPUTERNAME"$E\$S

:: Followed by colored `Path`
set ConEmuPrompt1=%ConEmuPrompt0%$E[92m$P$E[90m
if NOT "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
  if "%PROCESSOR_ARCHITEW6432%" == "AMD64" if "%PROCESSOR_ARCHITECTURE%" == "x86" (
    rem Use another text color if cmd was run from SysWow64
    set ConEmuPrompt1=%ConEmuPrompt0%$E[93m$P$E[90m
  )
)

:: Carriage return and `$` or `>`
:: Spare `$E[90m` was specially added because of GitShowBranch.cmd
if "%ConEmuIsAdmin%" == "ADMIN" (
  set ConEmuPrompt2=$_$E[90m$$
) else (
  set ConEmuPrompt2=$_$E[90m$G
)

:: Finally reset color and add space
set ConEmuPrompt3=$E[m$S$E[0m

:: Set the prompt
prompt %ConEmuPrompt1%%ConEmuPrompt2%%ConEmuPrompt3%

:: Enable inserting ESC code in batch file through the %ESC% env var
call "%ConEmuBaseDir%\SetEscChar.cmd"

::
:: Print start screen
::
cls
echo %ESC%[36m Cowshell v3.3 Copyright (c) 2015-2018 TheArtist %ESC%[33m
type "%RESOURCES_ROOT%\motd.txt"
echo %ESC%[39m