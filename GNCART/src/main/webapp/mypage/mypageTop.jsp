<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*, java.text.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />
<%
request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");

String memNo = null;
String start1 = null;
String start2 = null;
String workdNo = null;
String authlsNo = null;

String end1 = null;
String end2 = null;
int end3 = 0;

String max0 = null;
String max1 = null;
String max2 = null;
String max3 = null;

int min1 = 0;
String min2 = null;
int min3 = 0;
int min4 = 0;
String min5 = null;

Date date = new Date();
SimpleDateFormat dayStart1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat dayStart2 = new SimpleDateFormat("yyyy-MM-dd");

if (id != null && pw != null) {
	memNo = pMgr.memNoFind(id, pw);

	start1 = dayStart1.format(date);
	start2 = start1.substring(0, 10);
	workdNo = pMgr.workdNoFind(start2, memNo);
	authlsNo = pMgr.authlsNoFind(start2, memNo);

	end1 = start1.replaceAll("[^0-9]", "");
	end2 = end1.substring(8, 10);
	end3 = Integer.parseInt(end2);
	
	max0 = dayStart2.format(date);
	max1 = max0.substring(0,4);
	max2 = max0.substring(4,6);
	max3 = max0.substring(6,8);

	min1 = Integer.parseInt(max2) - 1;
	min2 = Integer.toString(min1);
	
	if(min1 > 0){
	min5 = max1 + "-" + min2 + "-" + max3;
	} else {
		min3 = Integer.parseInt(max1) - 1;
		min4 = min1 + 12;
		
		min5 = Integer.toString(min3) + "-" + Integer.toString(min4) + "-" + max3;
	}
}
%>

<!-- 내 정보 -->
<div id="title">
	<h2>내 정보</h2>

	<div>
		<form method="post" action="workday/workStart.jsp" id="workStart2"
			name="workStart2" class="nonebox"></form>
		<form method="post" action="workday/workEnd.jsp" id="workEnd2"
			name="workEnd2" class="nonebox"></form>
		<form method="post" action="workday/workRest.jsp" id="workRest2"
			name="workRest2" class="nonebox"></form>

		<button class="buttonwork" id="workStart">출근하기</button>

		<button class="buttonwork nonebox" id="workEnd">퇴근하기</button>

		<button class="buttonwork nonebox" id="workStart1">출근</button>

		<button class="buttonwork nonebox" id="workEnd1">퇴근</button>
		
		<button class="buttonwork nonebox" id="workRest1">휴가 취소</button>
		
		<input type="date" min=<%=min5 %> max=<%=max0 %> class="nonebox"
		id="workdate" name="workdate" value=<%=max0 %>>
	</div>

</div>
<%
if (authlsNo == null || authlsNo == "") { //휴가가 아니라면의 if문 시작(1번)

	if (workdNo != null) { //출근 기록이 있다면의 if문 시작(2번)

		String start3 = pMgr.workdStartFind(workdNo);

		String start4 = start3.substring(0, 10);

		String end4 = pMgr.workdEndFind(workdNo);

		if (end4 != null) { //퇴근 기록이 있다면의 if문 시작(3번)

			String end5 = end4.substring(0, 10);

			if (end5.equals(start4)) { //퇴근 기록이 오늘 날짜라면의 if문 시작(4번)
%>
			<script>
				//퇴근 나오기
				document.querySelector('#workStart').style.display = "none";
				document.querySelector('#workStart1').style.display = "none";
				document.querySelector('#workEnd').style.display = "none";
				document.querySelector('#workEnd1').style.display = "block";
				document.querySelector('#workRest1').style.display = "none";
			</script>
<%
			} //퇴근 기록이 오늘 날짜라면의 if문 종료 (4번 if문 끝)
		} //퇴근 기록이 있다면의 if문 종료 (3번 if문 종료)
		else { //퇴근 기록이 있다면의 else문 시작(3번의 else문)

			if (start2.equals(start4)) { //출근 기록이 있다면의 if문 시작(3번 else문의 if문)(3e-1i번의 if문)

				if (end3 < 17) { //17시 전이라면의 if문 시작(3번 else문의 if문의 if문)(3e-1i-1i번의 if문)
%>
					<script>
						//출근 나오기
						document.querySelector('#workStart').style.display = "none";
						document.querySelector('#workStart1').style.display = "block";
						document.querySelector('#workEnd').style.display = "none";
						document.querySelector('#workEnd1').style.display = "none";
						document.querySelector('#workRest1').style.display = "none";
					</script>
<%
				} //17시 전이라면의 if문 종료(3e-1i-1i번 if문 종료)
				else { //17시 전이라면의 else문 시작(3e-1i-1e번의 else문)
%>
					<script>
						//퇴근하기 나오기
						document.querySelector('#workStart').style.display = "none";
						document.querySelector('#workStart1').style.display = "none";
						document.querySelector('#workEnd').style.display = "block";
						document.querySelector('#workEnd1').style.display = "none";
						document.querySelector('#workRest1').style.display = "none";
					</script>
<%
				} //17시 전이라면의 else문 종료(3e-1i-1e번의 if else문 종료)
			} //출근 기록이 있다면의 if문 종료(3e-1i번 if문 종료)
		} //퇴근 기록이 오늘 날짜라면의 else문 종료(3번 if else문 종료)
	} //출근 기록이 있다면의 if문 종료(2번 종료)
} //id, pw, 오늘 날짜의 데이터가 전부 있다면의 if문 종료(1번 종료)
else { //휴가가 아니라면의 else문 시작(1번의 else문)
%>
	<script>
		//휴가 취소 나오기
		document.querySelector('#workStart').style.display = "none";
		document.querySelector('#workStart1').style.display = "none";
		document.querySelector('#workEnd').style.display = "none";
		document.querySelector('#workEnd1').style.display = "none";
		document.querySelector('#workRest1').style.display = "block";
	</script>
<%
}
%>
