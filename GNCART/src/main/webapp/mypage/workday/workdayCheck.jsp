<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*, mypage.*, java.time.*, java.time.format.*, static java.time.temporal.ChronoUnit.DAYS"%>
<jsp:useBean id="wMgr" class="mypage.WorkdayMgr" />
<%
request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

LocalDate day = LocalDate.now();

String day2 = day.format(formatter);

String memNo = wMgr.memNoFind(id, pw);

String endDay = null;
String endDay1 = null;
String endDay2 = null;
String endDay3 = null;

String startDay = null;
String startDay2 = null;

String workday = null;
String workday2 = null;

String endNo = null;
String workdNo = null;
String workdVacNo = null;

String vacReason = null;
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
		workdNo = wMgr.workdNoStartFind(day2, memNo);

		if (workdNo != null) {
			if (wMgr.workdEndFind(workdNo) != null) {
				endDay = wMgr.workdEndFind(workdNo);
				endDay1 = endDay.substring(0, 10);
				endDay2 = endDay.substring(11, 19);
				endDay3 = endDay.substring(11, 13);

				startDay = wMgr.workdStartFind(workdNo).substring(11, 19);
				startDay2 = startDay.substring(0, 2);
				} else {
				endDay1 = day2;
				endDay2 = "-- : -- : --";

				startDay = wMgr.workdStartFind(workdNo).substring(11, 19);
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
			endDay1 = day2;
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
		for (int i = 1; i <= day.minusMonths(1).lengthOfMonth(); i++) {
			String day5 = day.minusDays(i).format(formatter);
			endNo = wMgr.workdNoEndFind(day5, memNo);
			
			workdVacNo = wMgr.workdVacNoFind(day5, memNo);
			
			if(workdVacNo != null) {
				vacReason = wMgr.vacReasonFind(workdVacNo);
				
				switch(Integer.parseInt(vacReason)) {
			    	case 1: vacReason="월차";
						break;
				    case 2: vacReason="연차";
						break;
				    case 3: vacReason="병가";
						break;
				    case 4: vacReason="기타";
						break;
				}
				
				endDay1 = day5;
				endDay2 = "-- : -- : --";
				
				startDay = "-- : -- : --";
				%>
				<tr>
					<td><%=endDay1%></td>
					<td><%=startDay%></td>
					<td><%=endDay2%></td>
					<td><%=vacReason%></td>
					<td><%=vacReason%></td>
				</tr>
				<%
			}
			else if (endNo != null) {
				endDay = wMgr.workdEndFind(endNo);
				endDay1 = endDay.substring(0, 10);
				endDay2 = endDay.substring(11, 19);
				endDay3 = endDay.substring(11, 13);
	
				startDay = wMgr.workdStartFind(endNo).substring(11, 19);
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

<script type="text/javascript" src="mypage.js?ver=1"></script>
</html>