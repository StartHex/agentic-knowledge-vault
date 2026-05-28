---
type: synthesis
created: 2026-05-28
source: test-conversation (Hermes / Feishu)
tags: [hermes, vault-setup, workspace-config]
status: captured
---

# Hermes + agentic-knowledge-vault 接入记录

## 概要

2026-05-28 测试对话：将 Hermes Agent 接入 agentic-knowledge-vault，作为知识库 editor agent。

## 操作记录

1. **清理旧记忆系统** — 移除了之前安装的 memory-os（mem-gateway-obsidian）MCP 服务器、memgate 插件、代码目录 `~/mem-gateway-obsidian/`。vault 数据目录 `~/my-memory/` 保留未删。
2. **新建 Hermes 技能** — 创建技能 `agentic-knowledge-vault`（`~/.hermes/skills/knowledge/agentic-knowledge-vault/SKILL.md`）
3. **设置工作区根目录** — 将 `/Users/shx/Documents/Obsidian Vault/agentic-knowledge-vault/` 设为当前工作区
4. **读取协议文件** — 已读取 AGENTS.md、HERMES.md、02_wiki/index.md、04_prompts/agent-handoff.md

## 确立的工作规则

| 规则 | 内容 |
|------|------|
| 角色 | editor agent（默认），maintainer 需显式授权 |
| 01_raw/ | 不修改，只读 |
| 新知识 | 写入 02_wiki/ |
| 输出成果 | 写入 03_outputs/ |
| 链接 | 使用 Obsidian `[[双链]]` |
| 索引 | 重要修改后更新 02_wiki/index.md |
| 日志 | ingest/query/lint/批量修改后追加 02_wiki/log.md |
| 锁定 | 批量修改前检查/创建 06_agent_state/locks/ |
| 运行记录 | 完成后写 06_agent_state/runs/ |
| 删除 | 不删页除非明确要求 |
| 不确定性 | 证据不足时标记 `[uncertain]` |
| 沉淀 | 每次有实质内容的对话按 auto-capture policy 轻量沉淀 |

## 后续待办

- 知识库已完成基础初始化、自动沉淀策略、GitHub/WebDAV/Mac 同步策略和 Hermes 接入测试
- 后续可通过 `00_inbox/` 导入新素材，走 ingest workflow
