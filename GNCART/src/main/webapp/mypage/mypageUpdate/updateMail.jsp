<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String id = (String) session.getAttribute("idKey");

MypageBean upBean = new MypageBean();

upBean.setMEM_MAIL(request.getParameter("mail4"));

String mail = request.getParameter("mail4");

String email = "\\w+@\\w+\\.\\w+(\\.\\w+)?";

if (id != null && upBean != null && mail.matches(email)) {

	pMgr.updateMail(upBean, id);

	String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

	response.sendRedirect(url);
} else if (mail == null || mail == ""){
	%>
	<script>
		history.back();
	</script>
	<%	
} else {
%>
<script>
	alert("변경할 수 없는 이메일입니다.");
	history.back();
</script>
<%
}
%>
