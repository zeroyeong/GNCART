<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<%
request.setCharacterEncoding("UTF-8");
String Name = (String) session.getAttribute("memName");
Integer No = (Integer) session.getAttribute("memNo");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/eventAdd.css">
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
		<div class="container-fluid">
			<div class="container">
				<div class="title">
					<h3>행사사진 추가</h3>
				</div>
				<div class="content">
					<table>
						<colgroup>
							<col />
							<col />
							<col />
							<col />
						</colgroup>

						<form method="post" action="../eventWrite"
							enctype="multipart/form-data" onsubmit="return notfile();">
						<tr>
							<td><span>제목</span></td>
							<td colspan="3"><input type="text" name="EVENT_TITLE"
								required></td>
						</tr>
						<tr>
							<td><span>행사종류</span></td>
							<td><select name="EVENTSUB_NO">
									<option value="1">부서행사</option>
									<option value="2">사내행사</option>
									<option value="3">사외행사</option>
							</select></td>

							<td><span>날짜</span></td>
							<td><input type="date" name="desdate" required /></td>

						</tr>
						<tr>
							<td><span>부서</span></td>
							<td><select name="PART_NO">
									<option value="1">경영지원팀</option>
									<option value="2">개발팀</option>
									<option value="3">홍보팀</option>
									<option value="4">영업팀</option>
									<option value="5">서비스지원팀</option>
									<option value="6">전체부서</option>
							</select></td>
						</tr>
						<tr>
							<td><span class="memeo">내용</span></td>
							<td colspan="3"><textarea name="EVENT_CONTENT" rows="10"
									required></textarea></td>
						</tr>
						<tr>
							<td><span>첨부파일</span></td>
							<td colspan="3">
								<div class="addbox">
									<input id="filename1" placeholder="첨부파일" readonly> <input
										type="file" id="file1" name="EVENT_FILENAME1"
										onchange="findFile(1)">
									<div>
										<a onclick="fileplus()"><label>추가</label></a>
									</div>
								</div>
							</td>
						</tr>
					</table>

					<div class="button">
						<button type="submit" value="등록하기">저장</button>
						<a href="event.jsp">
							<button type="button">목록</button>
						</a>
					</div>
				</div>
			</div>
		</div>
		</form>
	</section>

	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="../script/indexScript.js"></script>
	<script src="../script/eventScript.js"></script>
</body>
</html>