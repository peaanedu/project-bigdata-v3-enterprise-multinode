FROM apache/hive:4.1.0

USER root

# Copy LOCAL jar (NOT URL)
COPY lib/postgresql.jar /opt/hive/lib/postgresql.jar

# Force classpath globally
ENV HIVE_AUX_JARS_PATH=/opt/hive/lib/postgresql.jar
ENV HADOOP_CLASSPATH=/opt/hive/lib/postgresql.jar
ENV HIVE_CLASSPATH=/opt/hive/lib/postgresql.jar

USER hive