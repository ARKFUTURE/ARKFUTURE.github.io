
  const titles = ["欢迎进入ARKFUTURE WEB SITE", "标题2", "标题3", "标题4", "标题5"];  
  let currentIndex = 0;   
  function updateTitle() {   
      currentIndex = (currentIndex + 1) % titles.length;  
      document.title = titles[currentIndex];  
  }    
  setInterval(updateTitle, 1000);  