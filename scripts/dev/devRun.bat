@echo off

echo Start PostgreSQL container
docker start optaweb-db

cd ..\..
pushd .
cd optaweb-employee-rostering-frontend
start "" npm start
popd

cd optaweb-employee-rostering-backend
mvn quarkus:dev