@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

@REM See if we can run as admin, since docker service needs that to run
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
@REM Restart our script but this time as admin. It will start in a new window
@REM Wait for that to be finished before we say we're done
echo Need admin, requesting and re-running
powershell Start-Process cmd -ArgumentList "/c","`"%~f0`"" -Wait -Verb RunAs
echo Done, docker exiting.
exit 0

:gotPrivileges
@REM Stop all docker services, then kill the processes
powershell Stop-Service *docker* -Force -ErrorAction SilentlyContinue
powershell Stop-Process -Name *docker* -Force
echo Done, docker exiting.
