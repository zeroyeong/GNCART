<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*, java.text.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />
gr" />
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");

String memNo = pMgr.memNoFind(id, pw);

Date date = new Date();
SimpleDateFormat day = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String start1 = day.format(date);

if (id != null && pw != null && start1 != null) { //id, pw, 오늘 데이터가 있다면

	String start2 = start1.substring(0, 10);

	String workdNo = pMgr.workdNoFind(start2, memNo); //WORKD_NO가 있는지 확인한다.

	if (workdNo != null) { //WORKD_NO가 있다면

		String start3 = pMgr.workdStartFind(workdNo);

		String start4 = start3.substring(0, 10);

		if (start2.equals(start4)) { //출근을 했는데 오늘 날짜와 동일하다면
%>
<script>
	alert("이미 출근을 하셨습니다."); //출근 했다고 표시해준다.
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

pMgr.workStart(start1, memNo);

String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

response.sendRedirect(url);
} //출근을 했다면의 if else문 종료

} //id, pw, 오늘 데이터가 있다면의 if문 종료
else { //id, pw, 오늘 데이터가 있다면의 else문 시작
%>
<script>
	alert("실패");
	history.back();
</script>
<%
} //id, pw, 오늘 데이터가 있다면의 if else문 종료
%>