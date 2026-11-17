#!/usr/bin/env bash
# 阿阳酒店一键安装 / 更新
#
#   curl -fsSL https://raw.githubusercontent.com/mimaweimahan/ayangjiudian/main/install.sh | bash
#
# 只做四件事：装 Docker → 拉几 KB 的编排文件 → docker compose pull → up --wait。
# 重复执行即更新（保留 .env、数据库与上传卷）。
#
# 选项（也可用同名环境变量）：
#   --dir DIR        安装目录，默认 /www/wwwroot/ayangjiudian   (AYANG_DIR)
#   --port PORT      应用端口，默认 8088                        (APP_PORT)
#   --ref REF        本仓分支/标签，默认 main                    (AYANG_REF)
#   --image IMAGE    应用镜像，默认 ghcr.io/mimaweimahan/ayangjiudian:latest (AYANG_IMAGE)
#   --takeover       删除同名旧容器 ayang-app/ayang-mysql（旧数据卷不动）
set -euo pipefail

REPO="mimaweimahan/ayangjiudian"
AYANG_DIR="${AYANG_DIR:-/www/wwwroot/ayangjiudian}"
AYANG_REF="${AYANG_REF:-main}"
APP_PORT="${APP_PORT:-}"
AYANG_IMAGE="${AYANG_IMAGE:-}"
TAKEOVER="${AYANG_TAKEOVER:-0}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dir) AYANG_DIR="$2"; shift 2 ;;
    --port) APP_PORT="$2"; shift 2 ;;
    --ref) AYANG_REF="$2"; shift 2 ;;
    --image) AYANG_IMAGE="$2"; shift 2 ;;
    --takeover) TAKEOVER=1; shift ;;
    -h|--help) sed -n '2,16p' "$0"; exit 0 ;;
    *) echo "未知参数: $1" >&2; exit 2 ;;
  esac
done

T0=$(date +%s)
step() { printf '\n[ayang %3ss] %s\n' "$(( $(date +%s) - T0 ))" "$*"; }
die() { echo "[ayang] 失败: $*" >&2; exit 1; }
rand() { tr -dc 'A-Za-z0-9' </dev/urandom | head -c "${1:-24}"; }

[[ $(id -u) -eq 0 ]] || die "请用 root 运行"

step "1/5 Docker"
if ! command -v docker >/dev/null 2>&1; then
  curl -fsSL https://get.docker.com | sh >/tmp/ayang-docker-install.log 2>&1 \
    || { tail -20 /tmp/ayang-docker-install.log; die "Docker 安装失败"; }
fi
systemctl enable --now docker >/dev/null 2>&1 || true
docker compose version >/dev/null 2>&1 || die "缺少 docker compose 插件"
docker --version

step "2/5 编排文件 ($REPO@$AYANG_REF → $AYANG_DIR)"
mkdir -p "$AYANG_DIR/database"
cd "$AYANG_DIR"
RAW="https://raw.githubusercontent.com/$REPO/$AYANG_REF"
for f in docker-compose.yml install.sh database/01_schema.sql database/02_seed.sql; do
  curl -fsSL --retry 3 -o "$f.tmp" "$RAW/$f" || die "下载 $f 失败"
  mv -f "$f.tmp" "$f"
done
chmod +x install.sh

step "3/5 配置 .env"
touch .env && chmod 600 .env
getenv() { grep -E "^$1=" .env | tail -1 | cut -d= -f2- || true; }
setenv() {
  if grep -qE "^$1=" .env; then sed -i "s|^$1=.*|$1=$2|" .env; else echo "$1=$2" >> .env; fi
}
[[ -n "$(getenv DB_PASS)" ]] || setenv DB_PASS "$(rand 24)"
[[ -n "$(getenv MYSQL_ROOT_PASSWORD)" ]] || setenv MYSQL_ROOT_PASSWORD "$(rand 24)"
[[ -n "$APP_PORT" ]] && setenv APP_PORT "$APP_PORT"
[[ -n "$(getenv APP_PORT)" ]] || setenv APP_PORT 8088
[[ -n "$AYANG_IMAGE" ]] && setenv AYANG_IMAGE "$AYANG_IMAGE"
APP_PORT="$(getenv APP_PORT)"
echo "APP_PORT=$APP_PORT"

for c in ayang-app ayang-mysql; do
  proj=$(docker inspect -f '{{index .Config.Labels "com.docker.compose.project"}}' "$c" 2>/dev/null || true)
  if docker inspect "$c" >/dev/null 2>&1 && [[ "$proj" != "ayangjiudian" ]]; then
    [[ "$TAKEOVER" == "1" ]] || die "已存在其它部署的容器 $c（project=${proj:-无}）。确认要替换请加 --takeover"
    docker rm -f "$c" >/dev/null
    echo "已移除旧容器 $c（旧数据卷保留）"
  fi
done
if [[ "$TAKEOVER" != "1" ]] && ss -ltnH "( sport = :$APP_PORT )" 2>/dev/null | grep -q . \
   && ! docker ps --format '{{.Names}}' | grep -qx ayang-app; then
  die "端口 $APP_PORT 已被占用，请用 --port 换一个"
fi

step "4/5 拉取镜像"
docker compose pull --quiet || die "镜像拉取失败（若 GHCR 包仍为私有，请在 GitHub Packages 设为 Public）"

step "5/5 启动"
docker compose up -d --remove-orphans --wait --wait-timeout 300 \
  || { docker compose ps; docker compose logs --tail 60; die "容器未就绪"; }

sqlq() { docker compose exec -T -e MYSQL_PWD="$(getenv MYSQL_ROOT_PASSWORD)" mysql mysql -uroot -N xinayang -e "$1"; }
CRED="$AYANG_DIR/.admin_credentials"
if [[ "$(sqlq 'SELECT COUNT(*) FROM mod_admin')" == "0" ]]; then
  ADMIN_PASS="$(rand 16)"
  sqlq "INSERT INTO mod_admin (role_id,username,password,status,create_time,update_time,google_secret,google_url) VALUES (0,'admin',MD5('$ADMIN_PASS'),1,UNIX_TIMESTAMP(),UNIX_TIMESTAMP(),'','')"
  umask 077
  printf 'username=admin\npassword=%s\n' "$ADMIN_PASS" > "$CRED"
  echo "已创建后台管理员 admin，密码见 $CRED"
fi

code=$(curl -s -o /dev/null -w '%{http_code}' "http://127.0.0.1:$APP_PORT/" || true)
docker compose ps --format 'table {{.Name}}\t{{.Status}}'
step "完成 HTTP $code  →  http://$(curl -fsS --max-time 3 https://api.ipify.org 2>/dev/null || hostname -I | awk '{print $1}'):$APP_PORT/"
[[ "$code" =~ ^(200|301|302)$ ]] || die "首页返回 $code"
echo "AYANG_INSTALL_OK dir=$AYANG_DIR port=$APP_PORT seconds=$(( $(date +%s) - T0 ))"
