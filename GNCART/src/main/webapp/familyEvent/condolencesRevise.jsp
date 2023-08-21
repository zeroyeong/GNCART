<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="familyEvent.ConBean"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" />

<%
int con_no = Integer.parseInt(request.getParameter("con_no"));
ConBean bean = new ConBean();
bean = conMgr.getBoard(con_no);
String title = bean.getCon_title();
String content = bean.getCon_content();
String regdate = bean.getCon_regdate();
String type = bean.getCon_type();
String userPart = bean.getCon_userPart();
String userName = bean.getCon_userName();
String desdate = bean.getCon_desdate();
String location = bean.getCon_location();
String map = bean.getCon_map();
String filename = bean.getCon_file();
int hit = bean.getCon_hit();
int mem_no = bean.getMem_no();
String writer = bean.getMem_name();
String part_type = bean.getPart_type();

int memNo = (int)session.getAttribute("memNo");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/NEWcondolencesAdd.css">
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
	        <h3>경조사 일정 수정</h3>
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
	        <form name="postFrm" method="post" action="conboardUpdate" enctype="multipart/form-data">
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
	              <td><input type="text" name="desdate" value="<%=desdate%>"></td>
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
	                value="<%=location%>" placeholder="지도에서 검색 해주세요" readonly></td>
	            </tr>
	            <tr>
	              <th>내용</th>
	              <td colspan="3">
	                <textarea id="detailContent" name="content"><%=content%></textarea>
	              </td>
	            </tr>
	
	            <tr>
	              <th>지도</th>
	              <td colspan="3">
	                  <%
	                  if (map != null && !map.isEmpty()) {
	                  %>
	                  <div class="loadBox" id="loadMap">
	                    <input id="kakaoField" name="filed" type="text"
	                      value="<%=map%>" readonly>
	                    <button id="deleteBtn" type="button" onclick="deleteMap()">지도삭제</button>
	                  </div>
	                  <div class="changeBox" id="changeMap" style="display: none;">
	                    <input id="kakaoField" placeholder="지도첨부" readonly> <label
	                      for="mapBtn">지도찾기</label> <input type="button" id="mapBtn"
	                      onclick="mapSearch()">
	                  </div> 
	                  <%
	                    } else {
	                   %>
	                  <div class="addbox">
	                    <input id="kakaoField" placeholder="지도첨부" readonly> <label
	                      for="mapBtn">지도찾기</label> <input type="button" id="mapBtn"
	                      onclick="mapSearch()">
	                  </div> 
	                  <%
	                  }
	                  %>
	              </td>
	            </tr>
	
	            <tr>
	              <th>첨부 파일</th>
	              <td colspan="3">
	                <%
	                if (filename != null && !filename.isEmpty()) {
	                %>
	                <div class="loadBox" id="loadFile">
	                  <input id="addfile" name="af" type="text" value="<%=filename%>"
	                    readonly>
	                  <button id="deleteBtn" type="button" onclick="deleteFile()">파일삭제</button>
	                </div>
	                <div class="changeBox" id="changeFile" style="display: none;">
	                  <input id="addfile" placeholder="첨부파일" readonly> <label
	                    for="file">파일찾기</label> <input type="file" id="file"
	                    name="filename" onclick="findFile()">
	                </div> 
	                <%
	                 } else {
	                 %>
	                <div class="addbox">
	                  <input id="addfile" placeholder="첨부파일" readonly> <label
	                    for="file">파일찾기</label> <input type="file" id="file"
	                    name="filename" onclick="findFile()">
	                </div> 
	                <%
	                 }
	                 %>
	              </td>
	            </tr>
	
	          </table>
	            <input type="hidden" id="typeSelect" value="<%= type %>">
	            <!-- 페이지 넘버를 넘겨주기 위한 히든 -->
	            <input type="hidden" name="con_no" value="<%=con_no%>">
	            <input type="hidden" id="addressName" name="map">
	            <input type="hidden" id="delFile" name="delFile">
	          <div class="button">
	            <button type="button" onclick="reviseSubmit()">수정</button>
	            <button type="reset">리셋</button>
	            <button>
	              <a href="javascript:history.back()">뒤로</a>
	            </button>
	          </div>
	       </form>
	      </div>
	    </div>

	</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="../script/condolencesRevise.js?asdf"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>