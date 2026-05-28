---
run_id: hermes-setup-2026-05-28-001
agent: Hermes
date: 2026-05-28
type: workspace-setup
status: completed
locks: []
---

# Run: Hermes 接入知识库

## 操作

1. 清理旧记忆系统（memory-os / memgate 插件 / mem-gateway-obsidian 目录）
2. 创建 Hermes 技能 `agentic-knowledge-vault`
3. 设置知识库为工作区根目录
4. 读取并确认 AGENTS.md 协议、HERMES.md、04_prompts/agent-handoff.md
5. 按 auto-capture policy 沉淀测试对话到 `02_wiki/syntheses/hermes-vault-setup-2026-05-28.md`

## 产出

- `02_wiki/syntheses/hermes-vault-setup-2026-05-28.md` — 测试对话沉淀
- `02_wiki/index.md` — 更新索引（含双链）
- `02_wiki/log.md` — 追加日志条目

## 状态

知识库已就绪，等待 ingest 或 query 操作。
