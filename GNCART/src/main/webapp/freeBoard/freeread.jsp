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
  <link rel="stylesheet" href="../css/freeread.css">
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
			<div id="container">
				<div id="title">
					<h3>자유게시판</h3>

				</div>

	      <div class="content">
	        <h3 class="caption"><%= FREE_TITLE %></h3>
	        <form name="detailFrm" class="detail">

	          <table>
	            <colgroup>
	              <col class="col1" />
	              <col class="col2" />
	              <col class="col3" />
	              <col class="col4" />
	            </colgroup>
	            <tr>
	              <th>날짜</th>
	              <td><%= FREE_DATE %></td>
	            </tr>
	            <tr>
	              <th>부서 / 이름</th>
	              <td colspan="3"><%= PART_TYPE %> / <%= MEM_NAME %></td>
	            </tr>
	            <tr>
	              <th class="board-content">내용</th>
	              <td colspan="3"><%= FREE_CONTENT %></td>
	            </tr>
	            <%
			    if(FREE_FILENAME != null && !FREE_FILENAME.isEmpty()){  
				%>
	            <tr>
	              <th>첨부파일</th>
	              <td colspan="3">
	                <a
	                  id="filename"
	                  href="javascript:down('<%=FREE_FILENAME%>')"
	                  ><%= FREE_FILENAME %></a
	                >
	              </td>
	            </tr>
	            <%
	            }
	            %>
	          </table>
	          

				
				<table>
					<%-- 홀,짝 행 구분 --%>
			
					<tr>댓글</th>
					<tbody>
					
						<%
							replyDAO replyDAO=new replyDAO();
							ArrayList<reply> list=replyDAO.getList(MEM_NO, pageNumber);
							for(int i=list.size()-1;i>=0;i--){
							
						%>

						<tr>
							<p style="text-align: left;"><%= list.get(i).getMEM_NAME() %></p>
							<p style="text-align: left;"><%= list.get(i).getReplyContent() %></p>
						<div>
							<a href="replyDeleteProc.jsp?replyNo=<%=list.get(i).getReplyNo() %>&FREE_NO=<%=FREE_NO %>" class="del">삭제</a>
						</div>
						</tr>
						<%
								}
						%>
					</tbody>
				</table>
			 </form>  
			<form method="post" action="replyAction.jsp">
				<input type="hidden" name="MEM_NO" value="<%=MEM_NO %>">
				<input type="hidden" name="FREE_NO" value="<%=FREE_NO %>">
				<textarea type="text" class="form-control" placeholder="댓글을 입력하세요." name="replyContent"></textarea>
				<input type="submit" value="댓글입력">
			</form>
 			
 			<div class="button">
	            <% 
	            String id = (String)session.getAttribute("memId");
	            if (id != null && id.equals(MEM_ID)) {
	            %>
	          	<a href="freeupdate.jsp?=&FREE_NO=<%=FREE_NO%>">
	            	<button type="button">수정</button>
	            </a>
	            <button type="button"><a href="freedelete.jsp?=&FREE_NO=<%=FREE_NO%>">삭제하기</a></button>
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

</body>
</html>
<script src="../script/free.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24e23b8a98c1750309dd34a0c1ea57d3&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script src="../script/indexScript.js"></script>
