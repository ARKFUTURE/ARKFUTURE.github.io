#!/bin/bash  
echo "脚本版本 :30 "
echo "Debian"
service inspircd stop
systemctl stop inspircd
sleep 1s
echo "关闭INSPIRCD服务完成 "

cd /etc/inspircd/  
rm -rf /etc/inspircd/*

echo "正在下载 INSPIRCD 配置文件 "
wget -N  inspircd.conf http://arkfuture.cn/ARKFUTURE/IRC/inspircd.conf 
chmod 644 /etc/inspircd/inspircd.conf

mkdir /etc/inspircd/.md/
chmod 777 /etc/inspircd/.md/
cd /etc/inspircd/.md/
echo "正在下载 MOTD 配置文件 "
wget -N  motd.txt http://arkfuture.cn/ARKFUTURE/IRC/.md/motd.txt  
wget -N  opermotd.txt http://arkfuture.cn/ARKFUTURE/IRC/.md/opermotd.txt  
wget -N  quotes.txt http://arkfuture.cn/ARKFUTURE/IRC/.md/quotes.txt  
wget -N  rules.txt http://arkfuture.cn/ARKFUTURE/IRC/.md/rules.txt  
chmod 644 /etc/inspircd/.md/ -R
cd ~

mkdir /etc/inspircd/.cf/
chmod 777 /etc/inspircd/.cf/
cd /etc/inspircd/.cf/
echo "正在下载 插件 配置文件 "
wget -N  helpop.conf http://arkfuture.cn/ARKFUTURE/IRC/.cf/helpop.conf  
wget -N  opers.conf http://arkfuture.cn/ARKFUTURE/IRC/.cf/opers.conf  
wget -N  ssl.conf http://arkfuture.cn/ARKFUTURE/IRC/.cf/ssl.conf  
wget -N  permchannels.conf http://arkfuture.cn/ARKFUTURE/IRC/.cf/permchannels.conf 
chmod 644 /etc/inspircd/.cf/ -R
cd ~

echo "显示文件版本  "
cd /etc/inspircd/
head -n 1 inspircd.conf
cd /etc/inspircd/.md/
head -n 1 motd.txt
head -n 1 opermotd.txt
head -n 1 rules.txt
cd /etc/inspircd/.cf/
head -n 1 opers.conf 
head -n 1 ssl.conf 
head -n 1 helpop.conf
head -n 1 permchannels.conf
cd ~


#证书生成
read -p "是否生成证书 yes/no(空证书)/其他(结束): " input
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

    echo "所有证书生成完毕,正在执行剩下的命令"
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










