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
String add = null;

if(id != null && pw != null) {
	add = pMgr.addFind(id, pw);
}
%>
<!-- 주소 -->
<div class="box3">
	<div class="box4">
		<div>
			<a id="add"> 주소 </a>
		</div>

		<div class="boxtext">
			<div class="space">
				<div>
					<a id="add2"> <%=add%>
					</a>
					<form action="mypageUpdate/updateAdd.jsp" method="post" name="add6"
						id="add6">
						<input class="nonebox" name="add4" id="add4"
							placeholder="바꾸고 싶은 주소를 입력하세요." style="width: 220px;"
							maxlength="30"></input>
					</form>
				</div>

				<div>
					<button class="buttonbox blockbox" id="add1">수정</button>

					<div>
						<button class="buttonbox nonebox" id="add3">수정 완료</button>
					</div>

					<div style="margin-top: 30px;">
						<button class="buttonbox nonebox" id="add5">취소</button>
					</div>

				</div>
			</div>
		</div>

	</div>
</div>