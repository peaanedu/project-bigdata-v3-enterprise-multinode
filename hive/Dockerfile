FROM apache/hive:4.1.0

USER root

COPY lib/postgresql.jar /opt/hive/lib/postgresql.jar

RUN apt-get update && \
    apt-get install -y --no-install-recommends iproute2 netcat-openbsd procps && \
    rm -rf /var/lib/apt/lists/*

ENV HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
ENV HADOOP_CLASSPATH=/opt/hive/lib/postgresql.jar
ENV HIVE_CLASSPATH=/opt/hive/lib/postgresql.jar

USER hive