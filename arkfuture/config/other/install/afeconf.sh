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
###### INSPIRCD配置
curl -L -o inspircd.sh https://arkfuture.github.io/ARKFUTURE/CONFIG/other/install/2.sh
chmod 777 ./inspircd.sh
sleep 1
echo "安装结束"