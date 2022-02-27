@echo off

echo Starting docker engine
call dev/dockerStartEngine.bat

@REM Check if we need to build or not
docker image inspect optaweb/windows -f "{{.Os}}" 1> nul
if NOT %errorlevel% == 0 (
    echo Could not find main docker container, starting build
    call dev/dockerBuild.bat
    if NOT %errorlevel% == 0 goto errEnd
)

@REM Containers are for sure build, start them
call dev/dockerRun.bat
exit %errorlevel%


:errEnd
echo Error, exiting
exit 1