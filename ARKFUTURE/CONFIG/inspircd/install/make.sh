#!/bin/bash
echo "inspircd 编译安装脚本 需要root权限 Debian"
echo "此脚本当前为[测试版],加载内容为[额外的模块,第三方模块,许可证不兼容的模块,可能为自己开发的第三方模块,也可能为每夜版本的ircd]"
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：请使用 sudo 或 root 权限执行本脚本"
    exit 1
fi
echo "现在是root用户权限"
sleep 3
echo "安装必要应用"
apt-get update
apt-get install -y build-essential checkinstall wget git libargon2-dev libpsl-dev libldap2-dev libpq-dev libsqlite3-dev libpcre2-dev libre2-dev libgnutls28-dev pkg-config libssl-dev libmaxminddb-dev libwww-perl
echo "下载源码包"
git clone https://github.com/inspircd/inspircd.git
cd inspircd
echo "配置编译选项"
# ./configure --enable-extras --disable-extras
# ./modulemanager upgrade
# ./modulemanager install solvemsg qrcode randomidxlines autokick profilelink
./configure --system
./configure --update
sleep 3
echo "启用了以下插件:"
./configure --list
sleep 3
echo "开始编译安装"
make -j5
make install
sleep 3
echo "编译安装完成,开始下载初始配置到/etc/inspircd/"
cd ~
wget https://arkfuture.github.io/ARKFUTURE/CONFIG/inspircd/conf/config.sh
chmod 777 ./config.sh
./config.sh
echo "若网络不好请手动重新执行./config.sh脚本 他会替换掉配置文件"
echo "脚本运行完成 请修进入/etc/inspircd改为您自己的配置文件"
cd ~