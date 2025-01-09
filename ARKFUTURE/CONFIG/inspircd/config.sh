#!/bin/bash
echo "更新配置文件"
echo "! 此操作会覆盖掉您的配置文件 !"
echo "此脚本仅适用测试最新的ARKFUTURE配置 以及 更新ARKFUTURE的默认配置"
echo "下面进行提权操作 请放心输入您的密码"
su
echo "开始下载配置文件到/etc/inspircd"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
mkdir ssl
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/inspircd.conf
cd /etc/inspircd/conf
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/helpop.conf
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/opers.conf
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/permchannels.conf
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/xline.db
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/modulesconf.conf
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/conf/ascii.conf
cd /etc/inspircd/txt
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/txt/motd.txt
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/txt/opermotd.txt
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/txt/quotes.txt
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/txt/rules.txt
cd /etc/inspircd/ssl
wget https://mirror.ghproxy.com/https://github.com/ARKFUTURE/ARKFUTURE.github.io/blob/main/ARKFUTURE/CONFIG/inspircd/ssl/ssl.conf
cd /etc/inspircd/
chmod 644 /etc/inspircd/ -R
sleep 3
echo "脚本运行完成 请修改为您自己的配置文件"