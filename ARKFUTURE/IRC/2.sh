#!/bin/bash  
echo "脚本版本 :3 "
service inspircd stop
#systemctl stop inspircd
sleep 15s
echo "关闭INSPIRCD服务完成 "
echo "正在切换到 /etc/inspircd 目录 "
cd /etc/inspircd/  
echo "删除 /etc/inspircd 下的文件 "
rm -rf /etc/inspircd/*
echo "正在下载 inspircd.txt 文件 "
wget -N  inspircd.conf http://arkfuture.cn/ARKFUTURE/IRC/inspircd.conf  
echo "正在将 inspircd.conf 文件的权限更改为 644"
chmod 644 inspircd.conf  
echo "正在下载 motd.txt 文件 " 
wget -N  motd.txt http://arkfuture.cn/ARKFUTURE/IRC/motd.txt  
echo "正在将 motd.txt 文件的权限更改为 644  "
chmod 644 motd.txt  
echo "正在下载 opermotd.txt 文件  "
wget -N  opermotd.txt http://arkfuture.cn/ARKFUTURE/IRC/opermotd.txt  
echo "正在将 opermotd.txt 文件的权限更改为 644  "
chmod 644 opermotd.txt   
echo "正在下载 quotes.txt 文件  "
wget -N  quotes.txt http://arkfuture.cn/ARKFUTURE/IRC/quotes.txt  
echo "正在将 quotes.txt 文件的权限更改为 644  "
chmod 644 quotes.txt  
echo "下载 rules.txt 文件  "
wget -N  rules.txt http://arkfuture.cn/ARKFUTURE/IRC/rules.txt  
echo "正在将 rules.txt 文件的权限更改为 644 " 
chmod 644 rules.txt
clear
head -n 1 /etc/inspircd/inspircd.conf
