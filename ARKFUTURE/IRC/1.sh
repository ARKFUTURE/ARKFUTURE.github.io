#!/bin/bash  
echo "脚本版本 :14 "
echo "Debian"
service inspircd stop
systemctl stop inspircd
sleep 1s
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
echo "下载 helpop.conf 文件  "
wget -N  helpop.conf http://arkfuture.cn/ARKFUTURE/IRC/helpop.conf  
mv helpop.conf .helpop.conf
echo "正在将 helpop.conf 文件的权限更改为 644 " 
chmod 644 .helpop.conf
echo "下载 .opers.conf 文件  "
wget -N  helpop.conf http://arkfuture.cn/ARKFUTURE/IRC/opers.conf  
echo "正在将 opers 文件的权限更改为 644 " 
mv opers.conf .opers.conf
chmod 644 .opers.conf 
echo "下载 ssl.conf 文件  "
wget -N  helpop.conf http://arkfuture.cn/ARKFUTURE/IRC/ssl.conf  
mv ssl.conf .ssl.conf
echo "正在将 ssl.conf 文件的权限更改为 644 " 
chmod 644 .ssl.conf
clear

echo "显示文件版本  "
head -n 1 inspircd.conf
head -n 1 motd.txt
head -n 1 opermotd.txt
head -n 1 rules.txt
head -n 1 .opers.conf 
head -n 1 .ssl.conf 
head -n 1 .helpop.conf


#证书生成
read -p "是否生成证书(yes/no): " input
if [ "$input" = "yes" ]; then
    echo "开始下载openssl"
    apt update && apt upgrade -y && apt install openssl
    mkdir /etc/inspircd/.ca/
    chmod 777 /etc/inspircd/.ca/ -R
    cd /etc/inspircd/.ca/
    clear

    echo "执行证书生成命令"
    echo "生成私钥 key.pem,部分操作您需要手动执行"
    openssl genrsa -out key.pem 2048
    clear
    echo "生成证书签名请求 CSR,cert.pem,部分操作您需要手动执行"
    openssl req -new -key key.pem -out csr.pem
    clear
    echo "使用自签名证书生成CA证书,授权730天 ca.pem,部分操作您需要手动执行"
    openssl x509 -req -days 730 -in csr.pem -signkey key.pem -out ca.pem
    clear
    echo "生成Diffie-Hellman参数 dhparams.pem,部分操作您需要手动执行"
    openssl dhparam -out dhparams.pem 2048

    echo "所有证书生成完毕,正在执行剩下的脚本"
    chmod 644 /etc/inspircd/.ca/ -R
    echo "结束脚本  "
    cd ~
    


elif [ "$input" = "no" ]; then
    echo "结束脚本  "
    cd ~
else
    echo "结束脚本  "
    cd ~
fi










