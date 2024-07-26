#!/bin/sh

# 删除 /var/run/xrdp.pid 文件（如果存在）
if [ -f /var/run/xrdp.pid ]; then
    rm /var/run/xrdp.pid
fi

# 启动 xrdp 服务
/usr/sbin/xrdp

# 删除 /var/run/xrdp-sesman.pid 文件（如果存在）
if [ -f /var/run/xrdp-sesman.pid ]; then
    rm /var/run/xrdp-sesman.pid
fi

# 启动 xrdp-sesman 服务
/usr/sbin/xrdp-sesman

# 使 Docker 能够接收传递的命令
exec "$@"
