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
echo "anope配置文件下载完成,请修改相关配置以便使用"