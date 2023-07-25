<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="message.MsgBean"%>
<jsp:useBean id="msgMgr" class="message.MsgMgr" /> 

<% 
request.setCharacterEncoding("UTF-8");
Vector<MsgBean> msglist = null; 
 
%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/messageInbox.css">


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
				<form name="msgFrm" method="post" action="msgDelete.jsp">
					<table id="example" class="table table-striped" style="width: 100%">
						<thead>
							<tr>
								<th>순서</th>
								<th>보낸사람</th>
								<th>제목</th>
								<th>보낸시간</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>순서</th>
								<th>보낸사람</th>
								<th>제목</th>
								<th>보낸시간</th>
							</tr>
						</tfoot>

						<tbody>
							<tr>
								<td><input class="checkbox"  type="checkbox" value="">0</td>
								<td>김말쑥</td>
								<td><a href="#">누구누구 결혼식</a></td>
								<td>2023/12/25</td>
							</tr>

							<%							
								int cnt = 1;
								String fromName = "박말쑥";
								String pageName = "messageInbox.jsp";
								msglist = msgMgr.msgInboxList(fromName);								
								for(int i=0; i < msglist.size(); i++){
									
									MsgBean bean = new MsgBean();
									bean = msglist.get(i);
									int msg_no = bean.getMsg_no();
									String msg_title = bean.getMsg_title();
									String msg_toname = bean.getMsg_toname();
									String msg_sendtime = bean.getMsg_sendtime();
							%>
							<tr>
								<td><input class="checkbox" name="check" type="checkbox" value="<%= msg_no %>"><%= cnt %></td>
								<td><%= msg_toname %></td>
								<td><a id="" href="messageDetail.jsp?msg_no=<%= msg_no %>&pageName=<%= pageName %>"><%= msg_title %></a></td>
								<td><%= msg_sendtime %></td>
							</tr>									
							<%
							cnt++;  
								}
							%>
						</tbody>
					</table>
						<input type="hidden" name="pageName" value="<%= pageName %>">
						
						<div id="btns">
							<button type="button"><a href="messageWrite.jsp">보내기</a></button>
							<button type="button" onclick="deleteBtn()">
								삭제하기
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<script src="../script/indexScript.js"></script>
<script src="../script/messageInbox.js"></script>
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