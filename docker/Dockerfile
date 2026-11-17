# syntax=docker/dockerfile:1.7
# 阿阳酒店应用镜像：Nginx + PHP-FPM 7.4
#
# 构建上下文 = 业务源码仓 mimaweimahan/ayang-docker 的检出目录（见 .github/workflows/image.yml）
# 额外命名上下文：
#   vendor = <src>/vendor
#   h5     = <src>/public/h5（CI 已删掉 11/h5.zip）
#   seed   = 本仓 seed/（默认图片，首次建卷时自动铺进 uploads 卷）
#
# 层按变更频率从低到高排列，日常改代码只需重拉最后一层。

FROM php:7.4-fpm-bullseye AS runtime

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    APP_DIR=/var/www/ayang

# bullseye 已 EOL，只能走 archive 源；编译依赖用完即删
RUN set -eux; \
    printf 'deb http://archive.debian.org/debian bullseye main\n' > /etc/apt/sources.list; \
    printf 'Acquire::Check-Valid-Until "false";\n' > /etc/apt/apt.conf.d/99no-check-valid; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        nginx supervisor cron curl default-mysql-client \
        libfreetype6 libjpeg62-turbo libpng16-16 libzip4 libonig5; \
    savedAptMark="$(apt-mark showmanual)"; \
    apt-get install -y --no-install-recommends \
        libfreetype6-dev libjpeg62-turbo-dev libpng-dev libzip-dev libonig-dev libxml2-dev $PHPIZE_DEPS; \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j"$(nproc)" bcmath gd mbstring mysqli pdo_mysql zip opcache pcntl sockets; \
    pecl install redis-5.3.7; \
    docker-php-ext-enable redis opcache; \
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark > /dev/null; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/* /tmp/pear ~/.pearrc /usr/src/php*; \
    php -r 'foreach (["bcmath","gd","mbstring","mysqli","pdo_mysql","zip","redis","pcntl","sockets"] as $e) { if (!extension_loaded($e)) { fwrite(STDERR, "missing ext $e\n"); exit(1); } }'; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone

RUN { \
      echo 'memory_limit=128M'; \
      echo 'upload_max_filesize=50M'; \
      echo 'post_max_size=50M'; \
      echo 'max_execution_time=300'; \
      echo 'date.timezone=PRC'; \
      echo 'opcache.enable=1'; \
      echo 'opcache.memory_consumption=128'; \
      echo 'opcache.validate_timestamps=1'; \
    } > /usr/local/etc/php/conf.d/ayang.ini \
    && sed -i 's|^listen = .*|listen = 127.0.0.1:9000|' /usr/local/etc/php-fpm.d/www.conf \
    && rm -f /etc/nginx/sites-enabled/default \
    && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
    && mkdir -p /var/log/supervisor /run/nginx

WORKDIR ${APP_DIR}

COPY --link --chown=33:33 --from=vendor / ${APP_DIR}/vendor/
COPY --link --chown=33:33 --from=h5 / ${APP_DIR}/public/h5/
COPY --link --chown=33:33 --from=seed uploads/ ${APP_DIR}/public/uploads/

COPY docker/nginx.conf /etc/nginx/sites-available/default
COPY docker/supervisord.conf /etc/supervisor/conf.d/ayang.conf
COPY docker/crontab /etc/cron.d/ayang
COPY docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY --link --chown=33:33 . ${APP_DIR}/

RUN set -eux; \
    chmod 0644 /etc/cron.d/ayang; \
    sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh docker/scripts/*.sh; \
    chmod +x /usr/local/bin/docker-entrypoint.sh docker/scripts/*.sh; \
    mkdir -p runtime/cache runtime/log runtime/session runtime/backup public/tmp; \
    chown www-data:www-data runtime runtime/cache runtime/log runtime/session runtime/backup public/tmp public/uploads; \
    chmod 775 runtime runtime/cache runtime/log runtime/session runtime/backup public/tmp public/uploads; \
    rm -f .env public/.user.ini

EXPOSE 8088

HEALTHCHECK --interval=15s --timeout=5s --start-period=20s --retries=5 \
  CMD curl -fsS -o /dev/null http://127.0.0.1:8088/ || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
