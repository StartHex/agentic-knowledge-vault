# Codex + Obsidian 个人知识库设计文档

> 版本：v0.1  
> 日期：2026-05-28  
> 参考方案：https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f

## 1. 目标

搭建一个以 Obsidian 为浏览、编辑和知识图谱界面，以 Codex 为主要维护 agent 的个人知识库。知识库需要支持：

- 长期积累个人资料、笔记、网页、论文、书摘、会议纪要和项目资料。
- 让 AI agent 按统一规则读取、整理、链接、总结和维护知识。
- 后续可接入 Claude Code、Hermes、OpenClaw 等其他 agent。
- 所有知识以 Markdown 文件为核心资产，避免被单一 App、数据库或模型绑定。
- 通过 Git 管理变更，支持审查、回滚、分支和迁移。

## 2. 核心理念

参考 Karpathy 的方案，本知识库不把 AI 仅当作问答工具，而是把 AI 当作知识库维护者。

整体分为三层：

1. 原始资料层：保存未加工资料，作为事实来源。
2. Wiki 知识层：由 agent 消化、重组、链接后的 Markdown 知识网络。
3. 输出层：从知识层生成文章、报告、方案、复盘、演示稿等成果。

Obsidian 的职责是提供本地 Markdown 编辑、双链、图谱、检索和人工审查体验。Codex 的职责是按协议批量处理文件、维护链接、生成结构化页面、记录变更并执行检查。

## 3. 推荐目录结构

```text
KnowledgeVault/
  AGENTS.md
  CLAUDE.md
  README.md

  00_inbox/
  01_raw/
    articles/
    books/
    papers/
    transcripts/
    meetings/
    assets/

  02_wiki/
    index.md
    log.md
    concepts/
    people/
    projects/
    domains/
    questions/
    syntheses/
    source-notes/
    contradictions/

  03_outputs/
    essays/
    reports/
    slides/
    plans/

  04_prompts/
    ingest.md
    query.md
    lint.md
    weekly-review.md
    source-audit.md

  05_tools/
    kb_search.sh
    lint_links.sh
    export_context.sh

  06_agent_state/
    locks/
    runs/
    decisions/

  07_sync/
    README.md
    device-policy.md
    conflict-log.md

  .obsidian/
  .gitignore
```

## 4. 目录职责

### 4.1 `00_inbox/`

临时收集区。所有未处理资料先进入这里，包括网页剪藏、临时想法、PDF、语音转写、图片 OCR、会议记录等。

Agent 的 ingest 工作流可以从这里读取资料，处理完成后将资料归档到 `01_raw/`，并在 `02_wiki/` 生成对应 source note 和概念页。

### 4.2 `01_raw/`

原始资料区，只读。任何 agent 不应修改这里的内容。

建议规则：

- 文件名尽量包含日期、来源和主题。
- PDF、图片、网页正文、转写稿都保留原始版本。
- 如果资料来自网页，应保存 URL、抓取日期和正文。
- 不在 raw 层做大量总结或改写。

示例：

```text
01_raw/articles/2026-05-28-karpathy-llm-os-for-pk.md
01_raw/papers/2024-example-paper.pdf
01_raw/meetings/2026-05-28-product-sync.md
```

### 4.3 `02_wiki/`

核心知识层，由 agent 和人共同维护。这里不是资料堆放区，而是经过整理后的知识网络。

推荐页面类型：

- `concepts/`：概念、方法、框架、理论。
- `people/`：人物、作者、联系人。
- `projects/`：个人项目、产品、研究方向。
- `domains/`：领域总览，例如 AI agent、投资、教育、写作。
- `questions/`：长期问题和已回答问题。
- `syntheses/`：跨资料综合、阶段性结论。
- `source-notes/`：每个原始资料对应的结构化笔记。
- `contradictions/`：冲突观点、未决问题、证据不足的判断。

### 4.4 `03_outputs/`

输出成果区。文章、报告、商业计划、演讲稿、课程大纲等放在这里。

原则：输出可以引用 wiki，但不要把输出当成事实来源。若输出中产生了新的稳定洞察，应反向沉淀回 `02_wiki/`。

### 4.5 `04_prompts/`

保存稳定任务提示词，避免每次重新口述工作流。

建议至少包含：

- `ingest.md`：处理新资料。
- `query.md`：回答问题并沉淀结果。
- `lint.md`：检查知识库质量。
- `weekly-review.md`：周度复盘。
- `source-audit.md`：来源可信度审查。

### 4.6 `05_tools/`

本地脚本区。初期可以为空，后续逐步加入搜索、断链检查、导出上下文、统计等工具。

不要一开始引入复杂数据库或向量服务。Markdown + Git + Obsidian + Codex 足够支撑早期使用。

### 4.7 `06_agent_state/`

多 agent 协作状态区。用于避免多个 agent 同时修改同一批文件时出现冲突。

建议用途：

- `locks/`：简单锁文件，标记某 agent 正在处理的资料或页面。
- `runs/`：每次 agent 运行的摘要。
- `decisions/`：重要结构调整、命名规范、合并决策的记录。

这部分是原方案中容易被忽略但对多 agent 很重要的补充。

### 4.8 `07_sync/`

跨设备同步策略区，不存放同步工具自己的数据库，而是记录人的决策和同步事故。

建议用途：

- `README.md`：当前同步拓扑、WebDAV 服务、各设备路径。
- `device-policy.md`：Mac、Windows、Linux 服务器分别承担什么角色。
- `conflict-log.md`：记录同步冲突、恢复方式和经验。

不要把 WebDAV 客户端的缓存、锁文件或插件内部状态放进这里。

## 5. Agent 协议设计

`AGENTS.md` 是 Codex 的主要入口，也是所有 agent 的统一工作协议。其他 agent 专属文件应尽量引用 `AGENTS.md`，不要复制一套独立规则。

### 5.1 `AGENTS.md` 建议内容

```md
# Personal Knowledge Base Agent Protocol

## Roles
- Human owns source selection, priorities, and final judgment.
- Agent owns wiki maintenance, linking, summaries, contradiction tracking, and logs.

## Directory Rules
- Never modify `01_raw/`.
- Write synthesized knowledge only under `02_wiki/`.
- Put generated deliverables under `03_outputs/`.
- Update `02_wiki/index.md` after every meaningful edit.
- Append to `02_wiki/log.md` after every ingest, query, lint, or major rewrite.

## Ingest Workflow
1. Read the new source from `00_inbox/` or `01_raw/`.
2. Create or update one source note under `02_wiki/source-notes/`.
3. Update relevant concept, person, project, domain, question, or synthesis pages.
4. Add backlinks using Obsidian `[[Page Name]]` syntax.
5. Record contradictions or uncertainty explicitly.
6. Update `02_wiki/index.md`.
7. Append one log entry.

## Query Workflow
1. Search `02_wiki/index.md` first.
2. Read relevant wiki pages.
3. Use raw sources only when verification is needed.
4. Answer with links to wiki pages and source notes.
5. If the answer is reusable, create or update a page under `02_wiki/questions/` or `02_wiki/syntheses/`.

## Lint Workflow
Check for:
- orphan pages
- stale claims
- missing backlinks
- duplicated concepts
- unresolved contradictions
- pages without source references
- inconsistent frontmatter

## Safety
- Do not delete pages without human confirmation.
- Do not rewrite large areas without first summarizing the intended change.
- Prefer small, reviewable commits.
- If source evidence is weak, mark the claim as uncertain.
```

### 5.2 多 agent 入口文件

建议新增：

```text
CLAUDE.md
HERMES.md
OPENCLAW.md
```

这些文件只做适配，不重复规则。

示例 `CLAUDE.md`：

```md
# Claude Code Instructions

This vault follows the shared protocol in `AGENTS.md`.

Before editing:
1. Read `AGENTS.md`.
2. Read `02_wiki/index.md`.
3. Follow the ingest/query/lint workflows exactly.
```

## 6. 页面模板

### 6.1 概念页

```md
---
type: concept
status: active
updated: 2026-05-28
sources: 0
tags: [concept]
---

# Concept Name

## Summary

一句话说明这个概念。

## Key Points

- ...

## Related

- [[Other Concept]]

## Evidence

- [[Source - Example]]

## Open Questions

- ...

## Change Notes

- 2026-05-28: Created.
```

### 6.2 Source Note

```md
---
type: source-note
source_type: article
raw_path: 01_raw/articles/example.md
created: 2026-05-28
source_url:
---

# Source - Title

## Bibliographic Info

- Author:
- Date:
- URL:
- Captured:

## Summary

...

## Claims

- ...

## Useful Quotes

短引文即可，不整篇复制。

## Links Created

- [[Concept A]]
- [[Project B]]

## Reliability Notes

- ...
```

### 6.3 问题页

```md
---
type: question
status: open
updated: 2026-05-28
tags: [question]
---

# Question

## Current Answer

...

## Evidence

- [[Source - Example]]

## Competing Views

- ...

## Next Checks

- ...
```

## 7. 常用工作流

### 7.1 新资料处理

用户指令示例：

```text
处理 00_inbox/xxx.md，按 AGENTS.md 的 ingest workflow 更新知识库。
```

Agent 执行：

1. 读取资料。
2. 归档或引用原始资料。
3. 创建 source note。
4. 更新相关概念页、项目页、人物页。
5. 建立 Obsidian 双链。
6. 更新 `index.md`。
7. 写入 `log.md`。

### 7.2 问题回答与沉淀

用户指令示例：

```text
基于 02_wiki 回答这个问题；如果答案有长期价值，写入 questions/。
```

Agent 执行：

1. 先查 `index.md`。
2. 再查相关 wiki 页。
3. 必要时回查 raw。
4. 输出答案。
5. 将可复用答案沉淀为 question 或 synthesis 页面。

### 7.3 周度维护

用户指令示例：

```text
对 02_wiki 做一次 weekly review，找重复、孤立、冲突和缺失链接。
```

Agent 执行：

1. 检查孤立页面。
2. 合并重复概念建议。
3. 标记证据不足的页面。
4. 更新 index。
5. 生成本周新增主题和下一步阅读建议。

## 8. Obsidian 配置建议

初期建议少装插件，避免系统过早复杂化。

推荐：

- Obsidian Web Clipper：网页收集。
- Dataview：基于 YAML frontmatter 做动态列表。
- Git：管理版本，也可以用命令行替代。
- Canvas：做主题地图。
- Excalidraw：画思维图和结构图。
- Marp：从 Markdown 生成演示稿。

建议先关闭或延后：

- 复杂自动同步插件。
- 多个 AI 插件同时写入同一 vault。
- 未审查的自动批量重命名插件。

## 9. Git 与同步策略

必须使用 Git。

建议：

- `main` 分支保存稳定知识库。
- 每次大规模整理开新分支。
- Agent 每次批量修改后提供 diff 摘要。
- 不让多个 agent 同时在同一分支做大规模修改。

同步方式：

1. 单设备起步：本地 Git 即可。
2. 多设备：GitHub private repo、GitLab private repo 或自建 Git。
3. Obsidian Sync 可用于设备同步，但 Git 仍负责审查和回滚。

## 10. 跨系统部署与 WebDAV 同步设计

目标部署环境：

- Linux 远程服务器：长期在线，适合作为 agent 运行环境、备份节点、定时维护节点。
- 本地 Mac：主要阅读、写作、整理和 Obsidian 使用环境。
- 本地 Windows：辅助阅读、编辑和资料收集环境。
- WebDAV 服务：多端文件同步中心。

### 10.1 推荐拓扑

推荐采用：

```text
Mac Obsidian 本地 Vault
        ↕
      WebDAV
        ↕
Windows Obsidian 本地 Vault
        ↕
Linux Server 工作副本
        ↕
Git Remote / Git Snapshot
```

职责划分：

- WebDAV 负责把 Markdown、附件和 Obsidian 配置同步到多端。
- Git 负责版本历史、审查、回滚和分支。
- Linux 服务器负责定时备份、批量 ingest、lint、导出上下文和运行长期 agent。
- Mac/Windows 负责人工阅读、编辑、剪藏和少量即时 agent 操作。

### 10.2 WebDAV 与 Git 的边界

重要原则：不要把 `.git/` 当作普通文件夹交给 WebDAV 多端同步。

原因：

- `.git/` 内部文件更新频繁，WebDAV 容易同步到中间状态。
- 多端同时 commit、fetch、gc 时可能造成索引损坏。
- 冲突文件进入 `.git/` 后恢复成本高。

推荐方案：

1. WebDAV 同步 vault 内容，但排除 `.git/`。
2. Git 使用独立 remote，例如 GitHub private repo、GitLab private repo、自建 Gitea 或服务器 bare repo。
3. 如果所用 WebDAV 客户端不能排除 `.git/`，就不要在被 WebDAV 同步的目录里初始化 Git。改为在 Linux 服务器上对 WebDAV 挂载目录做定时快照，或用单独脚本复制到 Git 工作区后提交。

### 10.3 设备角色

Mac：

- 默认主编辑端。
- Obsidian 插件、主题、模板优先在 Mac 上调整。
- 大段写作和人工知识整理以 Mac 为主。

Windows：

- 作为阅读、剪藏、轻量编辑端。
- 避免在 Windows 上执行大规模批量重命名。
- 文件名需避免 Windows 不支持字符：`< > : " / \ | ? *`，不要使用结尾空格或结尾句点。

Linux 远程服务器：

- 作为 agent 运行端和自动维护端。
- 定时执行 lint、备份、上下文导出。
- 可挂载 WebDAV，或用同步工具定时拉取/推送。
- 适合维护 Git 历史快照。

### 10.4 同步方式选择

可选方案：

1. Obsidian 插件直连 WebDAV  
   适合简单使用，Mac 和 Windows 都通过插件同步。缺点是 Linux 服务器通常仍需要单独工具。

2. 系统级 WebDAV 客户端  
   适合把 WebDAV 当普通目录使用。缺点是不同系统客户端行为不一致，冲突处理不一定可靠。

3. `rclone` 同步或挂载 WebDAV  
   适合 Linux 服务器和自动化。可以写定时任务，也可以做只读备份。缺点是需要配置和维护。

建议组合：

- Mac/Windows：使用 Obsidian 内的 WebDAV 同步插件或稳定的桌面同步客户端。
- Linux：使用 `rclone` 或 `davfs2` 获取 WebDAV 内容。
- Git：由 Linux 服务器定时提交快照，Mac 需要时也可以手动提交。

### 10.5 写入规则

为了减少冲突，采用“单一主动写入者”原则：

- 日常人工编辑：Mac 为主写入者。
- Windows 只做轻量编辑和收集。
- Linux agent 在运行批量任务前，需要确认没有其他设备正在编辑。
- 多 agent 不同时写同一批文件。

建议在执行批量 agent 任务前创建：

```text
06_agent_state/locks/<date>-<device>-<task>.lock
```

锁文件内容包含：

```md
# Active Agent Task

- Device: linux-server
- Agent: codex
- Task: ingest weekly inbox
- Started: 2026-05-28T15:00:00Z
- Expected files:
  - 00_inbox/
  - 02_wiki/index.md
  - 02_wiki/source-notes/
```

任务完成后删除 lock，并在 `06_agent_state/runs/` 写入运行记录。

### 10.6 冲突处理

WebDAV 同步冲突不可避免，应提前定义处理流程。

冲突处理原则：

1. 不直接删除冲突文件。
2. 先用 Git 或手工 diff 比较差异。
3. 如果是 wiki 页面冲突，保留两边新增知识，合并后更新 backlinks。
4. 如果是 `index.md` 冲突，以较新的完整索引为基础，再补回缺失链接。
5. 每次严重冲突记录到 `07_sync/conflict-log.md`。

建议让 agent 可以执行一个专门任务：

```text
检查 WebDAV 同步冲突文件，生成合并建议，不要直接删除任何文件。
```

### 10.7 `.gitignore` 与同步排除

建议 `.gitignore` 包含：

```gitignore
.DS_Store
Thumbs.db
desktop.ini

.obsidian/workspace.json
.obsidian/workspace-mobile.json
.obsidian/cache/

*.tmp
*.temp
*.bak
*.conflict*

private/
restricted/
```

是否同步 `.obsidian/` 需要分开看：

- 建议同步核心配置、插件列表、模板。
- 不建议同步 workspace 状态、缓存、设备相关布局。
- 如果 Mac 和 Windows 的窗口布局差异很大，可以只同步 vault 内容，不同步 `.obsidian/`。

### 10.8 附件与大文件

WebDAV 可以同步附件，但需要控制体积。

建议：

- 小图片、网页附件、OCR 文本可以进入 vault。
- 大视频、大型 PDF、模型文件、数据库 dump 不建议直接放入 WebDAV vault。
- 大文件放对象存储、NAS 或单独归档目录，在 wiki 中保留路径或链接。

可选目录：

```text
01_raw/assets-small/
01_raw/assets-large-index.md
```

### 10.9 远程服务器自动任务

Linux 服务器可以执行：

- 每日 WebDAV 拉取或同步检查。
- 每日 Git 快照提交。
- 每周知识库 lint。
- 每周生成 `03_outputs/reports/weekly-kb-report.md`。
- 定期检查孤立页面、断链、缺少 source 的页面。
- 为其他 agent 生成上下文包。

但不建议一开始自动让 agent 大规模改写。早期自动任务应以只读检查和报告为主。

### 10.10 推荐落地顺序

第一步：

- Mac 建立本地 vault。
- 初始化目录和 Obsidian。
- 配置 WebDAV 同步。

第二步：

- Windows 接入同一个 WebDAV vault。
- 只做阅读和少量编辑，观察冲突情况。

第三步：

- Linux 服务器接入 WebDAV。
- 先做只读备份和 Git 快照。

第四步：

- 在 Linux 上运行 Codex ingest/lint。
- 每次批量写入前创建 lock。
- 每次写入后提交 Git 快照并记录 run log。

## 11. 命名规范

建议使用英文或中英混合，但保持一致。

文件名规则：

- Source note：`Source - Title.md`
- Concept：`Concept Name.md`
- Question：`Question - xxx.md`
- Synthesis：`Synthesis - xxx.md`

如果主要用中文，也可以：

- `来源 - Karpathy 的 LLM Wiki 方案.md`
- `概念 - Agent 维护的知识库.md`
- `问题 - 如何设计多 Agent 知识库.md`

关键是不要频繁改命名规则，否则双链和 agent 检索都会变差。

## 12. 额外需要考虑的问题

### 12.1 来源可信度

容易忽略。每个 source note 应包含 `Reliability Notes`，标记：

- 一手资料还是二手资料。
- 是否有商业利益或明显立场。
- 是否过期。
- 是否需要交叉验证。

### 12.2 隐私与敏感信息

个人知识库很容易混入账号、客户、财务、健康、合同、聊天记录。

建议：

- 建立 `private/` 或 `restricted/` 子目录。
- 在 `AGENTS.md` 中声明哪些目录不能发送给外部模型。
- 对 API key、身份证件、合同扫描件等使用 `.gitignore` 或加密存储。
- 多 agent 接入前先确认每个 agent 是否会上传上下文。

### 12.3 权限边界

不同 agent 的权限不应一样。

建议分三类：

- Reader agent：只能读和回答。
- Editor agent：可以改 `02_wiki/` 和 `03_outputs/`。
- Maintainer agent：可以调整目录、模板、索引和协议。

Codex 可以作为 maintainer，但其他 agent 初期建议只给 reader/editor 权限。

### 12.4 并发冲突

多 agent 同时工作时，最容易出现：

- 同一概念页被不同 agent 改写。
- index 被覆盖。
- 页面重命名导致双链断裂。
- 一个 agent 删除另一个 agent 刚生成的内容。

解决方式：

- 每次运行前创建 `06_agent_state/locks/<task>.lock`。
- 每个 agent 运行后写 `06_agent_state/runs/<date>-<agent>-<task>.md`。
- 大规模重构前先开分支。
- 不自动删除页面，只生成删除建议。

### 12.5 知识衰减

很多知识会过期，尤其是技术、法规、价格、工具、模型能力、API。

建议 frontmatter 增加：

```yaml
review_after: 2026-08-28
volatility: high
```

对高波动知识，agent 回答时应优先提醒需要重新验证。

### 12.6 评价指标

可以定期统计：

- 新增 source 数量。
- 新增 concept 数量。
- 孤立页面数量。
- 没有 source 的页面数量。
- open question 数量。
- contradiction 数量。
- 最近 30 天被引用最多的页面。

这些指标比单纯看文件数量更有意义。

### 12.7 上下文导出

后续接入不同 agent 时，不应把整个 vault 塞进上下文。需要一个导出机制：

```text
问题 -> 搜索 index -> 找相关页面 -> 导出上下文包 -> 交给 agent
```

可以后续实现 `05_tools/export_context.sh`，输出：

```text
03_outputs/context-packs/<date>-<topic>.md
```

### 12.8 迁移能力

所有核心内容必须保持为普通 Markdown。

避免把关键知识只放在：

- Obsidian 私有插件数据库。
- 某个 AI 工具的专有记忆系统。
- 只能通过 App 导出的隐藏格式。

## 13. 分阶段实施路线

### 阶段 1：最小可用版

完成：

- 建立目录结构。
- 写好 `AGENTS.md`、`CLAUDE.md`、`README.md`。
- 开启 Git。
- 使用 Obsidian 打开 vault。
- 在 Mac 上配置 WebDAV，同步到 Windows 做只读或轻量编辑测试。
- 手工处理 5 到 10 个资料，验证流程。

暂不做：

- 向量数据库。
- 复杂 RAG。
- 多 agent 自动协作。
- 自动发布。

### 阶段 2：稳定工作流

完成：

- 固化 ingest/query/lint 提示词。
- 增加 source note、concept、question 模板。
- 每周运行一次 lint。
- 引入 Dataview 做索引视图。
- 开始使用 `06_agent_state/` 记录 agent 运行。
- Linux 服务器接入 WebDAV，先做只读备份和 Git 快照。

### 阶段 3：多 agent 接入

完成：

- 为 Claude Code、Hermes、OpenClaw 等添加入口文件。
- 明确每个 agent 的读写权限。
- 使用分支或 lock 文件避免并发冲突。
- 建立 agent 运行日志。
- 在 Linux 上运行批量 agent 任务，Mac/Windows 保持轻量编辑。

### 阶段 4：检索增强

当 Markdown 文件数量明显增加后再做：

- 本地全文搜索脚本。
- 上下文导出工具。
- 可选向量检索。
- 可选 MCP 服务。
- 可选自动 source audit。

## 14. 推荐起步清单

第一天只做这些：

1. 创建 `KnowledgeVault/`。
2. 创建本文档中的目录。
3. 写入 `AGENTS.md`。
4. 用 Obsidian 打开目录。
5. 初始化 Git。
6. 在 Mac 上配置 WebDAV，并用 Windows 连接同一个 vault。
7. 放入 3 篇资料到 `00_inbox/`。
8. 让 Codex 执行一次 ingest。
9. 人工检查 diff。
10. Linux 服务器先只做 WebDAV 拉取和 Git 快照，不急着自动改写。

不要一开始追求自动化完整。先让 Markdown 知识网络能稳定增长，再逐步增加工具层。
