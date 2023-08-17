<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />

<%
request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");
%>
<!-- 비밀번호 --> 
<div class="box3">
	<div class="box4">
		<div>
			<a id="pwd"> 비밀번호 </a>
		</div>

		<div class="boxtext">
			<div class="space">
				<div>
					<a id="pwd2">
						****
					</a>
					<a id="pwd12" class="nonebox">
						<%=pw%>
					</a>
					
					<form action="mypageUpdate/updatePw.jsp" method="post" name="pwd7"
						id="pwd7">
						<input class="nonebox" name="pwd4" id="pwd4"
							placeholder="영어와 숫자를 입력해주세요."
							style="width: 220px; margin-bottom: 5px;" maxlength="20"
							type="password"></input>
						<input class="nonebox" name="pwd5"
							id="pwd5" placeholder="동일한 비밀번호를 입력하세요." style="width: 220px;"
							type="password"  maxlength="20"></input>
					</form>
				</div>

				<div>
					<button class="buttonbox blockbox" id="pwd1" style="margin-left: 10px;">수정</button>
					<button class="buttonbox" id="pwd10">보기</button>
					<button class="buttonbox nonebox" id="pwd11">숨기기</button>

					<div>
						<button class="buttonbox nonebox" id="pwd3">수정 완료</button>
					</div>

					<div style="margin-top: 30px;">
						<button class="buttonbox nonebox" id="pwd6" style="margin-left: 10px;">취소</button>
						<button class="buttonbox nonebox" id="pwd8">보기</button>
						<button class="buttonbox nonebox" id="pwd9">숨기기</button>
					</div>

				</div>

			</div>
		</div>

	</div>
</div>