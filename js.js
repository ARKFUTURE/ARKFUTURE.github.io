
  const titles = ["⫷ARKFUTURE⫸", "⫷方舟未来⫸", "技术无止,勇于创新", "以史为镜,洞察未来"];  
  let currentIndex = 0;   
  function updateTitle() {   
      currentIndex = (currentIndex + 1) % titles.length;  
      document.title = titles[currentIndex];  
  }    
  setInterval(updateTitle, 3000);  