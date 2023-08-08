<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*, java.text.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />
<!-- 내 정보 -->
<div id="title">
	<h2>내 정보</h2>

	<div>
		<form method="post" action="workday/workStart.jsp" id="workStart2"
			name="workStart2" class="nonebox"></form>
		<form method="post" action="workday/workEnd.jsp" id="workEnd2"
			name="workEnd2" class="nonebox"></form>
		<form method="post" action="workday/workRestCancel.jsp" id="workRestCancel2"
			name="workRestCancel2" class="nonebox"></form>

		<button class="buttonwork" id="workStart">출근하기</button>

		<button class="buttonwork nonebox" id="workEnd">퇴근하기</button>

		<button class="buttonwork nonebox" id="workStart1">출근</button>

		<button class="buttonwork nonebox" id="workEnd1">퇴근</button>
		
		<button class="buttonwork nonebox" id="workRestCancel1">휴가 취소</button>
	</div>

</div>

<jsp:include page="mypageTop/mypageTopBottom.jsp" />