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
  <link rel="stylesheet" href="../css/freeadd.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<%
	  request.setCharacterEncoding("UTF-8");

	  int FREE_NO = Integer.parseInt(request.getParameter("FREE_NO"));
	  //read.jsp 페이지 가 호출되면 해당 게시물의 조회수를 증가 시킨다.
	  //BoardMgr 클래스 upCount() 메서드 호출, 매개변수는 게시물의 num 으로 한다.
	  bMgr.upHit(request, response);//조회수 증가 
	  
	  //BoardMgr 클래스의 getBoard() 메서드 호출하여 게시물을 가져온다. 매개변수는 게시물의 num으로 함.
	  //BoardBean 클래스 타입의 객체 bean 을 생성하고, 게시물 조회 결과를 대입한다.
	  BoardBean bean = bMgr.getBoard(FREE_NO);//게시물 가져오기
	  
	  //bean 객체 에서 getter 메서드를 이용하여 파라미터를 가져와서 화면에 출력하기 위해 각 변수에 대입한다.
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
					<h2>자유게시판</h2>
					<div id="writerInfo" style="text-align: right">
						<span>작성자 : <b><%=MEM_NAME %></b></span> <span>작성일 : <b><%=FREE_DATE %></b></span>
					</div>
				</div>

				<hr>

				<table>
					<tr>
						<td class="tableTitle">제목</td>
						<td colspan="3"><b>[<%=FREE_TITLE%>] </b><%=FREE_TITLE %></td>
					</tr>
					<tr>
						<td class="tableTitle">작성자</td>
						<td><%=MEM_NAME %></td>
						<td class="tableTitle">해당부서</td>
						<td><%=PART_TYPE %></td>
					</tr>
					<tr>
						<td class="tableTitle detail">상세내용</td>
						<td colspan="3"><%=FREE_CONTENT %></td>
					</tr>
					<tr>
						<td class="tableTitle">첨부파일</td>
						<td colspan="3">
							<% if( FREE_FILENAME !=null && !FREE_FILENAME.equals("")) {%> <a
							href="javascript:down('<%=FREE_FILENAME%>')"><%=FREE_FILENAME%></a>
							&nbsp;&nbsp;<font color="blue">(<%=FREE_FILESIZE%>KBytes)
						</font> <%} else{%> 등록된 파일이 없습니다.<%}%>
						</td>
					</tr>
					
					
				<form method="post" action="replyAction.jsp?MEM_NO=<%= MEM_NO %>">

				
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<%-- 홀,짝 행 구분 --%>
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #11101d; text-align: center;"><font color="white">댓글</th>
						</tr>
					</thead>
					<tbody>
					
						<%
							replyDAO replyDAO=new replyDAO();
							ArrayList<reply> list=replyDAO.getList(MEM_NO, pageNumber);
							for(int i=list.size()-1;i>=0;i--){
							
						%>

						<tr>
							<td style="text-align: left;"><%= list.get(i).getReplyContent() %></td>
							<td style="text-align: right;"><%= list.get(i).getFREE_NO() %>
							<a href="freeupdate.jsp?FREE_NO=<%= FREE_NO %>" class="btn">수정</a>
							<a href="freeupdate.jsp?FREE_NO=<%= FREE_NO %>" class="btn ">삭제</a>
							</td>
						</tr>
					
						<%
								}
						%>
						<td><textarea type="text" class="form-control"
								placeholder="댓글을 입력하세요." name="replyContent" maxlength="2048"></textarea></td>
					
					</tbody>
				</table>
				<input type="submit" class="btn" value="댓글입력">
			</form>
			<br>
			
			<%
				if(MEM_NAME!=null && MEM_NAME.equals("")) {
			%>
				<a href="freeupdate.jsp?FREE_NO=<%= FREE_NO %>" class="btn btn-primary">수정</a>
				<a href="freedelete.jsp?FREE_NO=<%= FREE_NO %>" class="btn btn-primary">삭제</a>
			
			<%
			} 
			%>
			
					
					
				</table>
				<div id="btns" style="text-align: right">
					<% 
          String id = (String)session.getAttribute("memId");
          if (id != null && id.equals(MEM_ID)) {
        %>
					<button><a href="freeupdate.jsp?=&FREE_NO=<%=FREE_NO%>">수정하기</a></button>
					<button><a href="freedelete.jsp?=&FREE_NO=<%=FREE_NO%>">삭제하기</a></button>
					<% } %>
					<button><a href="free.jsp">뒤로가기</a></button>
				</div>
			</div>
		
		</div>

	<form name="downFrm" action="freedownload.jsp" method="post">
		<input type="hidden" name="filename">
	</form>
	

  </section>
  
  			</table>


			
		</div>
	</div>


<script src="../script/free.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script src="../script/indexScript.js"></script>
</body>
</html>
