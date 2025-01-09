#!/bin/bash
echo "inspircd 编译安装脚本"
echo "下面进行提权操作 请放心输入您的密码"
su
echo "开始执行编译脚本"
apt-get update
apt-get install -y build-essential wget libssl-dev libpq-dev
wget https://github.com/inspircd/inspircd/archive/refs/tags/v4.5.0.tar.gz
tar -xzf v4.5.0.tar.gz 
rm -rf v4.5.0.tar.gz
mv inspircd-4.5.0 inspircd
cd inspircd
./configure --enable-extras ssl_openssl 
./configure --system
make install -j6
sleep 3
echo "编译安装完成,开始下载初始配置到/etc/inspircd/"
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