#!/usr/bin/env bash
set -euo pipefail

query="${1:-}"

if [[ -z "$query" ]]; then
  echo "Usage: 05_tools/kb_search.sh <query>" >&2
  exit 1
fi

rg -n --hidden --glob '!.git' --glob '!01_raw/assets/**' "$query" .

