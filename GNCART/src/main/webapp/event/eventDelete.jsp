<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@page import="event.EventBean"%>
<jsp:useBean id="eMgr" class="event.EventMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<%
        int EVENT_NO = Integer.parseInt(request.getParameter("EVENT_NO"));
        EventBean bean = (EventBean) session.getAttribute("bean");

        // 게시글 삭제
        eMgr.deleteEvent(EVENT_NO);
    %>
<script type="text/javascript">
        alert('게시글이 정상적으로 삭제되었습니다.');
        window.location.href = 'event.jsp';
    </script>
</head>
<body>
	<input type="hidden" name="EVENT_NO" value="<%=EVENT_NO%>">
</body>
</html>