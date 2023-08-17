<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="event.EventBean"%>
<% 
	  //read.jsp 페이지에서 이동한 num, nowPage 파라미터를 받아 각 각 변수에 저장
	  int EVENT_NO = Integer.parseInt(request.getParameter("EVENT_NO"));
	  
	  //session에 저장된 bean객체를 이용해서 게시물 정보를 각 각 변수에 저장 
	  EventBean bean = (EventBean)session.getAttribute("bean");
	  String EVENT_TITLE = bean.getEVENT_TITLE();
	  String EVENT_CONTENT = bean.getEVENT_CONTENT(); 
	  String EVENT_DATE = bean.getEVENT_DATE();
	  String MEM_NAME = bean.getMEM_NAME();
	  int EVENTSUB_NO = bean.getEVENTSUB_NO();
	  int PART_NO = bean.getPART_NO();
	  
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
					<h2>공지사항</h2>
				</div>
				<hr>
				<form name="ReviseFrm" method="post" action="../eventRevise">
					<table>
						<tr>
							<td class="tableTitle"><label>작성자</label></td>
							<td><input type="text" name="MEM_NO" value="<%=MEM_NAME%>" readonly></td>
							<!--작성자 이름 나오게-->
							<td class="tableTitle"><label>작성일</labe></td>
							<td><input type="text" name="EVENT_DATE" value="<%=EVENT_DATE%>" readonly></td>
							<!--작성일 나오게-->
						</tr>
						<tr>
							<td class="tableTitle"><label>말머리</label></td>
							<td><select name="EVENTSUB_NO">
									<option value="1" <%= (EVENTSUB_NO == 1) ? "selected" : "" %>>부서행사</option>
									<option value="2" <%= (EVENTSUB_NO == 2) ? "selected" : "" %>>사내행사</option>
									<option value="3" <%= (EVENTSUB_NO == 3) ? "selected" : "" %>>사외행사</option>
							</select></td>
							<td class="tableTitle"><label>해당 부서</label></td>
							<td><select name="PART_NO">
									<option value="1" <%= (PART_NO == 1) ? "selected" : "" %>>경영지원팀</option>
									<option value="2" <%= (PART_NO == 2) ? "selected" : "" %>>개발팀</option>
									<option value="3" <%= (PART_NO == 3) ? "selected" : "" %>>홍보팀</option>
									<option value="4" <%= (PART_NO == 4) ? "selected" : "" %>>영업팀</option>
									<option value="5" <%= (PART_NO == 5) ? "selected" : "" %>>서비스지원팀</option>
									<option value="6" <%= (PART_NO == 6) ? "selected" : "" %>>전체부서</option>
							</select></td>
						</tr>
						<tr>
							<td class="tableTitle"><label>제목</label></td>
							<td colspan="3"><input type="text" name="EVENT_TITLE" value="<%=EVENT_TITLE%>"></td>
							<!--작성자 이름 나오게-->
						</tr>
						<tr>
							<td class="tableTitle detail"><label>상세 내용</label></td>
							<td colspan="3"><textarea name="EVENT_CONTENT"><%=EVENT_CONTENT%></textarea></td>
						</tr>
						<tr>
							<td class="tableTitle"><label>첨부 파일</label></td>
							<td colspan="3"><input type="file" name="EVENT_FILENAME"></td>
						</tr>
					</table>
					<div id="btns">
						<button>수정하기</button>
						<button> <a href="eventDelete.jsp?=&EVENT_NO=<%=EVENT_NO%>">삭제하기</a></button>
					</div>
			</div>
			<input type='hidden' name="EVENT_NO" value="<%=EVENT_NO%>">
			</form>
		</div>
	</section>


	<script src="../script/indexScript.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

</body>
</html>