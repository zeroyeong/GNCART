<%@page import="java.util.*"%>
<%@page import="java.time.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="schedule.ScheduleBean"%>
    
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
  <link rel="stylesheet" href="../../css/scheduleWeek.css?dsfsf">
  
</head>

<%
	int calYear=0; //현재 년도
	int calMonth=0; //현재 월
	int calDay=0; //현재 일
	int calWeek=0; //현재 주차
	
	int lastDay=0; //마지막 날
	int lastWeek=0; //마지막 날의 요일
	int totalWeek=0; //월의 전체 주차
	
	LocalDate now = LocalDate.now();
	Calendar cal = Calendar.getInstance();
	
	if(request.getParameter("calYear") !=null){
		calYear = Integer.parseInt(request.getParameter("calYear"));
		calMonth = Integer.parseInt(request.getParameter("calMonth"));
		calWeek = Integer.parseInt(request.getParameter("calWeek"));
		
		cal.set(calYear, calMonth-1, 1);
		lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		cal.set(calYear, calMonth-1, lastDay);
		lastWeek = cal.get(Calendar.DAY_OF_WEEK);
		
		totalWeek = (lastDay - lastWeek + 13) / 7;
		
		if(calWeek > totalWeek || calMonth > 12){ //주차가 월주차보다 크거나 월이 12월보다 크다면
			if(calWeek > totalWeek){
				calMonth +=1;
				calWeek = 1;
				
				cal.set(calYear, calMonth-1, 1);
				lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				
				cal.set(calYear, calMonth-1, lastDay);
				lastWeek = cal.get(Calendar.DAY_OF_WEEK);
				
				totalWeek = (lastDay - lastWeek + 13) / 7;
			}
			else if(calMonth > 12){
				calYear +=1;
				calMonth = 1;
				calWeek = 1;
				
				cal.set(calYear, calMonth-1, 1);
				lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				
				cal.set(calYear, calMonth-1, lastDay);
				lastWeek = cal.get(Calendar.DAY_OF_WEEK);
				
				totalWeek = (lastDay - lastWeek + 13) / 7;
			}
		}
		
		else if(calWeek <1 || calMonth < 1){ //주차가 1보다 작거나 월이 1보다 작다면
			if(calWeek < 1){
				calMonth -=1;
				
				cal.set(calYear, calMonth-1, 1);
				lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				
				cal.set(calYear, calMonth-1, lastDay);
				lastWeek = cal.get(Calendar.DAY_OF_WEEK);
				
				calWeek = (lastDay - lastWeek + 13) / 7;
			}
			else if(calMonth < 1 ){
				calMonth = 12;
				calYear -= 1;
				
				cal.set(calYear, calMonth-1, 1);
				lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				
				cal.set(calYear, calMonth-1, lastDay);
				lastWeek = cal.get(Calendar.DAY_OF_WEEK);
				
				calWeek = (lastDay - lastWeek + 13) / 7;
				
			}
		}
	} else{
		calYear = now.getYear();
		calMonth = now.getMonthValue();
		calDay = now.getDayOfMonth();
		cal.set(calYear, calMonth-1, calDay);
		calWeek = cal.get(Calendar.WEEK_OF_MONTH);
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
			<!-- submit을 위한 hidden form -->
			<form name="prevWeekFrm" action="scheduleWeek.jsp">
				<input type="hidden" name="calYear" value="<%=calYear %>">
				<input type="hidden" name="calMonth" value="<%=calMonth %>">
				<input type="hidden" name="calWeek" value="<%=calWeek -1 %>">
			</form>
			<form name="nextWeekFrm" action="scheduleWeek.jsp">
				<input type="hidden" name="calYear" value="<%=calYear %>">
				<input type="hidden" name="calMonth" value="<%=calMonth %>">
				<input type="hidden" name="calWeek" value="<%=calWeek +1 %>">
			</form>
		
    <div class="content">
   			
   			<%
   				cal.set(calYear, calMonth-1, 1); //1일로 세팅
   				int firstDay = cal.get(Calendar.DAY_OF_WEEK); //1일날의 요일 숫자
					String week = ""; //firstDay를 한글로 바꿀 변수
					
   				calDay = cal.get(Calendar.DATE); //날짜
   				lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH); //월의 마지막 날짜
   				
   				firstDay-=1; //초기 firstDay가 for문에서 처음 값을 유지할 수 있도록!
   				
   				for(int i=0; i < lastDay; i++){
   					firstDay += 1;
   					
   					if(firstDay >=8){
   						firstDay = firstDay % 7;
   					}
   					
   					week = firstDay + "";
   					
   					switch(week){
   					case "1" : week = "일"; break;
   					case "2" : week = "월"; break;
   					case "3" : week = "화"; break;
   					case "4" : week = "수"; break;
   					case "5" : week = "목"; break;
   					case "6" : week = "금"; break;
   					case "7" : week = "토"; break;
   					}
   					
   					String month = "", day = "";
   					int d = i+1;

						if(calMonth < 10) {
							month = "0" + calMonth;
						}else{
							month = calMonth + "";
						}
						
						if(d < 10){
 							day = "0" + d;
 						}else{
 							day = d + "";
 						}
								
   					String date = calYear + "-" + month + "-" + day;
 				%>
   			
   			<%
					Vector<ScheduleBean> list = sMgr.getScheduleList(calYear, calMonth, d);
				%>
				
   			<table id="daySchedule">
   				<colgroup>
   					<col class="col1" />
   					<col class="col2" />
   					<col class="col3" />
   				</colgroup>
   				<tr>
   					<td rowspan="<%=list.size() %>">
   						<span class="week"><%=week %></span>
   					</td>
   					<td rowspan="<%=list.size() %>"><%=date %></td>
   					<%
   						if(list.isEmpty()){%>
   					
   					<td>등록된 일정이 없습니다.</td>
   					
   					<%
   						}else{
	   						for(int j = 0; j < list.size(); j++){
	   							ScheduleBean bean = new ScheduleBean();
	   							bean = list.get(j);
	   							
	   							int SCHE_NO = bean.getSCHE_NO();
	          			String SCHE_NAME = bean.getSCHE_NAME();
	          %>
	          		
          	<td><a href="" onclick="read(<%=SCHE_NO%>)"> <%=SCHE_NAME %> </a></td>
          </tr>
          <tr>          			
   					<%		} //두번째 for문 종료
   							} //if문 종료
   					%>
   				</tr>
   			</table>
   			<%
   				} //첫번째 for문 종료
   			%>
   			
      </div>
      
      <form id="readF" action="scheduleDetail.jsp" onsubmit="return false;">
	  		<input type="hidden" name="SCHE_NO" value="">
		  </form>
		           
    </div>
  </section>
<!-- index js -->
<script src="../../script/indexScript.js"></script>
   
</body>
</html>

<script>
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
	function nextWeek(){
		document.nextWeekFrm.submit();
	}
	
	function prevWeek(){
		document.prevWeekFrm.submit();
	}

	/*______table 묶음______*/
	let calYear = <%=calYear %>;
	let calMonth = <%=calMonth %>-1;
	
	let firstCal = new Date(calYear, calMonth, 1);
	let firstDay = firstCal.getDay();
	
	let lastCal = new Date(calYear, calMonth + 1, 0);
	let lastDay = lastCal.getDate();
	
	let table = document.querySelectorAll("#daySchedule");
	let tArray = [...table];
	
	let start = 0;
	let end = 6 - firstDay;
	let array1 = tArray.slice(start, end);

	start = end + 1;
	end = start + 6;
	let array2 = tArray.slice(start, end);

	start = end + 1;
	end = start + 6;
	let array3 = tArray.slice(start, end);

	start = end + 1;
	end = start + 6;
	let array4 = tArray.slice(start, end);
	
	start = end + 1;
	end = start + 6;
	let array5 = tArray.slice(start, end);
	
	start = end + 1;
	end = start + 6;
	let array6 = tArray.slice(start, end);
	
	let array = [array1, array2, array3, array4, array5, array6]
	
	/*______table 보이고 안보이고______*/
	for (at of tArray) {
		  at.style.display = "none";
		}
	
	if(<%=calWeek %> == 1){
		for(a of array1){
			a.style.display="";
		}
	} else if(<%=calWeek %> == 2){
		for(a of array2){
			a.style.display="";
		}
	} else if(<%=calWeek %> == 3){
		for(a of array3){
			a.style.display="";
		}
	} else if(<%=calWeek %> == 4){
		for(a of array4){
			a.style.display="";
		}
	}  else if(<%=calWeek %> == 5){
		for(a of array5){
			a.style.display="";
		}
	}  else if(<%=calWeek %> == 6){
		for(a of array6){
			a.style.display="";
		}
	}  
	
</script>