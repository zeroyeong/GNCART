<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
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
	<form action="" method="post">
		<label for="Line1">결재자 팀장</label>
		 <select name="approver1" id="approver1">
			<option>팀장 쫘라락</option>
		</select> 
		
		<br> 
		
		<label for="Line2">결재자 부장</label> 
		<select name="approver2" id="approver2">
			<option>부장 쫘라락</option>
		</select>

		<button class="submitBtn" type="submit">확인</button>
	</form>
</body>

</html>