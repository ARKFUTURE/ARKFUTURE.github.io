#!/bin/bash
echo "inspircd 安装脚本 需要root权限 Debian"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
echo "开始执行安装脚本"
echo "此软件包是已经编译了第三方插件的软件包,包括了不兼容许可的插件,拥有SSL支持,且使用了ssl相关的插件"
echo "请注意此软件包不是官方软件包,且拥有许可不兼容的第三方插件,请自行选择是否安装"
sleep 3
apt update && apt install -y wget
wget -O inspircd.deb https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20250310/inspircd_4.7.0.deb12u1_amd64.deb
chmod 777 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
echo "安装完成,开始下载初始配置到/etc/inspircd/"
echo "您安装了 INSPIRCD 全模块版本 此配置需要您自行配置额外的预编译模块"
sleep 2
cd ~
read -p "是否下载 noroot 配置? (y/n 默认 n): " choice 
if [ "$choice" = "y" ]; then 
    echo "开始下载 noroot 配置..." 
    wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/norootconf/config.sh
else 
    echo "开始下载 root 配置..." 
    wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/config.sh
fi 
sleep 2
./config.sh
echo "脚本运行完成 请修进入/etc/inspircd改为您自己的配置文件"
sleep 3
echo "若网络不好请手动重新执行./config.sh脚本 他会替换掉配置文件"
cd ~