<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    
    import="schedule.ScheduleBean"
    import="java.util.*, java.time.*"%>
<jsp:useBean id="sMgr" class="schedule.ScheduleMgr" />

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
  <link rel="stylesheet" href="../../css/scheduleMonth.css">
  
</head>

<%
 	int calYear=0;
	int prevYear=0;
	int nextYear=0;
	
	int calMonth=0;
	
	if(request.getParameter("calYear") != null && request.getParameter("calMonth") != null){
		calYear = Integer.parseInt(request.getParameter("calYear"));
		prevYear = calYear -1;
		nextYear = calYear +1;
		
		calMonth = Integer.parseInt(request.getParameter("calMonth"));
		
		if(calMonth>12){
			calMonth = calMonth-12;
			calYear+=1;
		}
		if(calMonth<1){
			calMonth = calMonth+12;
			calYear-=1;
		}
	}else{
		LocalDate date = LocalDate.now();
		
		calYear = date.getYear();
		prevYear = calYear -1;
		nextYear = calYear +1;
		
		calMonth = date.getMonthValue();
	} 
	
	Calendar cal = Calendar.getInstance();
	
	cal.set(calYear, calMonth-1, 1); //현재 년월의 1일로 캘린더 세팅
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); //1일날의 요일
	int lastDay = cal.getActualMaximum(Calendar.DATE); //현재 월의 마지막 일
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
	          <button class="prevYear" onclick="prevYear()">◁ <span><%=prevYear %>년</span></button>
	          <h3><%=calYear %>년</h3>
	          <button class="nextYear" onclick="nextYear()"><span><%=nextYear %>년</span> ▷</button>
        </div>
		      <div class="monthArea">
		          <input type="button" value="1">
		          <input type="button" value="2">
		          <input type="button" value="3">
		          <input type="button" value="4">
		          <input type="button" value="5">
		          <input type="button" value="6">
		          <input type="button" value="7">
		          <input type="button" value="8">
		          <input type="button" value="9">
		          <input type="button" value="10">
		          <input type="button" value="11">
		          <input type="button" value="12">
		      </div>
		    </div>
		    
		    <div class="content">
		      <div class="calendar">
		        <table>
		          <thead>
		            <tr class="tableHead">
	                <td onclick="prevMonth()" class="prevMonth"> ◁ </td>
	                <td colspan="5"><%=calMonth %>월</td>
	                <td onclick="nextMonth()" class="nextMonth"> ▷ </td>
              	</tr>
		            <tr>
		              <td>SUN</td>
		              <td>MON</td>
		              <td>TUE</td>
		              <td>WEN</td>
		              <td>THU</td>
		              <td>FRI</td>
		              <td>SAT</td>
		            </tr>
		          </thead>
		          <tbody>
		          	<tr>
						<%
							int count = 0; //한 행의 칸을 세기위한 변수
							for(int i=0; i<dayOfWeek-1; i++){
								count++;
								out.print("<td></td>");
							}
							for(int j=1; j<=lastDay; j++){
								count++;
						%>
						<td><%=j %></td>
						<%		if(count%7 == 0){
							out.print("</tr><tr>");
						}
							}
						%>
					</tr>
		          </tbody>
		        </table>
		      </div>
		      
		      	<!-- 달력 버튼 클릭을 위한 hidden form -->
				<form name="prevYearFrm" action="scheduleMonth.jsp">
					<input type="hidden" name="calYear" value="<%=calYear -1%>">
					<input type="hidden" name="calMonth" value="<%=calMonth%>">
				</form>
				
				<form name="nextYearFrm" action="scheduleMonth.jsp"">
					<input type="hidden" name="calYear" value="<%=calYear +1%>">
					<input type="hidden" name="calMonth" value="<%=calMonth%>">
				</form>
				
				<form name="prevMonthFrm" action="scheduleMonth.jsp">
					<input type="hidden" name="calYear" value="<%=calYear%>">
					<input type="hidden" name="calMonth" value="<%=calMonth -1%>">
				</form>
				
				<form name="nextMonthFrm" action="scheduleMonth.jsp">
					<input type="hidden" name="calYear" value="<%=calYear%>" >
					<input type="hidden" name="calMonth" value="<%=calMonth +1%>">
				</form>
				
				<!-- monthArea의 월 버튼을 클릭하면 해당 월값을 처리해주는 hidden form -->
				<form name="monthAreaFrm" action="scheduleMonth.jsp">
					<input type="hidden" name="calYear" value="<%=calYear%>">
					<input type="hidden" name="calMonth" id="formInput">
				</form>
		
		      <div class="list">
		        <table>
		          <thead>
		            <tr class="tableHead">
		              <td colspan="2">일정내역</td>
		            </tr>
		            <tr>
		              <td>날짜</td>
		              <td>내용</td>
		            </tr>
		          </thead>
		          <tbody>
		          <%		          	
		          	Vector<ScheduleBean> vlist = sMgr.getScheduleList(calYear, calMonth);
		          
		          	if(vlist.isEmpty()){%>
		            <tr>
		              <td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
		            </tr>
		            <%}
		          	else{
		          		for(int i=0; i<vlist.size(); i++){
		          			ScheduleBean bean = new ScheduleBean();
		          			bean = vlist.get(i);
		          			
		          			int SCHE_NO = bean.getSCHE_NO();
		          			String SCHE_NAME = bean.getSCHE_NAME();
		          			String SCHE_START_DATE = bean.getSCHE_START_DATE();
		          			String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
			        	<tr onclick="read(<%=SCHE_NO%>)">
			          		<td><input type="hidden" name="SCHE_NO" value="<%=SCHE_NO %>"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></td>
			          		<td><%=SCHE_NAME %></td>
			          	</tr>
		          	<%
		          		}
		          	}
		          	%>
		          </tbody>
		        </table> 
		      </div>
		    </div>
		  </div>
		  
		  <form id="readF" action="scheduleDetail.jsp" onsubmit="return false;">
		  	<input type="hidden" name="SCHE_NO" value="">
		  </form>
          
    </div>
  </section>

<!-- index js -->
<script src="../../script/indexScript.js"></script>

<script>
	function openCenter(doc,win,w,h){
	  var left=(screen.availWidth-w)/2; //왼쪽 좌표
	  var top=(screen.availHeight-h)/2; //위쪽 좌표
	  var opt='left='+left+', top='+top+', width='+w+', height='+h; //창의 좌표값
	  
	  window.open(doc,win,opt);
	}
	
	/*______list 클릭시 detail 팝업______*/
	
	function read(no){
		document.getElementById('readF').SCHE_NO.value=no;
		
		popup();
		
		document.getElementById('readF').submit();
	}
	function popup(){
		openCenter('', 'popup', 550,560);
		document.getElementById('readF').target='popup';
		document.getElementById('readF').submit();
	}

	
	/*______달력 버튼클릭시의 submit______*/
	
	function prevYear(){
		document.prevYearFrm.submit();
	}
	
	function nextYear(){
		document.nextYearFrm.submit();
	}
	
	function prevMonth(){
		document.prevMonthFrm.submit();
	}
	
	function nextMonth(){
		document.nextMonthFrm.submit();
		
	}
	
	/*______월 클릭시 class변환______*/
	
	const monthArea = document.querySelectorAll('.monthArea input');
	const inputHd = document.getElementById('formInput');

	
	window.onload = () => {
	    
		monthArea.forEach(t => {
			t.classList.remove('active');
			
			if(t.value == <%=calMonth%>){
	 			t.classList.add('active');
			}
		})
	}
	
	monthArea.forEach((t) => {
		t.addEventListener('click', (e)=>{
			let target = e.currentTarget;
			inputHd.value=target.value;
			document.monthAreaFrm.submit();
		})
	})
</script>
</body>
</html>