<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/conAddMap.css">
<!--Boxicons CDN Link-->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<!-- kakao map  -->

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
					<h2>지도 추가</h2>
				</div>

				<table>
					<tr>
						<td class="tableTitle">주소</td>
						<td colspan="3">
							<div id="placediv">
								<input id="place" placeholder="주소를 입력해 주세요">
								<div id="btns">
									<button id="searchBtn" onClick="searchPlace()">주소 찾기</button>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div id="map"></div>
						</td>
					<tr>
				</table>

				<!-- 	<input type="hidden" id="place_name" name="place_name">
			<input type="hidden" id="address_name" name="address_name"> -->

				<div id="btns">
					<button onClick="sendmap()">저장</button>
				</div>

			</div>
		</div>
	</section>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24e23b8a98c1750309dd34a0c1ea57d3&libraries=services"></script>
	<script src="../script/indexScript.js"></script>
	<script src="../script/conAddMap.js"></script>

</body>
</html>