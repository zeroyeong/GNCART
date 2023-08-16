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

<!-- 현재 페이지 css -->
<link rel="stylesheet" href="../../css/scheduleYear.css?sdsfdd">

<!-- include css -->
<link rel="stylesheet" href="include/scheduleTop.css">

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
	
		<table class="MonthSchedule">
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
				Vector<ScheduleBean> alist = sMgr.getScheduleList(calYear, 1);
				
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
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
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
				Vector<ScheduleBean> blist = sMgr.getScheduleList(calYear, 2);
				
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
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
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
				Vector<ScheduleBean> clist = sMgr.getScheduleList(calYear, 3);
				
				if(clist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<clist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = clist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">4월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> dlist = sMgr.getScheduleList(calYear, 4);
				
				if(dlist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<dlist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = dlist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">5월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> elist = sMgr.getScheduleList(calYear, 5);
				
				if(elist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<elist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = elist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">6월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> flist = sMgr.getScheduleList(calYear, 6);
				
				if(flist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<flist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = flist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">7월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> glist = sMgr.getScheduleList(calYear, 7);
				
				if(glist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<glist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = glist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">8월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> hlist = sMgr.getScheduleList(calYear, 8);
				
				if(hlist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<hlist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = hlist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">9월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> ilist = sMgr.getScheduleList(calYear, 9);
				
				if(ilist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<ilist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = ilist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">10월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> jlist = sMgr.getScheduleList(calYear, 10);
				
				if(jlist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<jlist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = jlist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">11월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> klist = sMgr.getScheduleList(calYear, 11);
				
				if(klist.isEmpty()){
				%>
				<tr>
					<td colspan="2" style="text-align:center;">등록된 일정이 없습니다.</td>
				</tr>
				
				<%
				}else{
					for(int i=0; i<klist.size(); i++){
					ScheduleBean bean = new ScheduleBean();
					bean = klist.get(i);
					
					int SCHE_NO = bean.getSCHE_NO();
					String SCHE_NAME = bean.getSCHE_NAME();
					String SCHE_START_DATE = bean.getSCHE_START_DATE();
					String SCHE_END_DATE = bean.getSCHE_END_DATE();%>
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		
		<table class="MonthSchedule">
			<thead>
				<tr class="tableHead">
				<td colspan="2">12월</td>
				</tr>
				<tr>
				<td>날짜</td>
				<td>일정</td>
				</tr>
			</thead>
			<tbody>
			
				<%
				Vector<ScheduleBean> vlist = sMgr.getScheduleList(calYear, 12);
				
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
				<tr>
			  	<td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></span></td>
			    <td><span onclick="read(<%=SCHE_NO%>)"><%=SCHE_NAME %></span></td>
		    </tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
	
	
		<!-- page nation -->
		<div id="pagenation">
		</div>
	</div> 
	
	<!-- 일정 조회를 위한 hidden form -->
	<form id="readF" action="scheduleDetail.jsp" onsubmit="return false;">
		<input type="hidden" name="SCHE_NO" value="">
	</form>
	
	<!-- 상단 년도 변경을 위한 hidden form -->
	<form name="prevYearFrm" action="scheduleYear.jsp">
		<input type="hidden" name="calYear" value=<%=calYear -1 %>>
	</form>
	<form name="nextYearFrm" action="scheduleYear.jsp">
		<input type="hidden" name="calYear" value=<%=calYear +1 %>>
	</form>
	
	</div> <!-- container 끝 -->
	
</div>
</section>

<!-- index js -->
<script src="../../script/indexScript.js"></script>

<!-- 현재페이지 page nation -->
<script src="../script/pagenation.js"></script>

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