<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
//로그인 안했을 시 로그인 페이지로 리다이렉트 
if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null) {
	response.sendRedirect("../login.jsp");
	return; 
}

//캐시 설정(로그아웃 하고 뒤로가기시 인덱스 접근 차단)
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/conPopup.css">

</head>
<body style="background-color: #96969648">
    <div class="container">
      <div class="title">
        <h3>지도추가</h3>
        <span>×</span>
        <!-- x버튼 클릭시 windouw.close() 실행될 수 있도록 해주시면 깔끔할거같습니당! 
        필요없다면 삭제해도 무방합니다.-->
      </div> 
      <div class="content">
        <table>
          <tr>
            <td>주소</td>
            <td><input type="text" id="place" placeholder="주소를 입력해 주세요." /></td>
            <td>
              <button type="button" id="searchBtn" onClick="searchPlace()">찾기</button>
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <div class="map" id="map"></div>
            </td>
          </tr>
        </table>
        <div class="button">
          <input type="button" onClick="sendmap()" value="저장" />
        </div>
      </div>
    </div>

<!-- kakao map  -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24e23b8a98c1750309dd34a0c1ea57d3&libraries=services"></script>
<script src="../script/conAddMap.js?dd"></script>

</body>
</html>