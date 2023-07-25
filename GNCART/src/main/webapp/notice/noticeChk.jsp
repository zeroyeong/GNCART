<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeMgr"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>JSP Board</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<% 
		request.setCharacterEncoding("UTF-8");
	
	String[] NOT_NO = request.getParameterValues("chk");
	
	NoticeMgr Mgr = new NoticeMgr();
	
	int res = 0;
	if (NOT_NO != null && NOT_NO.length > 0) {
		res = Mgr.noticeCheck(NOT_NO);
	}
	
	if (NOT_NO == null || NOT_NO.length == 0) {
	%>
		<script type="text/javascript">
		alert("선택한 게시글이 없습니다.");
		location.href="notice.jsp";
		</script>
	<%
	} else if (res == NOT_NO.length) {
	%>
		<script type="text/javascript">
		alert("선택된 게시글이 삭제되었습니다.");
		location.href="notice.jsp";
		</script>
	<%
	} else {
	%>
		<script type="text/javascript">
		alert("선택된 게시글이 삭제되지않았습니다.");
		location.href="notice.jsp";
		</script>
	<%
	}
	%>
</body>
</html>