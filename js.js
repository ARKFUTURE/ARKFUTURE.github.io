//终端
document.addEventListener('DOMContentLoaded', function() {  
    const terminal = document.getElementById('terminal');  
    const input = document.getElementById('input');  
  
    // 模拟终端输出  
    function typeEffect(text) {  
        let index = 0;  
        let interval = setInterval(function() {  
            if (index < text.length) {  
                terminal.textContent += text.charAt(index);  
                index++;  
            } else {  
                clearInterval(interval);  
                terminal.textContent += '\n'; // 添加新行以便输入命令  
                input.focus(); // 输入命令后自动聚焦到输入框  
            }  
        }, 80); // 延迟100毫秒  
    }  
  
    // 监听输入框的回车事件  
    input.addEventListener('keypress', function(event) {  
        if (event.key === 'Enter') {  
            const command = input.value.trim();  
            const message = ''; // 用于清空输入框后的新值  
            input.value = message;  
  
            if (command === 'help') {  
                typeEffect("欢迎使用终端 \n 命令有: web irc proxy todo rss\n");  
            } 
            if (command === 'web') {  
                typeEffect("网站服务简介: \n 我们有网站主站,网站快速链接,网站导航 \n 网站主站是我们所有服务和简介的集合 \n 快速链接是方便快速到其他站,如搜索等直接打开搜索结果 \n 网站导航是方便我们快速使用的,如dns地址等等\n");  
            } 
            if (command === 'irc') {
                typeEffect("irc服务简介: \n irc作为一个老牌的聊天服务器 有很悠久的历史\n 经过不断发展和改进 已经非常稳定 \n 现在我们搭建属于自己的irc服务器\n 用来对外匿名交流技术 对内实时聊天协作 \n 请看我们的 #irc ");  
            }
            if (command === 'proxy') {  
                typeEffect("proxy服务简介: \n proxy代理服务是我们内网专属服务, \n 使用内网服务需要进入irc申请 \n 申请内网后可以使用我们的资源库和其他内网匿名服务\n");  
            } 
            if (command === 'todo') {  
                typeEffect("todo简介: \n todolist 是我们最近安排的列表, \n 之前我们使用webcal 发现效果不好,\n 现在直接在网站上嵌入TODOlist\n");  
            } 
            if (command === 'rss') {  
                typeEffect("rss简介: \n rss我们分为两个, \n 一个是普通的订阅, 一个是网络安全的漏洞更新订阅, \n 第二个是我们有往irc的安全频道添加了, 方便我们空间安全人员及时了解\n");  
            } 
  
            // 可以在这里添加更多命令的处理逻辑  
        }  
    });  
});
