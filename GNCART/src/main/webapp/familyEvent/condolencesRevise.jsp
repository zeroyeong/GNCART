<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="familyEvent.ConBean"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" />

<%
int con_no = Integer.parseInt(request.getParameter("con_no"));
ConBean bean = new ConBean();
bean = (ConBean) session.getAttribute("bean");
//bean = conMgr.getBoard(con_no);
String title = bean.getCon_title();
String content = bean.getCon_content();
String regdate = bean.getCon_regdate();
String type = bean.getCon_type();
String location = bean.getCon_location();
String desdate = bean.getCon_desdate();
String map = bean.getCon_map();
String filename = bean.getCon_file();
int hit = bean.getCon_hit();
String writer = bean.getMem_name();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/condolencesRevise.css">
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
					<h2>일정 수정</h2>
				</div>

				<hr>

				<form name="postFrm" method="post" action="conboardUpdate"
					enctype="multipart/form-data">
					<table>
						<tr>
							<td class="tableTitle">제 목</td>
							<td colspan="3"><input id="detailTitle" name="title"
								value="<%=title%>"></td>
						</tr>
						<tr>
							<td class="tableTitle">일정</tWd>
							<td><input type="text" name="desdate" value="<%=desdate%>"></td>
							<td class="tableTitle">장소</labe></td>
							<td><input type="text" id="locationId" name="location"
								value="<%=location%>" placeholder="지도에서 검색 해주세요" readonly></td>
						</tr>
						<tr>
							<td class="tableTitle"><label for="type">일정 종류</label></td>
							<td><select id="type" name="type" value="">
									<option>결혼식</option>
									<option>장례식</option>
									<option>출산</option>
							</select></td>
							<td class="tableTitle"><label for="part">해당 부서</label></td>
							<td><select id="part" name="part" value="">
									<option value="part1">부서 1</option>
									<option value="part1">부서 2</option>
									<option value="part1">부서 3</option>
							</select></td>
						</tr>
						<tr>
							<td class="tableTitle detail"><label for="detailContent">상세
									내용</label></td>
							<td colspan="3"><textarea id="detailContent" name="content"><%=content%></textarea></td>
						</tr>
						<!-- 지도 -->
						<tr>
							<td class="tableTitle">지도</td>
							<td colspan="3">
								<%
								if (map != null && !map.isEmpty()) {
								%>
								<div class="loadBox" id="loadMap">
									<input id="kakaoField" name="filed" type="text"
										value="<%=map%>" readonly>
									<button id="deleteBtn" type="button" onclick="deleteMap()">지도삭제</button>
								</div>
								<div class="changeBox" id="changeMap" style="display: none;">
									<input id="kakaoField" placeholder="지도첨부" readonly> <label
										for="mapBtn">지도찾기</label> <input type="button" id="mapBtn"
										onclick="mapSearch()">
								</div> <%
 									} else {
									 %>
								<div class="addbox">
									<input id="kakaoField" placeholder="지도첨부" readonly> <label
										for="mapBtn">지도찾기</label> <input type="button" id="mapBtn"
										onclick="mapSearch()">
								</div> <%
									 }
									 %>
							</td>
						</tr>
						<!-- 첨부파일 -->
						<tr>
							<td class="tableTitle">첨부 파일</td>
							<td colspan="3">
								<%
								if (filename != null && !filename.isEmpty()) {
								%>
								<div class="loadBox" id="loadFile">
									<input id="addfile" name="af" type="text" value="<%=filename%>"
										readonly>
									<button id="deleteBtn" type="button" onclick="deleteFile()">파일삭제</button>
								</div>
								<div class="changeBox" id="changeFile" style="display: none;">
									<input id="addfile" placeholder="첨부파일" readonly> <label
										for="file">파일찾기</label> <input type="file" id="file"
										name="filename" onclick="findFile()">
								</div> <%
								 } else {
								 %>
								<div class="addbox">
									<input id="addfile" placeholder="첨부파일" readonly> <label
										for="file">파일찾기</label> <input type="file" id="file"
										name="filename" onclick="findFile()">
								</div> <%
								 }
								 %>
							</td>
						</tr>

						<!-- 페이지 넘버를 넘겨주기 위한 히든 -->
						<input type="hidden" name="con_no" value="<%=con_no%>">
						<input type="hidden" id="addressName" name="map">
						<input type="hidden" id="delFile" name="delFile">
					</table>

					<div id="btns">
						<button type="button" onclick="reviseSubmit()">수정완료</button>
						<button type="reset">다시쓰기</button>
						<button>
							<a href="javascript:history.back()">뒤로가기</a>
						</button>
			<!-- <input type="submit" value="저장">
            <input type="reset" value="내용삭제"> -->
					</div>
				</form>
			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="../script/condolencesRevise.js"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>