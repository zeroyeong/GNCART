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

if (id != null && pw != null && start != null) { //id, pw, 오늘 데이터가 있다면

	String workdNo = wMgr.workdNoStartFind(start2, memNo); //WORKD_NO가 있는지 확인한다.

	if (workdNo != null) { //WORKD_NO가 있다면

		String start1 = wMgr.workdStartFind(workdNo);

		String start3 = start1.substring(0, 10);

		if (start.equals(start1)) { //출근을 했는데 오늘 날짜와 동일하다면
%>
<script>
	history.back();
</script>
<%
} //출근 날짜와 오늘 날짜와 동일하다면의 if문 종료
else { //출근을 했는데 오늘 날짜와 동일하지 않다면 (불가능한 상황)
%>
<script>
	history.back(); //돌아간다.
</script>
<%
} //출근을 했는데 오늘 날짜와 동일하다면의 if else문 끝

} //출근을 했다면의 if문 종료
else { //출근을 했다면의 else문 시작

wMgr.workStart(start, memNo);

String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

response.sendRedirect(url);
} //출근을 했다면의 if else문 종료

} //id, pw, 오늘 데이터가 있다면의 if문 종료
else { //id, pw, 오늘 데이터가 있다면의 else문 시작
%>
<script>
	history.back();
</script>
<%
} //id, pw, 오늘 데이터가 있다면의 if else문 종료
%>