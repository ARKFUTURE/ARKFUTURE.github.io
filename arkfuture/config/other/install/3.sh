#!/bin/bash
echo "Anope配置文件覆盖脚本"
echo "! 此操作会覆盖配置文件 !"
echo "ARKFUTURE 服务器正式的配置文件, 是ARKFUTURE公共配置的分支配置"
sleep 2
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
apt install -y anope
sleep 2
echo "开始下载配置文件到/etc/anope"
cd /etc/anope
rm -rf *
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/services.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/services.motd
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/modules.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/nickserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/chanserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/operserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/botserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/global.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/memoserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/anope/hostserv.conf
cd /etc/anope
chown root:root /etc/anope
chmod 755 /etc/anope
find /etc/anope -type f -exec chown root:irc {} \;
find /etc/anope -type f -exec chmod 640 {} \;
sleep 2
head -n 1 /etc/anope/services.conf
sleep 2
echo "anope配置文件下载完成"