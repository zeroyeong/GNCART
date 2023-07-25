<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="message.MsgBean"%>
<jsp:useBean id="msgMgr" class="message.MsgMgr" />

<%
	int msg_no = Integer.parseInt(request.getParameter("msg_no"));
	String pageName = request.getParameter("pageName");	

	MsgBean bean = new MsgBean();	
	bean = msgMgr.getMsg(msg_no);

	String title = bean.getMsg_title();
	String content = bean.getMsg_content();
	String toname = bean.getMsg_toname();
	String fromname = bean.getMsg_fromname();
	String sendtime = bean.getMsg_sendtime();
	String readtime = bean.getMsg_readtime();
	String read = bean.getMsg_read();
	
	request.setAttribute("bean", bean);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/messageDetail.css">
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
					<h2>메세지 내용</h2>

					<div id="writerInfo">
						<span>작성자 : <a href="#"><%= fromname %></a></span> <span>작성일
							: <span> <%= sendtime %></span>
						</span>
					</div>
				</div>
				<hr>
				<form name="msgFrm" method="post" action="msgDelete.jsp">
					<table>
						<tr>
							<td class="tableTitle">제목</td>
							<td colspan="3"><%= title %></td>
						</tr>
						<tr>
							<td class="tableTitle">보낸사람</td>
							<td><%= toname %></td>
							<td class="tableTitle">해당부서</td>
							<td>나중에 member 추가</td>
						</tr>
						<tr>
							<td class="tableTitle">받는사람</td>
							<td><%= fromname %></td>
							<td class="tableTitle">해당부서</td>
							<td>나중에 member 추가</td>
						</tr>
						<tr>
							<td class="tableTitle detail">상세내용</td>
							<td colspan="3"><%= content %></td>
						</tr>
					</table>

					<input type="hidden" name="read" value="읽음"> <input
						type="hidden" name="msg_no" value="<%= msg_no %>"> <input
						type="hidden" name="pageName" value="<%= pageName %>">

					<div id="btns">
						<button type="button" onclick="deleteBtn()">삭제하기</button>
						<button type="button">
							<a href="<%= pageName %>">목록</a>
						</button>
					</div>

				</form>
			</div>

		</div>
	</section>
	<script src="../script/messageDetail.js"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>