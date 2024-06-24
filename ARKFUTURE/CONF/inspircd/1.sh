timestamp=$(date +%s)  
apt update && apt upgrade && apt install wget
cd /etc/inspircd
rm -rf *
echo "下载配置文件1"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/inspircd.conf
mkdir conf
cd /etc/inspircd/conf
echo "下载配置文件2"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/helpop.conf
echo "下载配置文件2"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/opers.conf
echo "下载配置文件2"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/permchannels.conf
echo "下载配置文件2"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/ssl.conf
echo "下载配置文件2"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/xline.db
cd /etc/inspircd
mkdir txt
cd /etc/inspircd/txt
echo "下载配置文件3"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/txt/motd.txt
echo "下载配置文件3"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/txt/opermotd.txt
echo "下载配置文件3"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/txt/quotes.txt
echo "下载配置文件3"
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/txt/rules.txt
echo "下载完成"
cd /etc/inspircd/
echo "$timestamp" >> updatetime
chmod 644 -R /etc/inspircd/*
chmod 644 -R /etc/inspircd/
exit