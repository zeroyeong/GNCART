<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="message.MsgBean"%>
<jsp:useBean id="msgMgr" class="message.MsgMgr" />

<% 
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/messageWrite.css">
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
					<h2>메시지</h2>
				</div>
				<hr>
				<form name="msgFrm" method="post" action="messagedPost">
					<table>
						<tr>
							<td class="tableTitle">제 목</td>
							<td colspan="3"><input id="detailTitle" name="msg_title"
								required value="제목입니다."></td>
						</tr>
						<tr>
							<td class="tableTitle">받는사람</td>
							<td><input type="text" name="msg_toname" required
								value="김말쑥"></td>
							<td class="tableTitle">해당부서</labe></td>
							<td><input type="text" id="" name="part_type" value="인사팀"></td>
						</tr>
						<tr>
							<td class="tableTitle detail"><label for="detailContent">상세
									내용</label></td>
							<td colspan="3"><textarea id="detailContent"
									name="msg_content" value="상세 내용 입니다."></textarea></td>
						</tr>

					</table>
					<input type="hidden" name="msg_fromname" value="박말쑥">
					<div id="btns">
						<button type="submit">보내기</button>
						<button type="reset">다시쓰기</button>
						<button type="button">
							<a href="messageInbox.jsp">목록</a>
						</button>
						<!-- <input type="submit" value="저장">
            <input type="reset" value="내용삭제"> -->
					</div>
				</form>

			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>