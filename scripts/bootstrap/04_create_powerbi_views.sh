#!/bin/bash
set -e
for f in ./sql/trino/*.sql; do
  [ -f "$f" ] || continue
  echo "Applying $f"
  docker compose exec -T trino trino --file /opt/bootstrap/sql/trino/$(basename "$f")
done
