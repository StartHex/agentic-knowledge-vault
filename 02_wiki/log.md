# Knowledge Base Log

## 2026-05-28

- Initialized vault structure and agent protocol.
- Captured the initial setup conversation as [[Source - Conversation - Agentic Knowledge Vault Setup 2026-05-28]] and added [[Conversation Capture Workflow]].
- Added [[Automatic Conversation Capture]] as the default policy for meaningful agent sessions.
- Added the operating preference that repository changes should sync to GitHub, WebDAV, and Mac together.
- Fixed WebDAV upload exclusions so local environment files are not uploaded.
- Hermes 接入知识库（[[hermes-vault-setup-2026-05-28]]）: 清理旧 memory-os 系统，新建 agentic-knowledge-vault 技能，确认工作规则。
- Reviewed the Hermes auto-capture test and pulled the Mac-side result back into Git-managed history.
- Ingested [[Source - Agent Role Policy Test 2026-05-28]]: defined three-tier agent role policy (maintainer/editor/reader) with specific agent assignments. Updated [[Concept - Multi-Agent Vault Protocol]] and created [[Agent Role Policy 2026-05-28]] as a synthesis page.
- Reviewed the Claude Code ingest test and pulled the Mac-side result back into Git-managed history.
- Codex self-tested query/synthesis workflow by creating [[How Should Agent Changes Be Synchronized]] and recording `06_agent_state/runs/2026-05-28-codex-sync-query-self-test.md`.
- Made sync explicitly configurable with `.sync.env`; missing config disables sync and missing interval defaults to 7200 seconds.

## 2026-05-29

- Added native Windows PowerShell compatibility tools for filename/path validation and Markdown encoding normalization.
- Added UTF-8 normalization tooling for Markdown/text ingest, documented the encoding rule in AGENTS and ingest usage, and verified imported `github-devpor` documents are UTF-8.
- Added generated [[Project Documentation Index]] so project docs, paths, modified times, hashes, and current project root are searchable.
- Added [[How Should Project Documentation Be Indexed]] to document move handling, indexing limits, and remaining gaps.
- Added Windows compatibility checks, LF line-ending rules, and Windows setup documentation.
- Added [[How Should I Search the Knowledge Base]] with practical keywords for Obsidian and command-line search.
- Added [[How Should I Add Material to the Knowledge Base]] with source ingest, question search, and copywriting workflows.
- Imported `github-devpor` project documentation into [[Project - github-devpor]] and [[Source - github-devpor Project Documents]] after confirming it was missing from the knowledge base.

## 2026-06-04

- Queried vault records for device access information and noted that sensitive credentials should not be echoed in responses.

## 2026-06-06

- Queried Aliyun server connection records for `47.109.187.147`; found the current reference to Termark asset "阿里云R" and confirmed direct SSH from Ubuntu/Mac is blocked without the Termark asset or a valid private key. Public health endpoints remain reachable.
# 2026-06-11

- Added Windows short-video development host `10.106.106.30` and the current HyperFrames AI distill preview transfer workflow under [[Project - Short Video Production Environment]].
- Corrected the Windows host login to `shixu@10.106.106.30`, copied the AI distill HyperFrames project to `D:\AI\hyperframes-ai-distill-preview`, installed dependencies, verified Windows lint, and started persistent preview via scheduled task `HyperFramesAiDistillPreview` on `http://localhost:3028`.

# 2026-06-13

- Queried [[Project - Short Video Production Environment]] for Windows host access, started Wan2.2 under `D:\wuxian` via scheduled task `Wan22WuxianDirect`, verified Gradio `7861` and ComfyUI `8187`, and confirmed Gradio API control by calling `change_choices`.
- Ran a Wan2.2 Q-character first/last-frame video test through direct ComfyUI workflow submission after Gradio stateful queue automation proved unreliable headlessly; output was `codex_q_fflv_00001.mp4` at `704x368`, `32 fps`, about `4.03s`.

- Copied `windows-comfy-video-pipeline` and `video-transcribe` Codex skills to Mac `shx@10.106.106.5:/Users/shx/.codex/skills/`, excluding Linux venv/cache files, and verified Python script compilation on Mac.

# 2026-06-15

- Added [[Project - AI Creator Knowledge System]] and the detailed design document `03_outputs/plans/AI新闻教程知识库与灵感系统详细设计.md` for a Mac + Ubuntu AI news/tutorial collection system that maintains an AI handbook, creator idea queue, and monetization hypothesis workflow.
- Updated the AI creator knowledge system design with Tutorial Radar: daily tutorial collection, historical tutorial backfill, tutorial-specific data models, scoring, outputs, and commands.
- Revised the AI creator knowledge system design from phased MVP wording to a final-target architecture and complete development plan, including full collectors, review console, creator engine, monetization engine, feedback loop, sync layer, and operations plan.
- Prepared `/home/ubuntu/AINewsTutorialSys` as a local Git repository for `StartHex/AINewsTutorialSys`, added README, architecture design, development plan, starter config, and schemas, and created local commit `6cd4a17`. Push is pending safe GitHub credential configuration; no pasted token was stored or used.
- Pushed `/home/ubuntu/AINewsTutorialSys` to `StartHex/AINewsTutorialSys` using a repository-scoped SSH deploy key. Remote `LICENSE` initial commit was merged and preserved; latest pushed commit is `54ea9b7`.
- Started development on `StartHex/AINewsTutorialSys` and pushed commit `dfd2586`: added the runnable ingestion pipeline skeleton, config/schema validation, JSONL/audit helpers, RSS collection path, normalize/dedupe/review generation, final command entrypoints, and tests.
- Continued development on `StartHex/AINewsTutorialSys` and pushed commit `c3cb142`: added GitHub/arXiv/Hacker News collection adapters, enrichment/scoring/summarization, daily output generation, review apply, status/category/merge/outdated operations, manual import, and the daily CLI. Verified a live Ubuntu collection and raw-to-output flow.
- Pushed `f6b16e9` to `StartHex/AINewsTutorialSys`: added Tutorial Radar GitHub search collectors, verified Codex tutorial backfill into tutorial radar output, and added systemd, launchd, and GitHub Actions test helpers.
- Pushed `41c182b` to `StartHex/AINewsTutorialSys`: added Tgmeng hotlist and Tgmeng Index collectors based on the open platform docs, with environment-only licenses and a local quota guard set to QPM 60 / QPD 600.
- Pushed `ade933c` to `StartHex/AINewsTutorialSys`: added Attention Engine documentation and implementation with metrics fields, attention scoring, final score ranking, attention report output, and metrics mapping for Tgmeng/HN/GitHub.
- Pushed `abcf881` to `StartHex/AINewsTutorialSys`: removed the need for broad video platform crawling, documented the selected-video transcription workflow, and added `transcript_import.py` to ingest `video-transcribe` outputs into Tutorial Radar.
- Pushed `338422e` and completed the AI creator knowledge system workflow utilities: transcript fetch wrapper, content extraction, account performance ingestion, weekly review, sync health, Mac public-web collection, and final creator/manual/monetization outputs.
- Finalized remaining cleanup for `StartHex/AINewsTutorialSys`: removed skeleton markers, made transcript-missing handling explicit, verified tests and dry-runs, and confirmed no pasted GitHub/Tgmeng secrets are present in the repository or vault.
- Pushed `42adfb8` to `StartHex/AINewsTutorialSys`: added daily `today-actions` and `status` reports, split weekly review into content/manual/monetization reports, made raw collector/import writes idempotent, added `compact_raw.py`, and downgraded missing Tgmeng license to a blocker warning.
- Pushed `175a7f9` to `StartHex/AINewsTutorialSys`: added Redfox WeChat article collector with runtime `REDFOX_API_KEY`, verified the user-provided key works without storing it, and mapped high-read Chinese AI articles into normal news candidates.
- Pushed `f9a79dc` to `StartHex/AINewsTutorialSys`: expanded tutorial sources and runtime operations with env file loading, systemd `EnvironmentFile`, Mac CN public-web sources, public tutorial web sources, GitHub token/rate-limit handling, and daily script briefs.
- Pushed `e015523` to `StartHex/AINewsTutorialSys`: added Enterprise WeChat, Feishu, DingTalk, Slack, and generic webhook notifications plus environment health checks; verified the user-provided Enterprise WeChat webhook using a transient env value without storing it.
- Enabled local Ubuntu `ai-news-daily.timer`, persisted Enterprise WeChat notification env outside Git, and pushed `ddf2ee7` to `StartHex/AINewsTutorialSys` with a generated local HTML review console.
- Deployed `StartHex/AINewsTutorialSys` to the Mac collector host, installed launchd job `com.local.ai-news-cn-collect`, added Mac network health checks and public-web timeout isolation, verified launchd collected 39 CN raw items, reran the Ubuntu daily pipeline, and pushed `4e0c298`.
- Added Ubuntu-side Mac raw pull scheduling for `StartHex/AINewsTutorialSys`: `pull_mac_raw.py`, `ai-news-pull-mac.service`, and `ai-news-pull-mac.timer` now pull Mac CN raw output before the daily Ubuntu processing timer; pushed `e530c3f`.
- Added managed AI handbook maintenance for `StartHex/AINewsTutorialSys`: explicit `apply_to_vault.py --id`, managed Markdown blocks, idempotent re-apply, recategorization moves, and soft-delete block removal; pushed `9084aac`.
- Added interactive localhost review server for `StartHex/AINewsTutorialSys`: `cli.py server` / `review_server.py` exposes action buttons and local APIs for accept, archive, restore, delete, and recategorize; pushed `6590ead`.
- Updated the `StartHex/AINewsTutorialSys` review server default bind target to `10.106.106.80:9877`, leaving `10.106.106.80:8765` for the existing Codex status service; pushed `b02c276`.
- Installed and documented Ubuntu user systemd autostart for the `StartHex/AINewsTutorialSys` review panel with `ai-news-review-server.service` and an 08:40 UTC daily restart timer; verified `9877` works while `8765` remains the Codex status service; pushed `d6e553d`.
- Added batch review console actions for `StartHex/AINewsTutorialSys`: filters, visible-row selection, batch accept/archive/restore/delete, and `/api/batch_action`; pushed `6078fca`.
- Added account performance feedback for `StartHex/AINewsTutorialSys`: performance metrics now build topic preferences, `today-actions` includes Account Feedback and `account_fit`, and non-AI high-attention noise is capped as `off_topic`; pushed `ccd1fdf`.
- Added AI handbook index maintenance for `StartHex/AINewsTutorialSys`: managed wiki writes now refresh `02_wiki/domains/ai/index.md`, and `generate_handbook_index.py` can rebuild it manually; pushed `8b62269`.
- Added token protection for the `StartHex/AINewsTutorialSys` review panel APIs with private `AI_NEWS_REVIEW_TOKEN`; verified unauthenticated requests return 401 and authenticated requests return candidates; pushed `b10dc50`.
- Added same-topic clustering for `StartHex/AINewsTutorialSys`: daily output `YYYY-MM-DD-topic-clusters.md`, `generate_topic_clusters.py`, `cli.py clusters`, status integration, tests, docs, Mac sync, and pushed `ec8ade1`.
- Added merge and mark-outdated actions to the `StartHex/AINewsTutorialSys` review console and API; restarted the Ubuntu review service, verified token-protected API access, synced Mac, and pushed `74f374e`.
- Added modify support to the `StartHex/AINewsTutorialSys` review console and API: allowlisted field edits, `modify_item.py`, static console snippets, tests, docs, Mac sync, and pushed `66b2a0c`.
- Added review candidate listing for `StartHex/AINewsTutorialSys`: `list_items.py`, `cli.py list`, table/JSON/JSONL output, filters, tests, docs, Mac sync, and pushed `c3cca46`.
- Changed `StartHex/AINewsTutorialSys` timers to UTC+8 08:00 and 20:00 operating windows; installed Ubuntu systemd timer updates, reloaded Mac launchd triggers at 07:50/19:50, verified active schedules, and pushed `9b47480`.
- Added automatic outdated tutorial detection for `StartHex/AINewsTutorialSys`; integrated it into the daily flow before enrichment, verified 33 unit tests, dry-ran 269 tutorial candidates with 47 flagged, synced to Mac, and pushed `ad675ac`.
- Added daily run note generation for `StartHex/AINewsTutorialSys`; integrated `06_agent_state/runs/YYYY-MM-DD-daily-run.md` into the daily flow, exposed `run_note.py` and `cli.py run-note`, verified 34 unit tests and Mac dry-run, and pushed `e10fa18`.
- Added sync conflict note generation for `StartHex/AINewsTutorialSys`; exposed `conflict_note.py` and `cli.py conflict-note`, linked conflict recommendations from `sync_health.py`, verified 35 unit tests and Mac dry-run, and pushed `dbc23b1`.
- Added persistent creator idea backlog for `StartHex/AINewsTutorialSys`; integrated `generate_idea_backlog.py`, `cli.py backlog`, and daily output `YYYY-MM-DD-idea-backlog.md`, verified 36 unit tests and Mac dry-run, and pushed `53ad0f5`.
- Added creator idea backlog maintenance for `StartHex/AINewsTutorialSys`; `idea_backlog.py` and `cli.py backlog` can list/filter ideas, set audited status, and render the backlog report, verified 36 unit tests and Mac list command, and pushed `0d52ab7`.
- Added idea backlog controls to the `StartHex/AINewsTutorialSys` review server; the 9877 panel now lists idea backlog entries and can set open/parked/done/deleted status through token-protected APIs, verified 37 unit tests, Mac sync, and live 9877 HTML/API checks, and pushed `3675bd0`.
- Added a development-plan acceptance matrix for `StartHex/AINewsTutorialSys`; hardened Workstream A source/rule validation and Workstream F outdated handbook rendering, verified 39 unit tests, daily dry-run, Mac validation, and pushed `c397a46`.
- Completed the current `StartHex/AINewsTutorialSys` acceptance matrix; added collector quality gates and scoring/classification dimension hardening, verified 41 unit tests, daily dry-run, Mac validation, and pushed `f4d1fe5`.
- Added generated-output sync-back for `StartHex/AINewsTutorialSys`; `sync_outputs.py` now pushes daily reports, review candidates, run notes, and creator idea backlog to the Mac checkout, with optional WebDAV mirroring behind explicit env config. Verified 43 unit tests, real Mac output sync, Mac file visibility, Mac setup validation, and pushed `f6e24c6`.
- Merged `StartHex/AINewsTutorialSys` outputs into the existing Obsidian vault model; AI manual writes now target the detected vault `02_wiki/`, daily outputs mirror under `03_outputs/ai-news/`, the vault was synced to Mac at `~/agentic-knowledge-vault`, and pushed `eec6a97`.
- Added the AI news workflow to the existing knowledge vault tooling: `05_tools/ai_news_daily.sh` runs the `AINewsTutorialSys` engine into this vault, `sync_all.sh` can call it via `AI_NEWS_DAILY_ENABLED=true`, and standalone AI-news Mac/WebDAV sync is disabled by default. Verified Mac wrapper dry-run and cleaned the Mac `03_outputs/ai-news` layout. Existing WebDAV sync reached the configured endpoint but the server returned empty responses to MKCOL/PUT, so WebDAV service health remains a blocker outside the AI news integration.
- Added [[AI Tutorial Editing Playbook]] and [[AI Tutorial Psychology Playbook]] so collected AI tutorials can be reviewed for editing structure, viewer psychology, and reusable creator-account formats rather than only topic relevance.
- Added [[AI Tutorial Copywriting Playbook]], [[How Should I Use The Knowledge Base As Copywriting Assistant]], and `04_prompts/ai-copywriting-assistant.md` to make the vault usable as a copywriting assistant that distills high-performing videos and writing articles into reusable hooks, structures, proof patterns, and script review checks.
