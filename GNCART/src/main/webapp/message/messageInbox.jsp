<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="message.MsgBean"%>
<jsp:useBean id="msgMgr" class="message.MsgMgr" /> 

<% 
request.setCharacterEncoding("UTF-8");
Vector<MsgBean> msglist = null; 

if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null) {
	response.sendRedirect("../login.jsp");
	return;
}
String memId = (String)session.getAttribute("memId");
String memName = (String)session.getAttribute("memName");
int memNo = (int)session.getAttribute("memNo");

String pageName = "messageInbox";
int cnt = 1;

%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/messageInbox.css?after3">


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
				<div id="messageBox">
					<h5>받은 메시지</h5>
					<div class="msgBtn">
					<button type="button"><a href="messageInbox.jsp">받은 편지함</a></button>
					<button type="button"><a href="messageSent.jsp">보낸 편지함</a></button>
					</div>
				</div>
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
								<th>받은시간</th>
								<th>확인여부</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>순서</th>
								<th>보낸사람</th>
								<th>제목</th>
								<th>받은시간</th>
								<th>확인여부</th>
							</tr>
						</tfoot>

						<tbody>
							<tr>
								<td><input class="checkbox"  type="checkbox" value="">0</td>
								<td>김말쑥</td>
								<td><a href="#">누구누구 결혼식</a></td>
								<td>2023/12/25</td>
								<td>2023-12-25</td>
							</tr>

							<%												
								msglist = msgMgr.msgInboxList(memName);								
								for(int i=0; i < msglist.size(); i++){
									
									MsgBean bean = new MsgBean();
									bean = msglist.get(i);
									int msg_no = bean.getMsg_no();
									String msg_title = bean.getMsg_title();
									String msg_fromParyType = bean.getMsg_fromPartType();
									String msg_fromName = bean.getMsg_fromName();
									String msg_sendTime = bean.getMsg_sendTime();
									String msg_readTime = bean.getMsg_readTime();
									String msg_read = bean.getMsg_read();
									int msg_showcheck = bean.getMsg_showCheck();
									
									
									// 0이면 둘다 보이고 1이면 보낸사람이 지운상태 2이면 받은사람이 지운상태
									if(msg_showcheck == 0 || msg_showcheck == 1){ 
							%>
							<tr>
								<td><input class="checkbox" name="check" type="checkbox" value="<%= msg_no %>"><%= cnt %></td>
								<td><%= msg_fromParyType %> <%= msg_fromName %></td>
								<td><a id="" href="messageDetail.jsp?msg_no=<%= msg_no %>&pageName=<%= pageName %>"><%= msg_title %></a></td>
								<td><%= msg_sendTime %></td>
								<% 
								if(msg_read.equals("안읽음")){
								%>
								<td><%= msg_read %></td>
								<%											
								} else {
								%>
								<td><%= msg_readTime %></td>
								<%
								} //else
								%>
							</tr>									
							<%
							cnt++;  
									}//if
								}//for
							%>
						</tbody>
					</table>
						<input type="hidden" name="pageName" value="<%= pageName %>">
						
						<div id="btns">
							<button type="button"><a href="messageWrite.jsp">보내기</a></button>
							<button type="button" onclick="deleteBtn()">삭제하기</button>
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