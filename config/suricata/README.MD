```
apt-get install suricata

更新规则
suricata-update

使用其他规则 
suricata-update update-sources
然后看看什么是可用的规则源
suricata-update list-sources
使用规则源
suricata-update enable-source oisf/trafficid
suricata-update
然后更新 
suricata-update


查看日志
tail /var/log/suricata/suricata.log 
告警日志
tail /var/log/suricata/fast.log
```
