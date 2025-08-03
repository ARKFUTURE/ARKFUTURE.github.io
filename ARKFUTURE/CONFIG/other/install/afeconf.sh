#!/bin/bash
echo "inspircd 安装脚本 需要root权限 Debian"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误: 请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "当前目录: $(pwd)"
echo "现在是root用户权限"
echo "开始执行安装脚本"
echo "此软件包是编译了第三方插件的软件包,包括了不兼容许可的插件,拥有SSL支持,且使用了ssl相关的插件"
echo "请注意此软件包不是官方软件包,且拥有许可不兼容的第三方插件,请自行选择是否安装; 同时也安装了Anope IRC Service"
sleep 3
apt update && apt install -y wget curl anope openssl
curl -L -o inspircd.deb https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20250310/inspircd_latestversion_deb12u1_amd64.deb
chmod 777 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
echo "安装完成,开始下载配置文脚本"
sleep 1
curl -L -o config.sh https://arkfuture.github.io/ARKFUTURE/CONFIG/other/install/2.sh
chmod 777 ./config.sh
echo "请稍后手动修改然后执行 ./config.sh 命令来下载配置文件"
sleep 1
echo "结束"
cd ~