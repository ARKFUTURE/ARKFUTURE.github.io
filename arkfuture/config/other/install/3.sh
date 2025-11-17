if [ "$(id -u)" -ne 0 ]; then
    echo "错误: 请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
echo "---->>配置导入脚本,仅适于ARKFUTURE配置,进行中"
cd /etc/inspircd
rm -rf *
mkdir conf
mkdir txt
curl -L -O --anyauth --user ##USERNAME##:##PASSWORD## http://frp.freefrp.net:10240/inspircd.conf
curl -L -O --anyauth https://git.io/GeoLite2-Country.mmdb
read -rp "是否要生成自签名证书？ [y/N] "
if [[ "${ans,,}" == "y" || "${ans,,}" == "yes" ]]; then
openssl req -x509 -newkey rsa:4096 -sha256 -days 30 -nodes -keyout key.pem -out cert.pem -subj "/CN=irc.arkfuture.test" -addext "extendedKeyUsage = serverAuth"
echo "成功生成自签名证书,证书仅用于测试环境"
else
echo "未生成任何证书,请稍自行获取证书并修改/usr/share/inspircd/deploy-ssl.sh后执行此移动证书脚本"
fi
cd /etc/inspircd/conf
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/conf/modules.conf
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/conf/helpop.conf
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/conf/opers.conf
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/conf/ascii.conf
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/conf/generic.conf
cd /etc/inspircd/txt
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/txt/motd.txt
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/txt/opermotd.txt
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/txt/quotes.txt
curl -L -O https://arkfuture.top/ARKFUTURE/CONFIG/inspircd/txt/rules.txt
cd /etc/inspircd/
chown -R irc:irc /etc/inspircd/
find /etc/inspircd -type d -exec chmod 755 {} \;
find /etc/inspircd -type f -exec chmod 640 {} \;
cd ~
echo "---->>配置导入脚本,仅适于ARKFUTURE配置,进行中"