* 您可以查看我们的配置文件, 可以为我们的配置文件提出**安全相关的建议和意见**, 我们会为了IRC的**匿名性/安全性积极采纳**
# 安装 (此页面所有内容都基于 稳定的Debian 官方页面的最新版本)
# # INSPircd配置
* 官方deb包/本站全插件deb包+基本配置: https://arkfuture.github.io/ARKFUTURE/CONFIG/other/install/install.sh
* 文件夹: https://github.com/ARKFUTURE/ARKFUTURE.github.io/tree/main/ARKFUTURE/CONFIG/inspircd
# # HYBRIDircd配置
* 基本配置: https://arkfuture.github.io/ARKFUTURE/CONFIG/hybridircd/ircd.conf
* 文件夹: https://github.com/ARKFUTURE/ARKFUTURE.github.io/tree/main/ARKFUTURE/CONFIG/hybridircd
# # ERGOircd配置
* 基本配置: https://arkfuture.github.io/ARKFUTURE/CONFIG/ergoircd/ircd.yaml
* 文件夹: https://github.com/ARKFUTURE/ARKFUTURE.github.io/tree/main/ARKFUTURE/CONFIG/ergoircd

# 端口

| 端口      | 配置              |
| --------- | ----------------- |
| 6667-6669 | 客户端, 明文传输  |
| 6697      | 客户端, TLS传输   |
| 7000      | 服务器, TLS传输   |
| 8067      | websocket,TLS传输 |
| 8081      | httpd,TLS传输     |

# 说明/问题及相关帮助
* 1 systemctl 问题 [Debian尽量用systemdctl管理]
```
(编译安装后)使用systemctl时出错: 

1.因为 INSPIRCD 工作组就是这样设计的 需要自行添加
1.1.复制一个并重载 
https://github.com/inspircd/inspircd/blob/insp4/make/template/inspircd.service
cp inspircd.service /etc/systemd/system/
systemctl daemon-reload

2.对于无systemctl文件:

使用 root用户 来启动
[root@hostname:~# inrpircd]
关闭程序
[root@hostname:~# pkill -f inspircd]

需要 无root启动 则
[root@hostname:~# sudo -u irc inspircd]
关闭程序
[root@hostname:~# pkill -f inspircd]
``` 
* 2 管理员 (oper)
```
管理员配置 都存放在 /etc/inspircd/conf/opers.conf
!afeconf 配置 根据我们的需求 是从网络导入
```
* 3 模块 （modules）
```
模块配置 都存放在 /etc/inspircd/conf/modules.conf
!afeconf 配置 根据我们的需求 是从网络导入
``` 
* 4 SSL
```
0 参考下面的 #SSL证书生成

1 配置 /etc/inspircd/conf/modules.conf 中 关于SSL 的配置项目 (我们更改了之前的配置配置文件,以符合deploy-ssl.sh中的目录文件配置)

2修改证书续订拷贝脚本 /usr/share/inspircd/deploy-ssl.sh
在脚本中 需要修改为:
CERT_DIR="/etc/letsencrypt/live/example.com" (将example.com替换为您的域名, 也可以使用二级域名)

3 在第一次使用SSL时 对于证书文件 您可以主动执行脚本 `/usr/share/inspircd/deploy-ssl.sh` 来帮您正确拷贝证书文件

4 后续您可以使用sslrehashsignal模块, 以便在 TLS/SSL 证书更新时自动重新加载它们:
模块: https://docs.inspircd.org/4/modules/sslrehashsignal/

-------------

如果您为了安全可以执行命令: 
find /etc/inspircd/conf/ssl/ -name "key.pem" -exec chmod 600 {} \;
find /etc/inspircd/conf/ssl/ -name "cert.pem" -exec chmod 600 {} \;

详细配置
https://docs.inspircd.org/4/modules/ssl_gnutls
https://docs.inspircd.org/4/modules/ssl_openssl
``` 
* 5 关于<die>
```
我们在测试配置时 会添加` <die reason="服务器正在维护,请稍后再启动.">` 标签到服务器配置中 
测试完成后会及时删除, 这时请您稍后再更新

当 InspIRCd 启动时, 如果检测到配置文件中存在 `<die>` 标签, 服务器会立即停止启动, 并向日志或控制台输出配置中指定的消息.
``` 
* 6 对于部分插件 目录的配置
```
对于启用了某些插件 所引用的文件 ircd会报错找不到文件 **官方建议使用 绝对路径**

我们建议 使用了编译的第三方模块的 建议使用如下目录配置 来避免严重的文件读取失败报错 请参照我们的afeconf配置

&dir.config;
&dir.config;/conf/
&dir.config;/txt/

应该可以解决 /etc/inspircd 目录引入的问题 
``` 
* 7 irc互联
```
为了增强irc互联的标准性 我们将会定义我们自己的 limits(最大长度限制) 值:
cidr 32 IPv4长度
cidr 128 IPv6长度
line 512 最大irc行长度

away 200 最大离开消息长度
chan 60 最大频道名称长度
host 64 最大主机名长度
key 30 最大通频道密钥长度
kick 300 最大踢人消息长度
modes 20 单个MODE消息中可修改的非标签模式的最大数量
nick 30 最大昵称长度
quit 300 最大退出消息长度
real 130 最大真实姓名长度
topic 300 最大频道主题长度
user 10 最大用户名长度
ident 20 最大用户标识长度

modelistsize = 100 频道上可设置的列表模式(如b,e,I)的最大数量

whowas-entries 100 单个客户端最大监控条目数
whowas-entries 100 历史WhoWas记录数量
chan-list-modes 100 频道列表模式(beI)最大条目数
registration-messages 1024 注册期间最大接收消息数
multiline (max-bytes 4096, max-lines 100) 多行消息限制
``` 

# 目录和文件说明
```
* 完整的 /etc/inspirc/ 目录应该为: 
* 如果不是如下样式,请执行 ./config.sh 来重新下载所有配置文件
* 如果还不懂 请提问给我:2qwn2rrds@mozmail.com

/etc/inspircd
    --inspircd.conf
    --conf/
        --ssl/
    --txt/

-----------------

--inspircd.conf #inspircd配置文件
--ssl/ #证书存放目录
--conf/ #一般配置目录
--txt/ #MOTD文档所在的目录

``` 
* 对于官方-Debian编译 所使用的目录
```
Paths:
  Binary:  /usr/bin
  Config:  /etc/inspircd
  Data:    /var/lib/inspircd
  Example: /usr/share/doc/inspircd/examples
  Log:     /var/log/inspircd
  Manual:  /usr/share/man/man1
  Module:  /usr/lib/inspircd
  Runtime: /run/inspircd
  Script:  /usr/share/inspircd

``` 


# 重要！
* 自己编译安装包 或者使用 直接编译安装
* 直接使用 官方 的教程编译

# SSL证书生成
* 使用证书生成服务后 通常的 在你的域名目录中生成了以下四个证书文件
* cert.pem chain.pem fullchain.pem privkey.pem
* 对应的关系为:  

| Certbot 生成文件 | InspIRCd 配置参数 | 技术作用说明                      |
| ---------------- | ----------------- | --------------------------------- |
| `privkey.pem`    | `keyfile`          | 服务器私钥文件, 用于 TLS 握手加密 |
| `cert.pem`       | `certfile`          | 域名主体证书, 包含公钥信息        |
| `chain.pem`      | `cafile`            | 中间证书链                        |
| `fullchain.pem`  | `certfile`          | 合并后的完整证书链                |
 
* 使用有效的 TLS 证书
* * 在投入生产环境时,另一个主要障碍(但非常值得努力解决)是为您的域名获取有效的TLS证书(如果尚未完成):
``` 
Chinese:

获取TLS证书的最简单方式是使用Certbot从Let's Encrypt申请. 具体操作取决于您是否已在80端口运行Web服务器:

    如果已运行,请遵循Certbot官网的指南；
    如果未运行,可使用命令 certbot certonly --standalone --preferred-challenges http -d example.com (将example.com 替换为您的域名). 

证书存储路径:成功申请后,证书将保存在/etc/letsencrypt/live/example.com 目录下(替换为您的域名). 

您需要将fullchain.pem 作为证书文件,privkey.pem 作为私钥文件. 但需注意:

    这些文件默认属于root用户,且私钥对irc角色用户不可读,因此无法直接使用. 
    可通过编写Certbot的续订部署钩子(renewal deploy hook)解决权限问题.

----

English:

The simplest way to get valid TLS certificates is from Let's Encrypt with Certbot. 

The correct procedure will depend on whether you are already running a web server on port 80. 

If you are, follow the guides on the Certbot website; if you aren't, you can use certbot certonly --standalone --preferred-challenges http -d example.com (replace example.com with your domain).

The At this point, you should have certificates available at /etc/letsencrypt/live/example.com (replacing example.com with your domain).

You should serve fullchain.pem as the certificate and privkey.pem as its private key. 

However, these files are owned by root and the private key is not readable by the ergo role user, so you won't be able to use them directly in their current locations.

You can write a renewal deploy hook for certbot to make copies of these certificates accessible to the ergo role user. 
``` 

```
配置示例:
<sslprofile name="Clients"
            provider="gnutls"
            cafile="" #PEM格式CA文件的路径
            certfile="cert.pem" #PEM格式证书文件的路径
            crlfile="" #PEM格式CRL文件的路径
            dhfile="" #PEM格式DH参数文件的路径 在GnuTLS 3.6.0以上版本上无效
            hash="sha3-256" #用于TLS(SSL)客户端指纹的空格分隔哈希算法列表,前缀spki-可对WebIRC网关客户端使用SPKI指纹而非证书指纹.
            keyfile="key.pem" #PEM格式私钥文件的路径
            mindhbits="1024" #Diffie-Hellman密钥交换中使用的DH参数文件最小位数
            outrecsize="2048" #传出GnuTLS记录的最大大小
            priority="NORMAL" #GnuTLS优先级字符串
            requestclientcert="yes" #是否向客户端请求TLS(SSL)证书
            strictpriority="no"> #是否要求GnuTLS优先级字符串中的所有令牌均有效
```


# ARKFUTURE 正式配置文件 说明
* 使用了sql数据库 sqlite3
```
新建OP表
CREATE TABLE IF NOT EXISTS "oper" (
  "active" bool NOT NULL DEFAULT true,
  "name" text NOT NULL,
  "password" text NOT NULL,
  "host" text NOT NULL,
  "type" text NOT NULL,
  "hash" text,
  "account" text,
  "vhost" text,
  "commands" text,
  "chanmodes" text,
  "usermodes" text,
  "snomasks" text
);

新建user表
CREATE TABLE IF NOT EXISTS user (
    "name" text NOT NULL,
    "password" text
);

```

# 版权及源代码许可/所有人
```
项目主站: https://inspircd.org/
项目源代码: https://github.com/inspircd/

项目源代码属于原作者及源代码维护作者

ARKFUTURE 并未修改任何 INSPIRCD 源代码
ARKFUTURE 启用了所有的需要在编译时启用的插件
此站点并非是 INSPIRCD 的分支项目 我们仅仅是因为我们自己有需要而打包

全部模块deb包维护者 :ARKFUTURE studio(group) 简称 ARKFUTURE
```


* [arkfuture配置安装](https://arkfuture.github.io/ARKFUTURE/CONFIG/other/install/afeconf.sh)
