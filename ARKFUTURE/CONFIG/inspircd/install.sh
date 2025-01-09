#!/bin/bash
echo "inspircd 安装脚本 需要root权限"
if [ "$(id -u)" -eq 0 ]; then
echo "现在是root用户权限"
sleep 3
echo "开始执行安装脚本"
apt update && apt upgrade && apt install -y wget build-essential
wget https://github.com/inspircd/inspircd/releases/download/v4.5.0/inspircd_4.5.0.deb12u1_amd64.deb
chmod 777 inspircd_4.5.0.deb12u1_amd64.deb
apt install ./inspircd_4.5.0.deb12u1_amd64.deb -y
rm -rf ./inspircd_4.5.0.deb12u1_amd64.deb
sleep 3
echo "安装完成,开始下载初始配置到/etc/inspircd/"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
mkdir ssl
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/inspircd.conf
cd /etc/inspircd/conf
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/helpop.conf
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/opers.conf
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/permchannels.conf
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/xline.db
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/modulesconf.conf
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/ascii.conf
cd /etc/inspircd/txt
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/txt/motd.txt
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/txt/opermotd.txt
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/txt/quotes.txt
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/txt/rules.txt
cd /etc/inspircd/ssl
wget https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/ssl/ssl.conf
cd /etc/inspircd/
chmod 777 /etc/inspircd/ -R
sleep 3
echo "脚本运行完成 请修改为您自己的配置文件"
else
    echo "您现在不是root用户权限,请提权后再次执行脚本"
fi