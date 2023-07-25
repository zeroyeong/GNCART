<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="familyEvent.ConBean"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" />  

<% 
request.setCharacterEncoding("UTF-8");
Vector<ConBean> blist = null; 

%> 
<!DOCTYPE html>
<html lang="ko">
<head> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/condolences.css">


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
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h5>경조사 알림</h5>
			</div>
			<div class="card-body">
				<div>
				<form name="listFrm" method="post" action="conDelete.jsp">
					<table id="example" class="table table-striped" style="width: 100%">
						<thead>
							<tr>
								<th>등록순서</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>등록순서</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>등록일</th>
							</tr>
						</tfoot>

						<tbody>
							<tr>
								<td><input id="checkbox" type="checkbox">0</td>
								<td><a href="#">누구누구 결혼식</a></td>
								<td>작성자 - 누구누구</td>
								<td>1004</td>
								<td>2023/12/25</td>
							</tr>

							<%
								blist = conMgr.getBoardList();
								
								if(!blist.isEmpty()){
																								
								for(int i = 0; i < blist.size(); i++){
									ConBean bean = new ConBean(); 
									bean = blist.get(i);
									int con_no = bean.getCon_no();
									String title = bean.getCon_title();
									String regdate = bean.getCon_regdate();
									String wtriter = bean.getMem_name();
									int hit = bean.getCon_hit();												
							%>
							<tr>
								<td><input class="checkbox" name="check" type="checkbox" value="<%=con_no%>"><%= con_no %></td>
								<td><a href="condolencesDetail.jsp?con_no=<%=con_no %>"><%=title%></a></td>
								<td><%=wtriter%></td>
								<td><%=hit%></td>
								<td><%=regdate%></td>
							</tr>									
							<%						
									} //for
								} //if 
							%>
						</tbody>
					</table>
						
						<div id="btns">
							<button type="button">
								<a href="condolencesAdd.jsp">글쓰기</a>
							</button>
							<button type="button" onclick="deleteBtn()">
								삭제하기
							</button>
						</div>
						<input type="hidden" name ="con_no">
					</form>
				</div>
			</div>
		</div>
	</div>
 </section>
 
<script src="../script/indexScript.js"></script>
<script src="../script/condolences.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
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


</body>
</html>