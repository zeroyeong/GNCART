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

int monthVac = 0;
int yearVac = 0;
int vac = 0;
int useVac = 0;
int haveVac = 0;

int monthVac1 = 0;
int monthVac2 = 0;
int monthVac3 = 0;
int monthVac4 = 0;
int monthVac5 = 0;
int monthVac6 = 0;
int monthVac7 = 0;
int monthVac8 = 0;
int monthVac9 = 0;
int monthVac10 = 0;
int monthVac11 = 0;
int monthVac12 = 0;

int yearVac1 = 0;
int yearVac2 = 0;
int yearVac3 = 0;
int yearVac4 = 0;
int yearVac5 = 0;
int yearVac6 = 0;
int yearVac7 = 0;
int yearVac8 = 0;
int yearVac9 = 0;
int yearVac10 = 0;
int yearVac11 = 0;
int yearVac12 = 0;

int vac1 = 0;
int vac2 = 0;
int vac3 = 0;
int vac4 = 0;
int vac5 = 0;
int vac6 = 0;
int vac7 = 0;
int vac8 = 0;
int vac9 = 0;
int vac10 = 0;
int vac11 = 0;
int vac12 = 0;

int workStartLate1 = 0;
int workStartLate2 = 0;
int workStartLate3 = 0;
int workStartLate4 = 0;
int workStartLate5 = 0;
int workStartLate6 = 0;
int workStartLate7 = 0;
int workStartLate8 = 0;
int workStartLate9 = 0;
int workStartLate10 = 0;
int workStartLate11 = 0;
int workStartLate12 = 0;

int workEndEarly1 = 0;
int workEndEarly2 = 0;
int workEndEarly3 = 0;
int workEndEarly4 = 0;
int workEndEarly5 = 0;
int workEndEarly6 = 0;
int workEndEarly7 = 0;
int workEndEarly8 = 0;
int workEndEarly9 = 0;
int workEndEarly10 = 0;
int workEndEarly11 = 0;
int workEndEarly12 = 0;

int calYear=0;
int prevYear=0;
int nextYear=0;

if(request.getParameter("calYear") !=null){
	calYear = Integer.parseInt(request.getParameter("calYear"));
	prevYear = calYear -1;
	nextYear = calYear +1;
} else{
	LocalDate date = LocalDate.now();
	
	calYear = date.getYear();
	prevYear = calYear -1;
	nextYear = calYear +1;
}

String day = Integer.toString(calYear);

long days = 0;

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

days = YEARS.between(LocalDate.parse(memDate, formatter), LocalDate.now());

switch ((int)days) {
case 0:
	break;

case 1: 
case 2: vac = 15;
	break;
	
case 3:
case 4: vac = 16;
	break;
	
case 5:
case 6: vac = 17;
	break;
	
case 7: 
case 8: vac = 18;
	break;
	
case 9: 
case 10: vac = 19;
	break;
	
case 11: 
case 12: vac = 20;
	break;
	
case 13: 
case 14: vac = 21;
	break;
	
case 15: 
case 16: vac = 22;
	break;
	
case 17: 
case 18: vac = 23;
	break;
	
case 19: 
case 20: vac = 24;
	break;
	
default: vac = 25;
	break;
}

if (memNo != null) {

	vlist = wMgr.workdNoTotal(day, memNo);

	for (int i = 0; i < vlist.size(); i++) {

		MypageBean bean = vlist.get(i);

		String workdNo = bean.getWORKD_NO();

		String start = wMgr.workdStartFind(workdNo);
		String end = wMgr.workdEndFind(workdNo);
		String workdVacNo = wMgr.workdNoVacNoFind(workdNo);
		String vacReason = wMgr.vacReasonFind(workdVacNo);

		switch (Integer.parseInt(start.substring(5, 7))) {

		case 1:
	if ("1".equals(vacReason)) {
		monthVac1++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac1++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac1++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac1++; useVac++;
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
	break;

		case 2:
	if ("1".equals(vacReason)) {
		monthVac2++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac2++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac2++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac2++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly2++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate2++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly2++;
			}
		}
	}
	break;

		case 3:
	if ("1".equals(vacReason)) {
		monthVac3++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac3++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac3++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac3++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly3++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate3++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly3++;
			}
		}
	}
	break;

		case 4:
	if ("1".equals(vacReason)) {
		monthVac4++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac4++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac4++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac4++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly4++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate4++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly4++;
			}
		}
	}
	break;

		case 5:
	if ("1".equals(vacReason)) {
		monthVac5++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac5++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac5++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac5++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly5++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate5++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly5++;
			}
		}
	}
	break;

		case 6:
	if ("1".equals(vacReason)) {
		monthVac6++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac6++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac6++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac6++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly6++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate6++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly6++;
			}
		}
	}
	break;

		case 7:
	if ("1".equals(vacReason)) {
		monthVac7++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac7++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac7++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac7++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly7++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate7++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly7++;
			}
		}
	}
	break;

		case 8:
	if ("1".equals(vacReason)) {
		monthVac8++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac8++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac8++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac8++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly8++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate8++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly8++;
			}
		}
	}
	break;

		case 9:
	if ("1".equals(vacReason)) {
		monthVac9++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac9++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac9++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac9++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly9++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate9++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly9++;
			}
		}
	}
	break;

		case 10:
	if ("1".equals(vacReason)) {
		monthVac10++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac10++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac10++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac10++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly10++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate10++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly10++;
			}
		}
	}
	break;

		case 11:
	if ("1".equals(vacReason)) {
		monthVac11++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac11++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac11++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac11++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly11++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate11++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly11++;
			}
		}
	}
	break;

		case 12:
	if ("1".equals(vacReason)) {
		monthVac12++; useVac++;
	} else if ("2".equals(vacReason)) {
		yearVac12++; useVac++;
	} else if ("3".equals(vacReason)) {
		vac12++; useVac++;
	} else if ("4".equals(vacReason)) {
		vac12++; useVac++;
	} else if (start != null && end != null) {
		if (Integer.parseInt(start.substring(11, 13)) < 9) {
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly12++;
			}
		} else if (Integer.parseInt(start.substring(11, 13)) >= 9) {
			workStartLate12++;
			if (Integer.parseInt(end.substring(11, 13)) < 17) {
				workEndEarly12++;
			}
		}
	}
	break;
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
		if(days < 1) { 
		%> <td colspan="2">총 월차</td> <%
		} else if (days >= 1) {
		%> <td colspan="2">총 연차</td> <%
		}
		%>
		
		<td colspan="2"><%=vac %>개</td>
		
		<%
		if(days < 1) { 
		%> <td colspan="2">잔여 월차</td> <%
		} else if (days >= 1) {
		%> <td colspan="2">잔여 연차</td> <%
		}
		%>

		<td colspan="2"><%=haveVac %>개</td>
		<td colspan="3"></td>
		<td colspan="2"><button onclick="workDetail()">상세보기</button></td>
	</tr>
</thead>
             

<tr>
	<td class="prevYear" onclick="prevYear()"> ◁ <%=prevYear %>년</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td><%=calYear %>년</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td class="nextYear" onclick="nextYear()"><%=nextYear %>년 ▷ </td>
</tr>
	

<tbody>
	<tr>
		<td></td>
		<td>1월</td>
		<td>2월</td>
		<td>3월</td>
		<td>4월</td>
		<td>5월</td>
		<td>6월</td>
		<td>7월</td>
		<td>8월</td>
		<td>9월</td>
		<td>10월</td>
		<td>11월</td>
		<td>12월</td>
	</tr>
	<tr>
		<td>지각</td>
		<td><% if (workStartLate1 == 0) {%>-<%} else {%><%=workStartLate1 %><%}%></td>
		<td><% if (workStartLate2 == 0) {%>-<%} else {%><%=workStartLate2 %><%}%></td>
		<td><% if (workStartLate3 == 0) {%>-<%} else {%><%=workStartLate3 %><%}%></td>
		<td><% if (workStartLate4 == 0) {%>-<%} else {%><%=workStartLate4 %><%}%></td>
		<td><% if (workStartLate5 == 0) {%>-<%} else {%><%=workStartLate5 %><%}%></td>
		<td><% if (workStartLate6 == 0) {%>-<%} else {%><%=workStartLate6 %><%}%></td>
		<td><% if (workStartLate7 == 0) {%>-<%} else {%><%=workStartLate7 %><%}%></td>
		<td><% if (workStartLate8 == 0) {%>-<%} else {%><%=workStartLate8 %><%}%></td>
		<td><% if (workStartLate9 == 0) {%>-<%} else {%><%=workStartLate9 %><%}%></td>
		<td><% if (workStartLate10 == 0) {%>-<%} else {%><%=workStartLate10 %><%}%></td>
		<td><% if (workStartLate11 == 0) {%>-<%} else {%><%=workStartLate11 %><%}%></td>
		<td><% if (workStartLate12 == 0) {%>-<%} else {%><%=workStartLate12 %><%}%></td>
	</tr>
	<tr>
		<td>조퇴</td>
		<td><% if (workEndEarly1 == 0) {%>-<%} else {%><%=workEndEarly1 %><%}%></td>
		<td><% if (workEndEarly2 == 0) {%>-<%} else {%><%=workEndEarly2 %><%}%></td>
		<td><% if (workEndEarly3 == 0) {%>-<%} else {%><%=workEndEarly3 %><%}%></td>
		<td><% if (workEndEarly4 == 0) {%>-<%} else {%><%=workEndEarly4 %><%}%></td>
		<td><% if (workEndEarly5 == 0) {%>-<%} else {%><%=workEndEarly5 %><%}%></td>
		<td><% if (workEndEarly6 == 0) {%>-<%} else {%><%=workEndEarly6 %><%}%></td>
		<td><% if (workEndEarly7 == 0) {%>-<%} else {%><%=workEndEarly7 %><%}%></td>
		<td><% if (workEndEarly8 == 0) {%>-<%} else {%><%=workEndEarly8 %><%}%></td>
		<td><% if (workEndEarly9 == 0) {%>-<%} else {%><%=workEndEarly9 %><%}%></td>
		<td><% if (workEndEarly10 == 0) {%>-<%} else {%><%=workEndEarly10 %><%}%></td>
		<td><% if (workEndEarly11 == 0) {%>-<%} else {%><%=workEndEarly11 %><%}%></td>
		<td><% if (workEndEarly12 == 0) {%>-<%} else {%><%=workEndEarly12 %><%}%></td>
	</tr>
	<tr>
		<td>연차</td>
		<td><% if (yearVac1 == 0) {%>-<%} else {%><%=yearVac1 %><%}%></td>
		<td><% if (yearVac2 == 0) {%>-<%} else {%><%=yearVac2 %><%}%></td>
		<td><% if (yearVac3 == 0) {%>-<%} else {%><%=yearVac3 %><%}%></td>
		<td><% if (yearVac4 == 0) {%>-<%} else {%><%=yearVac4 %><%}%></td>
		<td><% if (yearVac5 == 0) {%>-<%} else {%><%=yearVac5 %><%}%></td>
		<td><% if (yearVac6 == 0) {%>-<%} else {%><%=yearVac6 %><%}%></td>
		<td><% if (yearVac7 == 0) {%>-<%} else {%><%=yearVac7 %><%}%></td>
		<td><% if (yearVac8 == 0) {%>-<%} else {%><%=yearVac8 %><%}%></td>
		<td><% if (yearVac9 == 0) {%>-<%} else {%><%=yearVac9 %><%}%></td>
		<td><% if (yearVac10 == 0) {%>-<%} else {%><%=yearVac10 %><%}%></td>
		<td><% if (yearVac11 == 0) {%>-<%} else {%><%=yearVac11 %><%}%></td>
		<td><% if (yearVac12 == 0) {%>-<%} else {%><%=yearVac12 %><%}%></td>
	</tr>
		<tr>
		<td>월차</td>
		<td><% if (monthVac1 == 0) {%>-<%} else {%><%=monthVac1 %><%}%></td>
		<td><% if (monthVac2 == 0) {%>-<%} else {%><%=monthVac2 %><%}%></td>
		<td><% if (monthVac3 == 0) {%>-<%} else {%><%=monthVac3 %><%}%></td>
		<td><% if (monthVac4 == 0) {%>-<%} else {%><%=monthVac4 %><%}%></td>
		<td><% if (monthVac5 == 0) {%>-<%} else {%><%=monthVac5 %><%}%></td>
		<td><% if (monthVac6 == 0) {%>-<%} else {%><%=monthVac6 %><%}%></td>
		<td><% if (monthVac7 == 0) {%>-<%} else {%><%=monthVac7 %><%}%></td>
		<td><% if (monthVac8 == 0) {%>-<%} else {%><%=monthVac8 %><%}%></td>
		<td><% if (monthVac9 == 0) {%>-<%} else {%><%=monthVac9 %><%}%></td>
		<td><% if (monthVac10 == 0) {%>-<%} else {%><%=monthVac10 %><%}%></td>
		<td><% if (monthVac11 == 0) {%>-<%} else {%><%=monthVac11 %><%}%></td>
		<td><% if (monthVac12 == 0) {%>-<%} else {%><%=monthVac12 %><%}%></td>
	</tr>
	<tr>
		<td>기타</td>
		<td><% if (vac1 == 0) {%>-<%} else {%><%=vac1 %><%}%></td>
		<td><% if (vac2 == 0) {%>-<%} else {%><%=vac2 %><%}%></td>
		<td><% if (vac3 == 0) {%>-<%} else {%><%=vac3 %><%}%></td>
		<td><% if (vac4 == 0) {%>-<%} else {%><%=vac4 %><%}%></td>
		<td><% if (vac5 == 0) {%>-<%} else {%><%=vac5 %><%}%></td>
		<td><% if (vac6 == 0) {%>-<%} else {%><%=vac6 %><%}%></td>
		<td><% if (vac7 == 0) {%>-<%} else {%><%=vac7 %><%}%></td>
		<td><% if (vac8 == 0) {%>-<%} else {%><%=vac8 %><%}%></td>
		<td><% if (vac9 == 0) {%>-<%} else {%><%=vac9 %><%}%></td>
		<td><% if (vac10 == 0) {%>-<%} else {%><%=vac10 %><%}%></td>
		<td><% if (vac11 == 0) {%>-<%} else {%><%=vac11 %><%}%></td>
		<td><% if (vac12 == 0) {%>-<%} else {%><%=vac12 %><%}%></td>
	</tr>
</tbody>
<%
}
%>

<form name="prevYearFrm" action="../../management/jsp/readMember.jsp">
	<input type="hidden" name="calYear" value=<%=calYear -1 %> >
	<input type="hidden" name="MEM_NO" value=<%=memNo %> >
	<input type="hidden" name="nowPage" value=<%=nowPage %> >
</form>
<form name="nextYearFrm" action="../../management/jsp/readMember.jsp">
	<input type="hidden" name="calYear" value=<%=calYear +1 %>>
	<input type="hidden" name="MEM_NO" value=<%=memNo %> >
	<input type="hidden" name="nowPage" value=<%=nowPage %> >
</form>

<script>
function prevYear(){
	document.prevYearFrm.submit();
}

function nextYear(){
	document.nextYearFrm.submit();
}

function workDetail(){
	window.open("../../mypage/workday/workdayDetailCheck.jsp?MEM_NO="+<%=memNo%>, "window_name", "width=540, height=570, location=no, status=no, scrollbars=yes");
}
</script>
</html>