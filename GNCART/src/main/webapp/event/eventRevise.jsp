<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="event.EventBean"%>
<jsp:useBean id="eMgr" class="event.EventMgr" />
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
	<link rel="stylesheet" href="../css/eventWrite.css">
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
		<div class="home-content">
			<div class="container">
				<div class="title">
					<h3>행사사진</h3>
				</div>
				<div class="content">
					<form name="ReviseFrm" method="post" action="../eventRevise">
						<table>
							<colgroup>
								<col class="col1" />
								<col class="col2" />
								<col class="col3" />
								<col class="col4" />
							</colgroup>
							<tr>
								<td><span>제목</span></td>
								<td colspan="3">
									<input type="text" name="EVENT_TITLE" value="<%=EVENT_TITLE%>">
								</td>
							</tr>
							<tr>
								<td><span>행사종류</span></td>
								<td><select name="EVENTSUB_NO">
									<option value="1" <%= (EVENTSUB_NO == 1) ? "selected" : "" %>>부서행사</option>
									<option value="2" <%= (EVENTSUB_NO == 2) ? "selected" : "" %>>사내행사</option>
									<option value="3" <%= (EVENTSUB_NO == 3) ? "selected" : "" %>>사외행사</option>
								</select></td>

								<td><span>날짜</span></td>
								<td><input type="text" id="currentDateInput" readonly>
								</td>
							</tr>
							<tr>
								<td><span>부서</span></td>
								<td colspan="3"><select name="PART_NO">
									<option value="1" <%= (PART_NO == 1) ? "selected" : "" %>>경영지원팀</option>
									<option value="2" <%= (PART_NO == 2) ? "selected" : "" %>>개발팀</option>
									<option value="3" <%= (PART_NO == 3) ? "selected" : "" %>>홍보팀</option>
									<option value="4" <%= (PART_NO == 4) ? "selected" : "" %>>영업팀</option>
									<option value="5" <%= (PART_NO == 5) ? "selected" : "" %>>서비스지원팀</option>
									<option value="6" <%= (PART_NO == 6) ? "selected" : "" %>>전체부서</option>
								</select></td>
							</tr>
							<tr>
								<td><span class="memeo">내용</span></td>
								<td colspan="3">
									<textarea name="EVENT_CONTENT"><%=EVENT_CONTENT%></textarea>
								</td>
							</tr>
							<tr>
								<td><span>첨부파일</span></td>
								<td colspan="3">
									<div class="addbox">
										<input id="filename1" placeholder="첨부파일" readonly> 
												
										<label for="file1">파일찾기</label>
									    <input type="file" id="file1" name="EVENT_FILENAME1" onchange="findFile(1)">
									    
									    
									    <a onclick="fileplus()"><label for="file">추가</label></a>
								
									</div>
								</td>
							</tr>
						</table>

						<div class="button">
							<a href="event.jsp">
								<button type="submit" value="등록하기">저장</button>
								<button type="button">목록</button>
							</a>
						</div>
						
						<input type='hidden' name="EVENT_NO" value="<%=EVENT_NO%>">

					</form>
				</div>
			</div>
		</div>

	</section>
<script src="../script/eventScript.js"></script>
</body>
</html>