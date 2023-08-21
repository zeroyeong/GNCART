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
<link rel="stylesheet" href="../css/condolencesAdd.css">
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
	      </div>
	      <div class="content">
	        <form name="postFrm" method="post" action="conboardUpdate" enctype="multipart/form-data">
	          <table>
	            <colgroup>
	              <col class="col1" />
	              <col class="col2" />
	              <col class="col3" />
	              <col class="col4" />
	            </colgroup>
	            <tr>
	              <td>제목</td>
	              <td colspan="3"><input id="detailTitle" name="title" value="<%= title %>"required></td>
	            </tr>
	            <tr>
	              <td>종류</td>
	              <td>
	                <select id="type" name="type">
	                  <option value="결혼식">결혼식</option>
	                  <option value="출산">출산</option>
	                  <option value="돌잔치">돌잔치</option>
	                  <option value="장례식">장례식</option>
	                </select>
	              </td>
	              <td>날짜</td>
	              <td>
	                <input type="date" name="desdate" value="<%=desdate%>" />
	              </td>
	            </tr>
	            <tr>
	              <td>부서 및 이름</td>
	              <td colspan="3">
	                <div class="user">
	                  <input type="text" id="user_part_name" name="user_part_name" placeholder="부서 / 이름" value="<%= userPart %> / <%= userName %>"readonly/>
	                  <input type="button" id="userBtn" name="userBtn" onclick="userSearch()" value="직원찾기"/>
	                </div>
	              </td>
	            </tr>
	            <tr>
	              <td>장소 및 주소</td>
	              <td colspan="3">
	                <input type="text" id="locationId" name="location" value="<%=location%>" placeholder="지도에서 검색 해주세요" readonly/>
	              </td>
	            </tr>
	            <tr>
	              <td>내용</td>
	              <td colspan="3">
	                <textarea id="detailContent" name="content" rows="10"><%=content%></textarea>
	              </td>
	            </tr>
	            <tr>
	              <td>지도</td>
	              <td colspan="3">
	              <%
	              if (map != null && !map.isEmpty()) {
	              %>
	                <div class="loadBox" id="loadMap">
	                  <input id="kakaoField" name="filed" type="text" value="<%=map%>" readonly />
	                  <input id="deleteBtn" type="button" onclick="deleteMap()" value="지도삭제"/>
	                  <!--지도삭제 누르면 지도찾기 버튼-->
	                </div>
	                <div class="changeBox" id="changeMap" style="display: none;">
	                  <input id="kakaoField" placeholder="지도첨부" readonly>
	                  <input type="button" id="mapBtn" onclick="mapSearch()" value="지도찾기"/>
	                </div>         
	              <%
	              } else {
	              %>
	              <div class="addr">
	                <input type="text" id="kakaoField" name="map" placeholder="지도첨부">
	                <input type="button" value="지도찾기" id="mapBtn" onclick="mapSearch()">
	              </div>    
	              <%
	              }
	              %>
	              </td>
	            </tr>
	            <tr>
	              <td>첨부파일</td>
	              <td colspan="3">
	                <%
	                if (filename != null && !filename.isEmpty()) {
	                %>
	                <div class="file">
	                  <div class="loadBox" id="loadFile">
	                    <input type="text" id="addfile" name="af" value="<%=filename%>" readonly />
	                    <input type="button" onclick="deleteFile()" value="파일삭제">
	                    <!--파일삭제 누르면 input file-->
	                  </div>
                      <div class="changeBox" id="changeFile" style="display: none;">
                        <input type="text" id="filename" placeholder="첨부파일" readonly>
	                    <input type="file" id="file" name="filename" onclick="findFile()">
	                  </div>
	                </div>
	                <%
	                } else {
	                %>
	                <div class="file">
	                  <input type="text" id="filename" placeholder="첨부파일" readonly>
	                  <input type="file" id="file" name="filename" onclick="findFile()"/>
	                </div>    
	                <%
	                }
	                %>
	              </td>
	            </tr>
	          </table>
	          <input type="hidden" id="typeSelect" value="<%= type %>" />
	          <!-- 페이지 넘버를 넘겨주기 위한 히든 -->
	          <input type="hidden" name="con_no" value="<%=con_no%>" />
	          <input type="hidden" id="addressName" name="map" />
	          <input type="hidden" id="delFile" name="delFile" />
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
<script src="../script/condolencesRevise.js?addsdf"></script>
<script src="../script/indexScript.js"></script>
</body>
</html>