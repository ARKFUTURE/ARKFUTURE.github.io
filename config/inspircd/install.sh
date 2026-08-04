#!/bin/bash
set -e

echo "此脚本仅用于INSPIRCD/ANOPE公共配置的安装 仅限于Debian"
echo "当前版本为Debian12,如果需要Debian13,则请您及时停止脚本并且主动修改脚本中的12u1为13u1"
if [ "$EUID" -ne 0 ]; then
    echo "请使用 root 或 sudo 运行"
    exit 1
fi
echo "现在是root用户权限"
sleep 3

###### 环境变量 ######
read -p "请输入您的域名,用来替换内嵌的域名: " domaind

###### 安装依赖 ######
echo "安装依赖"
apt update && apt install -y wget curl openssl gnutls-bin
echo "安装依赖-完成"

###### 安装inspircd ######
echo "安装inspircd"
echo "请选择要下载的版本:"
read -p "请输入数字(1-2);1为官方版本,2为第三方打包全模块版本: " version 
if [ "$version" == "1" ]; then
    echo "正在下载INSPIRCD官方软件包"
    apt update && apt install -y wget
    curl -L -o inspircd.deb https://github.com/inspircd/inspircd/releases/download/v4.11.0/inspircd_4.11.0.deb12u1_amd64.deb
    echo "校验,请对比官网所给出的sha256sum"
    sha256sum inspircd.deb
    sha512sum inspircd.deb
    echo "下载完成,等待自动安装"
elif [ "$version" == "2" ]; then
    echo "正在下载INSPIRCD-ARKFUTURE-FULL软件包"
    apt update && apt install -y wget
    echo "此软件包是已经编译了第三方插件的软件包,拥有gnutls-SSL支持,且使用了其他插件"
    curl -L -o inspircd.deb https://github.com/ARKFUTURE/inspircd-package-builder/releases/download/260706/inspircd_deb13u1_amd64.deb
    echo "校验,请对比官网所给出的sha256sum"
    sha256sum inspircd.deb
    sha512sum inspircd.deb
    echo "下载完成,等待自动安装"
else 
    echo "Error: 请输入正确的数字"
    exit 1 
fi 
chmod 644 ./inspircd.deb
apt install ./inspircd.deb -y
rm -rf ./inspircd.deb
systemctl disable inspircd
echo "安装inspircd-完成"

###### 安装anope ######
echo "安装anope"
apt install anope -y
systemctl disable anope
echo "安装anope-完成"

###### 配置INSPIRCD ######
echo "配置inspircd"
cd /etc/inspircd
rm -rf *
mkdir conf txt
curl -L -O https://arkfuture.github.io/config/inspircd/inspircd.conf
echo "自动生成证书,如需要使用自己的证书,请替换key.pem和cert.pem中的内容为自己的证书即可"
openssl req -x509 -newkey rsa:4096 -sha512 -days 360 -nodes -keyout key.pem -out cert.pem -subj "/CN=$domand" -addext "extendedKeyUsage = serverAuth"
sed -i "s|irc.arkfuture.irc|$domaind|g" inspircd.conf
sed -i "$(( $(wc -l < inspircd.conf) - 1 ))s/^#//" inspircd.conf
cd /etc/inspircd/conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/modules.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/help.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/opers.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/ascii.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/link-service.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/generic.conf
curl -L -O https://arkfuture.github.io/config/inspircd/conf/dnsbl.conf
cd /etc/inspircd/txt
curl -L -O https://arkfuture.github.io/config/inspircd/txt/motd.txt
curl -L -O https://arkfuture.github.io/config/inspircd/txt/opermotd.txt
curl -L -O https://arkfuture.github.io/config/inspircd/txt/quotes.txt
curl -L -O https://arkfuture.github.io/config/inspircd/txt/rules.txt
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
sleep 2
echo "配置inspircd-完成"
cd ~

###### 配置ANOPE ######
echo "配置anope"
cd /etc/anope
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
cd ~
clear

###### 说明 ######
echo "输出配置信息"
echo "INSPIRCD配置信息: $(head -n 1 /etc/inspircd/inspircd.conf)"
echo "ANOPE配置信息: $(head -n 1 /etc/anope/services.conf)"
echo "当前内网IP: $(hostname -I)" 
sleep 2
echo "相关配置文件下载完成"
echo "您需要手动执行systemctl enable 来开启自启动相关服务"
echo "您需要手动执行systemctl start 来开启自启动相关服务"
rm -rf ./afeconf.sh