---
type: project
status: active
updated: 2026-05-29
tags: [project, github-devpor, electron, react, github-tool]
---

# Project - github-devpor

## Summary

`github-devpor` is an Electron + React desktop assistant for GitHub projects. It focuses on a domestic-network-friendly workflow for searching GitHub repositories, reading README files, downloading source or release assets, and optionally executing AI-assisted installation steps.

## Project Path

```text
/home/ubuntu/code/github-devpor
```

## Imported Documents

Raw imported documents are stored under:

```text
01_raw/external-projects/github-devpor/
```

Imported files:

- `README.md`
- `AGENTS.md`
- `github-devpor设计.md`
- `详细设计.md`
- `最小交付说明.md`
- `开发进度与状态.md`
- `部署记录与操作.md`
- `发布前检查清单.md`
- `手工UI三轮回归记录.md`
- `交付结论.md`
- `payment-redesign.md`

## Core Product

- GitHub repository search by keyword or direct URL.
- In-app README reading.
- Source/release download with proxy fallback.
- Normal install mode and lazy install mode.
- AI-assisted minimal install plan generation.
- Command preview, blacklist checks, timeout limits, and execution logs.
- Local settings for model source, proxy mode, install mode, and server base URL.

## Stack

- Desktop: Electron, TypeScript.
- Frontend: React 18, Vite, Zustand.
- IPC: `ipcMain` / `ipcRenderer`.
- Local storage: `electron-store`.
- Packaging: `electron-builder`.
- Server: Node service for health, order/payment mock, AI/install planning, and proxy list.

## Delivery State

The imported docs describe an MVP/internal trial stage:

- build/test/smoke checks passed
- server health checks passed
- pm2 process online
- pm2-logrotate enabled
- payment flow still includes mock/test flows in the documented stage
- remaining manual work includes UI regression, sensitive-info review, and further log-rotation observation

## Risks And Notes

- Some docs include deployment and server endpoint information; no API keys were intentionally summarized here.
- Original root Markdown files used mixed encodings; imported copies were normalized to UTF-8 for Obsidian readability.
- Payment architecture has a later `payment-redesign.md` describing a pure license-key/card-code mode.

## Related

- [[Source - github-devpor Project Documents]]
- [[Project Documentation Index]]

