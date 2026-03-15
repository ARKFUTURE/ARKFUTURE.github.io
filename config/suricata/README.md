```
查看日志
tail /var/log/suricata/suricata.log 
告警日志
tail /var/log/suricata/fast.log

安装 Debian
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt-get update
sudo apt-get install suricata

更新规则
更新的规则，只要运行 sudo suricata-update

使用其他规则 
sudo suricata-update update-sources
然后看看什么是可用的规则源
sudo suricata-update list-sources
使用规则源
sudo suricata-update enable-source oisf/trafficid
sudo suricata-update
然后更新 
suricata-update
```
