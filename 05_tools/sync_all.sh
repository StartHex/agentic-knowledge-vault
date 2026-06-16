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
DOC_INDEX_ENABLED="${DOC_INDEX_ENABLED:-true}"
AI_NEWS_DAILY_ENABLED="${AI_NEWS_DAILY_ENABLED:-false}"
AI_NEWS_DRY_RUN="${AI_NEWS_DRY_RUN:-false}"

if [[ "$SYNC_ENABLED" != "true" ]]; then
  echo "Sync disabled. Set SYNC_ENABLED=true in .sync.env to enable."
  exit 0
fi

echo "Sync enabled. Interval setting: ${SYNC_INTERVAL_SECONDS}s"

if [[ "$AI_NEWS_DAILY_ENABLED" == "true" ]]; then
  echo "Running AI news daily flow into this vault"
  AI_NEWS_DRY_RUN="$AI_NEWS_DRY_RUN" 05_tools/ai_news_daily.sh
else
  echo "AI news daily flow disabled; skipping"
fi

if [[ "$DOC_INDEX_ENABLED" == "true" ]]; then
  echo "Updating project documentation index"
  05_tools/index_project_docs.sh
else
  echo "Project documentation index disabled; skipping"
fi

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
