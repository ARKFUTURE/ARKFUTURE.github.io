#!/bin/bash
echo "inspircd 添加 openssl模块 编译安装 脚本"
if [ "$(id -u)" -eq 0 ]; then
echo "现在是root用户权限"
sleep 3
echo "开始执行编译脚本"
apt-get update
apt-get install -y build-essential wget libssl-dev libpq-dev pkg-config libargon2-dev libldap2-dev libpcre2-dev libre2-dev gnutls-bin libgnutls28-dev
wget https://github.com/inspircd/inspircd/archive/refs/tags/v4.5.0.tar.gz
tar -xzf v4.5.0.tar.gz 
rm -rf v4.5.0.tar.gz
mv inspircd-4.5.0 inspircd
cd inspircd
./configure --enable-extras ssl_openssl,ssl_gnutls,argon2,ldap,regex_pcre2,regex_re2
./configure --system
sleep 3
make install -j9
sleep 3
echo "编译安装完成,开始下载初始配置到/etc/inspircd/"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
mkdir ssl
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/inspircdssl.conf
mv inspircdssl.conf inspircd.conf
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
cd /etc/inspircd/ssl
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/ssl/ssl.conf
cd /etc/inspircd/
chmod 777 /etc/inspircd/ -R
sleep 3
echo "脚本运行完成 请修改为您自己的配置文件"
else
    echo "您现在不是root用户权限,请提权后再次执行脚本"
fi