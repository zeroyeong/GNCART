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

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

String start = LocalDate.now().format(formatter);
String start2 = LocalDateTime.now().format(formatter2);

String workdNo = null;
String workdVacNo = null;

String vacSdate = null;
String vacEdate = null;

String minusDay = null;

if (id != null && pw != null && start != null) { //id, pw, 오늘 날짜의 데이터가 있다면

	workdNo = wMgr.workdNoStartFind(start, memNo);
	workdVacNo = wMgr.workdVacNoFind(start, memNo);

	vacSdate = wMgr.vacSdateFind(workdVacNo);
	vacEdate = wMgr.vacEdateFind(workdVacNo);
	
	long days = DAYS.between(LocalDate.parse(start, formatter), LocalDate.parse(vacEdate, formatter));
	
	if (workdVacNo != null) { //휴가 기록이 있다면
		 
		if (vacSdate.equals(start)) { //휴가 시작이 오늘이라면
			wMgr.workRestDelete(workdNo);
			wMgr.authdoucumentDelete(workdVacNo);
			wMgr.authvacationDelete(workdVacNo);
			
			wMgr.workStart(start2, memNo);

			
		} else { //휴가 시작이 오늘이 아니라면
			
			wMgr.workRestCancel(start, workdNo);
		
			minusDay = LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			
			wMgr.authvacationCancel(minusDay, workdVacNo);

		} //휴가 기록이 있다면 if 종료 else문 안씀
	
		for(int i = 1; i <= (int)days; i++ ) {
		
			String start3 = LocalDate.now().plusDays(i).format(formatter);
		
			workdNo = wMgr.workdNoStartFind(start3,memNo);
		
			wMgr.workRestDelete(workdNo);
		}
		
		String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

		response.sendRedirect(url);
	}
} //데이터가 있다면 if문 종료
else { //데이터가 있다면의 else문 시작
%>
<script>
	history.back();
</script>
<%
}
%>