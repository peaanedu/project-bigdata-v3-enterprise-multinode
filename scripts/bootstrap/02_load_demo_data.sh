#!/bin/bash
set -e
docker cp datasets/raw/sales_orders.csv namenode:/tmp/sales_orders.csv
docker compose exec namenode hdfs dfs -put -f /tmp/sales_orders.csv /data/raw/sales/
echo "Demo data loaded into HDFS."
