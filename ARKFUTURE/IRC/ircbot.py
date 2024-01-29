# IRC-bot
# no ssl

import socket  
import re  

  
# IRC服务器地址  
server = ''  
# 聊天频道  
channel = '#arkfuture'  
# 用户昵称  
nickname = 'AFLBOT'  
# IRC服务器端口  
port = 6667  
# 密码(若有)
password = None

# 定义全局频道变量
global user1
global cl
global user2
global hosts
global message



# 连接
ircsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # 创建一个socket对象 
ircsock.connect((server, port))  # 连接到指定的IRC服务器和端口  
handle = ircsock.makefile(mode='rw', buffering=1, encoding='utf-8', newline='\r\n')  # 创建一个文件对象，用于读写socket连接



# 向服务器发送NICK命令，设置用户昵称  
print('NICK ', nickname, file=handle)  
# 向服务器发送USER命令，提供一些用户信息  
print('USER ', nickname, nickname, nickname, ':'+ nickname, file=handle) 
# 向服务器发送PASS命令，提供密码(若有)
if password != None:
    print('PASS ' + password, file=handle) 


########################### for以下的为处理
while True: 
    for line in handle:  
        line = line.strip('\n\r')   # 去除接收消息的行尾换行符
        #print(line)
        


        # 初始化
        ## 您必须先用PONG响应PING，然后才能实际执行任何操作
        if "PING" in line:
            print("PONG :" + line.split(':')[1], file=handle)
        ## 加入频道
            print('JOIN ' + channel, file=handle)
            print('MODE AFLBOT +b' , file=handle)
            print("PRIVMSG " + channel + " " + "发送 'list' 获取功能列表，之后发送对应的的 数字 执行" + "\r\n", file=handle)




        if "PRIVMSG" in line and channel in line:    
            cm = re.search(r'(\w+)!(\w+)@(\d+\.\d+\.\d+\.\d+) PRIVMSG #(\w+) :(.*)', line)
            # 分割 
            user = cm.group(1)  
            cl = cm.group(2)  
            hosts = cm.group(3)  
            chchannel = cm.group(4)
            message = cm.group(5)  
            print("用户:" + user + "\n\r" + "客户端:" + cl + "\n\r" + "主机名:" + hosts + "\n\r" + "频道:" + chchannel + "\n\r" + "消息:" + message + "\n\r" )
            # 自动回复
            if message == "list":
                print("PRIVMSG " + channel + " " + "1.测试" + "\r\n", file=handle)
            if message == "1":
                print("PRIVMSG " + channel + " " + "测试" + "\r\n", file=handle)
                




        # 私聊消息处理
        elif "PRIVMSG" in line:    
            sm = re.search(r'(\w+)!(\w+)@(\d+\.\d+\.\d+\.\d+) PRIVMSG (\w+) :(.*)', line)
            # 分割
            user1 = sm.group(1)  
            cl = sm.group(2)  
            hosts = sm.group(3)  
            user2 = sm.group(4)
            message = sm.group(5)  
            print("私聊用户:" + user1 + "\n\r" + "客户端:" + cl + "\n\r" + "主机名:" + hosts + "\n\r" + "被私聊用户:" + user2 + "\n\r" + "消息:" + message + "\n\r" )
            # 自动回复
            if message == "list":
                print("PRIVMSG " + user1 + " " + "1.测试" + "\r\n", file=handle)
            if message == "1":
                print("PRIVMSG " + user1 + " " + "测试" + "\r\n", file=handle)
            




    else:  # 如果handle没有新的行，等待一段时间后再次检查  
        continue  # 跳过当前循环到下一次循环，即再次检查handle是否有新的行。

    