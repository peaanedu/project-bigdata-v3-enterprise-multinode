#!/bin/bash
set -e

echo "Starting HiveServer2..."

export HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
export HADOOP_CLASSPATH="/opt/hive/lib/postgresql.jar:${HADOOP_CLASSPATH}"
export HIVE_CLASSPATH="/opt/hive/lib/postgresql.jar:${HIVE_CLASSPATH}"

until nc -z hive-metastore 9083; do
  echo "Waiting for Hive Metastore..."
  sleep 5
done

exec /opt/hive/bin/hive --service hiveserver2