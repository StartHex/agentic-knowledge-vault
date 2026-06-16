#!/usr/bin/env bash
set -euo pipefail

vault_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -f "$vault_root/.sync.env" ]]; then
  # shellcheck disable=SC1091
  source "$vault_root/.sync.env"
fi

if [[ -f "$HOME/.config/ai-news/env" ]]; then
  # shellcheck disable=SC1090
  source "$HOME/.config/ai-news/env"
fi

project_root="${AI_NEWS_PROJECT_ROOT:-$HOME/AINewsTutorialSys}"
run_date="${AI_NEWS_RUN_DATE:-today}"
dry_run="${AI_NEWS_DRY_RUN:-false}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project-root)
      project_root="$2"
      shift 2
      ;;
    --date)
      run_date="$2"
      shift 2
      ;;
    --dry-run)
      dry_run="true"
      shift
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

if [[ ! -f "$project_root/05_tools/ai_news/cli.py" ]]; then
  echo "AI news project not found: $project_root" >&2
  exit 1
fi

export AI_NEWS_OBSIDIAN_VAULT_ROOT="$vault_root"
export AI_NEWS_SYNC_OBSIDIAN_OUTPUTS=1
export AI_NEWS_SYNC_MAC_OUTPUTS=0
export AI_NEWS_SYNC_WEBDAV_OUTPUTS=0

args=(daily --root "$project_root" --date "$run_date")
if [[ "$dry_run" == "true" ]]; then
  args+=(--dry-run --no-notify)
fi

python3 "$project_root/05_tools/ai_news/cli.py" "${args[@]}"
