<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.MemberMgr"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />

<%
// 세션 무효화
session.invalidate();

// 쿠키 삭제
javax.servlet.http.Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (javax.servlet.http.Cookie cookie : cookies) {
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
}
%>

<script>
	location.replace("login.jsp");
</script>