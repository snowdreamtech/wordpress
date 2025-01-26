FROM snowdreamtech/php:8.2.26-fpm-bookworm

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="WordPress Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for WordPress on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/wordpress" \
    org.opencontainers.image.base.name="snowdreamtech/wordpress:debian" \
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
    WORDPRESS_PATH=/usr/share/nginx/html

ARG GID=1000 \
    UID=1000  \
    USER=root \
    WORKDIR=/usr/share/nginx/html

# Create a user with UID and GID
RUN set -eux \
    && if [ "${USER}" != "root" ]; then \
    addgroup --gid ${GID} ${USER}; \
    adduser --home /home/${USER} --uid ${UID} --gid ${GID} --gecos ${USER} --shell /bin/bash --disabled-password ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

# Enable CAP_NET_BIND_SERVICE
RUN set -eux \
    && if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy update; \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install --no-install-recommends libcap2-bin; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

RUN set -eux \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy update  \
    && mkdir -p ${WORDPRESS_SRC_PATH} \
    && mkdir -p ${WORDPRESS_PATH} \
    && wget -c https://github.com/WordPress/WordPress/archive/refs/tags/${WORDPRESS_VERSION}.tar.gz \
    && tar zxvf ${WORDPRESS_VERSION}.tar.gz \
    && cp -rfv WordPress-${WORDPRESS_VERSION}/* ${WORDPRESS_SRC_PATH} \
    && cp -rfv WordPress-${WORDPRESS_VERSION}/* ${WORDPRESS_PATH} \
    && rm -rfv ${WORDPRESS_VERSION}.tar.gz \
    && rm -rfv WordPress-${WORDPRESS_VERSION} \
    && chown -Rfv nginx:nginx ${WORDPRESS_PATH} \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Switch to the user
USER nginx

# Set the workdir
WORKDIR ${WORKDIR}

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]