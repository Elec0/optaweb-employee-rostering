@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

@REM Figure out if we should build the postgres image
@REM FOR /F "tokens=* USEBACKQ" %%F IN (`docker container inspect optaweb-db -f "{{.State.Status}}"`) DO (
@REM     SET postgresStatus=%%F
@REM )
docker container inspect optaweb-db -f "{{.State.Status}}" > nul
if NOT %errorlevel% == 0 (
    echo Run PostgreSQL container
    docker run --name optaweb-db -e POSTGRES_PASSWORD=optaweb-db -e POSTGRES_DB=optaweb -d -p 5432:5432 postgres
) else (
    echo PostgreSQL contianer exists, start it
    docker start optaweb-db
)

for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
echo Network IP: %NetworkIP%

docker container inspect optaweb/windows -f "{{.State.Status}}" > nul
if NOT %errorlevel% == 0 (
    echo Run optaweb/windows container
    docker run --name optaweb/windows --add-host=host:%NetworkIP% -p 8080:8080 -it -e QUARKUS_PROFILE=production optaweb/windows
) else (
    echo optaweb/windows container exists, start it
    docker start optaweb/windows
)
