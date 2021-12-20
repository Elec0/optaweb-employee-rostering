@echo off

echo Stopping all docker containers
powershell docker stop $(docker ps -aq)

echo Removing old docker optaweb container
powershell docker rm optaweb-full

echo Building new docker container
call dockerBuild.bat

echo Running containers
call dockerRun.bat