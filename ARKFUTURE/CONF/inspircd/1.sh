timestamp=$(date +%s)  
apt update && apt upgrade && apt install curl
cd /etc/inspircd
rm -rf *
echo "下载配置文件1"
curl https://arkfuture.github.io/CONF/inspircd/inspircd.conf
mkdir conf
cd /etc/inspircd/conf
echo "下载配置文件2"
curl https://arkfuture.github.io/CONF/inspircd/conf/helpop.conf -o helpop.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/opers.conf -o opers.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/permchannels.conf -o permchannels.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/ssl.conf -o ssl.conf
curl https://arkfuture.github.io/CONF/inspircd/conf/xline.db -o xline.db
cd /etc/inspircd
mkdir txt
cd /etc/inspircd/txt
echo "下载配置文件3"
curl https://arkfuture.github.io/CONF/inspircd/txt/motd.txt -o motd.txt
curl https://arkfuture.github.io/CONF/inspircd/txt/opermotd.txt -o opermotd.txt
curl https://arkfuture.github.io/CONF/inspircd/txt/quotes.txt -o quotes.txt
curl https://arkfuture.github.io/CONF/inspircd/txt/rules.txt -o rules.txt
echo "下载完成"
cd /etc/inspircd/
echo "$timestamp" >> updatetime
chmod 644 -R /etc/inspircd/*
chmod 644 -R /etc/inspircd/
exit