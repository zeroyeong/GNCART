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

String number = "[0-9]{10,11}";

String phone0 = phone.replaceAll("[^0-9]", "");

String phone1 = null;
String phone2 = null;
String phone3 = null;
String phone4 = null;

if (phone0.length() == 11) {
	phone1 = phone0.substring(0, 3);
	phone2 = phone0.substring(3, 7);
	phone3 = phone0.substring(7, 11);
	phone4 = phone1 + "-" + phone2 + "-" + phone3;
} if (phone0.length() == 10) {
	phone1 = phone0.substring(0, 3);
	phone2 = phone0.substring(3, 6);
	phone3 = phone0.substring(6, 10);
	phone4 = phone1 + "-" + phone2 + "-" + phone3;
}

upBean.setMEM_PHONE(phone4);

//수정할 내용이 담긴 데이터는 upBean 객체에 있다. (jsp 화면에서 이동해온 phone4 데이터)

if (id != null && upBean != null && phone.length() > 9) {

	if (phone.matches(number)) {

		//MypageMgr 클래스 updatePhone() 메서드를 호출
		pMgr.updatePhone(upBean, id);

		String url = "http://localhost:8080/GNCART/mypage/mypageMain.jsp";

		response.sendRedirect(url);
	} else {
%>
<script>
	alert("숫자만 적어주세요.");
	history.back();
</script>
<%
}
%>
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
