<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String id = (String) session.getAttribute("idKey");

MypageBean upBean = new MypageBean();

String birth = request.getParameter("birth4");

String birth0 = birth.replaceAll("[^0-9]", "");

String birth1 = null;
String birth2 = null;
String birth3 = null;
String birth4 = null;

if (birth0.length() == 8) {
	birth1 = birth0.substring(0, 4);
	birth2 = birth0.substring(4, 6);
	birth3 = birth0.substring(6, 8);
	birth4 = birth1 + "-" + birth2 + "-" + birth3;
}

upBean.setMEM_BIRTH(birth4);

String number = "[0-9]{8}";

if (id != null && upBean != null && birth.matches(number) && birth0.length() == 8) {

	pMgr.updateBirth(upBean, id);

	String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

	response.sendRedirect(url);
} else {
%>
<script>
	alert("예시의 비밀번호처럼 작성해주세요.");
	history.back();
</script>
<%
}
%>
