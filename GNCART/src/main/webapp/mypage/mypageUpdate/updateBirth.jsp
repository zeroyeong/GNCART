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
System.out.println(birth);

upBean.setMEM_BIRTH(birth);

if (id != null && upBean != null && birth.length() == 10) {

	pMgr.updateBirth(upBean, id);

	String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

	response.sendRedirect(url);
} else if (birth == null || birth == ""){
	%>
	<script>
		history.back();
	</script>
	<%	
} else {
%>
<script>
	alert("예시의 비밀번호처럼 작성해주세요.");
	history.back();
</script>
<%
}
%> 
