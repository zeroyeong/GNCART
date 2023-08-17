<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="scheduleTop.css"> -->
</head>
<body>
	<div class="scheduleTop">
    <h2 class="title">회사일정</h2>

    <div class="scheduleMenu">
      <div class="linkBtn">
        <button onclick="month()">월간일정</button>
        <button onclick="year()">연간일정</button>
        <button onclick="week()">주간일정</button>
      </div>
      <div class="addBtn">
        <button onclick="addSchedule()">일정추가</button>
      </div>
    </div>
  </div>
</body>
<script>

	/*_________각 버튼별 active 클래스_________*/
	
	const btn = document.querySelectorAll('.linkBtn button');
	btn.forEach(t => t.addEventListener('click', (e) => {
	  const target = e.currentTarget;
	
	  btn.forEach(t => t.classList.remove('acting'));
	  target.classList.add('acting');
	}))
	
	/*_________일정등록 팝업_________*/
	
	function openCenter(doc,win,w,h){
	    var left=(screen.availWidth-w)/2; //왼쪽 좌표
	    var top=(screen.availHeight-h)/2; //위쪽 좌표
	    var opt='left='+left+', top='+top+', width='+w+', height='+h; //창의 좌표값
	    
	    window.open(doc,win,opt);
	  }
	  
	  function addSchedule() {
	    openCenter("scheduleAdd.jsp","",590,600);
	  }
	  
	  /*_________페이지별 링크 이동_________*/
	  
	  function month(){
	    location.href="scheduleMonth.jsp";
	  }
	  
	  function year(){
	    location.href="scheduleYear.jsp";
	  }
	  
	  function week(){
	    location.href="scheduleWeek.jsp";
	  }
</script>
</html>