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
curl -L -O --anyauth http://XXX/inspircd.conf
read -rp "是否要生成自签名证书？ [y/N] "
if [[ "${ans,,}" == "y" || "${ans,,}" == "yes" ]]; then
openssl req -x509 -newkey rsa:4096 -sha256 -days 30 -nodes -keyout key.pem -out cert.pem -subj "/CN=irc.arkfuture.test" -addext "extendedKeyUsage = serverAuth"
echo "成功生成自签名证书,证书仅用于测试环境"
else
echo "未生成任何证书,请稍自行获取证书并修改/usr/share/inspircd/deploy-ssl.sh后执行此移动证书脚本"
fi
cd /etc/inspircd/conf
curl -L -O --anyauth http://XXX/modules.conf
curl -L -O --anyauth http://XXX/opers.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/links.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/helpop.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/ascii.conf
curl -L -O --anyauth https://arkfuture.github.io/arkfuture/config/inspircd/conf/generic.conf
curl -L -O --anyauth https://git.io/GeoLite2-Country.mmdb
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
rm -rf ./afeconf.sh