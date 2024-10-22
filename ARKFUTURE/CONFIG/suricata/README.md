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
```

## suricata6 和 suricata7 的配置文件说明
```
我使用Debian安装的6的配置文件 跟 乌班图安装的7的配置文件
我修改了7的部分注释文字及路径，没有翻译全部，您使用时若需要部分功能，请自行翻译完整其他的注释
此配置文件为个人基础的使用文件，请根据需求自行修改 我仅仅在Debian上测试过
如果需要用在企业等生产环境，请自行修改改所有模块后再使用并测试后使用
如果您想翻译此配置，请加入此Github并提交，我翻译的不好，请见谅
```
