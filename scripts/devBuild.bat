@REM Maven
pushd ..
mvn clean install -DskipTests -DskipITs -D"quarkus.profile"=postgres

popd
@REM Docker build
@REM docker buildx create --use --name larger_log --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=50000000
@REM docker buildx build --progress plain .
@REM docker build -t optaweb/employee-rocstering --ulimit nofile=98304:98304 \\?\C:\Users\elec0\Downloads\optaweb-employee-rostering