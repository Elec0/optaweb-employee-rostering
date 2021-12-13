
@REM call java -jar optaweb-employee-rostering-standalone\target\quarkus-app\quarkus-run.jar
cd ..
pushd .
cd optaweb-employee-rostering-frontend
start "" npm start
popd

cd optaweb-employee-rostering-backend
mvn quarkus:dev