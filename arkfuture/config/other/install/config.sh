###### INSPIRCD配置
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/inspircd.conf
touch cert.pem
touch key.pem
read -rp "是否要生成自签名证书？ [y/N] " ans
if [[ ${ans,,} == @(y|yes) ]]; then
    openssl req -x509 -newkey rsa:4096 -sha256 -days 360 -nodes -keyout key.pem -out cert.pem -subj "/CN=irc.arkfuture.test" -addext "extendedKeyUsage = serverAuth"
    echo "成功生成自签名证书,证书仅用于测试环境"
else
    echo "未生成任何证书,请稍自行获取证书并修改/usr/share/inspircd/deploy-ssl.sh后执行此移动证书脚本"
fi
cd /etc/inspircd/conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/modules.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/helpop.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/opers.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/ascii.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/links.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/generic.conf
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/conf/dnsbl.conf
curl -L -O https://git.io/GeoLite2-Country.mmdb
touch filters.conf
cd /etc/inspircd/txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/txt/motd.txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/txt/opermotd.txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/txt/quotes.txt
curl -L -O https://arkfuture.github.io/arkfuture/config/inspircd/txt/rules.txt
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
cd ~
echo "inspircd配置下载完成,请修改相关配置以便使用"
###### ANOPE配置
cd /etc/anope
rm -rf *
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/services.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/services.motd
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/modules.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/nickserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/chanserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/operserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/botserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/global.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/memoserv.conf
curl -L -O --anyauth https://ARKFUTURE.github.io/arkfuture/config/anope/hostserv.conf
cd /etc/anope
chown root:root /etc/anope
chmod 755 /etc/anope
find /etc/anope -type f -exec chown root:irc {} \;
find /etc/anope -type f -exec chmod 640 {} \;
cd ~
echo "anope配置文件下载完成,请修改相关配置以便使用"