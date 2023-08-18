<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, common.*, mypage.*, java.time.*, java.time.format.*, static java.time.temporal.ChronoUnit.*"%>
<jsp:useBean id="wMgr" class="mypage.WorkdayMgr" />
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />
<%
request.setCharacterEncoding("UTF-8");

String memNo = request.getParameter("MEM_NO");
String nowPage = request.getParameter("nowPage");
String memName = pMgr.memNoNameFind(memNo);
String memDate = pMgr.memNoDateFind(memNo);

Vector<MypageBean> vlist = null;
Vector<MypageBean> vlist2 = null;

String[] monthVac = {"-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"};
String[] yearVac = {"-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"};
String[] workStartLate = {"-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"};
String[] workEndEarly = {"-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"};
String[] rest = {"-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"};

int vac = 0;
int useVac = 0;
int haveVac = 0;

int calYear = 0;
int prevYear = 0;
int nextYear = 0;

if (request.getParameter("calYear") != null) {
	calYear = Integer.parseInt(request.getParameter("calYear"));
	prevYear = calYear - 1;
	nextYear = calYear + 1;
} else {
	LocalDate date = LocalDate.now();

	calYear = date.getYear();
	prevYear = calYear - 1;
	nextYear = calYear + 1;
}

String day = Integer.toString(calYear);
String day0 = null;

long days = 0;
long days2 = 0;

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM");

days = YEARS.between(LocalDate.parse(memDate, formatter), LocalDate.now());
days2 = MONTHS.between(LocalDate.parse(memDate, formatter), LocalDate.now());

switch ((int) days) {
	case 0 :
		for (int i = 1; i <= days2; i++) {
	String monthWork = LocalDate.now().minusMonths(i).format(formatter2);

	vlist2 = wMgr.workdNoTotal(monthWork, memNo);

	int monthWorkLength = vlist2.size();

	int monthLength = LocalDate.now().minusMonths(i).lengthOfMonth();

	double workLength = (double) monthWorkLength / monthLength;

	if (workLength >= 0.8) {
		vac++;
	}
		}
		break;

	case 1 :
	case 2 :
		vac = 15;
		break;

	case 3 :
	case 4 :
		vac = 16;
		break;

	case 5 :
	case 6 :
		vac = 17;
		break;

	case 7 :
	case 8 :
		vac = 18;
		break;

	case 9 :
	case 10 :
		vac = 19;
		break;

	case 11 :
	case 12 :
		vac = 20;
		break;

	case 13 :
	case 14 :
		vac = 21;
		break;

	case 15 :
	case 16 :
		vac = 22;
		break;

	case 17 :
	case 18 :
		vac = 23;
		break;

	case 19 :
	case 20 :
		vac = 24;
		break;

	default :
		vac = 25;
		break;
}

if (memNo != null) {

	int monthVac1 = 0;
	int yearVac1 = 0;
	int vac1 = 0;
	int workStartLate1 = 0;
	int workEndEarly1 = 0;

	for (int i = 1; i < 13; i++) {
		String ii = Integer.toString(i);
		
		if (ii.length() < 2) {
			ii = "0" + ii;
		}

		day0 = day + "-" + ii;

		vlist = wMgr.workdNoTotal(day0, memNo);

		for (int j = 0; j < vlist.size(); j++) {

	MypageBean bean = vlist.get(j);

	String workdNo = bean.getWORKD_NO();

	String start = wMgr.workdStartFind(workdNo);
	String end = wMgr.workdEndFind(workdNo);
	String workdVacNo = wMgr.workdNoVacNoFind(workdNo);
	String vacReason = wMgr.vacReasonFind(workdVacNo);

	if ("1".equals(vacReason)) {
		monthVac1++;
		useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac1++;
		useVac++;
	} else if ("3".equals(vacReason)) {
		vac1++;
		useVac++;
	} else if ("4".equals(vacReason)) {
		vac1++;
		useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly1++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate1++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly1++;
			}
		}
	}
	if (vac1 != 0) {
		rest[i - 1] = Integer.toString(vac1);
	}
	if (yearVac1 != 0) {
		yearVac[i - 1] = Integer.toString(yearVac1);
	}
	if (monthVac1 != 0) {
		monthVac[i - 1] = Integer.toString(monthVac1);
	}
	if (workEndEarly1 != 0) {
		workEndEarly[i - 1] = Integer.toString(workEndEarly1);
	}
	if (workStartLate1 != 0) {
		workStartLate[i - 1] = Integer.toString(workStartLate1);
	}
		}
	}

	haveVac = vac - useVac;
%>
<thead>
	<tr>
		<td colspan="13"><%=memName%> 님의 근태현황</td>
	</tr>
	<tr>
		<%
		if (days < 1) {
		%>
		<td colspan="2">총 월차</td>
		<%
		} else if (days >= 1) {
		%>
		<td colspan="2">총 연차</td>
		<%
		}
		%>

		<td colspan="2"><%=vac%>개</td>

		<%
		if (days < 1) {
		%>
		<td colspan="2">잔여 월차</td>
		<%
		} else if (days >= 1) {
		%>
		<td colspan="2">잔여 연차</td>
		<%
		}
		%>

		<td colspan="2"><%=haveVac%>개</td>
		<td colspan="3"></td>
		<td colspan="2"><button onclick="workDetail()">상세보기</button></td>
	</tr>
</thead>


<tr>
	<td class="prevYear" onclick="prevYear()">◁ <%=prevYear%>년
	</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td><%=calYear%>년</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td class="nextYear" onclick="nextYear()"><%=nextYear%>년 ▷</td>
</tr>


<tbody>
	<tr>
		<td></td>
		<%
		for (int i = 1; i < 13; i++) {
		%>
		<td><%=i%>월</td>
		<%
		}
		%>
	</tr>
	<tr>
		<td>지각</td>
		<%
		for (int i = 0; i < 12; i++) {
		%>
		<td><%=workStartLate[i]%></td>
		<%
		}
		%>
	</tr>
	<tr>
		<td>조퇴</td>
		<%
		for (int i = 0; i < 12; i++) {
		%>
		<td><%=workEndEarly[i]%></td>
		<%
		}
		%>
	</tr>
	<tr>
		<td>연차</td>
		<%
		for (int i = 0; i < 12; i++) {
		%>
		<td><%=yearVac[i]%></td>
		<%
		}
		%>
	</tr>
	<tr>
		<td>월차</td>
		<%
		for (int i = 0; i < 12; i++) {
		%>
		<td><%=monthVac[i]%></td>
		<%
		}
		%>
	</tr>
	<tr>
		<td>기타</td>
		<%
		for (int i = 0; i < 12; i++) {
		%>
		<td><%=rest[i]%></td>
		<%
		}
		%>
	</tr>

</tbody>
<%
}
%>

<form name="prevYearFrm" action="readMember.jsp">
	<input type="hidden" name="calYear" value=<%=calYear - 1%>>
	<input type="hidden" name="MEM_NO" value=<%=memNo%>>
	<input type="hidden" name="nowPage" value=<%=nowPage%>>
</form>
<form name="nextYearFrm" action="readMember.jsp">
	<input type="hidden" name="calYear" value=<%=calYear + 1%>>
	<input type="hidden" name="MEM_NO" value=<%=memNo%>>
	<input type="hidden" name="nowPage" value=<%=nowPage%>>
</form>

<script>
	function prevYear() {
		document.prevYearFrm.submit();
	}

	function nextYear() {
		document.nextYearFrm.submit();
	}

	function workDetail() {
		window.open("../mypage/workday/workdayDetailCheck.jsp?MEM_NO=" + <%=memNo%>, "window_name", "width=540, height=570, location=no, status=no, scrollbars=yes");
	}
</script>
</html>