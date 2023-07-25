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
String restDay = pMgr.restDayFind(memNo);

if(memNo == restDay) {
	
}
else { //데이터가 있다면의 else문 시작
%>
<script>
	history.back();
</script>
<%
}
%>