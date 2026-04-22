#!/bin/bash
set -euo pipefail

echo "Starting Hive Metastore..."

export CLASSPATH="/opt/hive/lib/postgresql.jar:${CLASSPATH:-}"
export HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
export HADOOP_CLASSPATH="/opt/hive/lib/postgresql.jar:${HADOOP_CLASSPATH:-}"
export HIVE_CLASSPATH="/opt/hive/lib/postgresql.jar:${HIVE_CLASSPATH:-}"

until nc -z postgres 5432; do
  echo "Waiting for PostgreSQL..."
  sleep 5
done

until hdfs dfs -ls / >/dev/null 2>&1; do
  echo "Waiting for HDFS..."
  sleep 5
done

hdfs dfs -mkdir -p /user/hive/warehouse || true
hdfs dfs -chmod -R 777 /user/hive || true

echo "Initializing or upgrading metastore schema..."
/opt/hive/bin/schematool \
  -dbType postgres \
  -driver org.postgresql.Driver \
  -initOrUpgradeSchema

echo "Starting metastore service..."
exec /opt/hive/bin/hive --service metastore