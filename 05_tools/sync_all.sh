#!/usr/bin/env bash
set -euo pipefail

if [[ -f .webdav.env ]]; then
  # shellcheck disable=SC1091
  source .webdav.env
fi

if [[ -f .mac.env ]]; then
  # shellcheck disable=SC1091
  source .mac.env
fi

if [[ -f .sync.env ]]; then
  # shellcheck disable=SC1091
  source .sync.env
fi

SYNC_ENABLED="${SYNC_ENABLED:-false}"
SYNC_INTERVAL_SECONDS="${SYNC_INTERVAL_SECONDS:-7200}"
GIT_SYNC_ENABLED="${GIT_SYNC_ENABLED:-true}"
WEBDAV_SYNC_ENABLED="${WEBDAV_SYNC_ENABLED:-false}"
MAC_SYNC_ENABLED="${MAC_SYNC_ENABLED:-false}"

if [[ "$SYNC_ENABLED" != "true" ]]; then
  echo "Sync disabled. Set SYNC_ENABLED=true in .sync.env to enable."
  exit 0
fi

echo "Sync enabled. Interval setting: ${SYNC_INTERVAL_SECONDS}s"

if [[ "$GIT_SYNC_ENABLED" == "true" ]] && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch="$(git branch --show-current)"
  upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"

  if [[ -n "$upstream" ]]; then
    echo "Pushing Git branch $branch -> $upstream"
    git push
  else
    echo "No Git upstream configured for $branch; skipping git push" >&2
  fi
else
  echo "Git sync disabled or not a Git work tree; skipping Git"
fi

if [[ "$WEBDAV_SYNC_ENABLED" == "true" && -n "${WEBDAV_URL:-}" && -n "${WEBDAV_USER:-}" && -n "${WEBDAV_PASS:-}" ]]; then
  echo "Syncing WebDAV"
  05_tools/webdav_push.sh
else
  echo "WebDAV sync disabled or environment is incomplete; skipping WebDAV" >&2
fi

if [[ "$MAC_SYNC_ENABLED" == "true" && -n "${MAC_SSH_HOST:-}" && -n "${MAC_SSH_USER:-}" && -n "${MAC_VAULT_PATH:-}" ]]; then
  echo "Syncing Mac: $MAC_SSH_USER@$MAC_SSH_HOST:$MAC_VAULT_PATH"
  ssh "$MAC_SSH_USER@$MAC_SSH_HOST" "mkdir -p \"\$HOME\" && mkdir -p \"${MAC_VAULT_PATH//\"/\\\"}\""
  rsync -av --delete \
    --exclude='.git/' \
    --exclude='.env' \
    --exclude='.sync.env' \
    --exclude='.webdav.env' \
    --exclude='.mac.env' \
    ./ "$MAC_SSH_USER@$MAC_SSH_HOST:$MAC_VAULT_PATH/"
else
  echo "Mac sync disabled or environment is incomplete; skipping Mac" >&2
fi
