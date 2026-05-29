# 支付系统重构设计报告 v2 — 纯卡密模式

## 1. 现状与废弃清单

### 1.1 当前流程（全删）

```
order/create → EZFPAY 支付 → notify 回调 → verify/use → ai/chat (orderId 作 apiKey)
```

### 1.2 全部删除

| 删除项 | 说明 |
|--------|------|
| `orders.json` | 整个订单文件 |
| EZFPAY 全部常量/函数 | pid, key, submit.php, notify, return, 签名逻辑 |
| 所有 `/api/order/*` 路由 | create, status, webhook, refund |
| 所有 `/api/ezfpay/*` 路由 | pay, notify, return |
| `ezfpy-payment-integration.md` | 旧文档 |
| 前端 Payment 页面 EZFPAY 部分 | 创建订单/查询状态/模拟支付 等全部按钮和逻辑 |
| ai/chat + install/plan 中的 orderId 校验 | 改为 licenseId 校验 |

### 1.3 保留不变

| 保留项 | 说明 |
|--------|------|
| DS2 API 配置 + reload 机制 | `registerOrderAsApiKey()` 改为 `registerLicenseAsApiKey()` |
| `/api/ai/chat` + `/api/install/plan` | 核心业务接口，改校验逻辑 + 加日志 |
| MODEL_API_KEY / MODEL_ENDPOINT | 调用 DeepSeek 的凭据 |

---

## 2. 新架构

```
┌──────────┐     ┌──────────────┐     ┌──────────────┐
│ 管理员     │     │   服务端       │     │   客户端       │
│           │     │              │     │              │
│ 生成卡密   │────▶│ keys.json    │     │              │
│           │     │              │◀────│ 输入卡密激活   │
│           │     │ licenses.json │     │              │
│           │     │              │────▶│ licenseId     │
│           │     │              │     │              │
│           │     │ AI 接口       │◀────│ apiKey=      │
│           │     │ + 用量日志     │────▶│ licenseId    │
│           │     │              │     │              │
└──────────┘     └──────────────┘     └──────────────┘
```

---

## 3. 数据模型

### 3.1 卡密 `keys.json`

```
KEY_<16位hex> → {
  key: string           // "KEY_a1b2c3d4e5f6g7h8"
  status: string        // unused | activated | revoked
  createdAt: string     // ISO
  activatedAt: string|null
  activatedBy: string   // deviceId
  licenseId: string|null
  revokedAt: string|null
  revokeReason: string|null
}
```

**生成**：`node generate-keys.js --count 100`，格式 `KEY_<16位随机hex>`。

**激活规则**：
- key 存在
- status === "unused"
- 激活后立即创建 license → 关联 licenseId

### 3.2 授权 `licenses.json`

```
[
  {
    id: string           // "LIC_1760123456789_a1b2c3"
    deviceId: string
    keyRef: string       // "KEY_a1b2c3..."
    status: string       // active | revoked
    activatedAt: string
    revokedAt: string|null
    revokeReason: string|null
  }
]
```

### 3.3 用量日志 `usage_logs/YYYY-MM-DD.json`

```
{
  id: "USG_1760123500000_abc"
  licenseId: "LIC_xxx"
  endpoint: "chat" | "install-plan"
  model: "deepseek-v4-flash"
  prompt: string
  response: string
  promptTokens: number
  completionTokens: number
  durationMs: number
  createdAt: "2026-05-20T11:00:00.000Z"
}
```

---

## 4. API 设计

### 4.1 新增接口

#### `POST /api/key/activate`
```
Request:  { key: "KEY_...", deviceId: "xxx" }
Response: { ok: true, licenseId: "LIC_..." }
Error:    { ok: false, error: "无效卡密" | "卡密已被使用" | "卡密已吊销" }
```
- 内存锁 `activateLocks: Map<string, Promise>` 防并发
- 文件写入后释放锁
- 激活同时创建 license 记录

#### `POST /api/license/revoke`
```
Request:  { licenseId: "LIC_...", reason: "..." }
Response: { ok: true }
```
- 吊销 license → 同时吊销关联 key
- 吊销后对应 apiKey 立即失效

#### `POST /api/key/generate`（管理端）
```
Request:  { count: 50, adminToken: "xxx" }
Response: { ok: true, keys: ["KEY_...", ...] }
```
- adminToken 读环境变量 `ADMIN_TOKEN`

### 4.2 变更接口

#### `POST /api/ai/chat` + `POST /api/install/plan`
- **入参不变** `{ apiKey, prompt, ... }`
- **校验改为**：查 `licenses.json`，status 必须为 "active"
- **新增**：调用完成后写 usage_logs
- **保留**：registerLicenseAsApiKey() 机制（licenseId 写入 ds2api config）

---

## 5. 状态机

```
Key:    unused ──▶ activated ──▶ revoked
                        │
                        ▼
                     revoked
                       
License: active ──▶ revoked
```

---

## 6. 前端变更

```
┌─────────────────────────────────────────┐
│  🔑 授权                                 │
│                                          │
│  ┌─────────────────────────────────────┐ │
│  │ 卡密                                 │ │
│  │ [________________________] [激活]    │ │
│  │                                      │ │
│  │ 状态：✅ 已激活 / ⚠️ 无效卡密 / ❌ 已使用 │ │
│  └─────────────────────────────────────┘ │
│                                          │
│  ┌─────────────────────────────────────┐ │
│  │ 📋 当前授权                          │ │
│  │ licenseId: LIC_xxx                   │ │
│  │ 状态: active                         │ │
│  │ 激活时间: 2026-05-20 10:05           │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

**交互**：
- 输入卡密 → 点击激活 → 成功显示 licenseId / 失败显示错误
- 已有激活 license 时直接显示当前授权信息
- license 信息持久化到 Electron 本地（localStorage / electron-store）

---

## 7. 服务端文件变更

```
server/
├── data/
│   ├── orders.json              ✕ 删除
│   ├── keys.json                ✓ 新增
│   ├── licenses.json            ✓ 新增
│   └── usage_logs/              ✓ 新增
│       └── 2026-05-20.json
├── index.js                     ← 大量删除 + 新增路由
├── generate-keys.js             ✓ 新增
└── ezfpy-payment-integration.md ✕ 删除
```

## 8. 安全

| 风险 | 措施 |
|------|------|
| 卡密爆破 | 16 位 hex = 1.8×10¹⁹ 空间；限流每 IP 每分钟 5 次激活尝试 |
| 并发激活同一 key | 内存 `activateLocks` Map |
| licenseId 泄露 | 支持吊销；吊销后立即失效 |
| 用量日志含敏感内容 | 按日轮转，定期清理 |

## 9. 实施步骤

| 步 | 内容 |
|----|------|
| 1 | **删** — 后端删 EZFPAY 全部代码（常量/函数/路由/文件） |
| 2 | **建** — `keys.json` + `licenses.json` + `usage_logs/` 数据结构 + 读写函数 |
| 3 | **写** — `POST /api/key/activate` + `POST /api/license/revoke` + `POST /api/key/generate` |
| 4 | **改** — `/api/ai/chat` + `/api/install/plan` 改为 license 校验 + 写日志 |
| 5 | **改** — 前端 Payment 页面改为纯卡密 UI |
| 6 | **验** — 激活→调用 AI→用量落盘→吊销→拒绝调用 |
