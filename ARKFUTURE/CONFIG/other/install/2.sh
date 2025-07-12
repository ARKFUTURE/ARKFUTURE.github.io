#!/bin/bash
echo "更新配置文件"
echo "! 此操作会覆盖配置文件 !"
echo "ARKFUTURE 服务器正式的配置文件, 是ARKFUTURE公共配置的分支配置"
sleep 3
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
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/inspircd.conf
openssl req -x509 -newkey rsa:4096 -nodes -keyout key.pem -out cert.pem -days 365 -subj "/CN=irc.arkfuture.test" -addext "basicConstraints=critical,CA:FALSE"
cd /etc/inspircd/conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/modules.conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/helpop.conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/opers.conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/ascii.conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/generic.conf
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/links.conf
touch permchannels.conf
touch filters.conf
touch xline.db
cd /etc/inspircd/txt
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/motd.txt
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/opermotd.txt
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/quotes.txt
curl -L -O --anyauth --user ##修改为用户名##:##修改为密码## http://frp.freefrp.net:10240/SERVER/rules.txt
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
sleep 3
echo "脚本运行完成 请修改为您自己的配置 当前配置为"
head -n 1 ./inspircd.conf
sleep 4
echo "---注意---"
echo "1"
echo "请修改<define:value>为您的 [域名] 如:irc.example.test 和其它您需要修改的[自己的配置内容]"
echo "以便能达到在生产环境中正确运行 否则有可能会出现重大问题"
echo "2"
echo "我们添加了一个虚假的cert.pem/key.pem 在 etc/inspircd 中 ![此证书仅用于测试(占位用,并无其他作用),需要自行删除,并且使用官方脚本拷贝您的生产环境证书]!"
echo "按照 https://ARKFUTURE.github.io/ARKFUTURE/CONFIG/inspircd/README.md 的说明 使用官方脚本 正确导您自己的入证书"
echo "3"
echo "此脚本只能运行一次! 如果运行第二次 会覆盖您的配置文件! 请谨慎操作"
echo "---------"