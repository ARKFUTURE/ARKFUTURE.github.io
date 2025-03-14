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
1.Could not read "/etc/inspircd/inspircd.conf" for include: Permission denied 
原因是 inspircd-systemctl 默认使用irc用户执行inspircd程序 所加载的/etc/inspircd权限不够 (请自行为您的 /etc/inspircd/ 目录下文件授予 777 权限 [chmod 777 /etc/inspircd/ -R)]
2.同时 还有 /var/log/inspircd 目录不能写的 报错 [.log 授予 777 权限]


我们团队直接使用 root用户 来执行 启动inspircd的命令 [root@hostname:~# inrpircd]
并使用 [pkill -f inspircd 来关闭程序]

3.有可能没有inspircd.service文件 (个人解决方法) 复制一个并重载 
https://github.com/inspircd/inspircd/blob/insp4/make/template/inspircd.service
cp inspircd.service /etc/systemd/system/
systemctl daemon-reload

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

# 所有文件均为示例 不在正式环境中使用 仅用于基础测试 如果用在正式环境请修改相关配置(如:管理员名称及密码 ssl配置 频道设置 等文件)
# 记得修改管理及相关管理密码 !!!! 自行搜索 op测试用户名:arkfuture 密码:123456 正式环境请修改！！！！

# 证书的生成说明
```
生成私钥
openssl ecparam -genkey -name prime256v1 -out key.pem
生成证书签名请求（CSR）
openssl req -new -key key.pem -sha3-256 -out csr.pem 
```