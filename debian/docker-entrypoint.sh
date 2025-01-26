#!/bin/sh
set -e

WORDPRESS_DIR=/usr/share/nginx/html
WORDPRESS_CONFIG_SAMPLE_FILE=${WORDPRESS_DIR}/wp-config-sample.php
WORDPRESS_CONFIG_FILE=${WORDPRESS_DIR}/wp-config.php

# Download the latest salt keys from WordPress.org
SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

# wordpress
if [ ! -f ${WORDPRESS_CONFIG_FILE} ]; then
    {
        cp -r ${WORDPRESS_CONFIG_SAMPLE_FILE} ${WORDPRESS_CONFIG_FILE}
        chown -R nginx:nginx ${WORDPRESS_CONFIG_FILE}

        # Backup the original wp-config.php file
        cp "$WORDPRESS_CONFIG_FILE" "${WORDPRESS_CONFIG_FILE}.bak"

        # Remove old salt keys
        sed -i '/AUTH_KEY/d' "$WORDPRESS_CONFIG_FILE"
        sed -i '/SECURE_AUTH_KEY/d' "$WORDPRESS_CONFIG_FILE"
        sed -i '/LOGGED_IN_KEY/d' "$WORDPRESS_CONFIG_FILE"
        sed -i '/NONCE_KEY/d' "$WORDPRESS_CONFIG_FILE"
        sed -i '/AUTH_SALT/d' "$WORDPRESS_CONFIG_FILE"
        sed -i '/SECURE_AUTH_SALT/d' "$WORDPRESS_CONFIG_FILE"
        sed -i '/LOGGED_IN_SALT/d' "$WORDPRESS_CONFIG_FILE"
        sed -i '/NONCE_SALT/d' "$WORDPRESS_CONFIG_FILE"

        # # Insert the new salt keys
        # sed -i "/#@-/a ${SALTS}" "$WORDPRESS_CONFIG_FILE"
        echo "${SALTS}" >>"$WORDPRESS_CONFIG_FILE"
    }
fi

# WORDPRESS_DB_NAME
if [ -n "${WORDPRESS_DB_NAME}" ]; then
    {
        sed -i "s|define(.*'DB_NAME',.*'.*'.*);|define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );|g" ${WORDPRESS_CONFIG_FILE}
    }
fi

# WORDPRESS_DB_USER
if [ -n "${WORDPRESS_DB_USER}" ]; then
    {
        sed -i "s|define(.*'DB_USER',.*'.*'.*);|define( 'DB_USER', '${WORDPRESS_DB_USER}' );|g" ${WORDPRESS_CONFIG_FILE}
    }
fi

# WORDPRESS_DB_PASSWORD
if [ -n "${WORDPRESS_DB_PASSWORD}" ]; then
    {
        sed -i "s|define(.*'DB_PASSWORD',.*'.*'.*);|define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );|g" ${WORDPRESS_CONFIG_FILE}
    }
fi

# WORDPRESS_DB_HOST
if [ -n "${WORDPRESS_DB_HOST}" ]; then
    {
        sed -i "s|define(.*'DB_HOST',.*'.*'.*);|define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );|g" ${WORDPRESS_CONFIG_FILE}
    }
fi

# WORDPRESS_DB_CHARSET
if [ -n "${WORDPRESS_DB_CHARSET}" ]; then
    {
        sed -i "s|define(.*'DB_CHARSET',.*'.*'.*);|define( 'DB_CHARSET', '${WORDPRESS_DB_CHARSET}' );|g" ${WORDPRESS_CONFIG_FILE}
    }
fi

# WORDPRESS_DB_COLLATE
if [ -n "${WORDPRESS_DB_COLLATE}" ]; then
    {
        sed -i "s|define(.*'DB_COLLATE',.*'.*'.*);|define( 'DB_COLLATE', '${WORDPRESS_DB_COLLATE}' );|g" ${WORDPRESS_CONFIG_FILE}
    }
fi

# WORDPRESS_TABLE_PREFIX
if [ -n "${WORDPRESS_TABLE_PREFIX}" ]; then
    {
        sed -i "s|.*\$table_prefix.*=.*'.*'.*;|\$table_prefix = '${WORDPRESS_TABLE_PREFIX}';|g" ${WORDPRESS_CONFIG_FILE}
    }
fi

# WORDPRESS_DEBUG
if [ -n "${WORDPRESS_DEBUG}" ]; then
    {
        if [ "${WORDPRESS_DEBUG}" = 0 ]; then {
            sed -i "s|define(.*'WP_DEBUG',.*);|define( 'WP_DEBUG', false );|g" ${WORDPRESS_CONFIG_FILE}
        }; else
            {
                sed -i "s|define(.*'WP_DEBUG',.*);|define( 'WP_DEBUG', true );|g" ${WORDPRESS_CONFIG_FILE}
            }
        fi
    }
fi

# copy plugins and themes if necessarily
# https://github.com/docker-library/docs/tree/master/wordpress#include-pre-installed-themes--plugins
if [ -z "$(ls ${WORDPRESS_PATH}/wp-content/themes)" ]; then
    cp -r ${WORDPRESS_SRC_PATH}/wp-content/themes/* ${WORDPRESS_PATH}/wp-content/themes
fi

if [ -z "$(ls ${WORDPRESS_PATH}/wp-content/plugins)" ]; then
    cp -r ${WORDPRESS_SRC_PATH}/wp-content/plugins/* ${WORDPRESS_PATH}/wp-content/plugins
fi

# chown nginx:nginx
if [ ! -d "${WORDPRESS_PATH}/wp-content/languages" ]; then
    mkdir -p ${WORDPRESS_PATH}/wp-content/languages
fi

if [ ! -d "${WORDPRESS_PATH}/wp-content/uploads" ]; then
    mkdir -p ${WORDPRESS_PATH}/wp-content/uploads
fi

if [ ! -d "${WORDPRESS_PATH}/wp-content/themes" ]; then
    mkdir -p ${WORDPRESS_PATH}/wp-content/themes
fi

if [ ! -d "${WORDPRESS_PATH}/wp-content/plugins" ]; then
    mkdir -p ${WORDPRESS_PATH}/wp-content/plugins
fi

if [ ! -d "${WORDPRESS_PATH}/wp-content/upgrade" ]; then
    mkdir -p ${WORDPRESS_PATH}/wp-content/upgrade
fi

if [ "$(stat -c %U ${WORDPRESS_PATH}/wp-content/languages)" != "nginx" ]; then
    touch ${WORDPRESS_PATH}/wp-content/languages/.1
    chown -R nginx:nginx ${WORDPRESS_PATH}/wp-content/languages
fi

if [ "$(stat -c %U ${WORDPRESS_PATH}/wp-content/uploads)" != "nginx" ]; then
    chown -R nginx:nginx ${WORDPRESS_PATH}/wp-content/uploads
fi

if [ "$(stat -c %U ${WORDPRESS_PATH}/wp-content/themes)" != "nginx" ]; then
    chown -R nginx:nginx ${WORDPRESS_PATH}/wp-content/themes
fi

if [ "$(stat -c %U ${WORDPRESS_PATH}/wp-content/plugins)" != "nginx" ]; then
    chown -R nginx:nginx ${WORDPRESS_PATH}/wp-content/plugins
fi

if [ "$(stat -c %U ${WORDPRESS_PATH}/wp-content/upgrade)" != "nginx" ]; then
    chown -R nginx:nginx ${WORDPRESS_PATH}/wp-content/upgrade
fi

# start nginx
/usr/sbin/nginx -c /etc/nginx/nginx.conf

#fpm
/usr/bin/php-fpm --fpm-config /etc/php/8.2/fpm/php-fpm.conf

# exec commands
if [ -n "$*" ]; then
    sh -c "$*"
fi

# keep the docker container running
# https://github.com/docker/compose/issues/1926#issuecomment-422351028
if [ "${KEEPALIVE}" -eq 1 ]; then
    trap : TERM INT
    tail -f /dev/null &
    wait
    # sleep infinity & wait
fi
