# 说明
## 安装 kamailio 和 Mariadb
```bash
* apt install mariadb-server kamailio kamailio-*
```

## 配置 Kamailio 连接数据库并创建数据库
* 配置mariadb
* 在mariadb中创建kamailio用户及数据库
```sql
-- 改root密码
ALTER USER 'root'@'localhost' IDENTIFIED BY 'ROOT@12345678';

-- 建库
CREATE DATABASE kamailio CHARACTER SET utf8mb4;

-- 建读写账号
CREATE USER 'kamailio'@'localhost' IDENTIFIED BY 'KA@12345678';
GRANT ALL PRIVILEGES ON kamailio.* TO 'kamailio'@'localhost';

-- 建只读账号
CREATE USER 'kamailioro'@'localhost' IDENTIFIED BY 'KARO@12345678';
GRANT SELECT ON kamailio.* TO 'kamailioro'@'localhost';

FLUSH PRIVILEGES;
```
* 配置kamctlrc 本站给出
* 初始化数据库命令: kamdbctl create
* 配置kamailio.cfg 本站给出
* 启动 systemctl restart kamailio
* 管理用户

## rtpengine rtp转发 (可选)
* 安装 rtpengine
```bash
apt-get install rtpengine
```

* 配置
```text
rtpengine 配置的优化已经在本站有写 可以直接使用 (关闭了无用的端口 保持安全)
```

* 配置kamctlre
```
kamctlre 的模板已经有 rtpengine 可以直接注释使用

但是你需要修改对应的路由逻辑,这些逻辑询问ai可以给出
```