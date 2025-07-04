#!/bin/bash
echo "inspircd 安装脚本 需要root权限 Debian"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
echo "开始执行安装脚本"
echo "此软件包是编译了第三方插件的软件包,包括了不兼容许可的插件,拥有SSL支持,且使用了ssl相关的插件"
echo "请注意此软件包不是官方软件包,且拥有许可不兼容的第三方插件,请自行选择是否安装"
sleep 3
apt update && apt install -y wget
curl -L -o inspircd.deb https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20250310/inspircd_4.7.0.deb12_amd64.deb
chmod 777 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
echo "安装完成,开始下载初始配置到/etc/inspircd/"
sleep 2
cd ~
curl -L -o config.sh https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/2.sh
chmod 777 ./config.sh
./config.sh
echo "脚本运行完成 请进入/etc/inspircd改为您自己的配置文件"
sleep 3
echo "若网络不好请手动重新执行./config.sh脚本 ! 此操作会覆盖掉配置文件 !"
cd ~