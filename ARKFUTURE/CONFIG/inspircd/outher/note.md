# 自行编译!!!!
* 符合Debian 文件目录归纳标准
* 如果您需要省事的编译
* 请下载我们的预编译包 直接解压 使用make -j5 install安装 

# 编译前命令
```
sudo apt-get update
sudo apt-get install -y build-essential wget libssl-dev 
wget https://mirror.ghproxy.com/https://github.com/inspircd/inspircd/archive/refs/tags/v4.5.0.tar.gz
tar -xzf v4.5.0.tar.gz 
rm -rf v4.5.0.tar.gz
mv inspircd-4.5.0 inspircd
cd inspircd
#启用插件
sudo ./configure --enable-extras ssl_openssl
``` 
* 然后使用sudo ./configure 生成 ./.configure/ 配置文件目录
* 替换./configure/cache.cfg 完成相关目录修改 使用sudo

```
# 遇到 这些 使用 yes (使用root用户及root用户组)
Are you sure you want to build as the root group?
[no] => yes

Are you sure you want to build as the root user?
[no] => yes
``` 


# 编译时的 ./.configure/cache.cfg
```
GROUP root
USER root
BINARY_DIR /usr/bin
MODULE_DIR /usr/lib/inspircd
MANUAL_DIR /usr/share/man
RUNTIME_DIR /var/lib/inspircd
LOG_DIR /var/log/inspircd
CONFIG_DIR /etc/inspircd
DATA_DIR /var/lib/inspircd
EXAMPLE_DIR /usr/share/doc/inspircd/examples
SCRIPT_DIR /usr/bin
BASE_DIR /usr
DISABLE_OWNERSHIP 0
HAS_CLOCK_GETTIME 1
HAS_ARC4RANDOM_BUF 1
HAS_GETENTROPY 1
VERSION 1
SOCKETENGINE epoll
CXX c++
UID 0
GID 0
``` 

# 开始编译
```
sudo make
sudo make install
```


### 编译的时候遇到：这些配置符合 Debian 的 FHS 标准
```

Currently, InspIRCd is configured with the following paths:

Binary: /home/arkfuture/inspircd/run/bin
Config: /home/arkfuture/inspircd/run/conf
Data:   /home/arkfuture/inspircd/run/data
Log:    /home/arkfuture/inspircd/run/logs
Manual: /home/arkfuture/inspircd/run/manuals
Module: /home/arkfuture/inspircd/run/modules
Script: /home/arkfuture/inspircd/run

Do you want to change these settings?

[no] => yes

In what directory do you wish to install the InspIRCd base?
[/home/arkfuture/inspircd/run] => /usr

In what directory should the InspIRCd binary be placed?
[/usr/bin] => /usr/bin

In what directory are configuration files to be stored?
[/usr/conf] => /etc/inspircd

/etc/inspircd does not exist. Create it?
[yes] => yes

In what directory are variable data files to be stored?
[/usr/data] => /var/lib/inspircd

/var/lib/inspircd does not exist. Create it?
[yes] => yes

In what directory are log files to be stored?
[/usr/logs] => /var/log/inspircd

/var/log/inspircd does not exist. Create it?
[yes] => yes

In what directory are manual pages to be placed?
[/usr/manuals] => /usr/share/man

In what directory are modules to be placed?
[/usr/modules] => /usr/lib/inspircd

/usr/lib/inspircd does not exist. Create it?
[yes] => yea

/usr/lib/inspircd does not exist. Create it?
[yes] => yes

In what directory are scripts to be placed?
[/usr] => /usr/bin


``` 
