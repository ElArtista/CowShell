@echo off

::
:: CowShell
::
:: Set the CowShell Root dir
set COWSHELL_ROOT=%~dp0

:: Set the Vendor folder
set VENDOR_ROOT=%COWSHELL_ROOT%Vendor

:: Set the Config folder
set CONFIG_ROOT=%COWSHELL_ROOT%Config

:: Set the Resources folder
set RESOURCES_ROOT=%COWSHELL_ROOT%Resources

:: Set the CowShell icon
set COWSHELL_ICON=%RESOURCES_ROOT%\terminal.ico

::
:: ConEmu
::
:: Set the ConEmu location
set CONEMU_PATH=%VENDOR_ROOT%\ConEmu
set CONEMU_EXE=%CONEMU_PATH%\ConEmu.exe

:: Set the location of ConEmu config file
set CONEMU_CONFIG=%CONFIG_ROOT%\ConEmu.xml

::
:: Clink
::
set CLINK_PATH=%VENDOR_ROOT%\Clink

::
:: Entrypoint
::
:: Set the Boot command
set COWSHELL_BOOT="%CONEMU_EXE%" /single /Icon "%COWSHELL_ICON%" /Title CowShell /LoadCfgFile "%CONEMU_CONFIG%"

start "" %COWSHELL_BOOT%
