#!/bin/bash
echo "更新配置文件"
echo "! 此操作会覆盖掉配置文件 !"
echo "此脚本仅适用最新的ARKFUTURE nossl配置 以及 更新ARKFUTURE的默认配置"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
sleep 2
echo "开始下载配置文件到/etc/inspircd"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/inspircd.conf
cd /etc/inspircd/conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/modules.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/helpop.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/opers.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/ascii.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/generic.conf
cd /etc/inspircd/txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/txt/motd.txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/txt/opermotd.txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/txt/quotes.txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/txt/rules.txt
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
sleep 2
echo "脚本运行完成 请修改为您自己的配置 当前配置为"
head -n 1 ./inspircd.conf
echo "inspircd配置文件下载完成"