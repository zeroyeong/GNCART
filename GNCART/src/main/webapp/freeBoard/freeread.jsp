<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@page import="freeBoard.BoardBean"%>
<%@page import="freeBoard.BoardMgr" %>
<%@page import="freeBoard.reply" %>
<%@page import="freeBoard.replyDAO" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="bMgr" class="freeBoard.BoardMgr" />

<!DOCTYPE html>
<html lang="ko"> 
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/freeread.css?addffsd">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<% 
	  request.setCharacterEncoding("UTF-8");

	  int FREE_NO = Integer.parseInt(request.getParameter("FREE_NO"));

	  bMgr.upHit(request, response);//조회수 증가 
	  
	  BoardBean bean = bMgr.getBoard(FREE_NO);//게시물 가져오기
	  
	  String MEM_NAME = bean.getMEM_NAME();
	  String FREE_TITLE = bean.getFREE_TITLE();
      String FREE_DATE = bean.getFREE_DATE();
	  String FREE_CONTENT = bean.getFREE_CONTENT();
	  String FREE_FILENAME = bean.getFREE_FILENAME(); 
	  int FREE_FILESIZE = bean.getFREE_FILESIZE();
	  int FREE_HIT = bean.getFREE_HIT();
	  String PART_TYPE = bean.getPART_TYPE();
	  String MEM_ID = bean.getMEM_ID();
	  int MEM_NO = bean.getMEM_NO();
	 
	  
	  session.setAttribute("bean", bean);//게시물을 세션에 저장
	  
	  
	    
		if(session.getAttribute("MEM_NAME ")!=null){
			MEM_NAME =(String)session.getAttribute("MEM_NAME");
		}
		
		if(request.getParameter("MEM_NO")!=null){
			MEM_NO=Integer.parseInt(request.getParameter("MEM_NO"));
		}
		
		int pageNumber=1;
		// pageNumber는 URL에서 가져온다.
		if(request.getParameter("pageNumber")!=null){
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
		}
		

	  BoardMgr boardmgr = new BoardMgr();
	  
	  
%>


</head>
<body>
  <!-- sidebar include -->	
  <jsp:include page="../index/sidebar.jsp" flush="false"/>	

<section class="home-section">
   <!-- top include -->
  <jsp:include page="../index/top.jsp" flush="false"/>
	
  <!--home-content-->  
	<div class="home-content">
	  <div class="container">
	      <div class="title">
	        <h3>자유게시판 일정 추가</h3>
	      </div>
	      <div class="content">
	        <form name="detailFrm" class="detail">
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
	                <input id="detailTitle" name="FREE_TITLE" spellcheck="false" required />
	              </td>
	            </tr>
	            <tr>
	              <td><span>날짜</span></td>
	              <td><%= FREE_DATE %></td>
	            </tr>
	            <tr>
	              <td><span>부서 / 이름</span></td>
	              <td colspan="3"><%= PART_TYPE %> / <%= MEM_NAME %></td>
	            </tr>
	            <tr>
	              <td><span class="memeo">내용</span></td>
	              <td colspan="3">
	                <textarea name="FREE_CONTENT" id="detailContent" rows="10" spellcheck="false"><%= FREE_CONTENT %></textarea>
	              </td>
	            </tr>
	            <tr>
	              <td><span>첨부파일</span></td>
	              <td colspan="3">
	              <%
	              if(!FREE_FILENAME.equals(""))
	              {
	              %>
	                <a id="filename" href="javascript:down('<%=FREE_FILENAME%>')">
	                  <%= FREE_FILENAME %>
	                </a>
	              <%
	              } else {
	              %>  
	              첨부 파일이 없습니다.
	              <%
	              }
	              %>
	              </td>
	            </tr>
	          </table>  	
	        </form>        		   
          	<div class="button">
             <% 
	            String id = (String)session.getAttribute("memId");
	            if (id != null && id.equals(MEM_ID)) {
	            %>
	          	<a href="freeupdate.jsp?=&FREE_NO=<%=FREE_NO%>">
	            	<button type="button">수정</button>
	            </a>
	            <a href="freedelete.jsp?=&FREE_NO=<%=FREE_NO%>">
		           <button type="button">삭제하기</button>
	            </a>
	            <%
	            } 
	            %>
	            <a href="free.jsp">
               	<button type="button">목록</button>
            	</a>
          </div>
	      </div>
	    </div>
	</div>

	</section>
	<form name="downFrm" action="freedownload.jsp" method="post">
		<input type="hidden" name="FREE_FILENAME">
	</form>

<script src="../script/free.js"></script>
</body>
</html>

