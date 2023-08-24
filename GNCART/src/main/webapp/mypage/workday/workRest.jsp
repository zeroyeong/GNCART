<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, common.*, mypage.*, java.time.*, java.time.format.*, static java.time.temporal.ChronoUnit.DAYS"%>
<jsp:useBean id="wMgr" class="mypage.WorkdayMgr" />

<%
//휴가 기록 있으면 mysql에 있는 workday의 AUTHLS_NO에 값을 넣는 jsp
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

LocalDate day = LocalDate.now();

String day2 = day.format(formatter);

String vacNo = request.getParameter("VAC_NO");

String memNo = wMgr.memNoVacFind(vacNo);

String sdate = null;
String edate = null;

long days = 0;

if (vacNo != null) {
	sdate = wMgr.vacSdateFind(vacNo);
	edate = wMgr.vacEdateFind(vacNo);

	LocalDate sdate1 = LocalDate.parse(sdate, formatter);
	LocalDate edate1 = LocalDate.parse(edate, formatter);

	days = DAYS.between(sdate1, edate1);

	for (int i = 0; i <= (int) days; i++) {
		String start = sdate1.plusDays(i).format(formatter);

		wMgr.workdayVac(start, vacNo, memNo);
	}
}
%>
<script>
	alert("승인처리가 완료되었습니다");
	window.close();
	window.opener.location.reload();
</script> 