#!/bin/bash
echo "此脚本仅用于inspircd/anope及arkfuture配置的安装"
if [ "$EUID" -ne 0 ]; then
    echo "请使用 root 或 sudo 运行"
    exit 1
fi
echo "现在是root用户权限"
###### INSPIRCD配置
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
curl -L -O https://arkfuture.github.io/config/inspircd/inspircd.conf
echo "自动生成证书,如需要使用自己的证书,请替换key.pem和cert.pem中的内容为自己的证书"
openssl req -x509 -newkey rsa:4096 -sha256 -days 360 -nodes -keyout key.pem -out cert.pem -subj "/CN=irc.arkfuture.irc" -addext "extendedKeyUsage = serverAuth"
cd /etc/inspircd/conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/modules.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/helpop.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/opers.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/ascii.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/links.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/generic.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/dnsbl.conf
curl -L -O https://git.io/GeoLite2-Country.mmdb
touch filters.conf
cd /etc/inspircd/txt
curl -L -O https://arkfuture.github.io/config/inspircd/txt/motd.txt
curl -L -O https://arkfuture.github.io/config/inspircd/txt/opermotd.txt
curl -L -O https://arkfuture.github.io/config/inspircd/txt/quotes.txt
curl -L -O https://arkfuture.github.io/config/inspircd/txt/rules.txt
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
cd ~
echo "inspircd配置下载完成,请修改相关配置以便使用"
###### 检测配置
head -n 1 /etc/inspircd/inspircd.conf