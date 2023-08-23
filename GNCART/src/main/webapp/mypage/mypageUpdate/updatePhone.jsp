<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String id = (String) session.getAttribute("idKey");

MypageBean upBean = new MypageBean();

//MypageBean 클래스 객체 upBean을 생성하고, 변경된 전화번호를 setter 메서드를 이용해 담는다.

String phone = request.getParameter("phone4");

upBean.setMEM_PHONE(phone); 

//수정할 내용이 담긴 데이터는 upBean 객체에 있다. (jsp 화면에서 이동해온 phone4 데이터)

if (id != null && upBean != null && phone.length() > 11) {

	//MypageMgr 클래스 updatePhone() 메서드를 호출
	pMgr.updatePhone(upBean, id);

	String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

	response.sendRedirect(url);
} else if (phone == null || phone == ""){
	%>
	<script>
		history.back();
	</script>
	<%	
} else {
%>
<script>
	alert("전화번호를 적어주세요.");
	history.back();
</script>
<%
}
%>
