<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<%
	request.setCharacterEncoding("UTF-8");

	String Name = (String)session.getAttribute("memName");
	Integer No = (Integer)session.getAttribute("memNo");
	
	if(No == null) {
%>
<script>
	alert("로그인이 되어있지않습니다.");
	window.location.href = "../login.jsp";
</script>
<%
	return;
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/noticeWrite.css">
<!--Boxicons CDN Link-->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
					<h2>공지사항</h2>
				</div>

				<hr>

				<form method="post" action="../noticeWrite"
					enctype="multipart/form-data" onsubmit="return writeNOT();">
					<table>
						<tr>
							<td class="tableTitle"><label>작성자</label></td>
							<td><input type="text" value="<%=Name%>"></td>
							<input type="hidden" name="MEM_NO" value="<%=No%>">
							<td class="tableTitle"><label>작성일</label></td>
							<td><input type="text" id="currentDateInput" readonly></td>
							<!--작성일 나오게-->
						</tr>
						<tr>
							<td class="tableTitle"><label>말머리</label></td>
							<td><select name="NOTSUB_NO">
									<option value="1">공지</option>
									<option value="2">긴급</option>
									<option value="3">필독</option>
							</select></td>
							<td class="tableTitle"><label>해당부서</label></td>
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
							<td class="tableTitle"><label>제목</label></td>
							<td colspan="3"><input type="text" id="not_title"
								name="NOT_TITLE"></td>
							<!--작성자 이름 나오게-->
						</tr>
						<tr>
							<td class="tableTitle detail"><label>상세 내용</label></td>
							<td colspan="3"><textarea id="not_content"
									name="NOT_CONTENT"></textarea></td>
						</tr>
						<tr>
							<td class="tableTitle">첨부 파일</td>
							<td colspan="3">
								<div class="addbox">
									<input id="filename" placeholder="첨부파일" readonly> <label
										for="file">파일찾기</label> <input type="file" id="file"
										name="NOT_FILENAME" onclick="findFile()">
								</div>
							</td>
						</tr>
					</table>
					<div id="btns">
						<input type="submit" value="등록하기" style="text-align: center">
						<button>
							<a href="notice.jsp">뒤로가기</a>
						</button>
					</div>
				</form>
			</div>
	</section>

	<script src="../script/indexScript.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="../script/noticeScript.js"></script>
</body>
</html>