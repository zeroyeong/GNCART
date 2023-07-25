<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<jsp:useBean id="msgMgr" class="message.MsgMgr" />

<%
request.setCharacterEncoding("UTF-8");

String checkedList[] = request.getParameterValues("check");
String msgNum = request.getParameter("msg_no");
String url = request.getParameter("pageName");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
	<%
	if (checkedList != null) {
		msgMgr.deleteMsg(checkedList);
	} else if (msgNum != null) {
		int msg_no = Integer.parseInt(msgNum);
		msgMgr.deleteMsg(msg_no);
	}
	%>

	<input type="hidden" id="pageName" value="<%=url%>">

	<script type="text/javascript">
		var url = document.getElementById('pageName');

		location.href = url.value;
	</script>

	<script src="../script/conDelete.js"></script>
</body>
</html>