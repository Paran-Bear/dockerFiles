@echo off
set CONTAINER_NAME=maria-db
set SET_SQL_PATH=/etc/mysql/initDB/init.sql
set SET_SQL_DELAY=10
set DB_ROOT_UID=root
set DB_ROOT_PASSWORD=catch!23

echo.
echo.
echo [RUN] 1. Remove Container '%CONTAINER_NAME%'
echo.
docker stop %CONTAINER_NAME%
docker rm %CONTAINER_NAME%
docker rmi %CONTAINER_NAME%
echo.
echo [RUN] 2. Run Container
echo.
docker-compose up -d
echo.
echo [RUN] 3. Set DB
echo Wait for %SET_SQL_DELAY% second
timeout %SET_SQL_DELAY%
echo.
echo %CONTAINER_NAME% mysql -u%DB_ROOT_UID% -p%DB_ROOT_PASSWORD%  %SET_SQL_PATH%
docker exec %CONTAINER_NAME% sh -c "mysql -u%DB_ROOT_UID% -p%DB_ROOT_PASSWORD% < %SET_SQL_PATH%"
echo.
echo [RUN COMPLETE]
echo.
echo.
timeout 20