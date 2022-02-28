@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

call dev/stopAllContainers.bat

echo Stopping docker engine
call dev/dockerStopEngine.bat

