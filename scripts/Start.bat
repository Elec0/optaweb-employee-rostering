@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo Starting docker engine
pushd dev
call dockerStartEngine.bat
popd

@REM Check if we need to build or not
docker image inspect optaweb/windows -f "{{.Os}}" 1> nul
if NOT %errorlevel% == 0 goto startBuild

:startContainers
@REM Images are for sure built, start the containers
pushd dev
call dockerRun.bat
popd
exit


@REM  =====

:errEnd
echo Error, exiting
exit 1

:startBuild
echo Could not find main docker image, starting build
pushd dev
call dockerBuild.bat
if NOT %errorlevel% == 0 goto errEnd
popd
goto startContainers