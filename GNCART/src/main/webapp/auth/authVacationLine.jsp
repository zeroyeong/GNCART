<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<%@ page import="auth.AuthMgr"%>
<%@ page import="java.util.*"%>
<%
if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
	response.sendRedirect("../login.jsp");
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결재선 설정</title>
<link rel="stylesheet" href="../css/authLine.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"
	integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
	crossorigin="anonymous"></script>

</head>
<body>
	<h1>결재선 설정</h1>
	<form name="vacForm" id="vacForm" action="authVacation.jsp" method="post">
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
		
		<br> 
		
		<label for="line2">결재자 부장</label>
		 <select name="line2">
			<%
			ArrayList<String> managers = authMgr.getManagers();
			for (String manager : managers) {
			%>

			<option value="<%=manager%>"><%=manager%></option>

			<%
			}
			%>
		</select>

		<button class="submitBtn" type="submit" onclick="vacSubmit()">지정</button>
	</form>

	<script>
		function vacSubmit() {
			window.opener.name = "authVacation.jsp"; // 부모창의 이름 설정
			document.vacForm.target = "authVacation.jsp"; // 타켓을 부모창으로 설정
			document.vacForm.action = "../auth/authVacation.jsp";
			document.vacForm.submit();
			self.close();
		}
	</script>
</body>

</html>