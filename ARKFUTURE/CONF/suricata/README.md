
```
suricata-update
/etc/suricata/suricata.yaml
cp /var/lib/suricata/rules/suricata.rules /etc/suricata/rules/suricata.rules
cp /var/lib/suricata/rules/classification.config /etc/suricata/classification.config
配置文件正确性检查
suricata -c /etc/suricata/suricata.yaml -T -v
重启
systemctl restart suricata
查看日志
tail /var/log/suricata/suricata.log 
告警日志
tail /var/log/suricata/fast.log

searchsploit -u 更新漏洞库
```