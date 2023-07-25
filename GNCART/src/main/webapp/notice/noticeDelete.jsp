<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@page import="notice.NoticeBean"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP Board</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <%
        int NOT_NO = Integer.parseInt(request.getParameter("NOT_NO"));
        NoticeBean bean = (NoticeBean) session.getAttribute("bean");

        // 게시글 삭제
        nMgr.deleteNoitce(NOT_NO);
    %>
    <script type="text/javascript">
        alert('게시글이 정상적으로 삭제되었습니다.');
        window.location.href = 'notice.jsp';
    </script>
</head>
<body>
    <input type="hidden" name="NOT_NO" value="<%=NOT_NO%>">
</body>
</html>