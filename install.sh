#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-OneL1ght/uscripts}"
BRANCH="${BRANCH:-main}"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

curl -fsSL "https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz" | tar -xz -C "$tmp" --strip-components=1
mkdir -p "$INSTALL_DIR"

for f in "$tmp"/*; do
    name=$(basename "$f")
    # ставим только файлы с исполняемым битом из гита
    [[ -f $f && -x $f && $name != install.sh ]] || continue
    install -m 755 "$f" "$INSTALL_DIR/$name"
    echo "installed: $INSTALL_DIR/$name"
done

case ":$PATH:" in
    *":$INSTALL_DIR:"*) ;;
    *) echo
       echo "$INSTALL_DIR нет в PATH. Добавь в ~/.bashrc или ~/.zshrc:"
       echo "  export PATH=\"$INSTALL_DIR:\$PATH\"" ;;
esac
