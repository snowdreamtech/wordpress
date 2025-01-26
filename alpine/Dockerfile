FROM snowdreamtech/php:8.4.2-fpm-alpine3.21

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="WordPress Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for WordPress on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/wordpress" \
    org.opencontainers.image.base.name="snowdreamtech/wordpress:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/wordpress" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="6.6.1" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/wordpress"
    
# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ENV KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0 

ENV WORDPRESS_VERSION=6.6.1 \
    WORDPRESS_DB_NAME='test' \
    WORDPRESS_DB_USER='root' \
    WORDPRESS_DB_PASSWORD='' \
    WORDPRESS_DB_HOST='db' \
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
    WORDPRESS_DEBUG=0 \
    WORDPRESS_SRC_PATH=/usr/src/wordpress \
    WORDPRESS_PATH=/var/lib/nginx/html

ARG GID=1000 \
    UID=1000  \
    USER=root \
    WORKDIR=/root

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h /home/${USER} -u ${UID} -g ${USER} -G ${USER} -s /bin/sh -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

# Enable CAP_NET_BIND_SERVICE
RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    apk add --no-cache libcap; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi

RUN mkdir -p ${WORDPRESS_SRC_PATH} \
    && mkdir -p ${WORDPRESS_PATH} \
    && wget -c https://github.com/WordPress/WordPress/archive/refs/tags/${WORDPRESS_VERSION}.tar.gz \
    && tar zxvf ${WORDPRESS_VERSION}.tar.gz \
    && cp -rfv WordPress-${WORDPRESS_VERSION}/* ${WORDPRESS_SRC_PATH} \
    && cp -rfv WordPress-${WORDPRESS_VERSION}/* ${WORDPRESS_PATH} \
    && rm -rfv ${WORDPRESS_VERSION}.tar.gz \
    && rm -rfv WordPress-${WORDPRESS_VERSION} \
    && chown -Rfv nginx:nginx ${WORDPRESS_PATH} 

# Switch to the user
USER nginx

# Set the workdir
WORKDIR /var/lib/nginx/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]