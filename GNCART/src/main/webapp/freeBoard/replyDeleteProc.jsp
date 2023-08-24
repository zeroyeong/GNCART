<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeBoard.replyDAO" %>
<%@ page import="freeBoard.reply" %>
<%
	request.setCharacterEncoding("UTF-8");
	int replyNo = Integer.parseInt(request.getParameter("replyNo"));
	int FREE_NO = Integer.parseInt(request.getParameter("FREE_NO"));
	
	System.out.println("replyNo="+replyNo);
	System.out.println("FREE_NO="+FREE_NO);
	
	replyDAO dao = new replyDAO();
	dao.deleteReply(replyNo);
	
	
	
	response.sendRedirect("freeread.jsp?FREE_NO="+FREE_NO);
	
	%>
 

 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>