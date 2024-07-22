#!/bin/bash 

apt update && apt upgrade && apt install wget build-essential cmake -y
wget https://mirror.ghproxy.com/https://github.com/inspircd/inspircd/releases/download/v4.1.0/inspircd_4.1.0.deb12u1_amd64.deb
wget https://mirror.ghproxy.com/https://github.com/anope/anope/archive/refs/tags/2.1.7.zip
wget https://arkfuture.github.io/ARKFUTURE/CONF/inspircd/2.sh
wget https://arkfuture.github.io/ARKFUTURE/CONF/anope/anope.zip