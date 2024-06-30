echo "需要ROOT权限执行本脚本"
echo "此脚本为Debian系统安装Suricata后的升级操作"
apt install wget
wget https://arkfuture.github.io/CONF/suricata/suricata.yaml
mv -f suricata.yaml /etc/suricata/suricata.yaml
chmod 644 /etc/suricata/suricata.yaml
suricata-update
cd /etc/suricata/suricata.yaml
cp /var/lib/suricata/rules/suricata.rules /etc/suricata/rules/suricata.rules
cp /var/lib/suricata/rules/classification.config /etc/suricata/classification.config
chmod 644 suricata.rules
chmod 644 classification.config
echo "配置文件正确性检查"
suricata -c /etc/suricata/suricata.yaml -T -v
systemctl stop suricata
systemctl restart suricata