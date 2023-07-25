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
String mail = null;

if (id != null && pw != null) {
	mail = pMgr.mailFind(id, pw);
}
%>
<!-- 이메일 -->
<div class="box3">
	<div class="box4">
		<div>
			<a id="mail"> 이메일 </a>
		</div>

		<div class="boxtext">
			<div class="space">
				<div>
					<a id="mail2"> <%=mail%>
					</a>
					<form action="mypageUpdate/updateMail.jsp" method="post"
						name="mail6" id="mail6">
						<input class="nonebox" name="mail4" id="mail4"
							placeholder="바꾸고 싶은 이메일을 입력하세요." style="width: 220px;"
							maxlength="50" type="email"></input>
					</form>
				</div>

				<div>
					<button class="buttonbox blockbox" id="mail1">수정</button>


					<div>
						<button class="buttonbox nonebox" id="mail3">수정 완료</button>
					</div>

					<div style="margin-top: 30px;">
						<button class="buttonbox nonebox" id="mail5">취소</button>
					</div>

				</div>

			</div>
		</div>

	</div>
</div>