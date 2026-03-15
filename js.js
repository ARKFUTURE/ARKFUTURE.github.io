
/* ================================================================
   主题切换
   ================================================================ */

function loadCSS(href, id = 'theme-css') {
    const link = document.createElement('link');
    link.rel = 'preload';
    link.as = 'style';
    link.href = href;
    link.dataset.themeLoading = id;

    link.onload = function () {
        this.rel = 'stylesheet';
        this.id = id;
        delete this.dataset.themeLoading;
        document.querySelectorAll('#' + id).forEach(el => {
            if (el !== this) el.remove();
        });
    };
    link.onerror = function () {
        console.warn('[loadCSS] failed:', href);
        this.remove();
    };

    document.head.appendChild(link);
}

loadCSS(localStorage.getItem('theme') || 'theme0.css');

document.addEventListener('DOMContentLoaded', () => {
    const themeBtns = document.querySelectorAll('.theme-btn');
    const currentTheme = localStorage.getItem('theme') || 'theme0.css';

    function updateActiveBtn(href) {
        themeBtns.forEach(btn => {
            btn.classList.toggle('active', btn.dataset.theme === href);
        });
    }

    updateActiveBtn(currentTheme);

    themeBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const href = btn.dataset.theme;
            loadCSS(href);
            localStorage.setItem('theme', href);
            updateActiveBtn(href);
        });
    });
});


/* ================================================================
   标签页标题打字机
   ================================================================ */

const titles = [
    "ARKFUTURE",
    "ARK LAB",
    "ARKFUTURE STUDIO",
    "技术无止，勇于创新",
    "以史为镜，洞察未来"
];

const TYPEWRITER = {
    idx:         0,
    pos:         0,
    deleting:    false,
    cursor:      true,
    blinking:    false,
    cursorTimer: null,
    timer:       null,

    TYPE_SPEED:   100,
    DELETE_SPEED: 55,
    PAUSE_FULL:   1600,
    PAUSE_EMPTY:  350,

    render() {
        const text = titles[this.idx].slice(0, this.pos);
        document.title = text + (this.cursor ? '█' : ' ');
    },

    setCursorSolid() {
        clearInterval(this.cursorTimer);
        this.blinking = false;
        this.cursor = true;
    },

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
                this.setCursorSolid();
                this.pos++;
                this.render();
                this.schedule(this.TYPE_SPEED);
            } else {
                this.setCursorBlink();
                this.schedule(this.PAUSE_FULL, () => {
                    this.deleting = true;
                    this.step();
                });
            }
        } else {
            if (this.pos > 0) {
                this.setCursorSolid();
                this.pos--;
                this.render();
                this.schedule(this.DELETE_SPEED);
            } else {
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


/* ================================================================
   控制台计数器
   ================================================================ */

let counter = 0;

function incrementCounter() {
    const now = new Date();
    console.log(`计: ${counter}; 时: ${now.toString()}; UTC: ${now.toUTCString()}; 戳: ${now.getTime()};`);
    counter++;
}

document.addEventListener('DOMContentLoaded', () => {
    setInterval(incrementCounter, 1000);
});
