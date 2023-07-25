<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mMgr" class="management.ManagementMgr"/>

<%
	System.out.println("download.jsp 입장!");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	mMgr.downLoad(request, response, out, pageContext);
%>
</body>
</html>