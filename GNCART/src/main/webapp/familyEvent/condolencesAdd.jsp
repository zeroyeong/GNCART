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
			<div class="container">
		      <div class="title">
		        <h3>경조사 일정 추가</h3>
		        <div class="writer">
		          <ul>
		            <li>작성자</li>
		            <li>경영지원팀</li>
		            <li>강민서</li>
		          </ul>
		          <ul>
		            <li>작성일</li>
		            <li>2023-08-18</li>
		          </ul>
		        </div>
		      </div>
			 <div class="content">
			 <h3 class="caption">조예은 님의 결혼을 축하합니다.</h3>
			   <form name="postFrm" method="post" action="conboardPost" enctype="multipart/form-data">
			     <table>
			       <colgroup>
			         <col class="col1" />
			         <col class="col2" />
			         <col class="col3" />
			         <col class="col4" />
			       </colgroup>
			       <tr>
			         <th>제목</th>
			         <td colspan="3">
			         	<input id="detailTitle" name="title"required>
			         </td>
			         <td>
			       </tr>
			       <tr>
			         <th>종류</th>
			         <td>
			           <select id="type" name="type">
			             <option value="결혼식">결혼식</option>
			             <option value="출산">출산</option>
			             <option value="돌잔치">돌잔치</option>
			             <option value="장례식">장례식</option>
			           </select>
			         </td>
			         <th>날짜</th>
			         <td>
			           <input type="text" name="desdate" required>
			         </td>
			       </tr>
			       <tr>
			         <th>부서 / 이름</th>
			         <td colspan="3">
						<div class="addbox">
						<input id="user_part_name" name="user_part_name" placeholder="부서 / 이름" readonly>
						<label for="userBtn">직원 찾기</label>
						<input type="button" id="userBtn" name="userBtn" onclick="userSearch()">
						</div>
					</td>
			       </tr>
			       <tr>
			         <th>장소 및 주소</th>
			         <td colspan="3"><input type="text" id="locationId" name="location"
						placeholder="지도에서 검색 해주세요" readonly></td>
			       </tr>
			       <tr>
			         <th>내용</th>
			         <td colspan="3">
			           <textarea id="detailContent" name="content"></textarea>
			         </td>
			       </tr>
			       <tr>
			         <th>지도</th>
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
			         <th>첨부 파일</th>
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
			
			      <div class="button">
			        <button type="submit">저장</button>
			        <button type="button"><a href="condolences.jsp">목록</a></button>
			      </div>
			      
			    </form>
			  </div>
			</div>		
		</div>
	</section>

	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
	<script src="../script/condolencesAdd.js"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>