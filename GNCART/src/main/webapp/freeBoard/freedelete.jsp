<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="freeBoard.BoardBean"%>
<jsp:useBean id="bMgr" class="freeBoard.BoardMgr" />
<!DOCTYPE html>
<html> 
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/free.css">
  <!--Boxicons CDN Link-->
<link href="style.css" rel="stylesheet" type="text/css">
<%
        int FREE_NO = Integer.parseInt(request.getParameter("FREE_NO"));
        BoardBean bean = (BoardBean) session.getAttribute("bean");

        // 게시글 삭제
        bMgr.deletefreeBoard(FREE_NO);
    %>
<script type="text/javascript">
        alert('게시글이 정상적으로 삭제되었습니다.');
        window.location.href = 'notice.jsp';
    </script>
</head>
<body>
	<input type="hidden" name="FREE_NO" value="<%=FREE_NO%>">
</body>
</html>   