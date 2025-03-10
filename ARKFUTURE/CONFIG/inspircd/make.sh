#!/bin/bash
echo "inspircd 编译安装脚本 需要root权限 Debian"
if [ "$(id -u)" -eq 0 ]; then
echo "现在是root用户权限"
sleep 3
echo "开始执行编译脚本"
apt-get update
apt-get install -y build-essential wget libargon2-dev libmaxminddb-dev libpsl-dev libldap2-dev libpq-dev libsqlite3-dev libpcre2-dev libre2-dev libgnutls28-dev libssl-dev pkg-config
wget https://ghfast.top/https://github.com/inspircd/inspircd/archive/refs/tags/v4.6.0.tar.gz
tar -xzf v4.6.0.tar.gz 
rm -rf v4.6.0.tar.gz
mv inspircd-4.6.0 inspircd
cd inspircd
#./configure --enable-extras --disable-extras
./configure --system
sleep 3
echo "启用了以下插件:"
./configure --list
sleep 3
make install -j5
sleep 3
cd ..
rm -rf ./inspircd/
systemctl daemon-reload
echo "编译安装完成,开始下载初始配置到/etc/inspircd/"
cd ~
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/usessl/config.sh
chmod 777 ./config.sh
./config.sh
echo "若网络不好请手动重新执行./config.sh脚本 他会替换掉配置文件"
echo "脚本运行完成 请修进入/etc/inspircd改为您自己的配置文件"
cd ~
else
    echo "您现在不是root用户权限,请提权后再次执行脚本"
fi