#!/bin/bash
set -e

echo "Waiting for PostgreSQL..."
until nc -z postgres 5432; do
  sleep 2
done

echo "Initializing schema..."
/opt/hive/bin/schematool -dbType postgres -initSchema || true

echo "Starting Hive Metastore..."
exec /opt/hive/bin/hive --service metastore