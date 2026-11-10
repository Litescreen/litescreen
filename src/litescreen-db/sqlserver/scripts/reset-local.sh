#!/usr/bin/env sh
set -eu

if [ -z "${LITESCREEN_DB_CONNECTION_STRING:-}" ]; then
    echo 'Set LITESCREEN_DB_CONNECTION_STRING to your local development database before resetting.' >&2
    exit 1
fi

connection_value() {
    key="$1"
    printf '%s' "$LITESCREEN_DB_CONNECTION_STRING" | awk -F';' -v wanted="$key" '
        {
            for (i = 1; i <= NF; i++) {
                split($i, pair, "=")
                name = pair[1]
                value = $i
                sub(/^[^=]*=/, "", value)
                gsub(/^[[:space:]]+|[[:space:]]+$/, "", name)
                gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
                if (tolower(name) == tolower(wanted)) {
                    print value
                    exit
                }
            }
        }'
}

server="$(connection_value Server)"
if [ -z "$server" ]; then server="$(connection_value Data Source)"; fi
if [ -z "$server" ]; then server="$(connection_value Address)"; fi
if [ -z "$server" ]; then server="$(connection_value Addr)"; fi
if [ -z "$server" ]; then server="$(connection_value Network Address)"; fi
database="$(connection_value Database)"
if [ -z "$database" ]; then database="$(connection_value Initial Catalog)"; fi

if [ -z "$server" ] || [ -z "$database" ]; then
    echo 'The connection string must include Server (or Data Source) and Database (or Initial Catalog) so the reset target can be confirmed.' >&2
    exit 1
fi

target="$server/$database"
printf "WARNING: this will DROP database '%s' on '%s', then recreate it and run every pending SQL Server migration. Only use a local development connection string.\n" "$database" "$server" >&2
printf "Type '%s' to continue: " "$target" >&2
IFS= read -r confirmation
if [ "$confirmation" != "$target" ]; then
    echo 'Reset cancelled; the confirmation did not match the target.' >&2
    exit 1
fi

script_directory="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sh "$script_directory/migrate.sh" Development --drop
