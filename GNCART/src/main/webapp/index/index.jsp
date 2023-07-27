<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<jsp:useBean id="sMgr" class="schedule.ScheduleMgr" />
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" />
<%@ page import="familyEvent.ConMgr" import="familyEvent.ConBean"%>
<%@ page import="schedule.ScheduleMgr" import="schedule.ScheduleBean"%>
<%@ page import="java.util.*"%>
<%
//로그인 안했을 시 로그인 페이지로 리다이렉트 
if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null) {
	response.sendRedirect("../login.jsp");
	return;
}

// 캐시 설정
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

// 스케줄
ScheduleMgr schedulList = new ScheduleMgr();
Vector<ScheduleBean> scheduleList = sMgr.getScheduleList("", "");

//스케줄리스트 역순(최근순으로 보여지게)
Collections.sort(scheduleList, new Comparator<ScheduleBean>() {
	//@Override
	public int compare(ScheduleBean schedule1, ScheduleBean schedule2) {
		return schedule2.getSCHE_START_DATE().compareTo(schedule1.getSCHE_START_DATE());
	}
});

Vector<ConBean> blist = null;
blist = conMgr.getBoardList();
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<!--boxIcons CDN Link-->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
</head>

<body>
	<!-- sidebar include -->
	<jsp:include page="sidebar.jsp" flush="false" />

	<section class="home-section">
		<!-- top include -->
		<jsp:include page="top.jsp" flush="false" />

		<!--home-content-->
		<div class="home-content">
			<div class="overview-boxes">
				<div class="box">
					<div class="right-side">
						<div class="box-topic">
							<a href="#">공지사항</a>
						</div>
						<div class="indicator"></div>
					</div>
				</div>

				<div class="box">
					<div class="right-side">
						<div class="box-topic">
							<a href="#">자유게시판</a>
						</div>
						<div class="indicator">
							<p>123123123123</p>

						</div>
					</div>
				</div>

				<div class="box">
					<div class="right-side">
						<div class="box-topic">
							<a href="#">경조사알림</a>
						</div>
						<div class="indicator">
							<table class="details">
								<%
								int numConToDisplay = Math.min(blist.size(), 9);
								if (numConToDisplay > 0) {
									for (int i = 0; i < numConToDisplay; i++) {
										ConBean con = blist.get(i);
								%>
								<tr onclick="window.location='../familyEvent/condolences.jsp';">
									<td><%=con.getCon_title()%></td>
									<td><%=con.getMem_name()%></td>
									<td><%=con.getCon_regdate()%></td>
								</tr>
								<%
								}
								} else {
								%>
								<p>스케줄이 없습니다.</p>
								<%
								}
								%>
							</table>
						</div>
					</div>
				</div>

				<!--달력-->
				<table class="Calendar">
					<thead>
						<tr>
							<td onClick="prevCalendar();" style="cursor: pointer;">&#60;</td>
							<td colspan="5"><span id="calYear"></span>년 <span
								id="calMonth"></span>월</td>
							<td onClick="nextCalendar();" style="cursor: pointer;">&#62;</td>
						</tr>
						<tr>
							<td class="sundayRed">일</td>
							<td>월</td>
							<td>화</td>
							<td>수</td>
							<td>목</td>
							<td>금</td>
							<td>토</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>

			<div class="board-boxes">
				<div class="schedule-box">
					<div class="box-topic">
						<a href="../schedule/jsp/scheduleMonth.jsp">회사일정</a>
					</div>
					<div class="schedule-details">
						<%
						int numToDisplay = Math.min(scheduleList.size(), 9);
						if (numToDisplay > 0) {
						%>
						<table class="details">
							<thead>
								<tr>
									<th>순</th>
									<th>제목</th>
									<th>시작일</th>
									<th>종료일</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (int i = 0; i < numToDisplay; i++) {
									ScheduleBean schedule = scheduleList.get(i);
								%>
								<tr
									onclick="window.location='../schedule/jsp/scheduleMonth.jsp';">
									<td><%=schedule.getSCHE_NO()%></td>
									<td><%=schedule.getSCHE_NAME()%></td>
									<td><%=schedule.getSCHE_START_DATE()%></td>
									<td><%=schedule.getSCHE_END_DATE()%></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
						<%
						} else {
						%>
						<p>스케줄이 없습니다.</p>
						<%
						}
						%>
					</div>
				</div>

				<div class="picture-box">
					<div class="box-topic">
						<a href="#">행사사진</a>
					</div>
					<ul class="picture-details">
						<li><a href="#"> <img src="images/p1.jpg" alt=""> <span
								class="product">행사1</span>
						</a></li>
						<li><a href="#"> <img src="images/p2.jpg" alt=""> <span
								class="product">행사1</span>
						</a></li>
						<li><a href="#"> <img src="images/p3.jpg" alt=""> <span
								class="product">행사1</span>
						</a></li>
						<li><a href="#"> <img src="images/p4.jpg" alt=""> <span
								class="product">행사1</span>
						</a></li>
						<li><a href="#"> <img src="images/p5.jpg" alt=""> <span
								class="product">행사1</span>
						</a></li>
						<li><a href="#"> <img src="images/p6.jpg" alt=""> <span
								class="product">행사1</span>
						</a></li>

						<li><a href="#"> <img src="images/p7.jpg" alt=""> <span
								class="product">행사</span>
						</a></li>
						<li><a href="#"> <img src="images/p8.jpg" alt=""> <span
								class="product">행사1</span>
						</a></li>
					</ul>
				</div>
			</div>
		</div>
	</section>

</body>

</html>
