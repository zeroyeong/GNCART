<!-- 

	1. page nation : 한 페이지당 3개월씩 나오도록 해결하기
	2. 진정..... 12월의 표를 각각 호출해야 하는가....... 
	
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Vector, java.time.*"
    import="schedule.ScheduleBean"%>
    
<jsp:useBean id="sMgr" class="schedule.ScheduleMgr"/>

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
  
  <link rel="stylesheet" href="../../css//scheduleYear.css?ver2">
  
</head>

<%
	int calYear=0;
	int prevYear=0;
	int nextYear=0;
	
	if(request.getParameter("calYear") !=null){
		calYear = Integer.parseInt(request.getParameter("calYear"));
		prevYear = calYear -1;
		nextYear = calYear +1;
	}else{
		LocalDate date = LocalDate.now();
		
		calYear = date.getYear();
		prevYear = calYear -1;
		nextYear = calYear +1;
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
			
			<form name="dateFrm" action="scheduleYear.jsp" method="post" onsubmit="return false;">
		    <div class="calenderTitle">
		      <div class="yearArea">
		        <div class="prevYear" onclick="prevYear()"> ◁ <%=prevYear %>년</div>
		        <h3><%=calYear %>년</h3>
		        <div class="nextYear" onclick="nextYear()"><%=nextYear %>년 ▷ </div>
		        
		        <!-- submit을 위한 hidden input -->
		        <input type="hidden" id="input1" name="calYear" value="1234">
		      </div>
		    </div>
		    </form>
			
		    <div class="content">
				
			  <table>
		        <thead>
		          <tr class="tableHead">
		            <td colspan="2">1월</td>
		          </tr>
		          <tr>
		            <td>날짜</td>
		            <td>일정</td>
		          </tr>
		        </thead>
		        <tbody>
		        
				<%
					Vector<ScheduleBean> vlist = sMgr.getScheduleList(calYear, 1);
					
					if(vlist.isEmpty()){
				%>		        
		          <tr>
		            <td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
		          </tr>
		          
		        <%
		        	}else{
		        		for(int i=0; i<vlist.size(); i++){
		        			ScheduleBean bean = new ScheduleBean();
		          			bean = vlist.get(i);
		          			
		          			int SCHE_NO = bean.getSCHE_NO();
		          			String SCHE_NAME = bean.getSCHE_NAME();
		          			String SCHE_START_DATE = bean.getSCHE_START_DATE();
		          			String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
		          	<tr onclick="read(<%=SCHE_NO %>)">
		          		<td><a href="#"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></a></td>
		          		<td><a href="#"><%=SCHE_NAME %></a></td>
		          	</tr>
		          	<%
		          		}
		          	}
		          	%>
		          </tbody>
		      </table>
		      
		      <table>
		        <thead>
		          <tr class="tableHead">
		            <td colspan="2">2월</td>
		          </tr>
		          <tr>
		            <td>날짜</td>
		            <td>일정</td>
		          </tr>
		        </thead>
		        <tbody>
		        
				<%
					Vector<ScheduleBean> alist = sMgr.getScheduleList(calYear, 2);
					
					if(alist.isEmpty()){
				%>		        
		          <tr>
		            <td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
		          </tr>
		          
		        <%
		        	}else{
		        		for(int i=0; i<alist.size(); i++){
		        			ScheduleBean bean = new ScheduleBean();
		          			bean = alist.get(i);
		          			
		          			int SCHE_NO = bean.getSCHE_NO();
		          			String SCHE_NAME = bean.getSCHE_NAME();
		          			String SCHE_START_DATE = bean.getSCHE_START_DATE();
		          			String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
		          	<tr onclick="read(<%=SCHE_NO %>)">
		          		<td><a href="#"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></a></td>
		          		<td><a href="#"><%=SCHE_NAME %></a></td>
		          	</tr>
		          	<%
		          		}
		          	}
		          	%>
		          </tbody>
		      </table>
		      
		      <table>
		        <thead>
		          <tr class="tableHead">
		            <td colspan="2">3월</td>
		          </tr>
		          <tr>
		            <td>날짜</td>
		            <td>일정</td>
		          </tr>
		        </thead>
		        <tbody>
		        
				<%
					Vector<ScheduleBean> blist = sMgr.getScheduleList(calYear, 3);
					
					if(blist.isEmpty()){
				%>		        
		          <tr>
		            <td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
		          </tr>
		          
		        <%
		        	}else{
		        		for(int i=0; i<blist.size(); i++){
		        			ScheduleBean bean = new ScheduleBean();
		          			bean = blist.get(i);
		          			
		          			int SCHE_NO = bean.getSCHE_NO();
		          			String SCHE_NAME = bean.getSCHE_NAME();
		          			String SCHE_START_DATE = bean.getSCHE_START_DATE();
		          			String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
		          	<tr onclick="read(<%=SCHE_NO %>)">
		          		<td><a href="#"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></a></td>
		          		<td><a href="#"><%=SCHE_NAME %></a></td>
		          	</tr>
		          	<%
		          		}
		          	}
		          	%>
		          </tbody>
		      </table>
	        </div>   
	        
	        <!-- 일정 조회를 위한 hidden form -->
	        <form name="readFrm" method="get">
		    	<input type="hidden" name="SCHE_NO">
		    </form>
		    
		    <!-- 상단 년도 변경을 위한 hidden form -->
		    <form name="prevYearFrm" action="scheduleYear.jsp">
				<input type="hidden" name="calYear" value=<%=calYear -1 %>>
			</form>
			<form name="nextYearFrm" action="scheduleYear.jsp">
				<input type="hidden" name="calYear" value=<%=calYear +1 %>>
			</form>
					    
        </div>
    </div>
  </section>
  
<!-- index js -->
<script src="../../script/indexScript.js"></script>

<!-- include js -->
<script src="include/scheduleTop.js"></script>

<script>
	function read(SCHE_NO){
		document.readFrm.SCHE_NO.value = SCHE_NO;
		document.readFrm.action = "scheduleDetail.jsp";
		document.readFrm.submit();
	}
	
	
	/*_____년도 변경 + dateFrm submit_____*/
	
	function prevYear(){
		document.prevYearFrm.submit();
	}
	
	function nextYear(){
		document.nextYearFrm.submit();
	}
</script>
</body>
</html>