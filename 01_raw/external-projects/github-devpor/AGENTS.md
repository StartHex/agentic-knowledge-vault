# 仓库内 Agent 执行约定

## 外网访问与加速源

- 在本仓库执行任何需要外网的命令时，优先使用国内镜像源或已配置代理。
- 不要直接使用默认海外源，除非镜像不可用且已说明原因。

## Node/npm 相关

- `npm install`、`npm ci`、`npx` 等命令默认使用项目根目录 `.npmrc` 中的镜像配置。
- 如需临时覆盖，显式加上 `--registry=https://registry.npmmirror.com`。

## 其他常见命令

- `pip`：优先使用 `-i https://pypi.tuna.tsinghua.edu.cn/simple`
- `cargo`：优先使用可用的 crates 镜像（如已配置则沿用）
- `go`：优先使用 `GOPROXY=https://goproxy.cn,direct`
- `apt`/`yum`：在服务器上优先使用国内软件源

## 失败处理

- 若镜像源不可达，先重试一次并记录错误摘要，再切换备用镜像或代理。
- 必要时先在本地下载依赖包，再通过 `sftp/scp` 上传到目标环境。
