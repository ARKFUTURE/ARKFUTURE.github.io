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

# 配置编译
* 配置编译时 吧inspircd的conf目录改为 /etc/inspircd
* 其余的看您自己的需要

# 开始编译
`make install -j6`
即可使用