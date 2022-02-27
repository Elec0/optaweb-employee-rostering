@echo off

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
set doc=(Resolve-Path ((Get-Item (Get-Command docker).Source).DirectoryName + '../../../')).Path + 'Docker Desktop.exe'
@rem Check if docker is running, start it if not
net start docker
net start com.docker.service
powershell "if (!(Get-Process docker -ErrorAction SilentlyContinue)) { echo 'Done, docker window should be opening soon.'; $d_f = %doc% ; Start-Process -FilePath $d_f }"
