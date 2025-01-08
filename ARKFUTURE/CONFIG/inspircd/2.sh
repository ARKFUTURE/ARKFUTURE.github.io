#!/bin/bash
# 编译 inspircd 最新版

# MAKE
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev wget

wget https://github.com/inspircd/inspircd/archive/refs/tags/v4.5.0.tar.gz
tar -xzf v4.5.0.tar.gz
cd inspircd-4.5.0

./configure --enable-openssl --prefix=/usr --sysconfdir=/etc/inspircd
make
sudo make install

sudo mkdir -p /etc/inspircd/modules /etc/inspircd/conf
sudo cp docs/conf/inspircd.conf.example /etc/inspircd/conf/inspircd.conf

echo "Done。"
