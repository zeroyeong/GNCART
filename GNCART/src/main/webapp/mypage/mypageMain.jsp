<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.*"%>
<jsp:useBean id="pMgr" class="mypage.MypageMgr" />
<%
request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("idKey");
String pw = (String) session.getAttribute("pwKey");
%>

<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<!--css-->
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/mypage.css">
<!--Boxicons css-->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
</head>

<body>
	<!-- sidebar include -->
	<jsp:include page="../index/sidebar.jsp" flush="false" />

	<!--home-top--->
	<section class="home-section">
		<!-- top include -->
		<jsp:include page="../index/top.jsp" flush="false" />

		<!-- 마이페이지 -->
		<div class="home-content">
			<div id="container">

				<jsp:include page="mypageTop.jsp" />

				<hr>

				<jsp:include page="mypageBody.jsp" />

				<br>

				<jsp:include page="mypageBottom/mypagePhone.jsp" />
				<jsp:include page="mypageBottom/mypageMail.jsp" />
				<jsp:include page="mypageBottom/mypageBirth.jsp" />
				<jsp:include page="mypageBottom/mypageAdd.jsp" />
				<jsp:include page="mypageBottom/mypagePw.jsp" />

			</div>
		</div>
	</section>

	<!-- 자바스크립트 -->
	<script>
		$("#leftMenuBtn").on("click", function() {
			if ($(this).hasClass("menuOut")) {
				$(this).addClass("menuIn");
				$(this).removeClass("menuOut");
				$("div.sidebar").css("width", "240px");
				$("span.link").show();
			}

			else {
				$(this).addClass("menuOut");
				$(this).removeClass("menuIn");
				$("div.sidebar").css("width", "54px");
				$("span.link").hide();
			}
		})
	</script>

</body>

<script type="text/javascript" src="mypage.js?ver=1.3"></script>
</html>