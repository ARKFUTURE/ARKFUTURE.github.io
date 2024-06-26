echo "需要ROOT权限执行本脚本"
echo "此脚本为Debian系统安装Suricata后的升级操作"
suricata-update
mv -f /var/lib/suricata/rules/suricata.rules /etc/suricata/rules/suricata.rules
mv -f /var/lib/suricata/rules/classification.config /etc/suricata/classification.config
echo "配置文件正确性检查"
suricata -c /etc/suricata/suricata.yaml -T -v
systemctl stop suricata
systemctl restart suricata