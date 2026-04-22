#!/bin/bash
set -e

echo "Starting Hive Metastore..."

# Force classpath at runtime
export CLASSPATH="/opt/hive/lib/postgresql.jar:$CLASSPATH"

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

echo "Initializing schema..."

/opt/hive/bin/schematool \
  -dbType postgres \
  -driver org.postgresql.Driver \
  -initOrUpgradeSchema

echo "Starting metastore..."

exec /opt/hive/bin/hive --service metastore