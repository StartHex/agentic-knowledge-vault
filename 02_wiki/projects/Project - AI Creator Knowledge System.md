# Project - AI Creator Knowledge System

## Summary

AI Creator Knowledge System is a planned workflow for collecting AI news and tutorials across Mac and Ubuntu, maintaining a categorized AI handbook, and turning both new updates and historical high-quality tutorials into creator ideas and monetization hypotheses.

## Design

- Detailed design: [[AI新闻教程知识库与灵感系统详细设计]]
- Repository target: `https://github.com/StartHex/AINewsTutorialSys`
- Local prepared repository: `/home/ubuntu/AINewsTutorialSys`
- Initial local commit: `6cd4a17 Add AI news tutorial system design plan`
- Pushed commit: `54ea9b7 Merge remote-tracking branch 'origin/main'`
- Development commit: `dfd2586 Add runnable ingestion pipeline skeleton`
- Development commit: `c3cb142 Add enrichment outputs and review maintenance flow`
- Development commit: `f6b16e9 Add tutorial search collectors and deployment helpers`
- Development commit: `41c182b Add Tgmeng hotlist and index collectors`
- Development commit: `ade933c Add attention metrics scoring and report`
- Development commit: `abcf881 Add video transcript import workflow`
- Development commit: `338422e Complete workflow utilities and transcript wrapper`
- Development commit: `7c63996 Remove remaining skeleton markers`
- Development commit: `42adfb8 Add daily operations reports and idempotent raw ingestion`
- Development commit: `175a7f9 Add Redfox WeChat article collector`
- Development commit: `f9a79dc Expand tutorial sources and runtime operations`
- Development commit: `e015523 Add webhook notifications and environment health checks`
- Development commit: `6efac10 Use UTC+8 timestamps in notifications`
- Development commit: `ddf2ee7 Add local HTML review console`
- Development commit: `4e0c298 Harden Mac collection deployment`
- Development commit: `e530c3f Add Mac raw pull scheduling`
- Development commit: `9084aac Add managed knowledge base maintenance`
- Development commit: `6590ead Add interactive local review server`
- Development commit: `b02c276 Bind review server to overlay IP`
- Development commit: `d6e553d Add review server autostart service`
- Development commit: `6078fca Add batch review console actions`
- Development commit: `ccd1fdf Use performance feedback in action priorities`
- Development commit: `8b62269 Add AI handbook index maintenance`
- Development commit: `b10dc50 Protect review server APIs with token`
- Development commit: `ec8ade1 Add topic clustering report`
- Development commit: `74f374e Add merge and outdated review actions`
- Development commit: `66b2a0c Add modify review action`
- Development commit: `c3cca46 Add review item listing command`
- Development commit: `9b47480 Schedule AI news jobs twice daily UTC+8`
- Development commit: `ad675ac Add tutorial outdated detection`
- Development commit: `e10fa18 Add daily run note generator`
- Development commit: `dbc23b1 Add sync conflict note generator`
- Development commit: `53ad0f5 Add persistent creator idea backlog`
- Development commit: `0d52ab7 Add creator idea backlog maintenance`
- Development commit: `3675bd0 Add idea backlog controls to review server`
- Development commit: `c397a46 Add acceptance matrix and harden config validation`
- Development commit: `f4d1fe5 Complete collector and scoring acceptance items`
- Development commit: `f6e24c6 Add output sync back to Mac`
- Development commit: `eec6a97 Merge AI outputs into Obsidian vault`

## Current Scope

- The design targets the final system directly rather than a reduced MVP.
- Mac collects domestic Chinese AI sources.
- Ubuntu collects global sources such as official blogs, GitHub, arXiv, Hacker News, and selected video transcription imports.
- News Radar tracks daily AI changes.
- Tutorial Radar collects both new tutorials and historical high-quality tutorials by topic, such as Codex, OpenClaw, AI agents, ComfyUI, AI video, and AI automation.
- A unified processor deduplicates, classifies, summarizes, and generates a daily review.
- Knowledge updates are review-first before being written into the wiki.
- The system outputs daily AI briefs, tutorial radar reports, creator ideas, manual update suggestions, monetization hypotheses, today action plans, and pipeline status reports.
- The final system also includes weekly content/manual/monetization reviews, account performance feedback, outdated content detection, merge/delete/recovery workflows, and monetization opportunity reports.

## Creator Craft Knowledge

- [[AI Tutorial Editing Playbook]] — reusable editing structures for turning AI news/tutorial items into watchable practical content.
- [[AI Tutorial Psychology Playbook]] — audience psychology, persuasion principles, and topic-selection lenses for AI tutorial content.
- [[AI Tutorial Copywriting Playbook]] — reusable hook, structure, proof, and CTA patterns distilled from high-performing videos and copywriting articles.
- [[How Should I Use The Knowledge Base As Copywriting Assistant]] — operating workflow for turning the vault into a script/article assistant.

These pages should be used when reviewing collected tutorials from large creators: extract the repeatable mechanism, link the source note, and adapt the lesson into the account's own AI handbook format.

## Repository Status

- 2026-06-15: Prepared a local Git repository with README, architecture design, development plan, starter config, and JSON schemas.
- 2026-06-15: Pushed to GitHub using a repository-scoped SSH deploy key after write access was enabled. The remote `LICENSE` initial commit was merged and preserved.
- 2026-06-15: Started development with a runnable Python core: config/schema loading, JSONL helpers, audit log, RSS collector path, raw-to-review pipeline, command entrypoints, and unit tests.
- 2026-06-15: Continued development toward the final system: added GitHub/arXiv/Hacker News adapters, rule-based enrichment/scoring/summarization, daily outputs, review apply, item maintenance operations, manual import, and an end-to-end CLI. A live Ubuntu collection run produced 180 raw items, 168 deduped candidates, review Markdown, and daily output files.
- 2026-06-15: Added GitHub tutorial search collection for Tutorial Radar, verified a Codex tutorial backfill, and added Ubuntu systemd, Mac launchd, and GitHub Actions test helpers.
- 2026-06-15: Added Tgmeng hotlist and Tgmeng Index collection using environment-provided `TGMENG_LICENSES`, local `QPM=60` / `QPD=600` quota guard, and no key persistence.
- 2026-06-15: Added Attention Engine design and implementation: unified metrics fields, attention scoring, final score ranking, attention report output, and metrics mapping for Tgmeng, Hacker News, and GitHub tutorial repositories.
- 2026-06-15: Changed video strategy from platform-scale crawling to selected-video transcription import. Added `transcript_import.py` and transcription workflow docs using the existing Codex `video-transcribe` skill or external subtitle tools.
- 2026-06-15: Completed workflow utilities for content extraction, selected-video transcript fetching/import, account performance ingestion, weekly review, sync health checks, creator idea generation, manual update suggestions, monetization hypotheses, and Mac public-web source collection.
- 2026-06-15: Removed remaining skeleton wording and verified the runnable package with unit tests, compile checks, daily dry-run, weekly dry-run, sync-health dry-run, content extraction dry-run, transcript wrapper dry-run, and sensitive-token scans.
- 2026-06-15: Added daily operations reports and raw-ingestion hardening: `today-actions`, `status`, weekly content/manual/monetization report split, idempotent raw writes, `compact_raw.py`, and Tgmeng missing-license blocker handling.
- 2026-06-15: Added Redfox WeChat article collection using runtime `REDFOX_API_KEY`, with article title, WeChat URL, author/account, read count, likes, comments, keyword, and result-count metrics mapped into `redfox_gzh` news items.
- 2026-06-15: Expanded runtime operations and tutorial collection: local env loading, systemd environment file support, Mac CN public-web sources, public tutorial web sources, GitHub token/rate-limit handling, and daily short-video script briefs.
- 2026-06-15: Added Enterprise WeChat and multi-webhook notification support plus runtime environment health checks for Tgmeng, Redfox, GitHub, YouTube, WebDAV, and notification variables.
- 2026-06-15: Enabled Ubuntu user systemd daily timer locally, persisted Enterprise WeChat notification settings in private env, and added a local HTML review console for searching/filtering candidates and copying maintenance commands.
- 2026-06-15: Deployed the Mac collector to `~/AINewsTutorialSys`, installed launchd job `com.local.ai-news-cn-collect`, added Mac DNS/HTTP health checks, added per-source public-web process timeouts, made `jsonschema` optional for stock macOS Python, and verified launchd collection produced 39 CN raw items that were synced back into the Ubuntu daily pipeline. See run note `06_agent_state/runs/2026-06-15-ainnewstutorialsys-mac-deploy.md`.
- 2026-06-15: Added Ubuntu `pull_mac_raw.py` and enabled `ai-news-pull-mac.timer` at 08:15 UTC so Mac CN raw output is pulled before the 08:25 UTC Ubuntu daily timer.
- 2026-06-15: Added managed AI handbook maintenance: `apply_to_vault.py --id` now accepts explicit review console item ids, accepted items write managed Markdown blocks, re-apply updates existing blocks, recategorization moves blocks to new target pages, and soft deletion removes handbook blocks while preserving source notes and audit history.
- 2026-06-15: Added a localhost interactive review server: `cli.py server` / `review_server.py` serves review items and action buttons for accept, archive, restore, delete, and recategorize, backed by the managed handbook maintenance service.
- 2026-06-15: Changed the review server default bind target to `10.106.106.80:9877` because `10.106.106.80:8765` is already used by the Codex status service.
- 2026-06-15: Installed and enabled Ubuntu user systemd autostart for `ai-news-review-server.service` plus a daily 08:40 UTC restart timer so the review panel starts on login/boot and refreshes after daily processing.
- 2026-06-15: Added batch review console actions: source/category/status/min-score filters, visible-row selection, batch accept/archive/restore/delete, and backend `/api/batch_action` support.
- 2026-06-15: Added account performance feedback into daily priorities: imported metrics now build topic preferences, `today-actions` includes Account Feedback and `account_fit`, and high-attention low-AI-relevance items are capped as `off_topic`.
- 2026-06-15: Added AI handbook index maintenance: accepted/deleted/recategorized managed blocks now refresh `02_wiki/domains/ai/index.md`, and `generate_handbook_index.py` can rebuild the page manually.
- 2026-06-15: Added review panel API token protection using private `AI_NEWS_REVIEW_TOKEN`; unauthenticated API requests return 401 while token-authenticated requests continue to work. The token is stored only in local private env, not Git or vault.
- 2026-06-15: Added same-topic clustering for daily news/tutorial candidates. The Ubuntu daily flow now writes `YYYY-MM-DD-topic-clusters.md`, the unified CLI exposes `cli.py clusters`, status checks include the new output, and the implementation was synced to the Mac collector host after tests passed.
- 2026-06-15: Completed the review console maintenance action set by adding merge and mark-outdated support to the interactive server APIs, buttons, static command console, tests, docs, Mac sync, and the running Ubuntu review service.
- 2026-06-15: Added the missing modify review action. The interactive review server can now edit allowed candidate fields through JSON, `modify_item.py` supports command-line edits, static review console snippets include modify commands, and the Ubuntu review service plus Mac copy were updated.
- 2026-06-16: Added `list_items.py` and `cli.py list` for terminal review workflows. Candidates can now be filtered by type, status, category, source, score, and query, then printed as a compact table, JSON, or JSONL for maintenance pipelines.
- 2026-06-16: Changed scheduled execution to UTC+8 08:00 and 20:00 operating windows. Mac launchd now collects at local Beijing time 07:50 and 19:50; Ubuntu pulls Mac raw output at UTC 00:15/12:15, runs processing at 00:25/12:25, and refreshes the review server at 00:40/12:40.
- 2026-06-16: Added automatic tutorial outdated detection before enrichment. The detector uses tutorial age, deprecated/breaking-change wording, version-specific hints, and volatile API/UI/setup surfaces to set `freshness_score`, `still_valid`, `outdated_signals`, and `outdated_reason`; dry-run on 2026-06-15 tutorial candidates checked 269 items and flagged 47.
- 2026-06-16: Added daily run note generation. Full daily runs now include `06_agent_state/runs/YYYY-MM-DD-daily-run.md` with counts, outputs, failures, blockers, and status warnings; `run_note.py` and `cli.py run-note` can regenerate the note manually.
- 2026-06-16: Added sync conflict note generation. `conflict_note.py` and `cli.py conflict-note` write `06_agent_state/runs/YYYY-MM-DD-sync-conflicts.md` with conflict files, likely peers, and merge recommendations; `sync_health.py` now links the note when conflict-like files are detected.
- 2026-06-16: Added persistent creator idea backlog. Daily processing now writes `03_outputs/ai-daily/YYYY-MM-DD-idea-backlog.md` and maintains `06_agent_state/creator-ideas/backlog.jsonl`, deduplicating repeated source signals and preserving idea status across days.
- 2026-06-16: Added creator idea backlog maintenance commands. `idea_backlog.py` and `cli.py backlog` now support listing, filtering, status changes (`open`, `parked`, `done`, `deleted`), audited status reasons, and report rendering from current backlog state.
- 2026-06-16: Added creator idea backlog controls to the interactive review server. The `10.106.106.80:9877` panel now includes a token-protected idea backlog section plus `/api/ideas` and `/api/idea_status` for listing and changing idea status.
- 2026-06-16: Added `docs/acceptance-matrix.md` based on `docs/development-plan.md`. Workstream A was hardened with actionable invalid source/rule validation, and Workstream F now renders outdated validity/reason/signals into handbook blocks and source notes.
- 2026-06-16: Completed the remaining acceptance-matrix items. Workstream B now has collector output quality gates and audit warnings; Workstream D now has news dimension scores, manual target suggestions, off-topic manual target clearing, and tutorial format inference. The matrix now marks A-H as done.
- 2026-06-16: Added Ubuntu generated-output sync-back. Daily processing now syncs human-readable reports, review candidates, run notes, and the creator idea backlog back to the Mac checkout with `sync_outputs.py`, while excluding raw crawl data, credentials, cookies, browser profiles, and env files. WebDAV mirroring uses the same output list but remains opt-in through `AI_NEWS_SYNC_WEBDAV_OUTPUTS=1`.
- 2026-06-16: Merged AI news outputs into the existing Obsidian vault model. `AINewsTutorialSys` remains the collector/processor project, while `~/agentic-knowledge-vault` is the Obsidian vault. AI handbook writes target the vault's `02_wiki/`, and generated reports mirror to `03_outputs/ai-news/`. Synced the vault to Mac at `/Users/shx/agentic-knowledge-vault` and verified `.obsidian` plus AI news daily outputs are present.
- 2026-06-16: Added a vault-level AI news workflow wrapper. The old knowledge vault now owns the user-facing AI news/creator inspiration command via `05_tools/ai_news_daily.sh`; `05_tools/sync_all.sh` can optionally run it with `AI_NEWS_DAILY_ENABLED=true`, and cross-device sync remains owned by the existing vault sync flow. Standalone AI-news Mac/WebDAV sync is disabled by default.

## Safety Notes

- Use RSS, official APIs, public pages, authorized login sessions, and manual verification.
- Do not design bypasses for CAPTCHA, access controls, paywalls, or anti-abuse systems.
- Keep cookies, browser profiles, API keys, and account credentials out of Git and vault sync.
