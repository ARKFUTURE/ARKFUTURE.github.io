#!/bin/bash  
echo "脚本版本 :9 "
echo "从源码构建INSPIRCD "
echo "适用于Debian系统 "
read -p "请输入要编译INSPIRCD的版本号(如:3.17.0)： " versi
echo "更新软件包 "
apt update && apt upgrade -y
echo "安装依赖 "
apt install git build-essential autoconf libevent-dev libssl-dev openssl gnutls-bin -y
apt clean
echo "cd到~ "
cd ~
echo "获取源代码 解压 删除下载文件"
wget https://github.com/inspircd/inspircd/archive/refs/tags/v$versi.tar.gz
tar -xvf "v$versi.tar.gz"
rm -rf v$versi.tar.gz
mv inspircd-$versi inspircd
chmod 777 ./inspircd/ -R
cd ./inspircd
echo "启用使用第三方依赖的模组 "
# 启用OpenSsl
./configure --enable-extras ssl_openssl
echo "执行 ./configure 生成make文件 部分操作需要您手动操作"
echo "如果您在上一步中启用了TLS(SSL)模块,则系统将询问您是否要生成自签名证书以用于测试目的.如果你想这样做，然后输入"yes",按回车键继续,并填写它提示你的细节。否则,请按enter跳过此步骤。"
sleep 4s
make install
echo "安装完成,您可继续配置 "
clear
echo "若要卸载,在源代码的构建目录(通常是build目录)下执行make uninstall命令 "




