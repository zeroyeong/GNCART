<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<%@ page import="auth.AuthMgr"%>
<%@ page import="java.util.*"%>
<% 
	if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
		response.sendRedirect("../login.jsp");

	String leLevel = (String) session.getAttribute("leLevel");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>결재선</title>
	<link rel="stylesheet" href="../css/authLine.css">
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

</head>
<body>
	<h1>결재선</h1>
	<form name="busForm" id="busForm" action="authBusiness.jsp" method="post">
		<% if (!"팀장".equals(leLevel)) { %>
		<label for="line1">결재자 팀장</label> 
		<select name="line1">
			<%
				AuthMgr authMgr = new AuthMgr();
				ArrayList<String> teamLeaders = authMgr.getTeamLeaders();
				for (String teamLeader : teamLeaders) {
			%>
	
			<option value="<%=teamLeader%>"><%=teamLeader%></option>
	
			<%
			} 
			%>
		</select>
			<% } %>
		
		<br> 
		
		<label for="line2">결재자 부장</label>
		<select name="line2">
			<%
				AuthMgr authMgr = new AuthMgr();
				ArrayList<String> managers = authMgr.getManagers();
				for (String manager : managers) { 
			%>

			<option value="<%=manager%>"><%=manager%></option>

			<%
			}
			%>
		</select>

		<button class="submitBtn" type="submit" onclick="busSubmit()">지정</button>
	</form>

	<script src="../script/authScript.js"></script>
</body>

</html>