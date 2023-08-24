<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="java.util.Vector" %>
<% 
String Name = (String)session.getAttribute("memName");
Integer No = (Integer)session.getAttribute("memNo");
String Part = (String)session.getAttribute("parttype");
int PartNo = (int)session.getAttribute("partNo");
%> 
 
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/noticeWrite.css?1">
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
	        <h3>공지사항</h3>
	      </div>
	      <div class="content">
	        <form name="postFrm" method="post" action="../noticeWrite" enctype="multipart/form-data">
	        <div class="content">
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
                  <input id="detailTitle" name="NOT_TITLE" required />
                </td>  
              </tr>
              <tr>
                <td><span>말머리</span></td>
                <td>
                  <select id="type" name="NOTSUB_NO">
                    <option value="1">공지</option>
                    <option value="2">긴급</option>
                    <option value="3">필독</option>
                  </select>
                </td>
                <td><span>날짜</span></td>
                <td><input type="text" id="currentDateInput" readonly></td>
              </tr>
              <tr>
                <td><span>부서 / 이름</span></td>
                <td colspan="3">
                  <div class="user">
					<input type="text" value="<%=Part %> / <%=Name%>" readonly>
					<input type="hidden" name="MEM_NO" value="<%=No%>">
					<input type="hidden" name="PART_NO" value="<%=PartNo%>">
                  </div>
                </td>
              </tr>
              <tr>
                <td><span class="memeo">내용</span></td>
                <td colspan="3">
                  <textarea
                    name="NOT_CONTENT"
                    id="detailContent"
                    rows="10"
                  ></textarea>
                </td>
              </tr>
              <tr>
                <td><span>첨부파일</span></td>
                <td colspan="3">
                  <div class="file">
                    <input
                      type="text"
                      id="filename"
                      placeholder="첨부파일"
                      readonly
                    />
                    <label for="file">파일찾기</label> 
                    <input
                      type="file"
                      id="file"
                      name="NOT_FILENAME"
                      onclick="findFile()"
                    />
                  </div>
                </td>
              </tr>
            </table>
	          <div class="button">
	            <button type="submit">저장</button>
	            <a href="notice.jsp">
	         	   <button type="button">목록</button>
	            </a>
	          </div>
	          </div>
	        </form>
	      </div>
	    </div>
	</div>

	</section>

	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
	<script src="../script/noticeScript.js"></script>
	<script src="../script/indexScript.js"></script>
</body>
</html>