#!/bin/bash
echo "测试用!!!!!!"
echo "打包脚本 研究中"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
sleep 3
echo "开始执行编译脚本"
apt-get update
apt-get install -y build-essential checkinstall wget devscripts dh-make debhelper dpkg-dev  pkg-config libargon2-dev libmaxminddb-dev libpsl-dev libldap2-dev libpq-dev libsqlite3-dev libpcre2-dev libre2-dev libgnutls28-dev libssl-dev
wget https://ghfast.top/https://github.com/inspircd/inspircd/archive/refs/tags/v4.6.0.tar.gz
tar -xzf v4.6.0.tar.gz 
rm -rf v4.6.0.tar.gz
mv inspircd-4.6.0 inspircd
cd inspircd
#./configure --enable-extras --disable-extras
./configure --system
./configure --update
sleep 3
echo "启用了以下插件:"
./configure --list
sleep 3
echo "编译并打包为Debian12的deb包"
make -j9
