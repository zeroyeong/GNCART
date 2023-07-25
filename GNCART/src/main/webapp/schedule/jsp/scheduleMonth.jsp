<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    
    import="schedule.ScheduleBean"
    import="java.util.Vector"%>
<jsp:useBean id="sMgr" class="schedule.ScheduleMgr" />

<%
	String year="", month="";
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../../css/index.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  
  <link rel="stylesheet" href="../../css//scheduleMonth.css">
  
</head>
<body>
	
  <!-- sidebar include -->
  <jsp:include page="../../index/sidebar.jsp" flush="false" />

  <section class="home-section">
    <!-- top include -->
    <jsp:include page="../../index/top.jsp" flush="false" />
	

    <!--home-content-->  	
    <div class="home-content">
      <div id="container">
        
        <!----------------------------------->
        <!--------------타이틀--------------->
        <!----------------------------------->

        <div class="title">
          <h2>회사 일정</h2>
          <div class="btnBox">
            <div class="btns">
              <a href="scheduleMont.jsp">월간일정</a>
              <a href="scheduleYear.jsp">연간일정</a>
              <a href="scheduleWeek.jsp">주간일정</a>
            </div>
            <div class="btns">
              <a href="#" onclick="popup()">일정추가</a>
            </div>
          </div>
        </div>
        
        <!----------------------------------->
        <!----------페이지 소제목------------>
        <!----------------------------------->
		<div class="smallTitle">
          <div class="yearBtn">
            <button type="button" onClick="prevYearCalendar();" class="prev">< <span id="prevYear"></span>년</button>
            <h3><span id="calYear"></span>년</h3>
            <button type="button" onClick="nextYearCalendar();" class="next"><span id="nextYear"></span>년 ></button>
          </div>
          <hr>
          <div id="month">
            <a href="#" value="1" class="active">1월</a>
            <a href="#" value="2">2월</a>
            <a href="#" value="3">3월</a>
            <a href="#" value="4">4월</a>
            <a href="#" value="5">5월</a>
            <a href="#" value="6">6월</a>
            <a href="#" value="7">7월</a>
            <a href="#" value="8">8월</a>
            <a href="#" value="9">9월</a>
            <a href="#" value="10">10월</a>
            <a href="#" value="11">11월</a>
            <a href="#" value="12">12월</a>
          </div>
        </div>

        <!----------------------------------->
        <!---------------본문---------------->
        <!----------------------------------->
        <div class="content">
          <div class="contentBox">
            <table class="Calendar nonebox" id="workcal">
              <thead>
                  <tr>
                      <td onClick="prevCalendar();" style="cursor:pointer;"> < </td>
                      <td colspan="5">
                          <span id="calMonth"></span>월
                      </td>
                      <td onClick="nextCalendar();" style="cursor:pointer;"> > </td>
                  </tr>
                  <tr>
                      <td>SUN</td>
                      <td>MON</td>
                      <td>TUE</td>
                      <td>WED</td>
                      <td>THU</td>
                      <td>FRI</td>
                      <td>SAT</td>
                  </tr>
              </thead>

              <tbody>
              </tbody>
            </table>
          </div>
          <div class="contentBox">
            <table class="scheduleList">
              <thead>
                <tr>
                  <td colspan="2">일정내역</td>
                </tr>
                <tr>
                  <td>날짜</td>
                  <td>내용</td>
                </tr>
              </thead>
	              <tbody>
	                <%
	                	Vector<ScheduleBean> vlist = sMgr.getScheduleList(year, month);
	                	if(vlist.isEmpty()){%>
	                <tr>
	                	<td colspan="2">해당 월의 등록된 일정이 없습니다.</td>
	                </tr>
	                <%
	                	}else{
	                		for(int i=0; i<vlist.size(); i++){
	                			
	                			ScheduleBean bean = new ScheduleBean();
	                			bean = vlist.get(i);
	                			
	                			int SCHE_NO=bean.getSCHE_NO();
	                			String SCHE_NAME=bean.getSCHE_NAME();
	                			String SCHE_START_DATE=bean.getSCHE_START_DATE();
	                			String SCHE_END_DATE=bean.getSCHE_END_DATE();
	       			%>
	       			<form name="scheduleFrm" action="scheduleDetail.jsp" method="get">
		       			<tr>
		       				<td><a href="javascript:read()"><%=SCHE_START_DATE %> ~ <%=SCHE_END_DATE %></a></td>
		       				<td>
		       					<a href="javascript:read()"><%=SCHE_NAME %></a>
		       					<input type="hidden" name="SCHE_NO" value="<%=SCHE_NO%>">
		       					<input type="submit">
	       					</td>
		       			</tr>
	       			</form>
	       			<%
	                		}
	                	}
	                %>
	              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </section>
<script src="../../script/indexScript.js"></script>
<script src="../script/script.js"></script>
<!-- <script src="../script/popup.js"></script> -->
</body>
</html>