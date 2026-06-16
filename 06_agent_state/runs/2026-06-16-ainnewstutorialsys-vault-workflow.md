# AINewsTutorialSys Vault Workflow - 2026-06-16

## Summary

Moved the user-facing AI news and creator inspiration workflow into the existing knowledge vault tooling.

`AINewsTutorialSys` remains the collector/processor engine. The existing `agentic-knowledge-vault` now provides the command entrypoint and owns cross-device sync.

## Changes

- Added `05_tools/ai_news_daily.sh` to the vault.
- Updated `05_tools/sync_all.sh` with optional `AI_NEWS_DAILY_ENABLED=true`.
- Updated the AI news systemd daily service to run the vault wrapper and then call the vault `sync_all.sh`.
- Disabled standalone AI-news Mac sync by default.
- Kept AI-news WebDAV sync optional but no longer part of the normal path.
- Hardened vault WebDAV helper scripts:
  - credential use goes through temporary curl config
  - root and `.` MKCOL are skipped
  - MKCOL is best-effort
  - `WEBDAV_CREATE_DIRS=false` is the default because the current server does not respond reliably to MKCOL
  - PUT uses timeout and retry flags

## Validation

- AI news tests: 46 tests OK.
- Vault wrapper dry-run on Ubuntu: OK, sync targets show `obsidian` enabled and `mac`/`webdav` disabled.
- Vault wrapper dry-run on Mac: OK, writes to `/Users/shx/agentic-knowledge-vault/03_outputs/ai-news`.
- Ubuntu user systemd `ai-news-daily.service` now points to `%h/agentic-knowledge-vault/05_tools/ai_news_daily.sh`.
- Mac vault has cleaned AI news output layout:
  - `03_outputs/ai-news/ai-daily`
  - `03_outputs/ai-news/ai-weekly`
  - `03_outputs/ai-news/review/ai-news`
  - `03_outputs/ai-news/review/ai-tutorials`
  - `03_outputs/ai-news/runs`
  - `03_outputs/ai-news/creator-ideas`

## WebDAV Status

The existing vault `sync_all.sh` was invoked and reached the configured endpoint at `10.106.106.2:5255`, but the server returned empty responses or timeouts for both MKCOL and PUT. This confirms the AI news workflow is now connected to the old sync path, but current WebDAV service health is a blocker for completing an upload from this host.

## Commits

- `StartHex/AINewsTutorialSys`: `cef05b5 Delegate AI news sync to vault`
- `StartHex/AINewsTutorialSys`: `aa249f6 Fix Obsidian review output paths`
- local `agentic-knowledge-vault`: `1f084ed Add AI news vault workflow`
