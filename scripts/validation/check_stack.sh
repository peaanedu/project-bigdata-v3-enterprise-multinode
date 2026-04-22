#!/bin/bash
set -e
docker compose ps
echo
echo "Checking HDFS..."
docker compose exec namenode hdfs dfs -ls /
echo
echo "Checking Hive..."
docker compose exec hive-server beeline -u jdbc:hive2://hive-server:10000/default -n hive -e "SHOW DATABASES;"
echo
echo "Checking Trino..."
docker compose exec trino trino --execute "SHOW CATALOGS;"
