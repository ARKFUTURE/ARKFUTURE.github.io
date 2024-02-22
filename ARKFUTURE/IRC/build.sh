#!/bin/bash  
echo "脚本版本 :3 "
echo "从源码构建INSPIRCD "
echo "适用于Debian系统 "
echo "更新软件包 "
apt update && apt upgrade -y
echo "安装依赖 "
apt install wget curl git build-essential openssl gnutls-bin -y
apt reinstall cmake -y
echo "cd到~ "
cd ~
echo "获取源代码 "
git clone --branch insp3 "https://github.com/inspircd/inspircd.git"
chmod 777 ./inspircd/ -R
cd ./inspircd
echo "启用使用第三方依赖的模组 "
# 启用OpenSsl
./configure --enable-extras ssl_openssl
echo "开始编译安装 "
echo "如果您在上一步中启用了TLS(SSL)模块,则系统将询问您是否要生成自签名证书以用于测试目的.如果你想这样做，然后输入"yes",按回车键继续,并填写它提示你的细节。否则,请按enter跳过此步骤。"
sleep 4s
make install
echo "安装完成,您可继续配置 "




