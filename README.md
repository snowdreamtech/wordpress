# WordPress

[![dockeri.co](https://dockerico.blankenship.io/image/snowdreamtech/wordpress)](https://hub.docker.com/r/snowdreamtech/wordpress)

Docker Image packaging for WordPress. (amd64, arm32v5,  arm32v6, arm32v7, arm64v8, i386, mips64le, ppc64le,riscv64, s390x)

# Usage

To help you get started creating a container from this image you can either use docker-compose or the docker cli.

## Docker Cli

### Simple

```bash
docker run -d \
  --name=wordpress \
  -e TZ=Asia/Shanghai \
  -e WORDPRESS_DB_NAME='wordpress' \
  -e WORDPRESS_DB_USER='test' \
  -e WORDPRESS_DB_PASSWORD='test' \
  -e WORDPRESS_DB_HOST='db' \
  -p 80:80 \
  --restart unless-stopped \
  snowdreamtech/wordpress:latest
```

### Advance

```bash
docker run -d \
  --name=wordpress \
  -e TZ=Asia/Shanghai \
  -e WORDPRESS_DB_NAME='wordpress' \
  -e WORDPRESS_DB_USER='test' \
  -e WORDPRESS_DB_PASSWORD='test' \
  -e WORDPRESS_DB_HOST='db' \
  -e WORDPRESS_DB_CHARSET='utf8mb4' \
  -e WORDPRESS_DB_COLLATE='utf8mb4_unicode_ci' \
  -p 80:80 \
  -v /path/to/languages:/var/lib/nginx/html/wp-content/languages \
  -v /path/to/plugins:/var/lib/nginx/html/wp-content/plugins \
  -v /path/to/themes:/var/lib/nginx/html/wp-content/themes \
  -v /path/to/uploads:/var/lib/nginx/html/wp-content/uploads \
  --restart unless-stopped \
  snowdreamtech/wordpress:latest
```

## Docker Compose

### Simple

```bash
version: "3"

services:
  wordpress:
    image: snowdreamtech/wordpress:latest
    container_name: wordpress
    environment:
      - TZ=Asia/Shanghai
      - WORDPRESS_DB_NAME='wordpress'
      - WORDPRESS_DB_USER='test'
      - WORDPRESS_DB_PASSWORD='test'
      - WORDPRESS_DB_HOST='db'
    ports:
      - 80:80
    restart: unless-stopped
```

### Advance

```bash
version: "3"

services:
  wordpress:
    image: snowdreamtech/wordpress:latest
    container_name: wordpress
    environment:
      - TZ=Asia/Shanghai
      - WORDPRESS_DB_NAME='wordpress'
      - WORDPRESS_DB_USER='test'
      - WORDPRESS_DB_PASSWORD='test'
      - WORDPRESS_DB_HOST='db'
      - WORDPRESS_DB_CHARSET='utf8mb4'
      - WORDPRESS_DB_COLLATE='utf8mb4_unicode_ci'
    ports:
      - 80:80
    volumes:
      - /path/to/languages:/var/lib/nginx/html/wp-content/languages
      - /path/to/plugins:/var/lib/nginx/html/wp-content/plugins
      - /path/to/themes:/var/lib/nginx/html/wp-content/themes 
      - /path/to/uploads:/var/lib/nginx/html/wp-content/uploads
    restart: unless-stopped
```

# Development

```bash
docker buildx create --use --name build --node build --driver-opt network=host
docker buildx build -t snowdreamtech/wordpress --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x . --push
```

## Reference

1. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
1. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
1. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
1. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
1. [Faster Multi-Platform Builds: Dockerfile Cross-Compilation Guide](https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/)
1. [docker/buildx](https://github.com/docker/buildx)

## Contact (备注：wordpress)

* Email: sn0wdr1am@qq.com
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## License

MIT
