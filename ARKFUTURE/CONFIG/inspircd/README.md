# 安装
* 官方deb包安装: [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install.sh)
* 全插件deb包安装: [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/installssl.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/installssl.sh)
* 编译安装：[https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/other/make.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/other/make.sh)
* 更新配置文件: [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/config.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/config.sh)
*
* ARKFUTURE 服务器安装+arkfuture配置(此项目使用了数据库服务,使用了arkfuture专属配置文件,并且使用了ssl): [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/other/afeconf.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/other/afeconf.sh)
* 
* 我们在测试配置时 会添加` <die reason="服务器正在维护，请稍后再启动。">` 标签到服务器配置中 
* 测试完成后会及时删除, 这时请您稍后再更新
* * 当 InspIRCd 启动时，如果检测到配置文件中存在 `<die>` 标签，服务器会立即停止启动，并向日志或控制台输出配置中指定的消息。

# 问题及相关帮助
* 1 systemctl 问题
```
(编译安装后)使用systemctl时出错: 

1.因为 INSPIRCD 工作组就是这样设计的 需要自行添加
1.1.复制一个并重载 
https://github.com/inspircd/inspircd/blob/insp4/make/template/inspircd.service
cp inspircd.service /etc/systemd/system/
systemctl daemon-reload

2.对于无systemctl文件:
我们团队直接使用 root用户 来执行 启动inspircd [root@hostname:~# inrpircd]
并使用 [root@hostname:~# pkill -f inspircd] 来关闭程序
``` 
* 2 各种名词及解释
```
NetAdmin：服务器管理
GlobalOp：服务器操作员
Helper：帮助员
管理员配置 都存放在 /etc/inspircd/conf/opers.conf
```
* 3 配置相关
```
我们所有的模块(插件)配置(包括第三方) 都存放在 /etc/inspircd/conf/modulesconf.conf
``` 
* 4 如果您启用了SSL相关
```
配置 /etc/inspircd/conf/modulesconf.conf 中 关于SSL 的配置项目
并且在 /etc/inspircd/ssl/ 目录中 放入相关CA证书文件

详细配置
https://docs.inspircd.org/4/modules/ssl_gnutls
https://docs.inspircd.org/4/modules/ssl_openssl

我们的配置中 使用了 &SSLPath; 这样的定义符号 它会替换 /etc/inspircd/ssl/
如: &SSLPath;ca.crt 代替 /etc/inspircd/ssl/ca.crt
``` 


# 目录和文件说明
```
* 完整的 /etc/inspirc/ 目录应该为: 
* 如果不是如下样式,请执行 ./config.sh 来重新下载所有配置文件
* 如果还不懂 请提问给我:2qwn2rrds@mozmail.com

/etc/inspircd
    --inspircd.conf
    --ssl/
    --conf/
    --txt/
``` 

```
    --inspircd.conf #是inspircd的配置文件
    --ssl/ #ssl模块及安全证书相关的配置目录(如果要使用ssl请参照https://docs.inspircd.org/4/modules/ssl_openssl 修改)
    --conf/ #一般模块的配置目录(请参照 https://docs.inspircd.org/4/modules/ 修改)
    --txt/ #MOTD文档所在的目录 (请按需修改)
``` 

# other目录的说明
* 此目录是其他关于irc的配置
* 包括 ircd 及 客户端 和 bot 的相关软件的所有配置

# 重要！
* 自己编译安装包 或者使用 直接编译安装
* 直接使用 build.sh 编译全部插件的软件包(ARKFUTURE修改)
* https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/tag/20250310
