#!/bin/bash
set -e
echo "Starting Hive Metastore..."
export HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
export HADOOP_CLASSPATH="/opt/hive/lib/postgresql.jar:${HADOOP_CLASSPATH}"

until nc -z postgres 5432; do
  echo "Waiting for PostgreSQL..."
  sleep 5
done

if ! schematool -dbType postgres -info >/dev/null 2>&1; then
  echo "Initializing Hive metastore schema..."
  schematool -dbType postgres -initSchema
fi

exec /opt/hive/bin/hive --service metastore
