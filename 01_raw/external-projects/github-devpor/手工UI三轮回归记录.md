# 手工 UI 三轮回归记录

## 使用说明

- 目标：完成发布清单中的手工项（搜索/README/下载 UI 回归）
- 执行环境：本地桌面客户端（`npm run dev`）
- 每轮都按同一模板执行，便于对比稳定性

## 预置条件

- `Server Base URL`：`http://47.109.187.147:8788`
- `AI Base URL`：`http://47.109.187.147:5001/v1/chat/completions`
- 能正常打开客户端主页并显示版本号

## 自动烟测快照（辅助）

- 最近执行：`npm run smoke`
- 结果摘要：`6` 项中 `5 pass`、`1 warn`、`0 fail`
- 告警项：`download_small_file`（网络层偶发 `ECONNRESET`，标记为非阻断）
- 报告文件：`tmp/smoke-report.json`

---

## Round 1

### A. 搜索流程
- [ ] 关键词搜索：输入 `react`，结果列表可加载
- [ ] URL 搜索：输入 `https://github.com/facebook/react`，可定位仓库

### B. README 流程
- [ ] 点击结果项后 README 成功展示
- [ ] README 加载失败时有可见错误提示（如有）

### C. 下载流程
- [ ] 输入下载 URL 与目标路径后可开始下载
- [ ] 下载进度百分比持续变化
- [ ] 点击取消后状态变更为 cancelled

### D. 支付联动流程
- [ ] `Mode=lazy` + `AI Provider=builtin`
- [ ] 点击 `Run Full Mock Flow` 后日志出现 `status: paid`
- [ ] 验单成功后 `localRemaining` 增加
- [ ] 执行安装后 `Local Remaining Paid Uses` 扣减

### E. 记录
- 执行时间：
- 结果：`通过/失败`
- 失败项与日志：

---

## Round 2

### A. 搜索流程
- [ ] 关键词搜索：输入 `electron`，结果列表可加载
- [ ] URL 搜索：输入任一公开仓库 URL，结果可定位

### B. README 流程
- [ ] README 展示稳定，无空白卡死
- [ ] 连续点击不同仓库 README 可正常切换

### C. 下载流程
- [ ] 下载开始正常
- [ ] 下载进度可见
- [ ] 取消后状态正确

### D. 支付联动流程
- [ ] `Run Full Mock Flow` 可再次跑通
- [ ] `Auto Poll + Verify` 在 paid 状态下可完成验单
- [ ] 扣次逻辑符合预期

### E. 记录
- 执行时间：
- 结果：`通过/失败`
- 失败项与日志：

---

## Round 3

### A. 搜索流程
- [ ] 随机关键词搜索成功
- [ ] URL 搜索成功

### B. README 流程
- [ ] README 加载成功
- [ ] 切换仓库后展示正常

### C. 下载流程
- [ ] 下载可开始
- [ ] 进度正常
- [ ] 取消正常

### D. 支付联动流程
- [ ] `Run Full Mock Flow` 跑通
- [ ] 验单与本地剩余次数变化一致
- [ ] 次数不足时执行安装被阻断

### E. 记录
- 执行时间：
- 结果：`通过/失败`
- 失败项与日志：

---

## 汇总结论

- 三轮总体结果：`通过/失败`
- 是否满足发布前手工回归要求：`是/否`
- 遗留问题：
