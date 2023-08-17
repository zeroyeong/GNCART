<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="event.EventBean"%>
<%@ page import="java.util.Vector"%>
<jsp:useBean id="eMgr" class="event.EventMgr" />
<%	
	  request.setCharacterEncoding("UTF-8");
	  
      int totalRecord=0; //전체레코드수
	  int numPerPage=10; // 페이지당 레코드 수 
	  int pagePerBlock=15; //블럭당 페이지수 
	  
	  int totalPage=0; //전체 페이지 수
	  int totalBlock=0;  //전체 블럭수 

	  int nowPage=1; // 현재페이지
	  int nowBlock=1;  //현재블럭
	  
	  int start=0; //디비의 select 시작번호
	  int end=10; //시작번호로 부터 가져올 select 갯수
	  
	  int listSize=0; //현재 읽어온 게시물의 수

	String keyWord = "", keyField = ""; 
	Vector<EventBean> vlist = null;
	
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if (request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	 start = (nowPage * numPerPage)-numPerPage;
	 end = numPerPage;
	
	totalRecord = eMgr.getTotalCount(keyField, keyWord);
	
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/event.css">
<!--Boxicons CDN Link-->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
	<!-- sidebar include -->
	<jsp:include page="../index/sidebar.jsp" flush="false" />

	<section class="home-section">
		<!-- top include -->
		<jsp:include page="../index/top.jsp" flush="false" />

		<!--home-content-->

		<div class="container-fluid">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h5>행사사진</h5>
				</div>
				<div class="card-body">
					<div>
						<form method="post" action="#" id="eventForm">
							<table align="center" width="600" cellpadding="3">
							<tr>
				<td align="center" colspan="2">
				<%
					//BoardMgr 클래스 getBoardList() 메서드 호출 
					  vlist = eMgr.getBoardList(keyField, keyWord, start, end);
				
					  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
					  
					  if (vlist.isEmpty()) {
						out.println("등록된 게시물이 없습니다.");
						
					  } else {
				%>
					  <table width="100%" cellpadding="2" cellspacing="0">
						<tr align="center" bgcolor="#D0D0D0" height="120%">
							<td>번 호</td>
							<td>제 목</td>
							<td>날 짜</td>
							<td>조회수</td>
							<td>이 름</td>
						</tr>
						<%
							  for (int i = 0;i<numPerPage; i++) {
								if (i == listSize) break;
								EventBean bean = vlist.get(i);
								int EVENT_NO = bean.getEVENT_NO();
								String EVENT_TITLE = bean.getEVENT_TITLE();
								String EVENT_DATE = bean.getEVENT_DATE();
								int EVENT_HIT = bean.getEVENT_HIT();
								String MEM_NAME = bean.getMEM_NAME();
								String EVENT_SUB = bean.getEVENT_SUB();
								String EVENT_FILENAME = bean.getEVENT_FILENAME();
								String[] filenames = EVENT_FILENAME.split(",");
						%>
						<tr>
							<td align="center">
								<%=totalRecord-((nowPage-1)*numPerPage)-i%>
							</td>
							<td>
							  <a href="javascript:read('<%=EVENT_NO%>')">><img src='../filestorage/<%=filenames[0]%>' width="300" height="300" onerror="" /><%=EVENT_TITLE%></a>
							</td>
							<td align="center"><%=EVENT_DATE%></td>
							<td align="center"><%=EVENT_HIT%></td>
							<td align="center"><%=MEM_NAME%></td>
							</tr>
						<%}//for%>
					</table> <%
	 			}//if
	 		%>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br /><br /></td>
			</tr>
			<tr>
				<td>
		<!-- 페이징 및 블럭 처리 --> 
				<%
	   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
	   				  int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
	   				  //하단 페이지 끝번호
	   				  if(totalPage !=0){
	    			  	if (nowBlock > 1) {%>
	    			  		<a href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%>&nbsp; 
	    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
	     			     	<a href="javascript:pageing('<%=pageStart %>')"> 
	     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
	     					[<%=pageStart %>] 
	     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
	    					<%}//for%>&nbsp; 
	    					<%if (totalBlock > nowBlock ) {%>
	    					<a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
	    			<%}%>&nbsp;  
	   			<%}%>
	 	<!-- 페이징 및 블럭 처리 -->
				</td>
			</tr>
		</table>
						</form>
		<!-- 검색 폼 -->
		<hr width="600"/>
		<form name="searchFrm"  method="get" action="event.jsp">
		<table width="600" cellpadding="4" cellspacing="0">
	 		<tr>
	  			<td align="center" valign="bottom">
	   				<select name="keyField" size="1" >
	    				<option value="MEM_NAME"> 이 름</option>
	    				<option value="EVENT_TITLE"> 제 목</option>
	    				<option value="EVENT_CONTENT"> 내 용</option>
	   				</select>
	   				<input size="16" name="keyWord">
	   				<input type="button"  value="찾기" onClick="javascript:check()">
	   				<input type="hidden" name="nowPage" value="1">
	  			</td>
	 		</tr>
		</table>
		</form>
		<!-- 검색 폼 -->
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true"> 
			<input type="hidden" name="nowPage" value="1">
		</form>
		<form name="readFrm" method="get">
			<input type="hidden" name="EVENT_NO"> 
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField%>"> 
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
						<div id="btns">
						<%
						Integer acNo = (Integer) session.getAttribute("acNo");
						Integer partNo = (Integer) session.getAttribute("partNo");
							
						if (acNo == null || partNo == null) {
						    out.print("<script>");
						    out.print("alert('로그인을 해주세요');");
						    out.print("location.href = '../login.jsp';");
						    out.print("</script>");
						}
						else if (acNo == 2 || partNo == 1) { %>
							<button type="button"><a href="eventWrite.jsp">글쓰기</a></button>
							<%}%>
						</div>
					</div>
				</div>
			</div>
	</section>
	<script src="../script/indexScript.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
	<script>	
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value){
		 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		 document.readFrm.submit();
	} 
	
	function read(EVENT_NO){
		document.readFrm.EVENT_NO.value=EVENT_NO;
		document.readFrm.action="eventView.jsp";
		document.readFrm.submit();
	}
	
	function check() {
	     if (document.searchFrm.keyWord.value == "") {
	   alert("검색어를 입력하세요.");
	   document.searchFrm.keyWord.focus();
	   return;
	     }
	  document.searchFrm.submit();
	 }
</script>
</body>
</html>