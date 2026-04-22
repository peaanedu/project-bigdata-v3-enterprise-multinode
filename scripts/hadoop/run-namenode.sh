#!/bin/bash
set -e
mkdir -p /data/hdfs/namenode
chown -R hadoop:hadoop /data/hdfs || true
if [ ! -d /data/hdfs/namenode/current ]; then
  su -s /bin/bash hadoop -c "hdfs namenode -format -nonInteractive -force"
fi
exec su -s /bin/bash hadoop -c "hdfs namenode"
