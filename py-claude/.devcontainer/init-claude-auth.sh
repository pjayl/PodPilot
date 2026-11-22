#!/usr/bin/env bash
set -euo pipefail

MASTER_TOKEN="/run/claude-master/oauth-token"
PRIVATE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
PRIVATE_TOKEN="$PRIVATE_DIR/oauth-token"
CLAUDE_STATE="$HOME/.claude.json"

umask 077

mkdir -p "$PRIVATE_DIR"
chmod 700 "$PRIVATE_DIR"

# Skip the first-run onboarding wizard; the token provides authentication.
if [ ! -s "$CLAUDE_STATE" ]; then
  printf '{\n  "hasCompletedOnboarding": true\n}\n' > "$CLAUDE_STATE"
fi

if [ -s "$PRIVATE_TOKEN" ]; then
  echo "Claude authentication already initialized."
  exit 0
fi

if [ ! -s "$MASTER_TOKEN" ]; then
  echo "ERROR: Master Claude token unavailable."
  exit 1
fi

# Copy the token with owner-only permissions, stripping surrounding whitespace.
tr -d '[:space:]' < "$MASTER_TOKEN" > "$PRIVATE_TOKEN"
chmod 600 "$PRIVATE_TOKEN"

echo "Claude authentication initialized."
