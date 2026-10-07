# postgres

PostgreSQL 17 image based on [`pgvector/pgvector:pg17`](https://hub.docker.com/r/pgvector/pgvector), with [pg_partman](https://github.com/pgpartman/pg_partman) installed on top.

```sh
docker pull ghcr.io/dennyloko/postgres:pg17
```

Everything else works as in the official [`postgres`](https://hub.docker.com/_/postgres) image, including the entrypoint and its environment variables.

## Extensions

| Extension | Version | Source |
|---|---|---|
| [`vector`](https://github.com/pgvector/pgvector) | 0.8.7 | base image |
| [`pg_partman`](https://github.com/pgpartman/pg_partman) | 5.5.0 | `postgresql-17-partman` package from PGDG |

The contrib extensions bundled with PostgreSQL (`pg_trgm`, `pgcrypto`, `btree_gin`, `unaccent`, `pg_stat_statements` and so on) are also available. The versions in the table come from the latest build and move forward with the weekly rebuild.

You still have to create each extension in the databases that use it:

```sql
CREATE EXTENSION vector;
CREATE SCHEMA partman;
CREATE EXTENSION pg_partman SCHEMA partman;
```

## pg_partman maintenance

pg_partman creates future partitions and drops expired ones only when `partman.run_maintenance()` runs. Call it from a scheduler, or let the bundled background worker run it by adding this to `postgresql.conf`:

```
shared_preload_libraries = 'pg_partman_bgw'   # append to any libraries you already preload
pg_partman_bgw.interval = 3600                # seconds
pg_partman_bgw.role = 'postgres'
pg_partman_bgw.dbname = 'mydb'                # comma-separated list of databases
```

Changing `shared_preload_libraries` requires a restart.

## Tags

| Tag | Built on |
|---|---|
| `pg17`, `latest` | every push to `main`, plus a weekly rebuild (Mondays, 06:17 UTC) |
| `sha-<commit>` | every build |
| `<version>` | `v*` git tags |

Images are built for `linux/amd64` only.
