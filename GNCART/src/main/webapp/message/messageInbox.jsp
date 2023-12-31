<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="message.MsgBean"%>
<jsp:useBean id="msgMgr" class="message.MsgMgr" /> 

<% 
//로그인 안했을 시 로그인 페이지로 리다이렉트 
if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null) {
	response.sendRedirect("../login.jsp");
	return; 
}

//캐시 설정(로그아웃 하고 뒤로가기시 인덱스 접근 차단)
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

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
	<div class="home-content">
		<div class="container">
	      <div class="title">
	        <h3>받은 메시지</h3>
		      <div class="btns">
			      <a href="messageInbox.jsp"><button type="button">받은 편지함</button></a>
			      <a href="messageSent.jsp"><button type="button">보낸 편지함</button></a>
		      </div>
	      </div>
		<div class="content">
	        <form name="msgFrm" method="post" action="msgDelete.jsp">
	          <table>
	            <colgroup>
					<col class ="col1"/>
					<col class ="col2"/>
					<col class ="col3"/>
					<col class ="col4"/>
					<col class ="col5"/>
					<col class ="col6"/>
	            </colgroup>
	            <thead>
	              <tr>
	                <th></th>
	                <th>No.</th>
	                <th>제목</th>
	                <th>보낸사람</th>
	                <th>받은시간</th>
	                <th>확인여부</th>
	              </tr>
	            </thead>
	            <tbody>
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
					  <td><input class="checkbox" name="check" type="checkbox" value="<%= msg_no %>"></td>
					  <td><%= cnt %></td>
					  <td><a id="" href="messageDetail.jsp?msg_no=<%= msg_no %>&pageName=<%= pageName %>"><%= msg_title %></a></td>
					  <td><%= msg_fromParyType %> <%= msg_fromName %></td>
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
	          <div class="bottomMenu">
	            <div class="empty"></div>
          	  	<ul class="pagination" id="pagenation">
            
              	</ul>
	            <div class="button">
					<a href="messageWrite.jsp">
						<button type="button">보내기</button>
					</a>
					<button type="button" onclick="deleteBtn()">삭제하기</button>
           		 </div>
	          </div>
	          		<input type="hidden" name="pageName" value="<%=pageName%>">
	        </form>
	      </div> 
		</div>
	</div>
	</section>
	
<script src="../script/boardPagenation.js"></script>
<script src="../script/messageDelBtn.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

</body>
</html>