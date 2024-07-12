#!/bin/bash 

timestamp=$(date +%s)  
apt update && apt upgrade && apt install wget
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt

wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/inspircd.conf
cd /etc/inspircd/conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/helpop.conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/opers.conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/permchannels.conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/ssl.conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/xline.db
cd /etc/inspircd/txt
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/txt/motd.txt
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/txt/opermotd.txt
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/txt/quotes.txt
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/txt/rules.txt
cd /etc/inspircd/
echo "$timestamp" >> updatetime
chmod 644 /etc/inspircd/ -R

