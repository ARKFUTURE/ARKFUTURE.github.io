#!/bin/bash
echo "更新配置文件"
echo "! 此操作会覆盖掉您的配置文件 !"
echo "此脚本仅适用noroot模式的配置 以及 更新ARKFUTURE的默认配置"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
sleep 3
echo "开始下载配置文件到 ./inspircd/ (当前目录下)"
mkdir -p ./inspircd
cd ./inspircd
mkdir conf
mkdir txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/norootconf/inspircd.conf
cd ./conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/helpop.conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/opers.conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/permchannels.conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/xline.db
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/modulesconf.conf
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/ascii.conf
cd ../
cd ./txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/motd.txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/opermotd.txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/quotes.txt
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/txt/rules.txt
cd ../
mkdir -p ./conf/ssl
cd ../
chmod 644 ./inspircd/ -R
sleep 3
echo "脚本运行完成 请修改为您自己的配置文件 当前ARKFUTURE配置为"
head -n 1 ./inspircd/inspircd.conf