
  const titles = ["ARKFUTURE", "方舟未来", "欢迎进入", "标题4", "标题5"];  
  let currentIndex = 0;   
  function updateTitle() {   
      currentIndex = (currentIndex + 1) % titles.length;  
      document.title = titles[currentIndex];  
  }    
  setInterval(updateTitle, 1000);  