# 使用方法
## 注意
* 此配置加载了一些插件 
* 您需要在 limnoria 目录下的 data 目录下 创建 Herald.db 和 Seen.db 空文件 以便更好的使用 不创建会警告 不会停止运行
* 当您直接使用 AFEBOT.conf 配置文件时 您需要重启第二次 以便所有缺失的文件都自动生成 Herald.db 和 Seen.db 貌似需要手动创建
##
* 其他的一些命令
```
登录管理员
私聊 BOT 发送:
identify 用户名 密码

查询已加载插件
list

管理员在修改配置尽量私聊 BOT
修改配置:
config 配置项 值
如:config supybot.protocols.ssl.verifyCertificates True
修改完要保存
config save
``` 