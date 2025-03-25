# 安装及问题
* 编译安装：[编译安装](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/make.sh)
* deb包安装: [deb包安装](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install.sh)
* 更新配置文件: [更新配置文件](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/config.sh)
* 我们在测试配置时 会添加 <die reason="服务器正在维护，请稍后再启动。"> 标签 测试完成后会及时删除()
* * 当 InspIRCd 启动时，如果检测到配置文件中存在 <die> 标签，服务器会立即停止启动，并向日志或控制台输出配置中指定的消息。
*
*
* 在我的实践过程中 会遇到报错 :
```
(编译安装后)使用systemctl时出错: 
1.因为 INSPIRCD 工作组就是这样设计的 需要自行添加
1.1.复制一个并重载 
https://github.com/inspircd/inspircd/blob/insp4/make/template/inspircd.service
cp inspircd.service /etc/systemd/system/
systemctl daemon-reload

2.对于无systemctl文件:
我们团队直接使用 root用户 来执行 启动inspircd的命令 [root@hostname:~# inrpircd]
并使用 [pkill -f inspircd 来关闭程序]
``` 

# ARKFUTURE inspircd 基础配置
* 完整的 /etc/inspirc/ 目录应该为: 
* 如果不是如下样式,请执行 ./config.sh 来重新下载所有配置文件
* 如果还不懂 请提问给我:arkfuturestudio@gmail.com 
```
/etc/inspircd
    --inspircd.conf
    --ssl/
    --conf/
    --txt/
``` 

# 目录和文件说明
```
    --inspircd.conf #是inspircd的配置文件
    --ssl/ #ssl模块及安全证书相关的配置目录(如果要使用ssl请参照https://docs.inspircd.org/4/modules/ssl_openssl 修改)
    --conf/ #一般模块的配置目录(请参照 https://docs.inspircd.org/4/modules/ 修改)
    --txt/ #MOTD文档所在的目录 (请按需修改)
``` 

# other目录的说明
* 此目录是其他关于irc的配置
* 包括 ircd 及 客户端 和 bot 的相关软件的所有配置

# 重要！自己编译安装包
* 直接使用 build.sh 编译全部插件的软件包(ARKFUTURE修改)
* https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/tag/20250310
