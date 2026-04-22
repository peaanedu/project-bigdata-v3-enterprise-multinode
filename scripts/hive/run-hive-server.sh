#!/bin/bash
set -e

echo "Starting HiveServer2..."

# Ensure JDBC + classpath
export CLASSPATH="/opt/hive/lib/postgresql.jar:$CLASSPATH"
export HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
export HADOOP_CLASSPATH="/opt/hive/lib/postgresql.jar:${HADOOP_CLASSPATH}"
export HIVE_CLASSPATH="/opt/hive/lib/postgresql.jar:${HIVE_CLASSPATH}"

# Wait for metastore (VERY IMPORTANT)
until nc -z hive-metastore 9083; do
  echo "Waiting for Hive Metastore..."
  sleep 5
done

# Wait for HDFS warehouse
until hdfs dfs -ls /user/hive/warehouse >/dev/null 2>&1; do
  echo "Waiting for HDFS warehouse..."
  sleep 5
done

echo "Starting HiveServer2 now..."

exec /opt/hive/bin/hive --service hiveserver2