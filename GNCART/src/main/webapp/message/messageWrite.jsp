<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="message.MsgBean"%>
<%@page import="management.ManagementBean" %>
<jsp:useBean id="msgMgr" class="message.MsgMgr" />

<% 
request.setCharacterEncoding("UTF-8");

ManagementBean bean = new ManagementBean();

int mem_no = (int)session.getAttribute("memNo");
bean =  msgMgr.userInfo(mem_no);
 
String mem_name = bean.getMEM_NAME();
String part_type = bean.getPART_TYPE();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/NEWmessageDetail.css?after">
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
	        <h3>메세지</h3>
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
	        <form name="msgFrm" method="post" action="messagedPost" enctype="multipart/form-data">
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
	              <input id="detailTitle" name="msg_title"required>
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
	            <th>내용</th>
	            <td>
	              <textarea id="detailContent" name="msg_content"></textarea>
	            </td>
	          </tr>
	
	          <tr>
	            <th>첨부파일</th>
	            <td colspan="3">
	              <div class="addbox">
	                <input id="filename" placeholder="첨부파일" readonly> <label
	                  for="file">파일찾기</label> <input type="file" id="file"
	                  name="filename" onclick="findFile()">
	              </div>
	            </td>
	          </tr>
	        </table>
	
	        <div class="button">
	          <button type="submit">보내기</button>
	          <button type="reset">다시쓰기</button>
	          <button type="button">
	            <a href="messageInbox.jsp">목록</a>
	          </button>
	        </div>
	          <input type="hidden" name="mem_no" value="<%= mem_no %>">
	          <input type="hidden" name="msg_frompparttype" value="<%= part_type %>">
	          <input type="hidden" name="msg_fromname" value="<%= mem_name %>">
	        </form>
	      </div>
	    </div>

	</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="../script/indexScript.js"></script>
	<script src="../script/messageWrite.js"></script>
</body>
</html>