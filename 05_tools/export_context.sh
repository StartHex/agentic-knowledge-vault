#!/usr/bin/env bash
set -euo pipefail

topic="${1:-}"

if [[ -z "$topic" ]]; then
  echo "Usage: 05_tools/export_context.sh <topic>" >&2
  exit 1
fi

out="03_outputs/context-packs/$(date -u +%Y-%m-%d)-${topic// /-}.md"
{
  echo "# Context Pack - $topic"
  echo
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo
  echo "## Index Matches"
  rg -n "$topic" 02_wiki/index.md 02_wiki || true
} > "$out"

echo "$out"

