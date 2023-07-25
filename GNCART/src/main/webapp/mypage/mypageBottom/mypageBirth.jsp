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
String birth = null;

String birth0 = null;

String birth1 = null;
String birth2 = null;
String birth3 = null;

if (id != null && pw != null) {
	birth = pMgr.birthFind(id, pw);

	birth0 = birth.replaceAll("[^0-9]", "");

	birth1 = birth0.substring(0,4);
	birth2 = birth0.substring(4,6);
	birth3 = birth0.substring(6,8);
}
%>
<!-- 생년월일 -->
<div class="box3">
	<div class="box4">
		<div>
			<a id="birth"> 생년월일 </a>
		</div>

		<div class="boxtext">
			<div class="space">
				<div>
					<a id="birth2">
						<%=birth1%>-<%=birth2%>-<%=birth3%>
					</a>
					<form action="mypageUpdate/updateBirth.jsp" method="post"
						name="birth6" id="birth6">
						<input class="nonebox" name="birth4" id="birth4"
							placeholder="예시 : 19990101" style="width: 220px;"
							maxlength="8"></input>
					</form>
				</div>

				<div>
					<button class="buttonbox blockbox" id="birth1">수정</button>


					<div>
						<button class="buttonbox nonebox" id="birth3">수정 완료</button>
					</div>

					<div style="margin-top: 30px;">
						<button class="buttonbox nonebox" id="birth5">취소</button>
					</div>

				</div>

			</div>
		</div>

	</div>
</div>