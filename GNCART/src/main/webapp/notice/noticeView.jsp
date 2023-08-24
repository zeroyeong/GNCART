<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="notice.NoticeBean"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr" />

<%    	
request.setCharacterEncoding("UTF-8");

int NOT_NO = Integer.parseInt(request.getParameter("NOT_NO"));

nMgr.upHit(request, response);

NoticeBean bean = nMgr.getNotice(NOT_NO);

String NOT_TITLE = bean.getNOT_TITLE();
String NOT_CONTENT = bean.getNOT_CONTENT();
String NOT_DATE = bean.getNOT_DATE();
String NOT_FILENAME = bean.getNOT_FILENAME();
int NOT_FILESIZE = bean.getNOT_FILESIZE();
int NOT_HIT = bean.getNOT_HIT();
int MEM_NO = bean.getMEM_NO();
int NOTSUB_NO = bean.getNOTSUB_NO();
String MEM_NAME = bean.getMEM_NAME();
String NOT_SUB = bean.getNOT_SUB();
String MEM_ID = bean.getMEM_ID();
String PART_TYPE = bean.getPART_TYPE();

session.setAttribute("bean", bean);//게시물을 세션에 저장
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css"> 
<link rel="stylesheet" href="../css/noticeView.css">
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
	        <div class="writer">
	          <ul>
	            <li>작성자</li>
	            <li><%= PART_TYPE %></li>
	            <li><%= MEM_NAME %></li>
	          </ul>
	          <ul>
	            <li>작성일</li>
	            <li><%= NOT_DATE %></li>
	          </ul>
	        </div>
	      </div>
	      <div class="content">
	        <h3 class="caption"><%= NOT_TITLE %></h3>
	        <form name="detailFrm" class="detail">
	          <table>
	            <colgroup>
	              <col class="col1" />
	              <col class="col2" />
	              <col class="col3" />
	              <col class="col4" />
	            </colgroup>
	            <tr>
	              <th>말머리</th>
	              <td><%= NOT_SUB %></td>
	              <th>날짜</th>
	              <td><%= NOT_DATE %></td>
	            </tr>
	            <tr>
	              <th>부서 / 이름</th>
	              <td colspan="3"><%= PART_TYPE %> / <%= MEM_NAME %></td>
	            </tr>
	            <tr>
	              <th class="board-content">내용</th>
	              <td colspan="3"><textarea><%=NOT_CONTENT%></textarea></td>
	            </tr>
	            <%
			    if(NOT_FILENAME != null && !NOT_FILENAME.isEmpty()){  
				%>
	            <tr>
	              <th>첨부파일</th>
	              <td colspan="3">
	                <a
	                  id="filename"
	                  href="javascript:down('<%=NOT_FILENAME%>')"
	                  ><%= NOT_FILENAME %></a
	                >
	              </td>
	            </tr>
	            <%
	            }
	            %>
	          </table>
	          <div class="button">
	            <% 
	            String id = (String)session.getAttribute("memId");
	            if (id != null && id.equals(MEM_ID)) {
	            %>
	          	<a href="noticeRevise.jsp?=&NOT_NO=<%=NOT_NO%>">
	            	<button type="button">수정</button>
	            </a>
	            <a href="noticeDelete.jsp?=&NOT_NO=<%=NOT_NO%>">
	            	<button type="button">삭제</button>
	            </a>
	            <%
	            } 
	            %>
             	<a href="newnotice.jsp">
             		<button type="button">목록</button>
            	</a>
	          </div>
	        </form>
	      </div>
	    </div>
	</div>
	</section>
	<form name="downFrm" action="noticeDownload.jsp" method="post">
		<input type="hidden" name="NOT_FILENAME">
	</form>
	
<script src="../script/noticeScript.js"></script>
<script src="../script/indexScript.js"></script>
</body>
</html>