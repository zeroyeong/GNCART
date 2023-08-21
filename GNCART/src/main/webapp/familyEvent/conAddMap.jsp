<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/conPopup.css?asssdd">

</head>
<body>
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
              <button><a onClick="searchPlace()">찾기</a></button>
              <input type="button" id="searchBtn" onClick="searchPlace()" value="찾기" />
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
<script src="../script/conAddMap.js?asfdd"></script>

</body>
</html>