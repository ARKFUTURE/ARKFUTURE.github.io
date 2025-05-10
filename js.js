    // 获取当前日期
    function getCurrentDate() {
        const today = new Date();
        const day = today.getDate();
        const month = today.getMonth() + 1; // 注意月份从0开始
        return { day, month };
    }

    // 设置标题的变化
    const titles = ["ARKFUTURE", "技术无止,勇于创新", "以史为镜,洞察未来"];
    let currentIndex = 0;

    function updateTitle() {
        currentIndex = (currentIndex + 1) % titles.length;
        document.title = titles[currentIndex];
    }

    let counter = 0;
    function incrementCounter() {
        const now = new Date();
        const utcString = now.toUTCString();
        const timestamp = String(now.getTime());
        const localString = now.toString();
        console.log(`计: ${counter}; 时: ${localString}; UTC: ${utcString}; 戳: ${timestamp};`);
        // document.cookie = `utcTIME=${utcString};`;
        // document.cookie = `locTIME=${localString};`;
        // document.cookie = `timestamp=${timestamp};`;
        // sessionStorage.setItem('utcTIME', utcString);
        // sessionStorage.setItem('locTIME', localString);
        // sessionStorage.setItem('timestamp', timestamp);
        counter++;
    }

    // 动态加载CSS文件
    function loadCSS() {
        const link = document.createElement('link');
        link.rel = 'stylesheet';
        link.href = 'theme.css';
        document.head.appendChild(link);
    }

    function UA() {
        if ( /curl|wget|libcurl/i.test(navigator.userAgent)) { 
            window.location.replace("/ARKFUTURE/MD/index.md");  
        }
}


    // 页面加载时执行
    window.onload = function() {
        loadCSS();
        UA();
        setInterval(incrementCounter, 1000);
        setInterval(updateTitle, 1500);
    };