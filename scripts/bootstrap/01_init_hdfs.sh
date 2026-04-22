#!/bin/bash
set -e
docker compose exec namenode hdfs dfs -mkdir -p /data/raw/sales
docker compose exec namenode hdfs dfs -mkdir -p /user/hive/warehouse
docker compose exec namenode hdfs dfs -chmod -R 777 /data /user
echo "HDFS bootstrap completed."
