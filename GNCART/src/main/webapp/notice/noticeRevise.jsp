<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="notice.NoticeBean"%>

<%
int NOT_NO = Integer.parseInt(request.getParameter("NOT_NO"));

NoticeBean bean = (NoticeBean)session.getAttribute("bean");
String NOT_TITLE = bean.getNOT_TITLE();
String NOT_CONTENT = bean.getNOT_CONTENT(); 
String NOT_DATE = bean.getNOT_DATE();
int MEM_NO = bean.getMEM_NO();
int NOTSUB_NO = bean.getNOTSUB_NO();
int PART_NO = bean.getPART_NO();
String MEM_NAME = bean.getMEM_NAME();
String NOT_SUB = bean.getNOT_SUB();
String MEM_ID = bean.getMEM_ID();

String Part = (String)session.getAttribute("parttype");
int partno = (int)session.getAttribute("partNo");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/noticeRevise.css?1">
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
	        <h3>공지사항 수정</h3>
	      </div>
	      <div class="content">
	        <form name="ReviseFrm" method="post" action="../noticeRevise">
	          <table>
	            <colgroup>
	              <col class="col1" />
	              <col class="col2" />
	              <col class="col3" />
	              <col class="col4" />
	            </colgroup>
	            <tr>
	              <td>제목</td>
	              <td colspan="3"><input id="detailTitle" name="NOT_TITLE" value="<%=NOT_TITLE%>"required></td>
	            </tr>
	            <tr>
	              <td>종류</td>
	              <td>
                  <select id="type" name="NOTSUB_NO">
					<option value="1" <%= (NOTSUB_NO == 1) ? "selected" : "" %>>공지</option>
					<option value="2" <%= (NOTSUB_NO == 2) ? "selected" : "" %>>긴급</option>
					<option value="3" <%= (NOTSUB_NO == 3) ? "selected" : "" %>>필독</option>
	                </select>
	              </td>
	              <td>날짜</td>
	              <td>
	                <input type="date" name="NOT_DATE" value="<%=NOT_DATE%>" />
	              </td>
	            </tr>
	            <tr>
	              <td>부서 및 이름</td>
	              <td colspan="3">
	                <div class="user">
	                  <input type="text" id="user_part_name" name="user_part_name" placeholder="부서 / 이름" value="<%=Part%> / <%=MEM_NAME%>"readonly/>	
	                  <input type="hidden" name="PART_NO" value="<%=partno %>">
	                  <input type="hidden" name="MEM_NAME" value="<%=MEM_NAME %>">
	                </div>
	              </td>
	            </tr>
	            <tr>
	              <td>내용</td>
	              <td colspan="3">
	                <textarea id="detailContent" name="NOT_CONTENT" rows="10"><%=NOT_CONTENT%></textarea>
	              </td>
	            </tr>

	          </table>
	          <!-- 페이지 넘버를 넘겨주기 위한 히든 -->
	          <div class="button"> 
	            <button>수정</button>
	            <button type="reset">리셋</button>
	          	  <a href="javascript:history.back()">
	            <button>뒤로</button></a>
	          </div>
	          <input type='hidden' name="NOT_NO" value="<%=NOT_NO%>">
	        </form>
	      </div> 
	    </div>
	</div>
	</section>
	
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="../script/indexScript.js"></script>
</body>
</html>