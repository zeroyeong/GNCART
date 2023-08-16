<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    import="schedule.ScheduleBean"
%>

<jsp:useBean id="sMgr" class="schedule.ScheduleMgr" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title> 
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	
		int SCHE_NO = Integer.parseInt(request.getParameter("SCHE_NO"));
		
		ScheduleBean bean = (ScheduleBean) session.getAttribute("bean");
		
		sMgr.delSchedule(SCHE_NO);
	%>

</body>
<script>
	window.onload = refreshParent;
	function refreshParent(){
		window.opener.location.reload();
		window.close();
	}
</script>
</html>