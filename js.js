
function getCurrentDate() {
    const today = new Date();
    const day = today.getDate();
    const month = today.getMonth() + 1; // 注意月份从0开始
    return { day, month };
}

const titles = ["ARKFUTURE","ARK LAB","ARKFUTURE STUDIO/GROUP/TEAM","技术无止,勇于创新", "以史为镜,洞察未来"];
let idx = 0, pos = 0, forward = true;   // idx:当前句子下标  pos:当前显示到第几个字  forward:正/反向

function typeWriter() {
    const cur = titles[idx];
    if (forward) {
        pos++;
        if (pos > cur.length) {
            forward = false;
            setTimeout(typeWriter, 1000);
            return;
        }
    } else {
        pos--;
        if (pos === 0) {
            forward = true;
            idx = (idx + 1) % titles.length;
        }
    }
    document.title = cur.slice(0, pos);
    setTimeout(typeWriter, 120);
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
