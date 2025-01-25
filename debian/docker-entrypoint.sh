#!/bin/sh
set -e

WORDPRESS_DIR=/usr/share/nginx/html
WORDPRESS_CONFIG_SAMPLE_FILE=${WORDPRESS_DIR}/wp-config-sample.php
WORDPRESS_CONFIG_FILE=${WORDPRESS_DIR}/wp-config.php

# https://api.wordpress.org/secret-key/1.1/salt/
# https://unix.stackexchange.com/a/230676
salt(){
    CHARS='a-zA-Z0-9!@#$%^&*()-_ []{}<>~`+=,.;:/?|';
    SALT=$(tr -dc "${CHARS}" </dev/urandom | tr -d '\' | head -c 64; echo)
    printf "%s" "${SALT}"
}

# escape characters
escape(){
    # str=$1
    str=$(salt)

    # escape characters
    str=$(echo "${str}"|sed  's/\\/\\\\/g')
    str=$(echo "${str}"|sed  's#\/#\\/#g')
    str=$(echo "${str}"|sed  's/\*/\\*/g')
    str=$(echo "${str}"|sed  's/\./\\./g')
    str=$(echo "${str}"|sed  's/\^/\\^/g')
    str=$(echo "${str}"|sed  's/\$/\\$/g')
    str=$(echo "${str}"|sed  's/\[/\\[/g')
    str=$(echo "${str}"|sed  's/\]/\\]/g')
    str=$(echo "${str}"|sed  's/(/\\(/g')
    str=$(echo "${str}"|sed  's/)/\\)/g')
    str=$(echo "${str}"|sed  's/+/\\+/g')
    str=$(echo "${str}"|sed  's/?/\\?/g')
    str=$(echo "${str}"|sed  's/{/\\{/g')
    str=$(echo "${str}"|sed  's/}/\\}/g')
    str=$(echo "${str}"|sed  's/|/\\|/g')
    str=$(echo "${str}"|sed  's/</\\</g')
    str=$(echo "${str}"|sed  's/>/\\>/g')
    str=$(echo "${str}"|sed  's/\&/\\&/g')

    printf "'%s'" "${str}"
}

# wordpress
if [ ! -f ${WORDPRESS_CONFIG_FILE} ]; then {
    cp -r ${WORDPRESS_CONFIG_SAMPLE_FILE} ${WORDPRESS_CONFIG_FILE}
    chown -R nginx:nginx ${WORDPRESS_CONFIG_FILE}

    # wordpress security salt
    if [ -z "${WORDPRESS_AUTH_KEY}" ]; then {
        WORDPRESS_AUTH_KEY=$(escape)
    }
    fi

    if [ -z "${WORDPRESS_SECURE_AUTH_KEY}" ]; then {
        WORDPRESS_SECURE_AUTH_KEY=$(escape)
    }
    fi

    if [ -z "${WORDPRESS_LOGGED_IN_KEY}" ]; then {
        WORDPRESS_LOGGED_IN_KEY=$(escape)
    }
    fi

    if [ -z "${WORDPRESS_NONCE_KEY}" ]; then {
        WORDPRESS_NONCE_KEY=$(escape)
    }
    fi

    if [ -z "${WORDPRESS_AUTH_SALT}" ]; then {
        WORDPRESS_AUTH_SALT=$(escape)
    }
    fi

    if [ -z "${WORDPRESS_SECURE_AUTH_SALT}" ]; then {
        WORDPRESS_SECURE_AUTH_SALT=$(escape)
    }
    fi

    if [ -z "${WORDPRESS_LOGGED_IN_SALT}" ]; then {
        WORDPRESS_LOGGED_IN_SALT=$(escape)
    }
    fi

    if [ -z "${WORDPRESS_NONCE_SALT}" ]; then {
        WORDPRESS_NONCE_SALT=$(escape)
    }
    fi

    sed -i "s|define(.*'AUTH_KEY',.*'.*'.*);|define( 'AUTH_KEY', ${WORDPRESS_AUTH_KEY} );|g" ${WORDPRESS_CONFIG_FILE}
    sed -i "s|define(.*'SECURE_AUTH_KEY',.*'.*'.*);|define( 'SECURE_AUTH_KEY', ${WORDPRESS_SECURE_AUTH_KEY} );|g" ${WORDPRESS_CONFIG_FILE}
    sed -i "s|define(.*'LOGGED_IN_KEY',.*'.*'.*);|define( 'LOGGED_IN_KEY', ${WORDPRESS_LOGGED_IN_KEY} );|g" ${WORDPRESS_CONFIG_FILE}
    sed -i "s|define(.*'NONCE_KEY',.*'.*'.*);|define( 'NONCE_KEY', ${WORDPRESS_NONCE_KEY} );|g" ${WORDPRESS_CONFIG_FILE}
    sed -i "s|define(.*'AUTH_SALT',.*'.*'.*);|define( 'AUTH_SALT', ${WORDPRESS_AUTH_SALT} );|g" ${WORDPRESS_CONFIG_FILE}
    sed -i "s|define(.*'SECURE_AUTH_SALT',.*'.*'.*);|define( 'SECURE_AUTH_SALT', ${WORDPRESS_SECURE_AUTH_SALT} );|g" ${WORDPRESS_CONFIG_FILE}
    sed -i "s|define(.*'LOGGED_IN_SALT',.*'.*'.*);|define( 'LOGGED_IN_SALT', ${WORDPRESS_LOGGED_IN_SALT} );|g" ${WORDPRESS_CONFIG_FILE}
    sed -i "s|define(.*'NONCE_SALT',.*'.*'.*);|define( 'NONCE_SALT', ${WORDPRESS_NONCE_SALT} );|g" ${WORDPRESS_CONFIG_FILE}
}
fi

# WORDPRESS_DB_NAME
if [ -n "${WORDPRESS_DB_NAME}" ]; then {
    sed -i "s|define(.*'DB_NAME',.*'.*'.*);|define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );|g" ${WORDPRESS_CONFIG_FILE} 
}
fi

# WORDPRESS_DB_USER
if [ -n "${WORDPRESS_DB_USER}" ]; then {
    sed -i "s|define(.*'DB_USER',.*'.*'.*);|define( 'DB_USER', '${WORDPRESS_DB_USER}' );|g" ${WORDPRESS_CONFIG_FILE} 
}
fi

# WORDPRESS_DB_PASSWORD
if [ -n "${WORDPRESS_DB_PASSWORD}" ]; then {
    sed -i "s|define(.*'DB_PASSWORD',.*'.*'.*);|define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );|g" ${WORDPRESS_CONFIG_FILE} 
}
fi

# WORDPRESS_DB_HOST
if [ -n "${WORDPRESS_DB_HOST}" ]; then {
    sed -i "s|define(.*'DB_HOST',.*'.*'.*);|define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );|g" ${WORDPRESS_CONFIG_FILE} 
}
fi

# WORDPRESS_DB_CHARSET
if [ -n "${WORDPRESS_DB_CHARSET}" ]; then {
    sed -i "s|define(.*'DB_CHARSET',.*'.*'.*);|define( 'DB_CHARSET', '${WORDPRESS_DB_CHARSET}' );|g" ${WORDPRESS_CONFIG_FILE} 
}
fi

# WORDPRESS_DB_COLLATE
if [ -n "${WORDPRESS_DB_COLLATE}" ]; then {
    sed -i "s|define(.*'DB_COLLATE',.*'.*'.*);|define( 'DB_COLLATE', '${WORDPRESS_DB_COLLATE}' );|g" ${WORDPRESS_CONFIG_FILE} 
}
fi

# WORDPRESS_TABLE_PREFIX
if [ -n "${WORDPRESS_TABLE_PREFIX}" ]; then {
    sed -i "s|.*\$table_prefix.*=.*'.*'.*;|\$table_prefix = '${WORDPRESS_TABLE_PREFIX}';|g" ${WORDPRESS_CONFIG_FILE} 
}
fi

# WORDPRESS_DEBUG
if [ -n "${WORDPRESS_DEBUG}" ]; then {
    if [ "${WORDPRESS_DEBUG}" = 0 ]; then {
        sed -i "s|define(.*'WP_DEBUG',.*);|define( 'WP_DEBUG', false );|g" ${WORDPRESS_CONFIG_FILE} 
    } else {
        sed -i "s|define(.*'WP_DEBUG',.*);|define( 'WP_DEBUG', true );|g" ${WORDPRESS_CONFIG_FILE} 
    }
    fi
}
fi

# copy plugins and themes if necessarily
# https://github.com/docker-library/docs/tree/master/wordpress#include-pre-installed-themes--plugins
if [ -z "$( ls ${WORDPRESS_PATH}/wp-content/themes )" ]; then
   cp -r ${WORDPRESS_SRC_PATH}/wp-content/themes/*  ${WORDPRESS_PATH}/wp-content/themes 
fi

if [ -z "$( ls ${WORDPRESS_PATH}/wp-content/plugins )" ]; then
   cp -r ${WORDPRESS_SRC_PATH}/wp-content/plugins/*  ${WORDPRESS_PATH}/wp-content/plugins 
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
