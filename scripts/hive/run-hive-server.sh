#!/bin/bash
set -euo pipefail

echo "Starting HiveServer2..."

export CLASSPATH="/opt/hive/lib/postgresql.jar:${CLASSPATH:-}"
export HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
export HADOOP_CLASSPATH="/opt/hive/lib/postgresql.jar:${HADOOP_CLASSPATH:-}"
export HIVE_CLASSPATH="/opt/hive/lib/postgresql.jar:${HIVE_CLASSPATH:-}"

until nc -z hive-metastore 9083; do
  echo "Waiting for Hive Metastore..."
  sleep 5
done

until hdfs dfs -test -d /user/hive/warehouse; do
  echo "Waiting for /user/hive/warehouse ..."
  sleep 5
done

echo "Launching HiveServer2..."
exec /opt/hive/bin/hiveserver2 \
  --hiveconf hive.server2.thrift.bind.host=0.0.0.0 \
  --hiveconf hive.server2.thrift.port=10000 \
  --hiveconf hive.server2.webui.port=10002 \
  --hiveconf hive.metastore.uris=thrift://hive-metastore:9083