#!/bin/bash  
  
# 生成CA私钥  
openssl genpkey -algorithm RSA -out ca.key.pem -pkeyopt rsa_keygen_bits:2048  
  
# 使用私钥生成CA证书（自签名）  
openssl req -new -x509 -key ca.key.pem -days 365 -out ca.pem -subj "/C=HK/ST=Beijing/L=Beijing/O=Example/OU=IT/CN=Example Root CA"  
  
# 生成服务器私钥  
openssl genpkey -algorithm RSA -out key.pem -pkeyopt rsa_keygen_bits:2048  
  
# 生成证书签名请求（CSR）  
openssl req -new -key key.pem -out csr.pem -subj "/C=HK/ST=Kowloon/L=Kowloon/O=ARKFUTURE/OU=SOC/CN=域名"  
  
# 生成Diffie-Hellman参数  
openssl dhparam -out dhparams.pem 2048  
  
echo "证书和密钥文件已生成："  