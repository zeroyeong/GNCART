<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="freeBoard.BoardBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="freeBoard.BoardMgr" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/free.css">
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
          <h3>자유게시판</h3>
    	  </div>
 			<div class="content">
 				<div class="tableMenu">
 				
 				 </div>
 				
 					<form name="listFrm" method="post" action="freedelete.jsp">
					<table>
				  	  <colgroup>
                		<col class="col2" />
            			<col class="col3" />
             			<col class="col4" />
             			<col class="col5" />
             			<col class="col6" />
           			 </colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>등록일</th>
							</tr>
						</thead>
					<tboody>
											<%
                  
				Vector<BoardBean> vlist = bMgr.getBoardList();
                  if (vlist.isEmpty()) {
                	  out.println("등록된 게시글이 없습니다.");
                  } else {
                  %>

						<%
								for (int i=0; i<vlist.size(); i++) { 
								BoardBean bean = new BoardBean();
								bean = vlist.get(i);
								int FREE_NO = bean.getFREE_NO();
								String FREE_TITLE = bean.getFREE_TITLE();
								String FREE_DATE = bean.getFREE_DATE();
								int FREE_HIT = bean.getFREE_HIT();
								int MEM_NO = bean.getMEM_NO();
								String MEM_ID = bean.getMEM_ID();
								String MEM_NAME = bean.getMEM_NAME();
						%>
						<tr>
							<td><%=FREE_NO %></td>
							<td><a href="freeread.jsp?FREE_NO=<%=FREE_NO%>"><%=FREE_TITLE%></a></td>
							<td><%=MEM_NAME %></td>
							<td><%=FREE_HIT %></td>
							<td><%=FREE_DATE%></td>
						</tr>
							<%						
									} //for
								} //if 
							%>
						</tboody>
					</table>
						
						<div class="bottomMenu">
						 <div class="empty"></div>
          				  <ul class="pagination" id="pagenation">
            
           					 </ul> 
           				   <div class="button"> 
							<button type="button">
								<a href="freeadd.jsp">글쓰기</a>
							</button>
							<button class="del" type="button" onclick="submitForm()">삭제하기</button>
						</div>
					 </div>
						
					</form>
		

  </div>

  </section>
  
   	<form name="listFrm" method="post"></form>
	<form name="viewFrm" method="get"><input type="hidden" name="FREE_NO"></form>
  
  
<script src="https://code.jquery.com/jquery-3.7.0.js" 
integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" 
crossorigin="anonymous"></script>  
<script src="../script/indexScript.js"></script>
<script src="../script/free.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
</body>
</html>
<script>
$(document).ready(function () {
    $('#example').DataTable({
        "order" : [[0, "desc"]],
        "language": {
            "decimal":        "",
            "emptyTable":     "등록된 게시글이 없습니다.",
            "info":           "최근 등록된 _END_개의 게시글 (총 게시글 수 _TOTAL_개)",
            "infoEmpty":      "0 개 항목 중 0 ~ 0 개 표시",
            "infoFiltered":   "(_MAX_ 총 항목에서 필터링 됨)",
            "infoPostFix":    "",
            "thousands":      ",",
            "lengthMenu":     "_MENU_개씩 보기",
            "loadingRecords": "로드 중 ...",
            "processing":     "처리 중 ...",
            "search":         "검색:",
            "zeroRecords":    "일치하는 검색결과가 없습니다",
            "paginate": {
                "first":      "처음",
                "last":       "마지막",
                "next":       "다음",
                "previous":   "이전"
            }}
    });
});
</script>
