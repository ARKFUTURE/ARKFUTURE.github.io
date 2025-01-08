
# 编译
```
sudo apt-get update
sudo apt-get install -y build-essential wget libssl-dev libpq-dev
wget https://github.com/inspircd/inspircd/archive/refs/tags/v4.5.0.tar.gz
tar -xzf v4.5.0.tar.gz 
rm -rf v4.5.0.tar.gz
mv inspircd-4.5.0 inspircd
cd inspircd
sudo ./configure --enable-extras ssl_openssl 
sudo ./configure --system
sudo make install -j6
``` 
