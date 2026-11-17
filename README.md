# 阿阳酒店 · 一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/mimaweimahan/ayangjiudian/main/install.sh | bash
```

新机（2C/4G，Ubuntu 22.04）目标：冷装 5 分钟内，已装过 Docker 的机器 90 秒内。

## 它做了什么

| 步骤 | 内容 | 体量 |
|---|---|---|
| 1 | 没有 Docker 就装 Docker | — |
| 2 | 从本仓拉 `docker-compose.yml` + `database/*.sql` | 约 420KB |
| 3 | 生成 `.env`（随机 DB/root 密码，已有则保留） | — |
| 4 | `docker compose pull`：`ghcr.io/mimaweimahan/ayangjiudian` + `mysql:8.0` | 分层并行拉取 |
| 5 | `up --wait`，空库时建后台管理员 `admin`（密码写入 `.admin_credentials`，权限 600） | — |

不再有：875MB 的 `docker save` tar 包、169MB 全量 SQL、Release 资产下载。

## 选项

```bash
bash install.sh --port 8090            # 换端口（与其它站点共存）
bash install.sh --dir /opt/ayang       # 换目录
bash install.sh --takeover             # 替换旧版 ayang-docker 部署的同名容器（旧数据卷不动）
```

重复执行 `install.sh` 即更新：只拉变化的镜像层，`.env`、数据库、上传文件都保留。

## 仓库结构

| 路径 | 说明 |
|---|---|
| `install.sh` | 安装 / 更新入口 |
| `docker-compose.yml` | app（GHCR 镜像）+ mysql:8.0 |
| `database/01_schema.sql` | 27 张 `mod_*` 表结构（不含数据） |
| `database/02_seed.sql` | 站点配置、VIP 等级、商品、角色等初始数据（不含用户/订单/管理员） |
| `seed/uploads/` | 种子数据引用的图片，构建时烤进镜像，首次建卷自动铺开 |
| `docker/Dockerfile` | 应用镜像；源码来自 [ayang-docker](https://github.com/mimaweimahan/ayang-docker) |
| `.github/workflows/image.yml` | 构建并推送 GHCR 镜像 |

## 镜像怎么更新

业务代码仍在 `mimaweimahan/ayang-docker`。改完代码后在本仓 Actions 手动运行 **image**（可填源码分支/提交），或从源码仓发 `repository_dispatch`（type `ayang-src-updated`）。镜像层顺序：运行时 → vendor → H5 → 种子图片 → 业务代码，日常改代码只需重拉最后一层。

后台入口为源码 `public/` 下的随机文件名 php（如 `/n67HSixJRfXh.php`）。
