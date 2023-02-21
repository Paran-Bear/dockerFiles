#!/bin/sh
docker run -p 5432:5432 --name postgres-ko-5432 -e POSTGRES_PASSWORD=1234 -e TZ=Asia/Seoul -v aibot30:/var/lib/postgresql/data -d --restart unless-stopped postgres-ko:latest
