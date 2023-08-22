<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*, java.io.File"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />
<%
request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");
%> 
<%
String name = null;
String partType = null;
String level = null;
String memNo = null;
String date = null;
String img = null;

Vector<MypageBean> vlist = pMgr.memberFind(id, pw);

MypageBean bean = vlist.get(0);
	
if (id != null & pw != null) {
	name = bean.getMEM_NAME();
	partType = bean.getPART_TYPE();
	level = bean.getLE_LEVEL();
	memNo = bean.getMEM_NO();
	date = bean.getMEM_DATE();
	img = bean.getMEM_IMG();
}

String path = session.getServletContext().getRealPath("/management/filestorage");

String check = null;
if (img != null) {
	File file = new File(path+"/"+img);

if(file.exists() ){ //파일 유무 확인
	check = "check";
}
}
%>
<!-- 아이디 이름 소속 직위 -->
<form action="../UpdateImgServlet?img=<%=img %>" method="post" enctype="multipart/form-data">
	<input type="file" class="nonebox" id="file" name="file" accept="image/*" onchange="change()">
	<input type="submit" class="nonebox" id="submit">
</form>

<div id="boximg" class="imgbutton">
	<% if (img != null && check == "check") {%>
	<input type="image" src="../management/filestorage/<%=img %>" id="img" class="imgbutton" onclick="img()">
	<%} else {%>
	<input type="image" src="../images/profile.jpg" id="img" class="imgbutton" onclick="img()">
	<%} %>
</div>

<script>
	function img() {
		document.getElementById('file').click();
	}
	
	function change() {
		document.getElementById('submit').click();
	}
</script>

<div class="inlineblock">

	<!-- ID -->
	<div class="box1">
		<div class="box2">
			<div>ID</div>
			<div class="boxtext">
				<%=id%>
			</div>
		</div>
	</div>

	<!-- 이름 -->
	<div class="box1">
		<div class="box2">
			<div>이름</div>
			<div class="boxtext">
				<%=name%>
			</div>
		</div>
	</div>

	<!-- 소속 -->
	<div class="box1">
		<div class="box2">
			<div>소속</div>
			<div class="boxtext">
				<%=partType%>
			</div>
		</div>
	</div>

	<!-- 직위 -->
	<div class="box1">
		<div class="box2">
			<div>직위</div>
			<div class="boxtext">
				<%=level%>
			</div>
		</div>
	</div>

	<!-- 사번 -->
	<div class="box1">
		<div class="box2">
			<div>사번</div>
			<div class="boxtext">
				<%=memNo%>
			</div>
		</div>
	</div>

	<!-- 입사일 -->
	<div class="box1">
		<div class="box2">
			<div>입사일</div>
			<div class="boxtext">
				<%=date%>
			</div>
		</div>
	</div>

</div>