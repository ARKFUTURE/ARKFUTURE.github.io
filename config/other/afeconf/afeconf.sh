#!/bin/bash
echo "此脚本仅用于inspircd/anope及arkfuture配置的安装"
echo "inspircd 安装脚本 需要root权限 Debian"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误: 请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
sleep 3
###### 安装依赖
echo "安装依赖"
apt update && apt install -y wget curl openssl gnutls-bin
echo "安装依赖-完成"
###### 安装inspircd
echo "安装inspircd"
curl -L -o inspircd.deb https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20260304/inspircd_deb13u1_amd64.deb
chmod 777 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
systemctl disable inspircd
echo "安装inspircd-完成"
###### 安装anope(Local)
echo "安装anope"
apt install anope -y
systemctl disable anope
echo "安装anope-完成"
###### INSPIRCD配置
echo "配置inspircd"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
curl -L -O https://gitea.com/ARKFUTURE/config/raw/branch/main/inspircd.conf
touch cert.pem
touch key.pem
read -rp "是否要生成自签名证书？ [y/N] " ans
if [[ ${ans,,} == @(y|yes) ]]; then
    openssl req -x509 -newkey rsa:4096 -sha256 -days 360 -nodes -keyout key.pem -out cert.pem -subj "/CN=irc.arkfuture.irc" -addext "extendedKeyUsage = serverAuth"
    echo "成功生成自签名证书,证书仅用于测试环境"
else
    echo "未生成任何证书,请稍自行获取证书并修改/usr/share/inspircd/deploy-ssl.sh后执行此移动证书脚本"
fi
cd /etc/inspircd/conf
curl -L -O https://git.io/GeoLite2-Country.mmdb
touch filters.conf
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
cd ~
echo "配置inspircd-完成"
###### ANOPE配置
echo "配置anope"
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/services.conf > /etc/anope/services.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/services.motd > /etc/anope/services.motd
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/modules.conf > /etc/anope/modules.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/nickserv.conf > /etc/anope/nickserv.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/chanserv.conf > /etc/anope/chanserv.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/operserv.conf > /etc/anope/operserv.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/botserv.conf > /etc/anope/botserv.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/global.conf > /etc/anope/global.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/memoserv.conf > /etc/anope/memoserv.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/anope/hostserv.conf > /etc/anope/hostserv.conf
echo "配置anope-完成"
###### 说明
cd ~
head -n 1 /etc/inspircd/inspircd.conf
head -n 1 /etc/anope/services.conf
curl -L --anyauth https://ARKFUTURE.github.io/config/other/install/config.sh > config.sh
echo "相关配置文件下载完成"
echo "若您在/etc/inspircd文件夹下没有发现inspircd.conf"
echo "或者/etc/anope文件夹下没有发现services.conf"
echo "则您需要执行./config.sh来重新下载配置文件"
echo "您需要手动执行systemctl enable 来自启动相关服务"
rm -rf ./afeconf.sh
EOF