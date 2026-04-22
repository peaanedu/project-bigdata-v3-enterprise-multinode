FROM apache/hive:4.1.0

USER root
ADD https://jdbc.postgresql.org/download/postgresql-42.7.3.jar /opt/hive/lib/postgresql.jar
ENV HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
ENV HADOOP_CLASSPATH=/opt/hive/lib/postgresql.jar
ENV HIVE_CLASSPATH=/opt/hive/lib/postgresql.jar
USER hive