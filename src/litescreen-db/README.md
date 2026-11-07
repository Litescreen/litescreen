# Litescreen database

Grate and provider-specific SQL live here. SQL Server is the first target; add a sibling `postgresql` root when that provider is introduced.

```text
litescreen-db/
├── install/
│   ├── install-grate.ps1
│   └── install-grate.sh
└── sqlserver/
    ├── up/          # Ordered, one-time schema and data changes
    ├── views/       # Repeatable view definitions
    ├── sprocs/      # Repeatable stored procedure definitions
    ├── functions/   # Repeatable function definitions
    ├── triggers/    # Repeatable trigger definitions
    └── scripts/
        ├── migrate.ps1 / migrate.sh
        └── reset-local.ps1 / reset-local.sh
```

## Install Grate

The install scripts download the self-contained Grate 2.2.0 release for the current OS and architecture and place it on the current user's PATH. No Docker, .NET SDK, or package manager is required. Windows installs under `%LOCALAPPDATA%\Programs\Grate`; macOS and Linux install under `~/.local/bin`.

```powershell
./install/install-grate.ps1
```

```sh
sh ./install/install-grate.sh
```

Pass a release version as the first argument to install another pinned version. Open a new terminal after installation so it sees the updated PATH. Keep the version in these scripts aligned with the version used in CI for repeatable deployments.

## Run migrations

Set `LITESCREEN_DB_CONNECTION_STRING` in the current shell or inject it from the local secret store/CI secret provider. The scripts do not print the connection string.

```powershell
$env:LITESCREEN_DB_CONNECTION_STRING = '...'
./sqlserver/scripts/migrate.ps1 -Environment Development
```

```sh
export LITESCREEN_DB_CONNECTION_STRING='...'
sh ./sqlserver/scripts/migrate.sh Development
```

The environment argument defaults to `Development`. Grate runs files in `up` once, in filename order; use ordered names such as `20261106120000_feature_01_create_table.sql`. Keep applied one-time files unchanged and add a forward migration for later changes. Use `.ENV.Development.sql` in a filename only when that file should run exclusively for that environment.

## Seed data

Grate does not expose a seed-only command. Put durable reference or initial data changes in separate, ordered SQL files under `sqlserver/up`; the normal migration command applies them along with any other pending changes. Treat seed files as immutable after they have run; add a later `UPDATE` or `INSERT` migration to adjust data.

## Reset a local database

The reset scripts ask you to type the server and database name before proceeding. They use Grate's `--drop` option, which drops the selected database, recreates it, and applies the migrations in `up`. Use only a local development connection string; the account must have permission to drop and create the database.

```powershell
./sqlserver/scripts/reset-local.ps1
```

```sh
sh ./sqlserver/scripts/reset-local.sh
```

The Bash reset script calls `migrate.sh` with `--drop` rather than copying its Grate command, so the normal migration options stay in one place. Grate's `--drop` behavior is documented in its [configuration options](https://grate-devs.github.io/grate/configuration-options/).

## Grate installation choice

Installing the self-contained binary to a user-local PATH directory is a good fit here: developers and CI can call `grate` directly without a project-specific .NET app or OS package manager. Pin the Grate version in developer setup and CI rather than silently following latest; the install scripts default to 2.2.0 and accept an explicit version override.
