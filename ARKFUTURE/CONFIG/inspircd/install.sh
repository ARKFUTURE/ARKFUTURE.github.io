#!/bin/bash
echo "inspircd 安装脚本 需要root权限 Debian"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
echo "开始执行安装脚本"
apt update && apt upgrade && apt install -y wget build-essential

# 版本选择及下载
echo ""
echo "请选择要安装的版本："
echo "1) 官方版本"
echo "2) 完整模块版(带第三方模块)"
read -t 5 -p "请输入选项 [1/2](5秒后自动选择默认标准版): " choice

if [ "$choice" = "1" ]; then
    echo "已选择官方版"
    wget https://ghfast.top/https://github.com/inspircd/inspircd/releases/download/v4.6.0/inspircd_4.6.0.deb12u1_amd64.deb
    chmod 777 ./inspircd_4.6.0.deb12u1_amd64.deb
    apt install ./inspircd_4.6.0.deb12u1_amd64.deb -y
    rm -rf ./inspircd_4.6.0.deb12u1_amd64.deb
    echo "安装完成,开始下载初始配置到/etc/inspircd/"
    echo "安装标准版配置"
    cd ~
    wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/config.sh
    chmod 777 ./config.sh
    ./config.sh
    echo "脚本运行完成 请修进入/etc/inspircd改为您自己的配置文件"
elif [ "$choice" = "2" ]; then
    echo "已选择完整模块版(带第三方模块)"
    wget https://ghfast.top/https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20250310/inspircd-fullmodules_4.6.0-1_amd64.deb
    chmod 777 inspircd-fullmodules_4.6.0-1_amd64.deb
    apt install ./inspircd-fullmodules_4.6.0-1_amd64.deb -y
    rm -rf inspircd-fullmodules_4.6.0-1_amd64.deb
    echo "安装完成,开始下载初始配置到/etc/inspircd/"
    echo "安装完整版配置(带第三方模块)"
    cd ~
    wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/usessl/config.sh
    chmod 777 ./config.sh
    ./config.sh
    echo "脚本运行完成 请修进入/etc/inspircd改为您自己的配置文件"
else
    echo "已选择官方版"
    wget https://ghfast.top/https://github.com/inspircd/inspircd/releases/download/v4.6.0/inspircd_4.6.0.deb12u1_amd64.deb
    chmod 777 ./inspircd_4.6.0.deb12u1_amd64.deb
    apt install ./inspircd_4.6.0.deb12u1_amd64.deb -y
    rm -rf ./inspircd_4.6.0.deb12u1_amd64.deb
    echo "安装完成,开始下载初始配置到/etc/inspircd/"
    echo "安装标准版配置"
    cd ~
    wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/config.sh
    chmod 777 ./config.sh
    ./config.sh
    echo "脚本运行完成 请修进入/etc/inspircd改为您自己的配置文件"
fi

sleep 3
echo "若网络不好请手动重新执行./config.sh脚本 他会替换掉配置文件"
cd ~