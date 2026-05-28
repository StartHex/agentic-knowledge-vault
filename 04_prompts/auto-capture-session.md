# Auto-Capture Session Prompt

在每次有实质内容的 agent 对话或任务结束前执行。

触发条件：

- 架构或设计决策。
- 部署、同步、工具或配置变化。
- 新工作流或操作规则。
- 资料 ingest、知识综合或问题回答。
- 调试结论。
- agent 接入决策。
- 会影响未来工作的用户偏好。

不记录：

- 密码、token、API key、私钥、cookie。
- 用户明确说不要记录的内容。
- 只包含状态检查的短对话。

执行方式：

1. 判断是否已有相关 project/concept/question/source note。
2. 优先更新已有页面，避免重复页面。
3. 如果会话本身值得作为来源，创建或更新 `02_wiki/source-notes/`。
4. 更新 `02_wiki/index.md`。
5. 追加 `02_wiki/log.md`。
6. 最终回复里说明“已沉淀到知识库”。

