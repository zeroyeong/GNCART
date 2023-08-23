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

if (id != null && pw != null) {
	birth = pMgr.birthFind(id, pw);
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
						<%=birth%>
					</a>
					<form action="mypageUpdate/updateBirth.jsp" method="post"
						name="birth6" id="birth6">
						<input class="nonebox" name="birth4" id="birth4"
							placeholder="예시 : 19990101" style="width: 220px;"
							maxlength="10"></input>
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
<script>
let birth = document.querySelector("#birth4");

birth.addEventListener("input", () => {

let val = birth.value.replace(/\D/g, "");
let leng = val.length;

let result = '';

if(leng < 5) result = val;
	else if(leng < 7){
		result += val.substring(0,4);
		result += "-";
		result += val.substring(4,6);
	} else{
		result += val.substring(0,4);
		result += "-";
		result += val.substring(4,6);
		result += "-";
		result += val.substring(6);
	}
	birth.value = result;
})
</script>