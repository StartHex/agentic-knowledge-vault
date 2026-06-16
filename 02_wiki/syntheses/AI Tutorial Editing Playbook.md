# AI Tutorial Editing Playbook

[[Project - AI Creator Knowledge System]]
[[AI Tutorial Psychology Playbook]]
[[AI新闻入口]]

## Purpose

This page stores reusable editing patterns for AI tutorial content. The goal is not to copy a creator's surface style, but to extract repeatable structure: why a viewer keeps watching, where they understand the value, and what makes the tutorial feel usable.

## Core Principle

Good AI tutorials are usually the same underlying lesson packaged with better pacing, proof, and emotional clarity. Treat every collected tutorial as four layers:

- **Problem**: the viewer's current pain or desired outcome.
- **Proof**: visible before/after result, benchmark, screen recording, or real artifact.
- **Path**: the smallest sequence of steps that reproduces the result.
- **Payoff**: what the viewer can now do faster, cheaper, or with less uncertainty.

## Editing Patterns

### 1. Cold Open With Result First

Open with the finished output before explaining setup.

Useful for:

- Codex / OpenClaw / agent demos
- n8n and Dify workflows
- ComfyUI / HyperFrames visual results

Template:

```text
先看结果：我让 AI 在 X 分钟内完成了 Y。
如果你也想复现，后面只需要三步。
```

### 2. Before And After Contrast

Show the old workflow and new workflow side by side.

Use when the tutorial is about efficiency:

- before: manually search, copy, summarize, organize
- after: collector, agent, workflow, dashboard, notification

The stronger the visible contrast, the easier the audience understands value.

### 3. One Screen One Job

Every screen segment should have one job only:

- show outcome
- show setup
- show command
- show error
- show fix
- show final check

Avoid mixing explanation, command input, and theory on the same visual beat unless necessary.

### 4. Micro Suspense Before Each Step

Before showing a step, state what could go wrong or why the step matters.

Examples:

- "这一步如果配错，后面就会一直抓不到数据。"
- "很多教程跳过这里，所以你照做也跑不起来。"
- "这里不是炫技，是为了让 Obsidian 图谱能看见它。"

### 5. Error Is Content

For technical tutorials, keep one real error and show the fix. This improves trust and makes the tutorial feel reproducible.

Good error segments:

- API key missing or expired
- port conflict
- path not inside Obsidian vault
- Mac launchd/systemd timer not firing
- GitHub rate limit

### 6. Cut Theory Into Labels

Do not explain every technical concept as a lecture. Convert concepts into short labels shown near the action.

Examples:

- "采集层"
- "去重层"
- "评分层"
- "人工审核层"
- "同步层"

This lets the viewer build a mental map without stopping the tutorial.

### 7. Use Progress Markers

For long tutorials, add simple checkpoints:

- 1/5 环境
- 2/5 采集
- 3/5 评分
- 4/5 写入知识库
- 5/5 定时通知

This reduces abandonment because the viewer can see the remaining cost.

### 8. Repeat The Same Visual Grammar

Use a stable format for recurring tutorial types:

- command line: dark terminal, highlighted command, output focus
- web dashboard: cursor path, selected field, result panel
- knowledge base: Obsidian page title, graph node, backlink
- comparison: two-column table, winner by use case

Consistency makes a series feel like a manual instead of isolated posts.

## Tutorial Packaging Formats

### Quick Win

Length: 60-120 seconds.

Use for:

- one Codex feature
- one prompt
- one automation shortcut
- one plugin/tool

Structure:

```text
结果 -> 三步复现 -> 一个坑 -> 适合谁
```

### Full Build

Length: 6-12 minutes.

Use for:

- complete workflow
- deployment
- knowledge base integration
- agent system setup

Structure:

```text
结果演示 -> 架构图 -> 环境准备 -> 分步搭建 -> 错误修复 -> 最终验证 -> 下一步扩展
```

### Comparison

Length: 3-8 minutes.

Use for:

- Kimi Work vs Codex
- OpenClaw vs Codex
- n8n vs Dify
- DeepSeek/Qwen/Kimi as coding-agent backends

Structure:

```text
同一个任务 -> 三个工具执行 -> 结果对比 -> 适用人群 -> 推荐结论
```

## Review Checklist

Before publishing an AI tutorial, check:

- Is the first 5 seconds showing a real outcome or strong pain?
- Can the viewer describe the benefit in one sentence?
- Is there one concrete before/after workflow?
- Are setup steps visually clear and not just narrated?
- Is at least one real failure mode addressed?
- Does the ending suggest the next useful tutorial in the same series?

## Source Handling

When a collected creator video or article has strong editing value, add it as a source note and link it here under the relevant pattern. Do not copy the creator's script; extract the reusable mechanism and adapt it to the AI handbook's own tutorial format.
