* 您可以查看我们的配置文件, 可以为我们的配置文件提出**安全相关的建议和意见**, 我们会为了IRC的**匿名性/安全性积极采纳**
# 安装 (此页面所有内容都基于 稳定的Debian 官方页面的最新版本)
# # INSPIRCD配置: 
* 官方deb包安装: https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/install.sh
* ARKFUTURE全插件deb包安装: https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/installssl.sh
* ARKFUTURE全插件编译安装(请自行修改编译脚本): https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/make.sh
* ARKFUTURE 全插件服务器安装+arkfuture配置(包含一个无作用的随机生成的测试ca证书 生产环境时需要自行替换): https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/afeconf.sh(主要更新): https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/afeconf.sh
# # ERGOIRCD配置: 
* https://arkfuture.github.io/ARKFUTURE/CONFIG/ergoircd/ircd.yaml
# # IRCBOT 配置 : 使用Limnoria
* https://arkfuture.github.io/ARKFUTURE/CONFIG/other/AFEBOT.conf

# 端口

| 端口      | 配置              |
| --------- | ----------------- |
| 6667-6669 | 客户端, 明文传输  |
| 6697      | 客户端, TLS传输   |
| 7000      | 服务器, TLS传输   |
| 6680      | websocket,TLS传输 |
| 8081      | httpd,TLS传输     |

# 说明/问题及相关帮助
* 1 systemctl 问题
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
* 2 管理员
```
管理员配置 都存放在 /etc/inspircd/conf/opers.conf

afeconf 管理员配置 都存放与数据库中 并启用了相关的sql插件
```
* 3 配置相关
```
我们所有的模块(插件)配置(包括第三方额外的需要编译的插件) 都存放在 /etc/inspircd/conf/modulesconf.conf
``` 
* 4 如果您启用了SSL相关
```
! 请参考第6项
配置 /etc/inspircd/conf/modulesconf.conf 中 关于SSL 的配置项目
并且在 /etc/inspircd/ssl/ 目录中 放入相关CA证书文件 

!INSPIRCD 工作组 推荐使用 gnutls(默认开启tls1.3)!

详细配置
https://docs.inspircd.org/4/modules/ssl_gnutls
https://docs.inspircd.org/4/modules/ssl_openssl
``` 
* 5 关于<die>
```
我们在测试配置时 会添加` <die reason="服务器正在维护，请稍后再启动。">` 标签到服务器配置中 
测试完成后会及时删除, 这时请您稍后再更新

当 InspIRCd 启动时，如果检测到配置文件中存在 `<die>` 标签，服务器会立即停止启动，并向日志或控制台输出配置中指定的消息。
``` 
* 6 对于 脚本 /usr/share/inspircd/deploy-ssl.sh 证书拷贝脚本(用于证书复制到配置文件)
```
我们的专属于ssl的目录为:
INSPIRCD_CONFIG_DIR="/etc/inspircd/conf/ssl"

如果您为了安全可以执行命令: 
find /etc/inspircd/conf/ssl/ -name "key.pem" -exec chmod 600 {} \;
find /etc/inspircd/conf/ssl/ -name "cert.pem" -exec chmod 644 {} \;
```
* 7 对于部分插件 目录的配置
```
对于启用了某些插件 所引用的文件 ircd会报错找不到文件 **官方建议使用 绝对路径**

我们建议 使用了编译的第三方模块的 建议使用如下目录配置 来避免严重的文件读取失败报错 请参照我们的afeconf配置

&dir.config;
&dir.config;/conf/
&dir.config;/conf/ssl/
&dir.config;/txt/

应该可以解决 /etc/inspircd 目录引入的问题 
``` 
* 8 对于使用官方的 INSPIRCD 版本的deb安装包
```
如果您需要在无ssl环境的 inspircd 上启用ssl
您可以使用官方的 haproxy 模组 代理使用ssl
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
* 直接使用 build.sh 编译全部插件的软件包(ARKFUTURE修改)
* https://github.com/ARKFUTURE/ARKFUTURE.github.io/releases/tag/20250310

# SSL证书
* 使用证书生成服务后 通常的 在你的域名目录中生成了以下四个证书文件
* cert.pem chain.pem fullchain.pem privkey.pem
* 对应的关系为:  

| Certbot 生成文件 | InspIRCd 配置参数 | 技术作用说明                      |
| ---------------- | ----------------- | --------------------------------- |
| `privkey.pem`    | keyfile           | 服务器私钥文件，用于 TLS 握手加密 |
| `cert.pem`       | certfile          | 域名主体证书，包含公钥信息        |
| `chain.pem`      | cafile            | 中间证书链                        |
| `fullchain.pem`  | certfile          | 合并后的完整证书链                |
 
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
    可通过编写Certbot的续订部署钩子(renewal deploy hook)解决权限问题. 例如,将以下脚本安装为/etc/letsencrypt/renewal-hooks/deploy/install-ergo-certificates(在证书续订成功后更新文件),并替换其中的example.com 为您的域名,再通过chmod 0755赋予执行权限:

----

English:
The simplest way to get valid TLS certificates is from Let's Encrypt with Certbot. 

The correct procedure will depend on whether you are already running a web server on port 80. 

If you are, follow the guides on the Certbot website; if you aren't, you can use certbot certonly --standalone --preferred-challenges http -d example.com (replace example.com with your domain).

The At this point, you should have certificates available at /etc/letsencrypt/live/example.com (replacing example.com with your domain).

You should serve fullchain.pem as the certificate and privkey.pem as its private key. 

However, these files are owned by root and the private key is not readable by the ergo role user, so you won't be able to use them directly in their current locations.

You can write a renewal deploy hook for certbot to make copies of these certificates accessible to the ergo role user. 

For example, install the following script as /etc/letsencrypt/renewal-hooks/deploy/install-ergo-certificates (which will update the certificate and key after a successful renewal), again replacing example.com with your domain name, and chmod it 0755:
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
ARKFUTURE 属于全模块deb包维护者
此站点并非是 INSPIRCD 的分支项目 我们仅仅是因为我们自己有需要而打包

全部模块deb包维护者 :ARKFUTURE studio(group) 简称 ARKFUTURE
```