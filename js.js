
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

/* ---- 字符推送 ---- */
let charTimer = 0;
function pushChar() {
  const cur = titles[idx];
  if (head < cur.length) {
    line.shift();
    line.push(cur[head++]);
  }
}
pushChar();
charTimer = setInterval(pushChar, 320);

/* ---- 主循环 ---- */
function tick() {
  const cur = titles[idx];

  /* 1. 尾巴已打完、且窗口里只剩当前句尾巴（或已清成空格）再开始清屏 */
  if (head >= cur.length) {
    /* 窗口里还有非空格字符 → 继续清屏 */
    if (line.some(c => c !== ' ')) {
      line.shift();
      line.push(' ');          // 慢慢用空格把尾巴推出去
    } else {
      /* 已清空 → 切下一句 */
      idx = (idx + 1) % titles.length;
      head = 0;
      clearInterval(charTimer);
      pushChar();              // 立即打新句首字
      charTimer = setInterval(pushChar, 320);
    }
  }

  /* 2. 光标闪 */
  if (++frame % 5 === 0) showCursor = !showCursor;
  document.title = line.join('') + (showCursor ? '_' : ' ');
}

setInterval(tick, 160);

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
