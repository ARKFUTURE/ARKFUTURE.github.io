#!/bin/bash
echo "此脚本仅用于inspircd及arkfuture配置的安装"
echo "inspircd 安装脚本 需要root权限 Debian"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误: 请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
sleep 3
###### 安装依赖
apt update && apt install -y wget curl openssl gnutls-bin
###### 安装inspircd
curl -L -o inspircd.deb https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20250310/inspircd_latestversion_amd64.deb
chmod 777 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
echo "安装完成"
###### INSPIRCD配置
echo "开始下载配置文件到/etc/inspircd"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://XXX/inspircd.conf
openssl req -x509 -newkey rsa:4096 -sha256 -days 10 -nodes -keyout key.pem -out cert.pem -subj "/CN=irc.arkfuture.test" -addext "extendedKeyUsage = serverAuth"
cd /etc/inspircd/conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://XXX/modules.conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://XXX/opers.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/links.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/helpop.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/ascii.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/generic.conf
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
cd ~
head -n 1 /etc/inspircd/inspircd.conf
sleep 2
###### 说明
echo "inspircd配置文件下载完成"