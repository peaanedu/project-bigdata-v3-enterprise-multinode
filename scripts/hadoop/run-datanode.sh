#!/bin/bash
set -e
mkdir -p /data/hdfs/datanode
chown -R hadoop:hadoop /data/hdfs || true
exec su -s /bin/bash hadoop -c "hdfs datanode"
