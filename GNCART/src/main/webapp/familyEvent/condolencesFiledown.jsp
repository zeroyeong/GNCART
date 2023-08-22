<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="conMgr" class="familyEvent.ConMgr" /> 
<!DOCTYPE html>
<html> 
<head>
	<meta charset="UTF-8">
	<title>JSP Board</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	
</head>
<body> 
	<% 
	  conMgr.downLoad(request, response, out, pageContext);
	%>
</body>
</html>   