#!/usr/bin/env sh
set -eu

if [ -z "${LITESCREEN_DB_CONNECTION_STRING:-}" ]; then
    echo 'Set LITESCREEN_DB_CONNECTION_STRING before running database migrations.' >&2
    exit 1
fi

environment="${1:-Development}"
drop_option="${2:-}"
if [ -n "$drop_option" ] && [ "$drop_option" != '--drop' ]; then
    echo "Unexpected second argument: $drop_option" >&2
    echo 'Usage: migrate.sh [environment] [--drop]' >&2
    exit 2
fi

script_directory="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
database_root="$(CDPATH= cd -- "$script_directory/.." && pwd)"

set --
if [ "$drop_option" = '--drop' ]; then
    set -- --drop
fi

exec grate \
    "--connectionstring=$LITESCREEN_DB_CONNECTION_STRING" \
    --databasetype=sqlserver \
    "--sqlfilesdirectory=$database_root" \
    "--environment=$environment" \
    --noninteractive \
    "$@"
