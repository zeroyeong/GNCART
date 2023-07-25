<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeBean"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr"/>
<%
	request.setCharacterEncoding("UTF-8");

	int NOT_NO = Integer.parseInt(request.getParameter("NOT_NO"));
	
	nMgr.upHit(NOT_NO);
	
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
	
	session.setAttribute("bean", bean);//게시물을 세션에 저장
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="noticeWrite.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
  <!-- sidebar include -->	
  <jsp:include page="../index/sidebar.jsp" flush="false"/>	

<section class="home-section">
   <!-- top include -->
  <jsp:include page="../index/top.jsp" flush="false"/>
	

  <!--home-content-->  
    <div class="home-content">
      <div id="container">
        <div id="title">
          <h2>공지사항</h2>
          <div id="writerInfo">
            <span>작성자 : <b><%=MEM_NAME %></b></span>
            <span>작성일 : <b><%=NOT_DATE %></b></span>
          </div>
        </div>
        
        <hr>
        
        <table>
          <tr>
            <td class="tableTitle">제목</td>
            <td colspan="3"><b>[<%=NOT_SUB%>]</b><%=NOT_TITLE %></td>
          </tr>
          <tr>
            <td class="tableTitle">작성자</td>
            <td><%=MEM_NAME %></td>
            <td class="tableTitle">해당부서</td>
            <td>부서1</td>
          </tr>
          <tr>
            <td class="tableTitle detail">상세내용</td>
            <td colspan="3"><%=NOT_CONTENT %></td>
          </tr>
          <tr>
            <td class="tableTitle">첨부파일</td>
            <td colspan="3">
	     	<% if( NOT_FILENAME !=null && !NOT_FILENAME.equals("")) {%>
	  		<a href="javascript:down('<%=NOT_FILENAME%>')"><%=NOT_FILENAME%></a>
	  		 &nbsp;&nbsp;<font color="blue">(<%=NOT_FILESIZE%>KBytes)</font>  
	  		 <%} else{%> 등록된 파일이 없습니다.<%}%>
            </td>
          </tr>
        </table>
        <div>
          <a id="clickC" href="#" class="notice-btn">공지사항 확인하기</a>
        </div> 
        <div id="btns" style="text-align:right">
          <button><a href="noticeRevise.jsp?=&NOT_NO=<%=NOT_NO%>" >수정하기</a></button>
          <button><a href="noticeDelete.jsp?=&NOT_NO=<%=NOT_NO%>">삭제하기</a></button>
          <button><a href="notice.jsp">뒤로가기</a></button>
        </div>
      </div>
     
    </div>
  </section>
<form name="downFrm" action="noticeDownload.jsp" method="post">
		<input type="hidden" name="NOT_FILENAME">
</form>

<script src="../script/indexScript.js"></script>  
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
<script src="noticeJs.js"></script>
</body>
</html>