#!/usr/bin/env bash
set -euo pipefail

if [[ -f .sync.env ]]; then
  # shellcheck disable=SC1091
  source .sync.env
fi

SYNC_ENABLED="${SYNC_ENABLED:-false}"
SYNC_INTERVAL_SECONDS="${SYNC_INTERVAL_SECONDS:-7200}"

if [[ "$SYNC_ENABLED" != "true" ]]; then
  echo "Sync disabled. Set SYNC_ENABLED=true in .sync.env to enable."
  exit 0
fi

while true; do
  echo "Running sync at $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  05_tools/sync_all.sh
  echo "Sleeping for ${SYNC_INTERVAL_SECONDS}s"
  sleep "$SYNC_INTERVAL_SECONDS"
done

