@echo off

echo Stopping all docker containers
powershell docker stop $(docker ps -q)

echo Shutting down WSL instances
wsl --shutdown