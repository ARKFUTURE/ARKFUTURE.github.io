function HiddenPage() {  
    var text = document.body;  
    text.style.display = 'none'
    setTimeout(function() {
        alert('哈哈哈，你被我整蛊了!');  
        text.style.display = 'block'
    }, 3000); // 持续3秒后停止  

}  
HiddenPage();  