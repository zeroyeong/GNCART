<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String id = (String) session.getAttribute("idKey");
String pw4 = request.getParameter("pwd4");
String pw5 = request.getParameter("pwd5");

String number = "(?=.*[a-zA-Z])(?=.*\\d).{2,20}";

MypageBean upBean = new MypageBean();

upBean.setMEM_PW(request.getParameter("pwd4"));

if (id != null && upBean != null && pw4.matches(number)) {

	if (pw4.equals(pw5)) {

		pMgr.updatePw(upBean, id);

		session.removeAttribute("pwKey");
		session.setAttribute("pwKey", pw4);

		String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

		response.sendRedirect(url);
	} else {
%>
<script>
	alert("동일한 비밀번호를 입력해주세요.");
	history.back();
</script>
<%
}
}  else if (pw4 == null || pw4  == ""){ 
	%>
	<script>
		history.back();
	</script>
	<%	
} else {
%>
<script>
	alert("변경할 수 없는 비밀번호입니다.");
	history.back();
</script>
<%
}
%>
