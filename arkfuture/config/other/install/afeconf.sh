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
apt update && apt install -y wget curl openssl gnutls-bin
curl -L -o inspircd.deb https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/download/20250310/inspircd_latestversion_amd64.deb
chmod 777 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
echo "安装完成,开始下载配置文脚本"
sleep 1
echo "inspircd配置文件覆盖导入脚本 ./inspircd.sh"
curl -L -o inspircd.sh https://arkfuture.github.io/ARKFUTURE/CONFIG/other/install/2.sh
#echo "anope配置文件覆盖导入脚本 anope.sh"
#curl -L -o anope.sh https://arkfuture.github.io/ARKFUTURE/CONFIG/other/install/3.sh
chmod 777 ./inspircd.sh && chmod 777 ./anope.sh
echo "我们提供了一个anope的配置文件下载脚本 默认是禁用的您需要修改本文件来下载脚本文件 anope需要自行安装"
echo "请稍后手动修改然后执行 ./config.sh 及 ./anope.sh 命令来覆盖式导入配置文件"
sleep 1
echo "---注意---"
echo "1"
echo "请修改<define:value>为您的 [域名] 如:irc.example.test 和其它您需要修改的[自己的配置内容]"
echo "以便能达到在生产环境中正确运行 否则有可能会出现重大问题"
echo "2"
echo "我们添加了一个虚假的cert.pem/key.pem 在 etc/inspircd 中 ![此证书仅用于测试(占位用,并无其他作用),需要自行删除,并且使用官方脚本拷贝您的生产环境证书]!"
echo "按照 https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/inspircd/README.md 的说明 使用官方脚本 正确导您自己的入证书"
echo "sslrehashsignal的脚本(请修改后使用)存放于: /usr/share/inspircd/deploy-ssl.sh"
echo "3"
echo "此脚本只能运行一次! 如果运行第二次 会覆盖您的配置文件! 请谨慎操作"
echo "---------"
cd ~