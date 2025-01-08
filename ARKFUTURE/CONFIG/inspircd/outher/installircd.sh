echo "inspircd 初始化 (安装+配置), 仅限第一次安装, 请手动启动和自行修改配置"
apt update && apt upgrade && apt install -y wget build-essential
wget https://mirror.ghproxy.com/https://github.com/inspircd/inspircd/releases/download/v4.5.0/inspircd_4.5.0.deb12u1_amd64.deb
chmod 777 inspircd_4.5.0.deb12u1_amd64.deb
apt install ./inspircd_4.5.0.deb12u1_amd64.deb -y
rm -rf ./inspircd_4.5.0.deb12u1_amd64.deb