
function getCurrentDate() {
    const today = new Date();
    const day = today.getDate();
    const month = today.getMonth() + 1; // 注意月份从0开始
    return { day, month };
}

const titles = [
    "ARKFUTURE",
    "ARK LAB",
    "ARKFUTURE STUDIO/GROUP/TEAM",
    "技术无止,勇于创新",
    "以史为镜,洞察未来"
];
const COLS = 20;          // 模拟终端列宽，自己看着改
let idx = 0;              // 当前句子
let head = 0;             // 下一个要打印的字符下标
let line = new Array(COLS).fill(' '); // 滑动窗口缓冲区

function scrollChar() {
    const cur = titles[idx];

    if (head < cur.length) {
        // 还有字符没打完：窗口右滑
        line.shift();               // 最左边掉出
        line.push(cur[head]);       // 新字符从右边进来
        head++;
    } else {
        // 一句打完了，清屏（全填空格）
        if (line.some(ch => ch !== ' ')) {
            line.fill(' ');
        } else {
            // 清屏已完成，切到下一句
            idx = (idx + 1) % titles.length;
            head = 0;
        }
    }

    document.title = line.join('');
}

document.addEventListener('DOMContentLoaded', () => {
    setInterval(scrollChar, 80);   // 80 ms 一帧
});

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
    typeWriter();   // 启动打字机效果（不再需要原来的 setInterval(updateTitle,1500)）
});
