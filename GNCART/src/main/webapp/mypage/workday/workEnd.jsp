<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*, java.time.*, java.time.format.*, static java.time.temporal.ChronoUnit.DAYS"%>
<jsp:useBean id="wMgr" class="mypage.WorkdayMgr" />

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");

String memNo = wMgr.memNoFind(id, pw);

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd");

String start = LocalDateTime.now().format(formatter);
String start2 = LocalDateTime.now().format(formatter2);

if (id != null && pw != null && start != null) { //id, pw, 오늘 날짜의 데이터가 있다면

	String workdNo = wMgr.workdNoStartFind(start2, memNo);

	if (workdNo != null) { //출근 기록이 있어서 WORKD_NO가 있다면

		wMgr.workEnd(start, workdNo);

		String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

		response.sendRedirect(url);
	} //출근 기록이 있다면 if 종료 else문 안씀
} //데이터가 있다면 if문 종료
else { //데이터가 있다면의 else문 시작
%>
<script>
	history.back();
</script>
<% 
}
%>