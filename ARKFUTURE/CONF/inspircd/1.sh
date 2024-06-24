timestamp=$(date +%s)  
apt update && apt upgrade && apt install wget
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/inspircd.conf
cd /etc/inspircd/conf
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/helpop.conf
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/opers.conf
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/permchannels.conf
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/ssl.conf
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/ascii.conf
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/conf/xline.db
cd /etc/inspircd/txt
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/txt/motd.txt
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/txt/opermotd.txt
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/txt/quotes.txt
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/txt/rules.txt
cd /etc/inspircd/
echo "$timestamp" >> updatetime
chmod -x -R /etc/inspircd/*
chmod -x -R /etc/inspircd/
exit