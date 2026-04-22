#!/bin/bash
set -e

echo "=============================="
echo "Starting HiveServer2 Service"
echo "=============================="

# Load Hadoop env (VERY IMPORTANT)
export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop

# PostgreSQL driver
export CLASSPATH="/opt/hive/lib/postgresql.jar:${CLASSPATH:-}"
export HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
export HADOOP_CLASSPATH="/opt/hive/lib/postgresql.jar:${HADOOP_CLASSPATH:-}"

# Wait for Metastore
echo "Waiting for Hive Metastore..."
until nc -z hive-metastore 9083; do
  sleep 3
done

# Wait for HDFS (SAFE VERSION)
echo "Waiting for HDFS..."
for i in {1..20}; do
  if hdfs dfs -ls / >/dev/null 2>&1; then
    echo "HDFS is ready"
    break
  fi
  echo "Retry HDFS..."
  sleep 3
done

# Ensure warehouse exists (DON'T BLOCK)
echo "Ensuring warehouse directory..."
hdfs dfs -mkdir -p /user/hive/warehouse || true
hdfs dfs -chmod 777 /user/hive/warehouse || true

echo "Launching HiveServer2..."

exec /opt/hive/bin/hiveserver2 \
  --hiveconf hive.server2.thrift.bind.host=0.0.0.0 \
  --hiveconf hive.server2.thrift.port=10000 \
  --hiveconf hive.server2.webui.port=10002 \
  --hiveconf hive.metastore.uris=thrift://hive-metastore:9083