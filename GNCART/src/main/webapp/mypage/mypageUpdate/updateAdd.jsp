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

if (id != null && upBean != null && add.length() > 6) {

	pMgr.updateAdd(upBean, id);

	String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

	response.sendRedirect(url);
} else if (add == null || add == ""){
	%>
	<script>
		history.back();
	</script>
	<%	
} else {
%>
<script>
	alert("변경할 수 없는 주소입니다.");
	history.back();
</script>
<%
}
%> 
