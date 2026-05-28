# Agent Role Policy Test - 2026-05-28

我希望这个个人知识库采用分层 agent 权限策略。Codex 默认是 maintainer agent，可以维护协议、脚本、同步流程和目录结构。Claude Code 与 Hermes 默认是 editor agent，可以创建和更新 wiki 页面、source note、question、synthesis、index 和 log，但不要默认修改目录结构、同步脚本或协议文件。未来接入的新 agent 默认先作为 reader agent，只能读取和回答，确认稳定后再升级为 editor agent。所有 agent 在批量修改前都应该检查 06_agent_state/locks/，必要时创建 lock，完成后写入 06_agent_state/runs/。
