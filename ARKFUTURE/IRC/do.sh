#!/bin/bash  
echo "脚本版本 :0.1 "
echo "下载 inspircd最新版 "
wget https://github.com/inspircd/inspircd/releases/download/v3.16.1/inspircd_3.16.1.ubuntu20.04.1_amd64.deb
apt install ./inspircd*.deb -y
echo "正在切换到 /etc/inspircd 目录 "
cd /etc/inspircd/  
echo "正在下载 inspircd.conf 文件 "
wget -O inspircd.conf http://arkfuture.cn/ARKFUTURE/IRC/inspircd.conf  
echo "正在将 inspircd.conf 文件的权限更改为 644"
chmod 644 inspircd.conf  
echo "正在下载 motd.txt 文件 " 
wget -O motd.txt http://arkfuture.cn/ARKFUTURE/IRC/motd.txt  
echo "正在将 motd.txt 文件的权限更改为 644  "
chmod 644 motd.txt  
echo "正在下载 opermotd.txt 文件  "
wget -O opermotd.txt http://arkfuture.cn/ARKFUTURE/IRC/opermotd.txt  
echo "正在将 opermotd.txt 文件的权限更改为 644  "
chmod 644 opermotd.txt   
echo "正在下载 quotes.txt 文件  "
wget -O quotes.txt http://arkfuture.cn/ARKFUTURE/IRC/quotes.txt  
echo "正在将 quotes.txt 文件的权限更改为 644  "
chmod 644 quotes.txt  
echo "下载 rules.txt 文件  "
wget -O rules.txt http://arkfuture.cn/ARKFUTURE/IRC/rules.txt  
echo "正在将 rules.txt 文件的权限更改为 644 " 
chmod 644 rules.txt