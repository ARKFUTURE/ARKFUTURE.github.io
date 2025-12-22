
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

function tick() {
  const cur = titles[idx];

  /* 卷动字符 */
  if (head < cur.length) {
    line.shift();
    line.push(cur[head++]);
  } else {
    if (line.some(c => c !== ' ')) {
      line.fill(' ');
    } else {
      idx = (idx + 1) % titles.length;
      head = 0;
    }
  }

  /* 光标闪烁：每 8 帧切一次（≈1.28 s）*/
  if (++frame % 8 === 0) showCursor = !showCursor;

  document.title = line.join('') + (showCursor ? '_' : ' ');
}

setInterval(tick, 160);   // 160 ms 一帧

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
