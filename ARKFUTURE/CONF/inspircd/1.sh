timestamp=$(date +%s)  
apt update && apt upgrade && apt install curl
cd /etc/inspircd
rm -rf *
mkdir conf
cd /etc/inspircd/conf
echo "下载配置文件"
curl https://arkfuture.github.io/CONF/inspircd/inspircd.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/helpop.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/opers.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/permchannels.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/ssl.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/xline.db
cd /etc/inspircd
mkdir txt
cd /etc/inspircd/txt
curl https://arkfuture.github.io/CONF/inspircd/txt/motd.txt
curl https://arkfuture.github.io/CONF/inspircd/txt/opermotd.txt
curl https://arkfuture.github.io/CONF/inspircd/txt/quotes.txt
curl https://arkfuture.github.io/CONF/inspircd/txt/rules.txt
echo "下载完成"
cd /etc/inspircd/
echo "$timestamp" >> updatetime
chmod 644 -R /etc/inspircd/*
chmod 644 -R /etc/inspircd/
exit