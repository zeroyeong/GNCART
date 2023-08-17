<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="event.EventBean"%>
<jsp:useBean id="eMgr" class="event.EventMgr" />
<%
	request.setCharacterEncoding("UTF-8");

	int EVENT_NO = Integer.parseInt(request.getParameter("EVENT_NO"));
	
	eMgr.upHit(request, response);
	
	EventBean bean = eMgr.getEvent(EVENT_NO);
	
	String EVENT_TITLE = bean.getEVENT_TITLE();
	String EVENT_CONTENT = bean.getEVENT_CONTENT();
	String EVENT_DATE = bean.getEVENT_DATE();
	String EVENT_FILENAME = bean.getEVENT_FILENAME();
	String EVENT_FILESIZE = bean.getEVENT_FILESIZE();
	int EVENT_HIT = bean.getEVENT_HIT();
	int MEM_NO = bean.getMEM_NO();
	int EVENTSUB_NO = bean.getEVENTSUB_NO();
	String MEM_NAME = bean.getMEM_NAME();
	String EVENT_SUB = bean.getEVENT_SUB();
	String MEM_ID = bean.getMEM_ID();
	String PART_TYPE = bean.getPART_TYPE();
	
	session.setAttribute("bean", bean);//게시물을 세션에 저장
	
	String[] filenames = EVENT_FILENAME.split(",");
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/noticeWrite.css">
<!--Boxicons CDN Link-->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
	<!-- sidebar include -->
	<jsp:include page="../index/sidebar.jsp" flush="false" />

	<section class="home-section">
		<!-- top include -->
		<jsp:include page="../index/top.jsp" flush="false" />


		<!--home-content-->
		<div class="home-content">
			<div id="container">
				<div id="title">
					<h2>행사사진</h2>
					<div id="writerInfo" style="text-align: right">
						<span>작성자 : <b><%=MEM_NAME %></b></span> <span>작성일 : <b><%=EVENT_DATE %></b></span>
					</div>
				</div>

				<hr>

				<table>
					<tr>
						<td class="tableTitle">제목</td>
						<td colspan="3"><b>[<%=EVENT_SUB%>] </b><%=EVENT_TITLE %></td>
					</tr>
					<tr>
						<td class="tableTitle">작성자</td>
						<td><%=MEM_NAME %></td>
						<td class="tableTitle">해당부서</td>
						<td><%=PART_TYPE %></td>
					</tr>
					<tr>
						<td class="tableTitle detail">상세내용</td>
						<td colspan="3">
						  <%=EVENT_CONTENT%><br/>
     					  <% for (String filename : filenames) { %>
          				  <img src='../filestorage/<%=filename%>' width="600" height="600"/>
      					  <% } %>	
						</td>
					</tr>
					<tr>
						<td class="tableTitle">첨부파일</td>
						<td colspan="3">
							<% if( EVENT_FILENAME !=null && !EVENT_FILENAME.equals("")) {%> <a
							href="javascript:down('<%=EVENT_FILENAME%>')"><%=EVENT_FILENAME%></a>
							&nbsp;&nbsp;<font color="blue">(<%=EVENT_FILESIZE%>KBytes)
						</font> <%} else{%> 등록된 파일이 없습니다.<%}%>
						</td>
					</tr>
				</table>
				<div id="btns" style="text-align: right">
					<% 
          String id = (String)session.getAttribute("memId");
          if (id != null && id.equals(MEM_ID)) {
        %>
					<button><a href="eventRevise.jsp?=&EVENT_NO=<%=EVENT_NO%>">수정하기</a></button>
					<button><a href="eventDelete.jsp?=&EVENT_NO=<%=EVENT_NO%>">삭제하기</a></button>
					<% } %>
					<button><a href="event.jsp">뒤로가기</a></button>
				</div>
			</div>

		</div>
	</section>
	<form name="downFrm" action="noticeDownload.jsp" method="post">
		<input type="hidden" name="NOT_FILENAME">
	</form>

	<script src="../script/indexScript.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="../script/noticeScript.js"></script>
</body>
</html>