<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="java.util.Vector" %>
<%@page import="familyEvent.ConBean" %>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" /> 

<% 
request.setCharacterEncoding("UTF-8");
int memNo = (int)session.getAttribute("memNo");

String user ="";
if(request.getParameter("user") != null){
	user = request.getParameter("user");
}
%> 
 
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/condolencesAdd.css?after1">
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
					<h2>경조사 일정 추가</h2>
				</div>
				<hr>
				<form name="postFrm" method="post" action="conboardPost"
					enctype="multipart/form-data">
					<table>
						<tr>
							<td class="tableTitle">제 목</td>
							<td colspan="3"><input id="detailTitle" name="title"
								required></td>
						</tr>
						<tr>
							<td class="tableTitle">일정</tWd>
							<td><input type="text" name="desdate" required></td>
							<td class="tableTitle">장소</labe></td>
							<td><input type="text" id="locationId" name="location"
								placeholder="지도에서 검색 해주세요" readonly></td>
						</tr>
						<tr>
							<td class="tableTitle"><label for="type">일정 종류</label></td>
							<td><select id="type" name="type">
									<option>결혼식</option>
									<option>장례식</option>
									<option>출산</option>
							</select></td>
							<td class="tableTitle"><label for="part">부서 / 이름</label></td>
							<td>
								<div class="addbox">
								<input id="user_part_name" name="user_part_name" placeholder="부서 / 이름" readonly>
								<label for="userBtn">직원 찾기</label>
								<input type="button" id="userBtn" name="userBtn" onclick="userSearch()">
								</div>
							</td>
						</tr>
						<tr>
							<td class="tableTitle detail"><label for="detailContent">상세
									내용</label></td>
							<td colspan="3"><textarea id="detailContent" name="content"></textarea></td>
						</tr>
						<tr>
							<td class="tableTitle">지도</td>
							<td colspan="3">
								<div class="addbox">
									<input id="kakaoField" name="map" placeholder="지도첨부" readonly>
									<label for="mapBtn">지도찾기</label> <input type="button"
										id="mapBtn" onclick="mapSearch()">
									<!-- name = "location" -->
								</div>
							</td>
						</tr>
						<tr>
							<td class="tableTitle">첨부 파일</td>
							<td colspan="3">
								<div class="addbox">
									<input id="filename" placeholder="첨부파일" readonly> <label
										for="file">파일찾기</label> <input type="file" id="file"
										name="filename" onclick="findFile()">
								</div>
							</td>
						</tr>
					</table>
					
					<input type="hidden" name="memNo" value="<%= memNo %>">
					<input type="hidden" name="userpart" value="userpart">
					<input type="hidden" name="username" value="username">
					
					<div id="btns">
						<button type="submit">저장</button>
						<button type="reset">다시쓰기</button>
						<button type="button">
							<a href="condolences.jsp">목록</a>
						</button>
						<!-- <input type="submit" value="저장">
            <input type="reset" value="내용삭제"> -->
					</div>
				</form>

			</div>
		</div>
	</section>

	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
	<script src="../script/condolencesAdd.js"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>