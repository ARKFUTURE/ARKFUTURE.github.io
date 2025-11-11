#!/bin/bash
echo "更新配置文件"
echo "! 此操作会覆盖配置文件 !"
sleep 2
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
sleep 2
echo "开始下载配置文件到/etc/inspircd"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/inspircd.conf
openssl req -x509 -newkey rsa:4096 -sha256 -days 10 -nodes -keyout key.pem -out cert.pem -subj "/CN=irc.arkfuture.test" -addext "extendedKeyUsage = serverAuth"
cd /etc/inspircd/conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/modules.conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/opers.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/links.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/helpop.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/ascii.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/generic.conf
curl -L -O --anyauth https://gh-proxy.com/https://github.com/P3TERX/GeoLite.mmdb/releases/download/2025.08.07/GeoLite2-Country.mmdb
touch filters.conf
touch xline.db
cd /etc/inspircd/txt
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/txt/motd.txt
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/txt/opermotd.txt
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/txt/quotes.txt
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/txt/rules.txt
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
sleep 2
echo "脚本运行完成 请修改为您自己的配置 当前配置为"
head -n 1 /etc/inspircd/inspircd.conf
sleep 2
echo "inspircd配置文件下载完成"