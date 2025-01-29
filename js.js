    // 获取当前日期
    function getCurrentDate() {
        const today = new Date();
        const day = today.getDate();
        const month = today.getMonth() + 1; // 注意月份从0开始
        return { day, month };
    }

    // 根据日期加载不同的CSS
    function loadCSS() {
        const date = getCurrentDate();
        const cssFiles = {
            '12-25': 'theme/christmas.css',   // 圣诞节
            '1-1': 'theme/newyear.css'       // 新年
        };
        const dateKey = `${date.month}-${date.day}`;
        const cssFile = cssFiles[dateKey] || 'theme/default.css';

        // 创建link标签加载CSS
        const link = document.createElement('link');
        link.rel = 'stylesheet';
        link.href = cssFile;
        document.head.appendChild(link);
    }

    // 设置标题的变化
    const titles = ["⫷ARKFUTURE⫸", "⫷方舟未来⫸", "技术无止,勇于创新", "以史为镜,洞察未来"];
    let currentIndex = 0;

    function updateTitle() {
        currentIndex = (currentIndex + 1) % titles.length;
        document.title = titles[currentIndex];
    }

    let counter = 0;
    function incrementCounter() {
        const now = new Date();
        const T1 = window.performance.now();
        const T2 = Date.now();
        const utcString = now.toUTCString();
        const UTC = now.getTime();
        const localString = now.toString();
        console.log(`计数: ${counter}; 本地时: ${localString}; UTC时: ${utcString}; 戳: ${UTC};`);
        console.log(`$(T1) $(T2)`);
        counter++;
    }

    // 页面加载时执行
    window.onload = function() {
        loadCSS();
        setInterval(updateTitle, 1500);
        setInterval(incrementCounter, 1000);
        setInterval(function() { loadCSS(); }, 60000); 
    };