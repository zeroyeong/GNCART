<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*, java.time.*, java.time.format.*, static java.time.temporal.ChronoUnit.DAYS"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />
<jsp:useBean id="wMgr" class="mypage.WorkdayMgr" />
<%
request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");

String start1 = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
String start2 = LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH"));

String memNo = null;
String start3 = null;
String start4 = null;

String workdNo = null;
String workdVacNo = null;

int end1 = Integer.parseInt(start2);
String end2 = null;
String end3 = null;

if (id != null && pw != null) {
	memNo = pMgr.memNoFind(id, pw);

	workdNo = wMgr.workdNoStartFind(start1, memNo);
	
	workdVacNo = wMgr.workdVacNoFind(start1, memNo);
}

if (workdVacNo == null) { //휴가가 없다면

	if (workdNo != null) { //workdNo가 있다면 

		start3 = wMgr.workdStartFind(workdNo); //출근 확인

		start4 = start3.substring(0, 10);

		end2 = wMgr.workdEndFind(workdNo); //퇴근 확인

		if (end2 != null) { //퇴근을 했다면

			end3 = end2.substring(0, 10);

			if (end3.equals(start4)) {
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
			}
		}
		else if (end1 < 17) { //퇴근을 안했고 지금이 17시 전이라면
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
		} 
		else if (end1 >= 17) { //17시 이후라면
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
		}
	}
} 
else { 
%>
	<script>
		//휴가 취소 나오기
		document.querySelector('#workStart').style.display = "none";
		document.querySelector('#workStart1').style.display = "none";
		document.querySelector('#workEnd').style.display = "none";
		document.querySelector('#workEnd1').style.display = "none";
		document.querySelector('#workRestCancel1').style.display = "block";
	</script>
<%
}
%>