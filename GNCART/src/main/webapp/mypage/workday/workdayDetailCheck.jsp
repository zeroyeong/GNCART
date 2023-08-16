<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, common.*, mypage.*, java.time.*, java.time.format.*, static java.time.temporal.ChronoUnit.*"%>
<jsp:useBean id="wMgr" class="mypage.WorkdayMgr" />
<%
request.setCharacterEncoding("UTF-8");

String memNo = request.getParameter("MEM_NO");
//String memNo = "2";

int totalWorkday = 0; //총 근태
int totalPage = 0; //총 페이지

int viewWorkday = 6; //페이지에 보이는 근태

int nowPage = 1; //현재 페이지
int nowBlock = 1; //현재 블럭

int start = 0; //페이지에 보이는 근태 시작
int end = 6; //페이지에 보이는 근태 끝

int viewSize = 0; //근태 본거 총합

Vector<MypageBean> vlist = null;
Vector<MypageBean> vlist2 = null;

String month = null;

int calYear = 0;
int prevYear = 0;
int nextYear = 0;

if (request.getParameter("calYear") != null && request.getParameter("month") != null) {
	calYear = Integer.parseInt(request.getParameter("calYear"));
	prevYear = calYear - 1;
	nextYear = calYear + 1;

	month = request.getParameter("month");

	if (month.length() < 2) {
		month = "0" + month;
	}

} else if (request.getParameter("calYear") != null && request.getParameter("month") == null) {
	calYear = Integer.parseInt(request.getParameter("calYear"));
	prevYear = calYear - 1;
	nextYear = calYear + 1;

	month = LocalDate.now().format(DateTimeFormatter.ofPattern("MM"));
} else {
	LocalDate date = LocalDate.now();

	calYear = date.getYear();
	prevYear = calYear - 1;
	nextYear = calYear + 1;

	month = LocalDate.now().format(DateTimeFormatter.ofPattern("MM"));
}

String day = Integer.toString(calYear) + "-" + month; //day에 년월 넣기

if (request.getParameter("nowPage") != null) { //버튼을 눌러서 새로고침되어 nowPage의 값이 있다면
	nowPage = Integer.parseInt(request.getParameter("nowPage")); //nowPage의 값을 받아오면서 int로 바꾼다.

	start = (nowPage * viewWorkday) - viewWorkday; //근태 보는 시작점을 nowPage에 해당하게 한다.
	end = viewWorkday; //끝나는건 그대로 viewWorkday만큼
}

if (memNo != null) {
	vlist2 = wMgr.workdNoTotal(day, memNo);
	totalWorkday = vlist2.size();

	vlist = wMgr.workdayList(start, end, memNo, day); //vlist에 WORKD_NO 값 담기
	viewSize = vlist.size();
}

totalPage = (int) Math.ceil((double) totalWorkday / viewWorkday); //총 근태 / 보이는 근태로 하며 올림한다.
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Document</title>
<link rel="stylesheet" href="../../css/detailWork.css" />
</head>
<body>
	<div class="container">

		<div class="title">
			<h3>근태현황</h3>
			<button onclick="cancel()">×</button>
		</div>

		<div class="calBox">

			<div class="cal">
				<button class="prevYear" onclick="prevYear()">
					<%=prevYear%>년
				</button>
				<span class="calYear"><%=calYear%>년</span>
				<button class="nextYear" onclick="nextYear()"><%=nextYear%>년
				</button>
			</div>

			<div class="month">
				<%
				for (int i = 1; i < 13; i++) {
					if (i < 10) {
				%>
				<input type="button" value="<%="0" + i%>" onclick="month(<%=i%>)" />
				<%
				} else {
				%>
				<input type="button" value="<%=i%>" onclick="month(<%=i%>)" />
				<%
				}
				}
				%>
			</div>

		</div>

		<div class="content">
			<table>
				<thead>
					<tr>
						<td colspan="2"><%=calYear%>년 <%=month%>월</td>
					</tr>
				</thead>
				<tbody>
					<%
					if (vlist.isEmpty()) {
					%>
					<tr>
						<td style="text-align: center;">정보가 없습니다.</td>
					</tr>
					<%
					}
					%>
				</tbody>
				<%
				for (int i = 0; i < vlist.size(); i++) {

					if (i == viewSize)
						break;

					MypageBean bean = vlist.get(i);

					String workdNo = bean.getWORKD_NO();

					String workStart = wMgr.workdStartFind(workdNo);
					String workEnd = wMgr.workdEndFind(workdNo);
					String workdVacNo = wMgr.workdNoVacNoFind(workdNo);
					String vacReason = wMgr.vacReasonFind(workdVacNo);

					String workdayCheck = null;

					String day1 = workStart.substring(8, 10);

					if ("1".equals(vacReason)) {
						workdayCheck = "월차";
					} else if ("2".equals(vacReason)) {
						workdayCheck = "연차";
					} else if ("3".equals(vacReason)) {
						workdayCheck = "병가";
					} else if ("4".equals(vacReason)) {
						workdayCheck = "기타";
					} else if (workStart != null && workEnd != null) {
						workdayCheck = "정상 출근";
						if (Integer.parseInt(workStart.substring(11, 13)) < 9) {
					if (Integer.parseInt(workEnd.substring(11, 13)) < 17) {
						workdayCheck = "조퇴";
					}
						} else if (Integer.parseInt(workStart.substring(11, 13)) >= 9) {
					workdayCheck = "지각";
					if (Integer.parseInt(workEnd.substring(11, 13)) < 17) {
						workdayCheck = "지각 및 조퇴";
					}
						}
					} else {
						if (Integer.parseInt(workStart.substring(11, 13)) < 9) {
					workdayCheck = "--";
						} else if (Integer.parseInt(workStart.substring(11, 13)) >= 9) {
					workdayCheck = "지각";
						}
					}
				%>
				<tr>
					<td><%=calYear%>-<%=month%>-<%=day1%></td>
					<td><%=workdayCheck%></td>
				</tr>
				<%
				}
				%>
				</tbody>
			</table>
		</div>

		<div class="month">
			<%
			if (totalPage != 0) {
				for (int i = 1; i <= totalPage; i++) {
			%>
			<input type="button" value="<%=i%>" onclick="nowPage(<%=i%>)" />
			<%
			}
			}
			%>
		</div>

	</div>
</body>

<script>
	function prevYear() {
		document.prevYearFrm.submit();
	}

	function nextYear() {
		document.nextYearFrm.submit();
	}
	
	function month(month) {
		document.monthFrm.month.value = month;
		document.monthFrm.submit();
	}
	
	function nowPage(nowPage) {
		document.pageFrm.nowPage.value = nowPage;
		document.pageFrm.submit();
	}

	function cancel() {
		window.close();
	}
</script>

<form name="prevYearFrm" action="workdayDetailCheck.jsp">
	<input type="hidden" name="calYear" value=<%=calYear - 1%>> <input
		type="hidden" name="MEM_NO" value=<%=memNo%>>
</form>

<form name="nextYearFrm" action="workdayDetailCheck.jsp">
	<input type="hidden" name="calYear" value=<%=calYear + 1%>> <input
		type="hidden" name="MEM_NO" value=<%=memNo%>>
</form>

<form name="monthFrm" action="workdayDetailCheck.jsp">
	<input type="hidden" name="calYear" value=<%=calYear%>> <input
		type="hidden" name="MEM_NO" value=<%=memNo%>> <input
		type="hidden" name="month">
</form>

<form name="pageFrm" action="workdayDetailCheck.jsp">
	<input type="hidden" name="calYear" value=<%=calYear%>> <input
		type="hidden" name="MEM_NO" value=<%=memNo%>> <input
		type="hidden" name="month" value=<%=month%>> <input
		type="hidden" name="nowPage">
</form>

</html>
