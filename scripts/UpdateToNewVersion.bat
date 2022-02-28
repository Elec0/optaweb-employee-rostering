@echo on
SETLOCAL ENABLEDELAYEDEXPANSION

echo Ensure docker is started
pushd dev
call dockerStartEngine.bat
popd

echo Stopping all docker containers
powershell docker stop $(docker ps -aq)

echo Removing old docker container and image
powershell docker rm optaweb-full
powershell docker image rm optaweb/windows

call Start.bat