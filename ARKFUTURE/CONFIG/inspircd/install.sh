#!/bin/bash
echo "inspircd 安装脚本 需要root权限 Debian"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
echo "开始执行安装脚本"
apt update && apt upgrade && apt install -y wget build-essential
wget https://ghfast.top/https://github.com/inspircd/inspircd/releases/download/v4.6.0/inspircd_4.6.0.deb12u1_amd64.deb
chmod 777 ./inspircd_4.6.0.deb12u1_amd64.deb
apt install ./inspircd_4.6.0.deb12u1_amd64.deb -y
rm -rf ./inspircd_4.6.0.deb12u1_amd64.deb
echo "安装完成,开始下载初始配置到/etc/inspircd/"
cd ~
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/config.sh
chmod 777 ./config.sh
./config.sh
echo "脚本运行完成 请修进入/etc/inspircd改为您自己的配置文件"
sleep 3
echo "若网络不好请手动重新执行./config.sh脚本 他会替换掉配置文件"
cd ~