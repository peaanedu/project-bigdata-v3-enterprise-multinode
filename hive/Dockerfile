FROM apache/hive:4.1.0

USER root

# Install curl (safe for all base images)
RUN microdnf install -y curl || yum install -y curl || true

# Download PostgreSQL driver properly
RUN curl -L https://jdbc.postgresql.org/download/postgresql-42.7.3.jar \
    -o /opt/hive/lib/postgresql.jar

# Fix permission
RUN chmod 644 /opt/hive/lib/postgresql.jar

USER hive