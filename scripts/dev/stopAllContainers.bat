@echo off

echo Stopping all docker containers
powershell docker stop $(docker ps -aq)

echo Shutting down WSL instances
wsl --shutdown