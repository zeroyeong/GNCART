<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="familyEvent.ConBean"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" />

<%    	
   	int con_no = Integer.parseInt(request.getParameter("con_no"));
	ConBean bean = new ConBean(); 
	conMgr.upCount(con_no);
	bean = conMgr.getBoard(con_no);
	String title = bean.getCon_title();
	String content = bean.getCon_content();
	String regdate = bean.getCon_regdate();
	String type = bean.getCon_type();
	String userPart = bean.getCon_userPart();
	String userName = bean.getCon_userName();
	String desdate = bean.getCon_desdate();
	String location = bean.getCon_location(); 
	String map = bean.getCon_map();
	String filename = bean.getCon_file();
	String writer = bean.getMem_name();
	int hit = bean.getCon_hit();
	int mem_no = bean.getMem_no();
	String part_type = bean.getPart_type();
	
	int memNo = (int)session.getAttribute("memNo");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/condolencesDetail.css">
<!--Boxicons CDN Link-->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

</head>
<body>

	<!-- sidebar include -->
	<jsp:include page="../index/sidebar.jsp" flush="false" />

	<section class="home-section">
		<!-- top include -->
		<jsp:include page="../index/top.jsp" flush="false" />

		<!--home-content-->
		<div class="home-content">
			<div id="container">
				<div id="title">
					<h2>경조사 일정</h2>

					<div id="writerInfo">
						<span>작성자 : <a href="#"><%= part_type %> <%= writer %></a></span> <span>작성일
							: <span><%= regdate %></span>
						</span>
					</div>
				</div>

				<hr>
				<form name="detailFrm" method="post" action="conDelete.jsp">
					<table>
						<tr>
							<td class="tableTitle">제목</td>
							<td colspan="3"><%= title %></td>
						</tr>
						<tr>
							<td class="tableTitle">일정</td>
							<td><%= desdate %></td>
							<td class="tableTitle">장소</td>
							<td><input id="locationId" value="<%= location %>" readonly></td>
						</tr>
						<tr>
							<td class="tableTitle">일정종류</td>
							<td><%= type %></td>
							<td class="tableTitle">부서 / 이름</td>
							<td><%= userPart %> / <%= userName %></td>
						</tr>
						<tr>
							<td class="tableTitle detail">상세내용</td>
							<td colspan="3"><%= content %></td>
						</tr>
				<%
            	if(map != null && !map.isEmpty()){  
				%>
						<tr>
							<td class="tableTitle">지도</td>
							<td colspan="3"><div id="map"></div></td>
						</tr>
				<%
            	}
				%>

				<%
            	if(filename != null && !filename.isEmpty()){  
				%>
						<tr>
							<td class="tableTitle">첨부파일</td>
							<td colspan="3"><a id="filename"
								href="condolencesFiledown.jsp?filename=<%=filename%>"><%= filename %></a></td>
						</tr>
				<%
            	}
				%>

					</table>

					<div id="btns">
					<% 
					if(mem_no == memNo){
					%>
						<button type="button">
							<a href="condolencesRevise.jsp?con_no=<%=con_no%>">수정하기</a>
						</button>
						<button type="button" onclick="deleteBtn()">삭제하기</button>
					<%
					}
					%>
						<button type="button">
							<a href="condolences.jsp">목록</a>
						</button>
					</div>
					<input type="hidden" name="con_no" value="<%= con_no %>">
					<input type="hidden" name ="pageName" value="condolencesDetail">
				</form>
			</div>

		</div>
	</section>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24e23b8a98c1750309dd34a0c1ea57d3&libraries=services"></script>
	<script src="../script/condolencesDetail.js"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>