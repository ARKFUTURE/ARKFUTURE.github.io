# 安装
* 编译安装：[编译安装](./make.sh)
* deb包安装: [deb包安装](./install.sh)
* 更新配置文件: [更新配置文件](./config.sh)

# ARKFUTURE inspircd 基础配置
* 需要将此目录下的所有文件及目录
* 拷贝到 /etc/inspirc/ 目录下
* 即: 
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
    --ssl/ #ssl模块及安全证书相关的配置目录
    --conf/ #一般模块的配置目录
    --txt/ #MOTD文档所在的目录
``` 

# other目录的说明
* 此目录是其他关于irc的配置
* 包括 inspircd的编译教程 一键配置脚本 安装脚本 ircbot的配置 irssi的示例配置 

# 所有文件均为示例 不在正式环境中使用 仅用于基础测试 如果用在正式环境请修改相关配置
# 记得修改管理及相关管理密码 !!!! 自行搜索

# 证书的生成说明
```
生成私钥
openssl ecparam -genkey -name prime256v1 -out key.pem
生成证书签名请求（CSR）
openssl req -new -key key.pem -sha3-256 -out csr.pem 
```