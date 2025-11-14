#!/bin/bash
echo "inspircd 安装脚本 需要root权限 Debian12"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "当前目录为: $(pwd)"
echo "现在是root用户权限"
echo "开始执行安装脚本"
sleep 2
echo "请选择要下载的版本:"
read -p "请输入数字(1-2);1为官方版本,2为第本站全模块版本: " version 
if [ "$version" == "1" ]; then
    echo "正在下载INSPIRCD官方软件包"
    apt update && apt install -y wget
    curl -L -o inspircd.deb https://github.com/inspircd/inspircd/releases/download/v4.8.0/inspircd_4.8.0.deb13u1_amd64.deb
    echo "校验,请对比官网所给出的sha256sum"
    sha256sum inspircd.deb
    sha512sum inspircd.deb
    echo "下载完成,等待自动安装"
elif [ "$version" == "2" ]; then
    echo "正在下载INSPIRCD-ARKFUTURE全模块软件包"
    apt update && apt install -y wget
    echo "此软件包是已经编译了第三方插件的软件包,包括了不兼容许可的插件,拥有SSL支持,且使用了ssl相关的插件"
    curl -L -o inspircd.deb https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20250310/inspircd_4.8.0_deb13u1_amd64.deb
    echo "校验,请对比官网所给出的sha256sum"
    sha256sum inspircd.deb
    sha512sum inspircd.deb
    echo "下载完成,等待自动安装"
else 
    echo "Error: 请输入正确的数字"
    exit 1 
fi 
chmod 777 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
echo "安装完成,开始下载ARKFUTURE初始模板配置到 /etc/inspircd/"
sleep 2
cd ~
curl -L -o config.sh https://arkfuture.github.io/ARKFUTURE/CONFIG/other/install/1.sh
chmod 777 ./config.sh
./config.sh
echo "脚本运行完成 请进入/etc/inspircd/ 根据官网教程改为您自己的配置文件"
sleep 3
echo "若网络不好请手动重新执行./config.sh脚本 ! 此操作会覆盖掉配置文件 !"
cd ~