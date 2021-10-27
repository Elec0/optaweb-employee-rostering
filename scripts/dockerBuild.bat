@echo off

@REM Figure out if we should build the postgres image
docker image inspect postgres -f "{{.Os}}" > nul
if NOT %errorlevel% == 0 (
    echo Pull PostgreSQL image
    @REM Set up the postgres docker stuff
    docker pull postgres
    
    @REM Build the postgres image with our single config file
    pushd .
    cd postgres
    docker build -t optaweb-db .
    popd
)

@REM buildtools image might exist, if so who cares
echo Create buildx image
docker buildx create --use --name larger_log --rm --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=50000000 > nul


pushd .
cd ..
echo Build Employee Rostering image
docker buildx build --load -t optaweb/windows \\?\%CD%
popd