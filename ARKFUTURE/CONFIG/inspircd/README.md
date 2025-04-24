# 安装 (对于稳定的Debian12)
* 官方deb包安装: [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/install.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/install.sh)
* ARKFUTURE全插件deb包安装: [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/installssl.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/installssl.sh)
* ARKFUTURE全插件编译安装(请自行修改编译脚本): [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/make.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/make.sh)
* 更新配置文件: [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/config.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/config.sh)
*
* ARKFUTURE 全插件服务器安装+arkfuture配置(此项目使用了第三方模块:数据库,ssl,sql认证等)(主要更新): [https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/afeconf.sh](https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/install/afeconf.sh)

# 端口

| 端口      | 配置                          |
| --------- | ----------------------------- |
| 6667-6669 | 客户端, 明文传输              |
| 6697      | 客户端, TLS传输               |
| 7000      | 服务器, 是否tls需要自行配置   |
| 8080      | websocket,是否tls需要自行配置 |
| 8081      | httpd                         |

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
``` 
* 2 管理员
```
管理员配置 都存放在 /etc/inspircd/conf/opers.conf
ARKFUTURE管理员配置 都存放与数据库中 并使用了相关的sql插件
```
* 3 配置相关
```
我们所有的模块(插件)配置(包括第额外的需要编译的插件) 都存放在 /etc/inspircd/conf/modulesconf.conf
``` 
* 4 如果您启用了SSL相关
```
配置 /etc/inspircd/conf/modulesconf.conf 中 关于SSL 的配置项目
并且在 /etc/inspircd/ssl/ 目录中 放入相关CA证书文件

!INSPIRCD 工作组 推荐使用 gnutls(默认开启tls1.3)!

详细配置
https://docs.inspircd.org/4/modules/ssl_gnutls
https://docs.inspircd.org/4/modules/ssl_openssl

我们的配置中 使用了 &SSLPath; 这样的定义符号 它会替换 /etc/inspircd/ssl/
如: &SSLPath;ca.crt 代替 /etc/inspircd/ssl/ca.crt
``` 
* 5 关于<die>
```
我们在测试配置时 会添加` <die reason="服务器正在维护，请稍后再启动。">` 标签到服务器配置中 
测试完成后会及时删除, 这时请您稍后再更新

当 InspIRCd 启动时，如果检测到配置文件中存在 `<die>` 标签，服务器会立即停止启动，并向日志或控制台输出配置中指定的消息。
``` 
* 6 关于无root 的配置 
```
因为某些原因 在配置时遇到了 
Unable to initialize m_randquote.so: Unable to read quotes from quotes: No such file or directory

所以正在排查 暂时无果 不能用
```
* 7 对于部分插件 目录的配置
```
对于启用了某些插件 所引用的文件 ircd会报错找不到文件 **官方建议使用 绝对路径**
个人测试过 使用 

&dir.config;
&dir.config;/conf/
&dir.config;/txt/

可以解决 /etc/inspircd 目录引入的问题 其他目录没试过
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
 
* 注意:
``` 
可能支持 fullchain.pem ;如果支持 请优先使用 fullchain.pem 请自行测试 

即删除 chain.pem 修改 cert.pem 为fullchain.pem

使用gnutls模块举例(使用fullchain.pem) 系统gnutls必须大于 3.7.0 版本
<sslprofile name="Clients"
            provider="gnutls"
            cafile=""
            certfile="&dir.config;/conf/fullchain.pem"
            crlfile=""
            dhfile=""
            hash="sha3-256"
            keyfile="&dir.config;/conf/key.pem"
            mindhbits="1024"
            outrecsize="2048"
            priority="NORMAL"
            requestclientcert="yes"
            strictpriority="no">

使用openssl模块举例(使用fullchain.pem) 系统openssl必须大于 3.0.15 版本
<sslprofile name="Clients"
            provider="openssl"
            cafile=""
            certfile="&dir.config;/conf/fullchain.pem"
            crlfile=""
            ciphers="DEFAULT"
            compression="no"
            dhfile=""
            ecdhcurve="prime256v1"
            hash="sha3-256"
            keyfile="&dir.config;/conf/key.pem"
            renegotiation="no"
            requestclientcert="yes"
            crlmode="chain"
            tlsv11="no"
            tlsv12="yes"
            tlsv13="yes">

大多数服务器（如 Nginx、Apache）可以直接引用fullchain.pem作为 SSL 证书
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