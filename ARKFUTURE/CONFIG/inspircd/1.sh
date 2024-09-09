apt update && apt upgrade && apt install wget build-essential cmake -y
wget https://mirror.ghproxy.com/https://github.com/inspircd/inspircd/releases/download/v4.3.0/inspircd_4.3.0.deb12u1_amd64.deb
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
mkdir ssl
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/inspircd.conf
cd /etc/inspircd/conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/helpop.conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/opers.conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/permchannels.conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/xline.db
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/modulesconf.conf
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/conf/ascii.conf
cd /etc/inspircd/txt
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/txt/motd.txt
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/txt/opermotd.txt
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/txt/quotes.txt
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/txt/rules.txt
cd /etc/inspircd/ssl
wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/ARKFUTURE/ARKFUTURE.github.io/main/ARKFUTURE/CONF/inspircd/ssl/ssl.conf
cd /etc/inspircd/
chmod 777 /etc/inspircd/ -R