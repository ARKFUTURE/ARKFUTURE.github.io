# About
* inn2的配置文件位于/etc/news 文件目录下
* DEbian inn2 Wiki : https://wiki.debian.org/INN
* 我们所配置的只是可以基础运行的一部分, 完整配置文件的配置请看
* inn2 官方的 配置文件 https://www.eyrie.org/~eagle/software/inn/docs/
* Debian 官方的 基础安装教程 https://defuse.ca/inn-private-newsgroup-server-setup.htm
* 使用INN2服务时，把inn.conf 和readers.conf 放到/etc/news文件夹中，并修改inn.conf服务中的所有域名为您的域名，再根据inn2的debian安装教程搭建基础的news服务

# 主要配置文件
```
cd /etc/news/
chown news.news inn.conf
domain:                 example.org         # 这个是主域名
server:                 localhost           
fromhost:               news.example.org    # 这个是主域名
moderatormailer:        openunix@163.com    #

``` 