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
String phone = null;

if (id != null && pw != null) {
	phone = pMgr.phoneFind(id, pw);

}
%>
<!-- 전화번호 -->
<div class="box3">
	<div class="box4">
		<div>
			<a id="phone"> 전화번호 </a>
		</div>

		<div class="boxtext">
			<div class="space">
				<div>
					<a id="phone2"> <%=phone%>
					</a>
					<form action="mypageUpdate/updatePhone.jsp" method="post"
						name="phone6" id="phone6">
						<input type="text" class="nonebox" name="phone4" id="phone4"
							placeholder="-를 빼고 전화번호를 입력해주세요." style="width: 220px;"
							maxlength="13"></input>
					</form>
				</div>

				<div>
					<button class="buttonbox blockbox" id="phone1">수정</button>

					<div>
						<button class="buttonbox nonebox" id="phone3">수정 완료</button>
					</div>

					<div style="margin-top: 30px;">
						<button class="buttonbox nonebox" id="phone5">취소</button>
					</div>

				</div>

			</div>
		</div>

	</div>
</div>
<script>
let phone = document.querySelector("#phone4");

phone.addEventListener("input", () => {

let val = phone.value.replace(/\D/g, "");
let leng = val.length;

let result = '';

if(leng < 4) result = val;
	else if(leng < 7){
		result += val.substring(0,3);
		result += "-";
		result += val.substring(3,6);
	} else if(leng < 11){
		result += val.substring(0,3);
		result += "-";
		result += val.substring(3,6);
		result += "-";
		result += val.substring(6);
	} else {
		result += val.substring(0,3);
		result += "-";
		result += val.substring(3,7);
		result += "-";
		result += val.substring(7);
	}
	phone.value = result;
})
</script>