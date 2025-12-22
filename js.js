
function getCurrentDate() {
    const today = new Date();
    const day = today.getDate();
    const month = today.getMonth() + 1; // 注意月份从0开始
    return { day, month };
}

const titles = ["ARKFUTURE","ARK LAB","ARKFUTURE STUDIO/GROUP/TEAM","技术无止,勇于创新", "以史为镜,洞察未来"];
const COLS   = 20;               // 模拟终端宽度，自己改
const CLEAR_FRAMES = 6;          // 清屏后空屏停留帧数（80ms*6≈0.5s）

let idx   = 0;                   // 当前句子
let head  = 0;                   // 下一个待打印字符下标
let line  = Array(COLS).fill(' ');
let state = 'PRINT';             // 两种状态：'PRINT' 或 'CLEAR'
let clearCnt = 0;                // 已经空屏了几帧

function scrollChar() {
    const cur = titles[idx];

    if (state === 'PRINT') {
        if (head < cur.length) {
            // 窗口右滑
            line.shift();
            line.push(cur[head]);
            head++;
        } else {
            // 一句打完了，进入清屏状态
            state = 'CLEAR';
            clearCnt = 0;
        }
    } else { // state === 'CLEAR'
        if (clearCnt === 0) {
            line.fill(' ');        // 第一次进入清屏时把整行变空格
        }
        clearCnt++;
        if (clearCnt >= CLEAR_FRAMES) {
            // 空屏停留结束，切到下一句，回到打印状态
            idx  = (idx + 1) % titles.length;
            head = 0;
            state = 'PRINT';
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
