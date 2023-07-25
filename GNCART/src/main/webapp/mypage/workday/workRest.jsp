<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*, java.text.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");

String memNo = pMgr.memNoFind(id, pw);

Date date = new Date();
SimpleDateFormat day = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String start1 = day.format(date);

if (id != null && pw != null && start1 != null) { //id, pw, 오늘 날짜의 데이터가 있다면

	String start2 = start1.substring(0, 10);

	String authlsNo = pMgr.authlsNoFind(start2, memNo);

	if (authlsNo != null) { //휴가 기록이 있다면
		String workdNo = pMgr.workdNoFind(start2, memNo);

		pMgr.workRestStart(start1, workdNo);

		String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

		response.sendRedirect(url);
	} //휴가 기록이 있다면 if 종료 else문 안씀
} //데이터가 있다면 if문 종료
else { //데이터가 있다면의 else문 시작
%>
<script>
	history.back();
</script>
<%
}
%>