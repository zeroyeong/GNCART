<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String id = (String) session.getAttribute("idKey");

MypageBean upBean = new MypageBean();

upBean.setMEM_ADD(request.getParameter("add4"));

String add = request.getParameter("add4");

String number = "[0-9]{8}";
String email = "\\w+@\\w+\\.\\w+(\\.\\w+)?";
String number2 = "[0-9]{10, 11}";
String number3 = "(?=.*[a-zA-Z])(?=.*\\d).{2,20}";

if (id != null && upBean != null && add.length() > 6) {

	pMgr.updateAdd(upBean, id);

	String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

	response.sendRedirect(url);
} else {
%>
<script>
	alert("변경할 수 없는 주소입니다.");
	history.back();
</script>
<%
}
%>
