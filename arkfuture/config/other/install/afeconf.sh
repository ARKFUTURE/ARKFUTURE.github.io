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
curl -L -o conf.sh https://arkfuture.github.io/arkfuture/config/other/install/3.sh
chmod 777 conf.sh
./config.sh
head -n 1 /etc/inspircd/inspircd.conf
###### 说明
echo "inspircd配置文件下载完成"
echo "若您在/etc/inspircd文件夹下没有发现inspircd.conf"
echo "则您需要执行./config.sh来重新下载配置文件"
rm -rf ./afeconf.sh