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

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch="$(git branch --show-current)"
  upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"

  if [[ -n "$upstream" ]]; then
    echo "Pushing Git branch $branch -> $upstream"
    git push
  else
    echo "No Git upstream configured for $branch; skipping git push" >&2
  fi
fi

if [[ -n "${WEBDAV_URL:-}" && -n "${WEBDAV_USER:-}" && -n "${WEBDAV_PASS:-}" ]]; then
  echo "Syncing WebDAV"
  05_tools/webdav_push.sh
else
  echo "WebDAV environment is incomplete; skipping WebDAV" >&2
fi

if [[ -n "${MAC_SSH_HOST:-}" && -n "${MAC_SSH_USER:-}" && -n "${MAC_VAULT_PATH:-}" ]]; then
  echo "Syncing Mac: $MAC_SSH_USER@$MAC_SSH_HOST:$MAC_VAULT_PATH"
  ssh "$MAC_SSH_USER@$MAC_SSH_HOST" "mkdir -p \"\$HOME\" && mkdir -p \"${MAC_VAULT_PATH//\"/\\\"}\""
  rsync -av --delete \
    --exclude='.git/' \
    --exclude='.webdav.env' \
    --exclude='.mac.env' \
    ./ "$MAC_SSH_USER@$MAC_SSH_HOST:$MAC_VAULT_PATH/"
else
  echo "Mac environment is incomplete; skipping Mac sync" >&2
fi

