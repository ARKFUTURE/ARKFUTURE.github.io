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
curl -L -o inspircd.deb https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20250310/inspircd_4.8.0_deb12u1_amd64.deb
chmod 777 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
echo "安装完成"
###### INSPIRCD配置
echo "---->>配置导入脚本,仅适于ARKFUTURE配置,进行中"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
curl -L -O --anyauth --user ##USERNAME##:##PASSWORD## http://frp.freefrp.net:10240/inspircd.conf
read -rp "是否要生成自签名证书？ [y/N] " ans
if [[ ${ans,,} == @(y|yes) ]]; then
    openssl req -x509 -newkey rsa:4096 -sha256 -days 360 -nodes -keyout key.pem -out cert.pem -subj "/CN=irc.arkfuture.test" -addext "extendedKeyUsage = serverAuth"
    echo "成功生成自签名证书,证书仅用于测试环境"
else
    echo "未生成任何证书,请稍自行获取证书并修改/usr/share/inspircd/deploy-ssl.sh后执行此移动证书脚本"
fi
cd /etc/inspircd/conf
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/modules.conf
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/helpop.conf
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/opers.conf
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/ascii.conf
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/generic.conf
curl -L -O https://git.io/GeoLite2-Country.mmdb
mkdir filters.conf
mkdir xline.db
mkdir permchannels.conf
cd /etc/inspircd/txt
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/motd.txt
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/opermotd.txt
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/quotes.txt
curl -L -O https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/rules.txt
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
cd ~
echo "---->>配置导入脚本,仅适于ARKFUTURE配置,进行中"
###### 说明
head -n 1 /etc/inspircd/inspircd.conf
echo "inspircd配置文件下载完成"
echo "若您在/etc/inspircd文件夹下没有发现inspircd.conf"
echo "则您需要执行./config.sh来重新下载配置文件"
rm -rf ./afeconf.sh