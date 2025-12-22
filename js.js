
function getCurrentDate() {
    const today = new Date();
    const day = today.getDate();
    const month = today.getMonth() + 1; // 注意月份从0开始
    return { day, month };
}

const titles = ["ARKFUTURE","ARK LAB","ARKFUTURE STUDIO/GROUP/TEAM","技术无止,勇于创新", "以史为镜,洞察未来"];
const COLS = 18;               // 模拟终端宽度，自己调
let idx   = 0;                 // 当前句子
let head  = 0;                 // 下一个字符下标
let line  = Array(COLS).fill(' ');

function tick(){
  const cur = titles[idx];

  if (head < cur.length){      // 还有字符：窗口右滑
    line.shift();
    line.push(cur[head++]);
  } else {                     // 一句打完：清屏 + 切句
    if (line.some(c=>c!==' ')){ // 先清成空格
      line.fill(' ');
    } else {                    // 清空完成，换句
      idx  = (idx+1)%titles.length;
      head = 0;
    }
  }
  document.title = line.join('');
}

setInterval(tick, 80);         // 80 ms 一帧

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
