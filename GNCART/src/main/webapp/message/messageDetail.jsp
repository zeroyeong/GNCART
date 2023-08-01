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
	String toPartType = bean.getMsg_toPartType();
	String toName = bean.getMsg_toName();
	String fromPartType = bean.getMsg_fromPartType();
	String fromName = bean.getMsg_fromName();
	String sendTime = bean.getMsg_sendTime();
	String readTime = bean.getMsg_readTime(); 
	String read = bean.getMsg_read();
	int delCnt = bean.getMsg_delCnt();
	String filename = bean.getMsg_file(); 
	
	
	if(read.equals("안읽음")){
		msgMgr.setRead(msg_no);
	} 
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
							<td><%= fromName %></td>
							<td class="tableTitle">해당부서</td>
							<td><%= fromPartType %></td>
						</tr>
						<tr>
							<td class="tableTitle">받는사람</td>
							<td><%= toName %></td>
							<td class="tableTitle">해당부서</td>
							<td><%= toPartType %></td></tr>
						<tr>
							<td class="tableTitle detail">상세내용</td>
							<td colspan="3"><%= content %></td>
						</tr>
						
						<%
            			if(filename != null && !filename.isEmpty()){  
						%>
						<tr>
							<td class="tableTitle">첨부파일</td>
							<td colspan="3"><a id="filename"
								href="msgFiledown.jsp?filename=<%=filename%>"><%= filename %></a></td>
						</tr>
						<%
            			}
						%>
					</table>

					<input type="hidden" name="read" value="읽음"> 
					<input type="hidden" name="msg_no" value="<%= msg_no %>"> 
					<input type="hidden" name="pageName" value="<%= pageName %>">

					<div id="btns">
						<%
						if(pageName.equals("messageInbox")){
						%>
						<button type="button"><a href="messageReply.jsp?fromPartType=<%= fromPartType %>&fromName=<%= fromName %>">답장하기</a></button>
						<%
						}
						%>
						<button type="button" onclick="deleteBtn()">삭제하기</button>
						<button type="button"><a href="<%= pageName %>.jsp">목록</a></button>
					</div>

				</form>
			</div>

		</div>
	</section>
	<script src="../script/messageDetail.js"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>