#!/usr/bin/env bash
set -euo pipefail

MASTER_AUTH="/run/codex-master/auth.json"
PRIVATE_DIR="${CODEX_HOME:-$HOME/.codex}"
PRIVATE_AUTH="$PRIVATE_DIR/auth.json"

umask 077

mkdir -p "$PRIVATE_DIR"
chmod 700 "$PRIVATE_DIR"

if [ -s "$PRIVATE_AUTH" ]; then
  echo "Codex authentication already initialized."
  exit 0
fi

if [ ! -r "$MASTER_AUTH" ]; then
  echo "ERROR: Master Codex credentials unavailable."
  exit 1
fi

# Copy credentials with owner-only permissions.
install -m 600 "$MASTER_AUTH" "$PRIVATE_AUTH"

echo "Codex authentication initialized."
