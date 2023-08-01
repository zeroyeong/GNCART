<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, common.*, mypage.*, java.text.*, java.time.*,java.time.format.TextStyle"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />

<%
request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");

String memNo = pMgr.memNoFind(id, pw);

List<String> listWorkday = new ArrayList<String>();
List<String> listWorkdayStart = new ArrayList<String>();
List<String> listWorkdayEnd = new ArrayList<String>();
List<String> listWork = new ArrayList<String>();

String endDay = null;
String endDay1 = null;
String endDay2 = null;
String endDay3 = null;

String startDay = null;
String startDay2 = null;

String workday = null;
String workday2 = null;

String endNo = null;
String startNo = null;

DateFormat day = new SimpleDateFormat("yyyy-MM-dd");

Calendar cal1 = Calendar.getInstance();
Calendar cal2 = Calendar.getInstance();

cal1.add(Calendar.MONTH, -1); //저번 달
%>
<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<!--css-->
<link rel="stylesheet" href="../../css/mypageWorkdayCheck.css?ver=3">
</head>

<body>
	<table>
		<thead>
			<tr>
				<th>날짜</th>
				<th>출근 시간</th>
				<th>퇴근 시간</th>
				<th>출근</th>
				<th>퇴근</th>
			</tr>
		</thead>
		<%
		cal2.add(Calendar.DATE, 0);
		startNo = pMgr.workdNoFind(day.format(cal2.getTime()), memNo);

		if (startNo != null) {
			if (pMgr.workdEndFind(startNo) != null) {
				endDay = pMgr.workdEndFind(startNo);
				endDay1 = endDay.substring(0, 10);
				endDay2 = endDay.substring(11, 19);
				endDay3 = endDay.substring(11, 13);

				startDay = pMgr.workdStartFind(startNo).substring(11, 19);
				startDay2 = startDay.substring(0, 2);
				} else {
				endDay1 = day.format(cal2.getTime()).substring(0, 10);
				endDay2 = "-- : -- : --";

				startDay = pMgr.workdStartFind(startNo).substring(11, 19);
				startDay2 = startDay.substring(0, 2);
			}
			
			if (Integer.parseInt(startDay2) < 9) {
				workday = "출근";
				workday2 = "--";
				if (endDay != null) {
					if (Integer.parseInt(endDay3) < 17) {
						workday2 = "조퇴";
					} else {
						workday2 = "퇴근";
					}
				}
			} else {
				workday = "지각";
				workday2 = "--";
				if (endDay3 != null) {
					if (Integer.parseInt(endDay3) < 17) {
						workday2 = "조퇴";
					} else {
						workday2 = "퇴근";
					}
				}
			}
		} else {
			endDay = day.format(cal2.getTime());
			endDay1 = endDay.substring(0,10);
		}
		%>
		<tr>
			<td><%=endDay1%></td>
			<td><%=startDay%></td>
			<td><%=endDay2%></td>
			<td><%=workday%></td>
			<td><%=workday2%></td>
		</tr>
		<%
		for (int i = 0; i < cal1.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {
			cal2.add(Calendar.DATE, -1);
			endNo = pMgr.workdayCheck(day.format(cal2.getTime()), memNo);

			if (endNo != null) {
				endDay = pMgr.workdEndFind(endNo);
				endDay1 = endDay.substring(0, 10);
				endDay2 = endDay.substring(11, 19);
				endDay3 = endDay.substring(11, 13);

				startDay = pMgr.workdStartFind(endNo).substring(11, 19);
				startDay2 = startDay.substring(0, 2);

				if (Integer.parseInt(startDay2) < 9) {
			workday = "출근";
				} else {
			workday = "지각";
				}
				
				if (Integer.parseInt(endDay3) < 17) {
			workday2 = "조퇴";
				} else {
			workday2 = "퇴근";
				}
		%>
		<tr>
			<td><%=endDay1%></td>
			<td><%=startDay%></td>
			<td><%=endDay2%></td>
			<td><%=workday%></td>
			<td><%=workday2%></td>
		</tr>
		<%
			}
		}
		%>
	</table>
</body>

<script type="text/javascript" src="mypage.js?ver=1.31"></script>
</html>