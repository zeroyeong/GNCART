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
  <link rel="stylesheet" href="../css/free.css?asd">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

<!-- sidebar include -->	
<jsp:include page="../index/sidebar.jsp" flush="false"/>	

<section class="home-section">
<!-- top include -->
<jsp:include page="../index/top.jsp" flush="false"/>
	

<div class="home-content">
  <div class="container">
    <div class="title">
      <h3>경조사 알림</h3>
    </div>
    <div class="content">
      <form name="listFrm" method="post" action="freedelete.jsp">
        <table>
          <colgroup>
            <col class="col1" />
            <col class="col2" />
            <col class="col3" />
            <col class="col4" />
            <col class="col5" />
            <col class="col6" />
          </colgroup>
          <thead>
            <tr>
              <th></th>
              <th>No.</th>
              <th>제목</th>
              <th>작성자</th>
              <th>조회수</th>
              <th>등록일</th>
            </tr>
          </thead>
          <tbody>
            <%
            Vector<BoardBean> vlist = bMgr.getBoardList();
              if (vlist.isEmpty()) {
                out.println("등록된 게시글이 없습니다.");
              } else {
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
              <td>
                <input class="checkbox" name="check" type="checkbox" value="<%=FREE_NO%>"/>
              </td>
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
          </tbody>
        </table>
        <div class="bottomMenu">
          <div class="empty"></div>
          <ul class="pagination" id="pagenation">
          
          </ul>
          <div class="button">
            <a href="freeadd.jsp">
              <button type="button">글쓰기</button>
            </a>
            <button class="del" type="button" onclick="submitForm()">
              삭제하기
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>	

  </section>
  
   	<form name="listFrm" method="post"></form>
	<form name="viewFrm" method="get"><input type="hidden" name="FREE_NO"></form>
  
  
<script src="../script/free.js"></script>

</body>
</html>

