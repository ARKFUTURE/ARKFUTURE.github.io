
function getCurrentDate() {
    const today = new Date();
    const day = today.getDate();
    const month = today.getMonth() + 1; // 注意月份从0开始
    return { day, month };
}

const titles = ["ARKFUTURE","ARK LAB","ARKFUTURE STUDIO/GROUP/TEAM","技术无止,勇于创新", "以史为镜,洞察未来"];
const COLS = 18;
let idx = 0, head = 0;
let line = Array(COLS).fill(' ');
let showCursor = true;
let frame = 0;

/* 字符推送定时器：每 320 ms 才往窗口塞一个新字符 */
let charTimer = 0;
function pushChar() {
  const cur = titles[idx];
  if (head < cur.length) {
    line.shift();
    line.push(cur[head++]);
  }
}
pushChar();                       // 先打第一个字
charTimer = setInterval(pushChar, 320);

function tick() {
  const cur = titles[idx];

  /* 清屏 & 换句 */
  if (head >= cur.length && line.some(c => c !== ' ')) {
    line.fill(' ');
  } else if (head >= cur.length && line.every(c => c === ' ')) {
    /* 已清空，切下一句，重置字符定时器 */
    idx = (idx + 1) % titles.length;
    head = 0;
    clearInterval(charTimer);
    pushChar();                   // 立即打新句首字
    charTimer = setInterval(pushChar, 300);
  }

  if (++frame % 0.4 === 0) showCursor = !showCursor;

  document.title = line.join('') + (showCursor ? '_' : ' ');
}

setInterval(tick, 150);   // 160 ms 刷一次光标/清屏

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
