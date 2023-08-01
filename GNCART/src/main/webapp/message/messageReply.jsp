<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="message.MsgBean"%>
<%@page import="management.ManagementBean" %>
<jsp:useBean id="msgMgr" class="message.MsgMgr" />

<% 
request.setCharacterEncoding("UTF-8");

String fromPartType= request.getParameter("fromPartType");
String fromName = request.getParameter("fromName");

ManagementBean bean = new ManagementBean();

int mem_no = (int)session.getAttribute("memNo");
bean =  msgMgr.userInfo(mem_no);

String mem_name = bean.getMEM_NAME();
String part_type = bean.getPART_TYPE();
%>

<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/messageWrite.css?after">
<!--Boxicons CDN Link-->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
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
					<h2>메시지</h2>
				</div>
				<hr>
				<form name="msgFrm" method="post" action="messagedPost" enctype="multipart/form-data">
					<table>
						<tr>
							<td class="tableTitle">제 목</td>
							<td colspan="3"><input id="detailTitle" name="msg_title"
								required></td>
						</tr>
						<tr>
						<td class="tableTitle"><label for="part">부서 / 이름</label></td>
						<td colspan="3">
							<input id="user_part_name" name="user_part_name" placeholder="부서 / 이름" value="<%= fromPartType %> / <%= fromName %>" readonly>
						</td>
						</tr>
						<tr>
							<td class="tableTitle detail"><label for="detailContent">상세
									내용</label></td>
							<td colspan="3">
							<textarea id="detailContent" name="msg_content"></textarea>
							</td>
						</tr>
						<tr>
							<td class="tableTitle">첨부 파일</td>
							<td colspan="3">
								<div class="addbox">
									<input id="filename" placeholder="첨부파일" readonly> <label
										for="file">파일찾기</label> <input type="file" id="file"
										name="filename" onclick="findFile()">
								</div>
							</td>
						</tr>
					</table>
					<input type="hidden" name="mem_no" value="<%= mem_no %>">
					<input type="hidden" name="msg_frompparttype" value="<%= part_type %>">
					<input type="hidden" name="msg_fromname" value="<%= mem_name %>">
					<div id="btns">
						<button type="submit">보내기</button>
						<button type="reset">다시쓰기</button>
						<button type="button">
							<a href="messageInbox.jsp">목록</a>
						</button>

					</div>
				</form>

			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="../script/indexScript.js"></script>
	<script src="../script/messageWrite.js"></script>
</body>
</html>