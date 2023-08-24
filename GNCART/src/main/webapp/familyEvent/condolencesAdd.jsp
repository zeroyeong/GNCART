<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="java.util.Vector" %>
<%@page import="familyEvent.ConBean" %>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" /> 

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
<link rel="stylesheet" href="../css/condolencesAdd.css?dssdasd">
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
		<div class="container">
	      <div class="title">
	        <h3>경조사 일정 추가</h3>
	      </div>
	      <div class="content">
	        <form name="postFrm" method="post" action="conboardPost" enctype="multipart/form-data">
	          <table>
              <colgroup>
                <col class="col1" />
                <col class="col2" />
                <col class="col3" />
                <col class="col4" />
              </colgroup>
              <tr>
                <td><span>제목</span></td>
                <td colspan="3">
                  <input id="detailTitle" name="title" spellcheck="false" required />
                </td>
              </tr>
              <tr>
                <td><span>종류</span></td>
                <td>
                  <select id="type" name="type">
                    <option value="결혼식">결혼식</option>
                    <option value="출산">출산</option>
                    <option value="돌잔치">돌잔치</option>
                    <option value="장례식">장례식</option>
                  </select>
                </td>
                <td><span>날짜</span></td>
                <td><input type="date" name="desdate" spellcheck="false" required /></td>
              </tr>
              <tr>
                <td><span>부서 / 이름</span></td>
                <td colspan="3">
                  <div class="user">
                    <input type="text" id="user_part_name" name="user_part_name" placeholder="부서 / 이름"/>
                    <input type="button" id="userBtn" name="userBtn" onclick="userSearch()" value="직원찾기" />
                  </div>
                </td>
              </tr>
              <tr>
                <td><span>장소 및 주소</span></td>
                <td colspan="3">
                  <input type="text" id="locationId" name="location" placeholder="지도에서 검색해주세요." readonly />
                </td>
              </tr>
              <tr>
                <td><span class="memeo">내용</span></td>
                <td colspan="3">
                  <textarea name="content" id="detailContent" rows="10" spellcheck="false"></textarea>
                </td>
              </tr>
              <tr>
                <td><span>지도</span></td>
                <td colspan="3">
                  <div class="addr">
                    <input type="text" id="kakaoField" name="map" placeholder="지도첨부"/>
                    <input type="button" value="지도찾기" id="mapBtn" onclick="mapSearch()"/>
                  </div>
                </td>
              </tr>
              <tr>
                <td><span>첨부파일</span></td>
                <td colspan="3">
                  <div class="file">
                    <input type="text" id="filename" placeholder="첨부파일" readonly/>
                    <label for="file">파일찾기</label> 
                    <input type="file" id="file" name="filename" onclick="findFile()"/>
                  </div>
                </td>
              </tr>
            </table>  
	            <input type="hidden" name="memNo" value="<%= memNo %>">
	            <input type="hidden" name="userpart" value="userpart">
	            <input type="hidden" name="username" value="username">
	          <div class="button">
	            <button type="submit">저장</button>
	            <a href="condolences.jsp">  
	         	   <button type="button">목록</button>
	            </a>
	          </div>
	        </form>
	      </div>
	    </div>
	</div>

	</section>

<script src="../script/condolencesAdd.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  

</body>
</html>