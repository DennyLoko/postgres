# PostgreSQL 17 with pgvector and pg_partman.
# pg_partman comes from the PGDG apt repository, which the official postgres image already configures.
FROM pgvector/pgvector:pg17

RUN apt-get update \
 && apt-get install -y --no-install-recommends postgresql-17-partman \
 && rm -rf /var/lib/apt/lists/*
