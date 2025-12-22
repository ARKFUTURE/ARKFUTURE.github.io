
function getCurrentDate() {
    const today = new Date();
    const day = today.getDate();
    const month = today.getMonth() + 1; // 注意月份从0开始
    return { day, month };
}

const titles = ["ARKFUTURE","ARK LAB","ARKFUTURE STUDIO/GROUP/TEAM","技术无止,勇于创新", "以史为镜,洞察未来"];
let idx = 0;        // 当前句子下标
let pos = 0;        // 当前已显示到第几个字符
let direction = 1;  // 1 表示正向追加，-1 表示反向删除

function terminalType() {
    const cur = titles[idx];

    if (direction === 1) {          // 正向：一个字一个字蹦
        pos++;
        if (pos > cur.length) {     // 打满了，切到反向
            direction = -1;
            setTimeout(terminalType, 600); // 停 600 ms 再删
            return;
        }
    } else {                        // 反向：删最后一个字
        pos--;
        if (pos < 0) {              // 删光了，切到下一句
            direction = 1;
            idx = (idx + 1) % titles.length;
        }
    }

    document.title = cur.slice(0, pos);
    const delay = direction === 1 ? 80 : 50; // 打 80 ms，删 50 ms
    setTimeout(terminalType, delay);
}

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
