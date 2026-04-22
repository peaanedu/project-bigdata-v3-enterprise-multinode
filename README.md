# Project Big Data v3 Enterprise Multi-Node

Enterprise-style Docker big data lab with:
- Hadoop 3.4.2 multi-node cluster
- HDFS: 1 NameNode + 3 DataNodes
- YARN: 1 ResourceManager + 3 NodeManagers
- Hive 4.1.0 with PostgreSQL metastore
- Trino 472 for BI / Power BI
- Spark 3.5.1 cluster
- Jupyter notebook

## Topology

- namenode
- datanode1
- datanode2
- datanode3
- resourcemanager
- nodemanager1
- nodemanager2
- nodemanager3
- postgres
- hive-metastore
- hive-server
- trino
- spark-master
- spark-worker-1
- spark-worker-2
- jupyter

## First run

```bash
cp .env.example .env
chmod +x scripts/bootstrap/*.sh scripts/hadoop/*.sh scripts/hive/*.sh scripts/validation/*.sh

docker compose down -v
docker builder prune -a -f
docker volume prune -f

docker compose up -d --build
```

## Bootstrap

```bash
./scripts/bootstrap/01_init_hdfs.sh
./scripts/bootstrap/02_load_demo_data.sh
./scripts/bootstrap/03_create_hive_objects.sh
./scripts/bootstrap/04_create_powerbi_views.sh
./scripts/validation/check_stack.sh
```

## Health checks

```bash
docker compose ps
docker compose exec namenode hdfs dfsadmin -report
docker compose exec hive-server beeline -u jdbc:hive2://hive-server:10000/default -n hive -e "SHOW DATABASES;"
docker compose exec trino trino --execute "SHOW SCHEMAS FROM hive;"
```

## URLs

- NameNode: http://localhost:9870
- YARN RM: http://localhost:8088
- Spark Master: http://localhost:8080
- Trino: http://localhost:8081
- Jupyter: http://localhost:8888

## Notes

- Hive uses a custom local image from `./hive/Dockerfile`
- The PostgreSQL JDBC driver is baked into the Hive image
- Start Power BI through Trino ODBC against port `8081`
