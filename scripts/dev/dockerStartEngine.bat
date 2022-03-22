@echo on
SETLOCAL ENABLEDELAYEDEXPANSION

@REM See if we can run as admin, since docker service needs that to run
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
@REM Restart our script but this time as admin. It will start in a new window
@REM Wait for that to be finished before we say we're done
echo Need admin, requesting and re-reunning...
powershell Start-Process cmd -ArgumentList "/c","`"%~f0`"" -Wait -Verb RunAs
echo Done, docker window should be opening soon.
exit 0

:gotPrivileges
@REM We might have re-called the batch file to get here, so make sure we're in the right directory
cd %~dp0

@rem Check if docker is running, start it if not
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './dockerStartEngineWait.ps1'"
