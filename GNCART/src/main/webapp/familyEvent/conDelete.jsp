<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" /> 

<% 
request.setCharacterEncoding("UTF-8");
 
String checkedList [] = request.getParameterValues("check");
String conNum = request.getParameter("con_no");

%> 
<!DOCTYPE html>
<html lang="ko">
<head> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<%
if(checkedList != null){
	conMgr.deleteBoard(checkedList);
}
else if(conNum != null){
	int con_no =Integer.parseInt(conNum); 
	conMgr.deleteBoard(con_no);
}

%>

<script type="text/javascript">
location.href="condolences.jsp";
</script>

<script src="../script/conDelete.js"></script>
</body>
</html>