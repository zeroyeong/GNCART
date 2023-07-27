<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeBean"%>
<%@ page import="java.util.Vector"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/notice.css">
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
					<h5>공지사항</h5>
				</div>
				<div class="card-body">
					<div>
						<form method="post" action="noticeChk.jsp" id="noticeForm">
							<table id="example" class="table table-striped" style="width: 100%">
								<thead>
									<tr>
										<th><input type="checkbox" name="all" onclick="checkAll()"></th>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>등록날짜</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th></th>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>등록날짜</th>
									</tr>
								</tfoot>
								<tbody>
									<%
                  Vector<NoticeBean> vlist = null; 
                  vlist = nMgr.getBoardList();
                  if (vlist.isEmpty()) {
                	  out.println("등록된 게시글이 없습니다.");
                  } else {
                  %>
				<%    for (int i=0; i<vlist.size(); i++) { 
                      NoticeBean bean = vlist.get(i);
                      int NOT_NO = bean.getNOT_NO();
                      String NOT_TITLE = bean.getNOT_TITLE();
                      int NOT_HIT = bean.getNOT_HIT();
                      String NOT_DATE = bean.getNOT_DATE();
                      int MEM_NO = bean.getMEM_NO();
                      String MEM_NAME = bean.getMEM_NAME(); 
                      int NOTSUB_NO = bean.getNOTSUB_NO();
                      String NOT_SUB = bean.getNOT_SUB();
                      String MEM_ID = bean.getMEM_ID();
                  %>
									<tr>
										<td><input type="checkbox" name="chk" value="<%=NOT_NO %>,<%=MEM_ID %>"></td>
										<td><%=NOT_NO %></td>
										<td><a href="javascript:view('<%=NOT_NO%>')"><b>[<%=NOT_SUB%>] </b><%=NOT_TITLE %></a></td>
										<td><%=MEM_NAME %></td>
										<td><%=NOT_HIT %></td>
										<td><%=NOT_DATE%></td>
									</tr>
									<%} %>
								<%} %>
								</tbody>
							</table>
						</form>
						<div id="btns">
						<%
						int acNo = (int)session.getAttribute("acNo");
						int partNo = (int)session.getAttribute("partNo");
						
						if (acNo == 2 || partNo == 1) { %>
							<button type="button"><a href="noticeWrite.jsp">글쓰기</a></button>
							<%} %>
							<button type="button" onclick="submitForm()">삭제하기</button>
						</div>
					</div>
				</div>
			</div>
	</section>

	<from name="listFrm" method="post"></from>
	<form name="viewFrm" method="get"><input type="hidden" name="NOT_NO"></form>

	<script src="../script/indexScript.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
	<script src="../script/noticeScript.js"></script>
	<script src="../script/notice.js"></script>
</body>
</html>