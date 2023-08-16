<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />
<%
request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");
%> 
<%
String name = null;
String partNo = null;
String partType = null;
String leNo = null;
String level = null;
String memNo = null;
String date = null;

if (id != null & pw != null) {
	name = pMgr.nameFind(id, pw);
	partNo = pMgr.partNoFind(id, pw);
	partType = pMgr.partTypeFind(partNo);
	leNo = pMgr.leNoFind(id, pw);
	level = pMgr.levelFind(leNo);
	memNo = pMgr.memNoFind(id, pw);
	date = pMgr.dateFind(id, pw);
}
%>
<!-- 아이디 이름 소속 직위 -->
<div id="boximg">
	<img src="../images/profile.jpg">
</div>

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