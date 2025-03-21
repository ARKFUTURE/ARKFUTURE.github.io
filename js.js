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
    const titles = ["ARKFUTURE", "方舟未来", "技术无止,勇于创新", "以史为镜,洞察未来"];
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

    //乱码
    document.addEventListener('DOMContentLoaded',  () => {
        class LMDecoder {
            constructor() {
                this.targetElement  = document.querySelector('.LM'); 
                this.TOTAL_DURATION = 1500;  // 总时长10秒 
                this.FLICKER_INTERVAL = 100;  // 乱码刷新频率 
                this.SYMBOL_POOL = ['#','$','%','&','*','@','~','\\','/','|','^'];
                this.initEngine(); 
            }

            initEngine() {
                // 动态分割字符 
                this.originalText  = this.targetElement.textContent; 
                this.targetElement.innerHTML  = [...this.originalText].map((char,  i) => 
                    `<span class="${i === 0 ? 'revealed' : ''}">${i === 0 ? char : this.generateFlickerText()}</span>` 
                ).join('');
                this.cells  = this.targetElement.querySelectorAll('span'); 
                this.stageIndex  = 0;
                this.startDecoding(); 
                this.addResponsiveHandler(); 
            }

            generateFlickerText() {
                // 生成混合字符（50%符号，30%字母，20%数字）
                const len = 3 + Math.floor(Math.random()  * 5);
                return Array.from({length:  len}, () => {
                    const rand = Math.random(); 
                    if (rand < 0.5) return this.SYMBOL_POOL[Math.random()*this.SYMBOL_POOL.length|0];
                    if (rand < 0.8) return String.fromCharCode(65  + Math.random()*26); 
                    return String.fromCharCode(48  + Math.random()*10); 
                }).join('');
            }

            startDecoding() {
                // 双引擎驱动 
                this.flicker  = setInterval(() => {
                    Array.from(this.cells).slice(this.stageIndex  + 1).forEach(cell => {
                        if (!cell.classList.contains('revealed'))  {
                            cell.textContent  = this.generateFlickerText(); 
                        }
                    });
                }, this.FLICKER_INTERVAL);

                this.progress  = setInterval(() => {
                    if (this.stageIndex  < this.cells.length  - 1) {
                        this.stageIndex++; 
                        const current = this.cells[this.stageIndex]; 
                        current.classList.add('revealed'); 
                        current.textContent  = this.originalText[this.stageIndex]; 
                        current.style.animation  = 'terminal-glitch 0.4s';
                        setTimeout(() => current.style.animation  = '', 400);
                    } else {
                        clearInterval(this.progress); 
                        setTimeout(() => this.reset(),  25000);
                    }
                }, this.TOTAL_DURATION / (this.cells.length  - 1));
            }

            addResponsiveHandler() {
                const rescale = () => {
                    const baseSize = Math.min(window.innerWidth  * 0.08, 64);
                    this.targetElement.style.fontSize  = `${baseSize}px`;
                    this.targetElement.style.letterSpacing  = `${baseSize * 0.15}px`;
                };
                window.addEventListener('resize',  rescale);
                rescale();
            }

            reset() {
                clearInterval(this.flicker); 
                clearInterval(this.progress); 
                this.stageIndex  = 0;
                this.cells.forEach((cell,  i) => {
                    cell.classList.remove('revealed'); 
                    cell.textContent  = i === 0 ? this.originalText[0]  : this.generateFlickerText(); 
                });
                this.startDecoding(); 
            }
        }

        new LMDecoder();
    }); 

    // 页面加载时执行
    window.onload = function() {
        loadCSS();
        setInterval(incrementCounter, 1000);
        setInterval(updateTitle, 1500);
        setInterval(function() { loadCSS(); }, 60000); 
    };