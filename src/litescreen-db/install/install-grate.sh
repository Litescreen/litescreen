#!/usr/bin/env sh
set -eu

version="${1:-2.2.0}"
os="$(uname -s)"
machine="$(uname -m)"

case "$machine" in
    x86_64|amd64) architecture='x64' ;;
    aarch64|arm64) architecture='arm64' ;;
    *) echo "Unsupported architecture: $machine" >&2; exit 1 ;;
esac

case "$os" in
    Darwin) platform='osx' ;;
    Linux)
        platform='linux'
        if [ -e /lib/ld-musl-x86_64.so.1 ] || [ -e /lib/ld-musl-aarch64.so.1 ] || ldd --version 2>&1 | grep -qi musl; then
            platform='linux-musl'
        fi
        ;;
    *) echo "Unsupported operating system: $os" >&2; exit 1 ;;
esac

asset="grate-${platform}-${architecture}-self-contained-${version}.zip"
download_uri="https://github.com/grate-devs/grate/releases/download/${version}/${asset}"
install_directory="${HOME}/.local/bin"
temporary_directory="$(mktemp -d)"
trap 'rm -rf "$temporary_directory"' EXIT HUP INT TERM

curl --fail --location --silent --show-error "$download_uri" --output "$temporary_directory/$asset"
unzip -q "$temporary_directory/$asset" -d "$temporary_directory/unpacked"
executable="$(find "$temporary_directory/unpacked" -type f -name grate -print -quit)"
if [ -z "$executable" ]; then
    echo "The release archive did not contain the grate executable: $download_uri" >&2
    exit 1
fi

mkdir -p "$install_directory"
cp -R "$(dirname "$executable")/"* "$install_directory/"
chmod +x "$install_directory/grate"

profile="${HOME}/.profile"
case "${SHELL##*/}" in
    zsh) profile="${HOME}/.zprofile" ;;
    bash)
        if [ "$(uname -s)" = 'Darwin' ]; then profile="${HOME}/.bash_profile"; fi
        ;;
esac
mkdir -p "$(dirname "$profile")"
path_line='export PATH="$HOME/.local/bin:$PATH"'
if ! grep -Fq "$path_line" "$profile" 2>/dev/null; then
    printf '\n%s\n' "$path_line" >> "$profile"
fi

echo "Installed Grate $version to $install_directory and added it to $profile. Open a new terminal to use grate from PATH."
