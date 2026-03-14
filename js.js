
/**
 * @param {string} href
 * @param {string} [id]
 */
function loadCSS(href, id = 'theme-css') {
    const existing = document.getElementById(id);

    const link = document.createElement('link');
    link.rel = 'preload';
    link.as = 'style';
    link.href = href;

    link.onload = function () {
        this.rel = 'stylesheet';
        this.id = id;
        if (existing && existing !== this) existing.remove();
    };
    link.onerror = function () {
        console.warn('[loadCSS] 加载失败:', href);
        this.remove();
    };

    document.head.appendChild(link);
}

// 立即加载主题（优先读取上次用户选择，否则用默认）
loadCSS(localStorage.getItem('theme') || 'theme.css');




function getCurrentDate() {
    const today = new Date();
    const day = today.getDate();
    const month = today.getMonth() + 1; // 注意月份从0开始
    return { day, month };
}


/* ---- 标签页标题打字机 ---- */
const titles = [
    "ARKFUTURE",
    "ARK LAB",
    "ARKFUTURE STUDIO",
    "技术无止，勇于创新",
    "以史为镜，洞察未来"
];

const TYPEWRITER = {
    idx:          0,       // 当前句子索引
    pos:          0,       // 当前已显示字符数
    deleting:     false,   // 是否正在删除
    cursor:       true,    // 光标当前状态（亮/灭）
    blinking:     false,   // 是否处于闲置闪烁模式
    cursorTimer:  null,    // 光标闪烁定时器

    // 节奏参数（ms）
    TYPE_SPEED:   100,     // 打字速度
    DELETE_SPEED: 55,      // 删除速度
    PAUSE_FULL:   1600,    // 打完后停顿
    PAUSE_EMPTY:  350,     // 清空后停顿

    timer: null,

    render() {
        const text = titles[this.idx].slice(0, this.pos);
        document.title = text + (this.cursor ? '█' : ' ');
    },

    // 打字/删除中：光标常亮
    setCursorSolid() {
        clearInterval(this.cursorTimer);
        this.blinking = false;
        this.cursor = true;
    },

    // 停顿等待时：光标闪烁
    setCursorBlink() {
        if (this.blinking) return;
        this.blinking = true;
        this.cursorTimer = setInterval(() => {
            this.cursor = !this.cursor;
            this.render();
        }, 500);
    },

    step() {
        const cur = titles[this.idx];

        if (!this.deleting) {
            if (this.pos < cur.length) {
                // 打字中：光标常亮
                this.setCursorSolid();
                this.pos++;
                this.render();
                this.schedule(this.TYPE_SPEED);
            } else {
                // 打完 → 光标闪烁，停顿后开始删除
                this.setCursorBlink();
                this.schedule(this.PAUSE_FULL, () => {
                    this.deleting = true;
                    this.step();
                });
            }
        } else {
            if (this.pos > 0) {
                // 删除中：光标常亮
                this.setCursorSolid();
                this.pos--;
                this.render();
                this.schedule(this.DELETE_SPEED);
            } else {
                // 清空 → 光标闪烁，停顿后切下一句
                this.setCursorBlink();
                this.idx = (this.idx + 1) % titles.length;
                this.deleting = false;
                this.schedule(this.PAUSE_EMPTY);
            }
        }
    },

    schedule(delay, fn) {
        clearTimeout(this.timer);
        this.timer = setTimeout(fn || (() => this.step()), delay);
    },

    start() {
        this.step();
    }
};

TYPEWRITER.start();

let counter = 0;
function incrementCounter() {
    const now = new Date();
    const utcString = now.toUTCString();
    const timestamp = String(now.getTime());
    const localString = now.toString();
    console.log(`计: ${counter}; 时: ${localString}; UTC: ${utcString}; 戳: ${timestamp};`);
    counter++;
}

// 页面加载时执行
document.addEventListener('DOMContentLoaded', () => {
    setInterval(incrementCounter, 1000);

    // ---- 主题切换按钮 ----
    const themeBtns = document.querySelectorAll('.theme-btn');
    const currentTheme = localStorage.getItem('theme') || 'theme.css';

    // 高亮当前主题对应的按钮
    function updateActiveBtn(href) {
        themeBtns.forEach(btn => {
            btn.classList.toggle('active', btn.dataset.theme === href);
        });
    }
    updateActiveBtn(currentTheme);

    // 点击切换
    themeBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const href = btn.dataset.theme;
            loadCSS(href);
            localStorage.setItem('theme', href);
            updateActiveBtn(href);
        });
    });
});
