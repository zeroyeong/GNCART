<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeBoard.BoardBean"%>
<% 
	  //read.jsp 페이지에서 이동한 num, nowPage 파라미터를 받아 각 각 변수에 저장
	  int FREE_NO = Integer.parseInt(request.getParameter("FREE_NO"));

	  //session에 저장된 bean객체를 이용해서 게시물 정보를 각 각 변수에 저장 
	  BoardBean bean = (BoardBean)session.getAttribute("bean");
	  String FREE_TITLE = bean.getFREE_TITLE();
	  String MEM_NAME = bean.getMEM_NAME(); 
	  String FREE_CONTENT = bean.getFREE_CONTENT(); 
	  String FREE_DATE = bean.getFREE_DATE();
	  int MEM_NO = bean.getMEM_NO();
	  int PART_NO = bean.getPART_NO();
	  String MEM_ID = bean.getMEM_ID();
	  
	  String Part = (String)session.getAttribute("parttype");
	  int partno = (int)session.getAttribute("partNo");
	   
%>
<!DOCTYPE html>
<html>
<head> 
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/freeupdate.css">
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
		<div class="container">
	      <div class="title">
            <h3>자유게시판 수정</h3>
        </div>
	<div class="content">
	<!-- boardUpdate 로 url맵핑된 서블릿으로 이동한다. -->
	<form name="updateFrm" method="post" action="boardUpdate">
	<table>
      <colgroup>
      <col class="col1" />
      <col class="col2" />
      <col class="col3" />
      <col class="col4" />
	  </colgroup>
	
	            <tr>
	              <td>제목</td>
	              <td colspan="3"><input id="detailTitle" name="FREE_TITLE" value="<%=FREE_TITLE%>"required></td>
	            </tr>
	            <tr>
	              <td>날짜</td>
	              <td>
	                <input type="date" name="FREE_DATE" value="<%=FREE_DATE%>" />
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
	                <textarea id="detailContent" name="FREE_CONTENT" rows="10"><%=FREE_CONTENT%></textarea>
	              </td>
	            </tr>
	            
			</table>
	          <div class="button"> 
	            <button>수정</button>
	            <button type="reset">리셋</button>
	          	  <a href="javascript:history.back()">
	            <button>뒤로</button></a>
	          </div>
	          <input type='hidden' name="FREE_NO" value="<%=FREE_NO%>">
	    </form>
	    </div> 
	   </div>
	</div>
	</section>
	
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="../script/indexScript.js"></script>
	
</body>
</html>