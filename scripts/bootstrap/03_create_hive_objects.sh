#!/bin/bash
set -e
for f in ./sql/hive/*.sql; do
  [ -f "$f" ] || continue
  echo "Applying $f"
  docker compose exec -T hive-server beeline -u jdbc:hive2://hive-server:10000/default -n hive -f /opt/bootstrap/sql/hive/$(basename "$f")
done
