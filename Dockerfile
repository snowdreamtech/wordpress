FROM snowdreamtech/php:fpm-8.1.29-nginx-1.26.1

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV WORDPRESS_VERSION=6.6.1 \
    WORDPRESS_DB_NAME='test' \
    WORDPRESS_DB_USER='root' \
    WORDPRESS_DB_PASSWORD='' \
    WORDPRESS_DB_HOST='mariadb' \
    WORDPRESS_DB_CHARSET='utf8mb4' \
    WORDPRESS_DB_COLLATE='utf8mb4_unicode_ci' \
    WORDPRESS_AUTH_KEY='' \
    WORDPRESS_SECURE_AUTH_KEY='' \
    WORDPRESS_LOGGED_IN_KEY='' \
    WORDPRESS_NONCE_KEY='' \
    WORDPRESS_AUTH_SALT='' \
    WORDPRESS_SECURE_AUTH_SALT='' \
    WORDPRESS_LOGGED_IN_SALT='' \
    WORDPRESS_NONCE_SALT='' \
    WORDPRESS_TABLE_PREFIX='wp_' \
    WORDPRESS_DEBUG=0 

RUN wget -c https://github.com/WordPress/WordPress/archive/refs/tags/${WORDPRESS_VERSION}.tar.gz \
    && tar zxvf ${WORDPRESS_VERSION}.tar.gz \
    && cp -rfv WordPress-${WORDPRESS_VERSION}/* /var/lib/nginx/html \
    && rm -rfv ${WORDPRESS_VERSION}.tar.gz \
    && rm -rfv WordPress-${WORDPRESS_VERSION} 

COPY http.d /etc/nginx/http.d

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]