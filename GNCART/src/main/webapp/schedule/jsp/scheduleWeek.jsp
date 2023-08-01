<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../../css/index.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  
  <!-- include css -->
  <link rel="stylesheet" href="include/scheduleTop.css">
  
  <!-- 현재파일 css -->
  <link rel="stylesheet" href="../../css/scheduleWeek.css">
  
</head>

<%
	LocalDate date = LocalDate.now();
	Calendar cal = Calendar.getInstance();
	
	int calYear = 0; //년
	int calMonth = 0; //월
	int calWeek  = 0; //주
	int calDay = 0; //입력된 일
	int day = 0; //일
	int lastDay = 0; //마지막 날
	
	if(request.getParameter("calWeek") != null){
		calYear = Integer.parseInt(request.getParameter("calYear"));
		calMonth = Integer.parseInt(request.getParameter("calMonth"));
		calWeek = Integer.parseInt(request.getParameter("calWeek"));
		calDay = Integer.parseInt(request.getParameter("calDay"));
		
		day = date.getDayOfMonth();
		
		cal.set(calYear, calMonth-1, day);
		lastDay = cal.getActualMaximum(Calendar.DATE);
		
		if(calDay>lastDay){
			calMonth+=1;
			calDay=1;
			
			cal.set(calYear, calMonth, calDay);
			calWeek = cal.get(Calendar.WEEK_OF_MONTH);
		}
		if(calDay<1){
			calMonth-=1;
			cal.set(calYear, calMonth,1);
			calDay = cal.getActualMaximum(Calendar.DATE);
		}
		
		
	}
%>

<body>
	
  <!-- sidebar include -->
  <jsp:include page="../../index/sidebar.jsp" flush="false" />

  <section class="home-section">
  
    <!-- top include -->
    <jsp:include page="../../index/top.jsp" flush="false" />
	

    <!--home-content-->  	
    <div class="home-content">
      
        <div class="container">
        
        	<jsp:include page="include/scheduleTop.jsp" />

		    <div class="calenderTitle">
		      <div class="yearArea">
		        <div class="prevWeek" onclick="prevWeek()"> ◁ </div>
			    <h3><%=calYear%>년 <%=calMonth%>월 <%=calWeek%>주차</h3>
			    <div class="nextWeek" onclick="nextWeek()"> ▷ </div>
		      </div>
		    </div>
		
		<!-- title 변경을 위한 hidden form -->
		<form name="prevWeekFrm" action="scheduleWeek.jsp">
			<input type="hidden" name="calYear" value="<%=calYear%>">
			<input type="hidden" name="calMonth" value="<%=calMonth%>">
			<input type="hidden" name="calWeek" value="<%=calWeek -1%>">
		</form>
		
		<form name="nextWeekFrm" action="scheduleWeek.jsp">
			<input type="hidden" name="calYear" value="<%=calYear%>">
			<input type="hidden" name="calMonth" value="<%=calMonth%>">
			<input type="hidden" name="calWeek" value="<%=calWeek +1%>">
		</form>
		
		    <div class="content">
		
		      <div class="dayList">
		        <ul class="day">
		          <li>요일</li>
		        </ul>
		  
		        <ul class="date">
		          <li>날짜</li>
		        </ul>
		  
		        <ul class="list">
		          <li>일정1</li>
		          <li>일정2</li>
		        </ul>
		      </div>
		
		    </div>
		  </div>
      
    </div>
  </section>
<!-- index js -->
<script src="../../script/indexScript.js"></script>

<!-- include js -->
<script src="include/scheduleTop.js"></script>
   
</body>
</html>

<script>
	function prevWeek(){
		document.prevWeekFrm.submit();
	}
	
	function nextWeek(){
		document.nextWeekFrm.submit();
	}
</script>