#!/bin/bash
echo "inspircd 编译安装脚本 需要root权限 此脚本仅限Debian及Debian打包"
if [ "$(id -u)" -eq 0 ]; then
echo "现在是root用户权限"
sleep 3
echo "开始执行编译脚本"
apt-get update
apt-get install -y build-essential checkinstall wget libargon2-dev libmaxminddb-dev libpsl-dev libldap2-dev libpq-dev libsqlite3-dev libpcre2-dev libre2-dev libgnutls28-dev libssl-dev pkg-config
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
checkinstall -D --default --pkgname="inspircd" --pkgversion="4.6.0"
echo "安装"
apt install ./inspircd*.deb
echo "安装完成"
else
    echo "您现在不是root用户权限,请提权后再次执行脚本"
fi