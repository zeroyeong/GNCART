<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="event.EventBean"%>
<%@ page import="java.util.Vector"%>
<jsp:useBean id="eMgr" class="event.EventMgr" />
<%
if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
    response.sendRedirect("../login.jsp");

request.setCharacterEncoding("UTF-8");

int start = 0; //디비의 select 시작번호
int end = 100; //시작번호로 부터 가져올 select 갯수

String keyWord = "", keyField = "";
Vector<EventBean> vlist = null;

if (request.getParameter("keyWord") != null) {
	keyWord = request.getParameter("keyWord");
	keyField = request.getParameter("keyField");
}
if (request.getParameter("reload") != null) {
	if (request.getParameter("reload").equals("true")) {
		keyWord = "";
		keyField = "";
	}
}

%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GNC:ART</title>
	<link rel="stylesheet" href="../css/index.css">
	<link rel="stylesheet" href="../css/event.css?esss">
	<!--Boxicons CDN Link-->
	<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'rel='stylesheet'>
</head>

<body>
	<!-- sidebar include -->
	<jsp:include page="../index/sidebar.jsp" flush="false" />

	<section class="home-section">
		<!-- top include -->
		<jsp:include page="../index/top.jsp" flush="false" />

		<!--home-content-->
		<div class="container-fluid">
			<div class="container">
				<div class="title">
					<h3>행사사진</h3>
				</div>
				<div class="content">
					<div class="photo">
						<%
						//BoardMgr 클래스 getBoardList() 메서드 호출 
						vlist = eMgr.getBoardList(keyField, keyWord, start, end);						
						if (vlist.isEmpty()) {
							out.println("등록된 게시물이 없습니다.");

						} else {
						%>
						<%
						for (int i = 0; i < vlist.size(); i++) {
							EventBean bean = vlist.get(i);
							int EVENT_NO = bean.getEVENT_NO();
							String EVENT_TITLE = bean.getEVENT_TITLE();
							String EVENT_DATE = bean.getEVENT_DATE();
							int EVENT_HIT = bean.getEVENT_HIT();
							String MEM_NAME = bean.getMEM_NAME();
							String EVENT_SUB = bean.getEVENT_SUB();
							String EVENT_FILENAME = bean.getEVENT_FILENAME();
							String[] filenames = EVENT_FILENAME.split(",");
						%>
						<table>
							<tr>
								<th colspan="4"><%=EVENT_NO%></th>
							</tr>
							<tr>
								<td colspan="4">
								<a href="javascript:read('<%=EVENT_NO%>')">
								<img src='../filestorage/<%=filenames[0]%>' onerror="" /></a>
								</td>
							</tr>
							<tr>
								<th>날짜</th>
								<td><%=EVENT_DATE%></td>
								<th>작성자</th>
								<td><%=MEM_NAME%></td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3"><%=EVENT_TITLE%></td>
							</tr>
							<%
							} //for
							%>
						</table>
						<%
						} //if
						%>
					</div>
			          <div class="bottomMenu">
			            <div class="empty"></div>
			            <ul class="pagination" id="pagenation">           
			            </ul>
						<div class="button">
							<a href="eventWrite.jsp"><button>글쓰기</button></a>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<form name="readFrm" method="get">
			<input type="hidden" name="EVENT_NO"> 
		</form>
	</section>

	<script src="../script/eventScript.js?qwfddge"></script>
	
</body>
</html>