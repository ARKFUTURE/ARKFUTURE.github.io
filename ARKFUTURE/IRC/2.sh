#!/bin/bash  
echo "脚本版本 :0.5 "
echo "正在切换到 /etc/inspircd 目录 "
cd /etc/inspircd/  
echo "正在下载 inspircd.txt 文件 "
wget -O inspircd.conf http://arkfuture.cn/ARKFUTURE/IRC/inspircd.txt  
echo "正在下载 更改文件扩展名为.conf"
mv inspircd.txt inspircd.conf
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