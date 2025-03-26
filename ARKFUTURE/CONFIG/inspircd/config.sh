#!/bin/bash
echo "更新配置文件"
echo "! 此操作会覆盖掉您的配置文件 !"
echo "此脚本仅适用测试最新的ARKFUTURE nossl配置 以及 更新ARKFUTURE的默认配置"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
sleep 3
echo "开始下载配置文件到/etc/inspircd"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
mkdir ssl
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/inspircd.conf
cd /etc/inspircd/conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/helpop.conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/opers.conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/permchannels.conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/xline.db
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/modulesconf.conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/ascii.conf
cd /etc/inspircd/txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/motd.txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/opermotd.txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/quotes.txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/rules.txt
cd /etc/inspircd/
chmod 644 /etc/inspircd/ -R
sleep 3
echo "脚本运行完成 请修改为您自己的配置文件 当前ARKFUTURE配置为"
head -n 1 ./inspircd.conf