<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

int msg_no = Integer.parseInt(request.getParameter("msg_no"));
String pageName = request.getParameter("pageName");	

MsgBean bean = new MsgBean();	
bean = msgMgr.getMsg(msg_no);

String title = bean.getMsg_title();
String content = bean.getMsg_content();
String toPartType = bean.getMsg_toPartType();
String toName = bean.getMsg_toName();
String fromPartType = bean.getMsg_fromPartType();
String fromName = bean.getMsg_fromName();
String sendTime = bean.getMsg_sendTime();
String readTime = bean.getMsg_readTime(); 
String read = bean.getMsg_read();
int delCnt = bean.getMsg_delCnt();
String filename = bean.getMsg_file(); 

//받은 메일함에서 열때
if(pageName.endsWith("messageInbox") && read.equals("안읽음")){
	msgMgr.setRead(msg_no);
} 
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/messageDetail.css">
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
	        <h3>메세지 내용</h3>
	      </div>
	      <div class="content">
	        <h3 class="caption"><%= title %></h3>
	        <form name="msgFrm" method="post" action="msgDelete.jsp" class="detail">
	          <table>
	            <colgroup>
	              <col class="col1" />
	              <col class="col2" />
	              <col class="col3" />
	              <col class="col4" />
	            </colgroup>
		          <tr>
		            <th>제목</th>
		            <td colspan="3"><%= title %></td>
		          </tr>
		          <tr>
		            <th>보낸사람</th>
		            <td><%= fromName %></td>
		            <th>해당부서</th>  
		            <td><%= fromPartType %></td>
		          </tr>
		          <tr>
		            <th>받는사람</th> 
		            <td><%= toName %></td>
		            <th>해당부서</th>
		            <td><%= toPartType %></td>
		          </tr>
		          <tr>
		            <th class="board-content">내용</th>
		            <td colspan="3"><textarea spellcheck="false"><%= content %></textarea></td>
		          </tr>
		          <%
		          if(filename != null && !filename.isEmpty()){  
		          %>
	            <tr>
		            <th>첨부파일</th>
		            <td colspan="3">
		              <a id="filename" href="msgFiledown.jsp?filename=<%=filename%>"><%= filename %></a>
		            </td>
		          </tr>
	            <%
	            }
	            %>
	          </table>
		        <div class="button">
		          <%
		          if(pageName.equals("messageInbox")){
		          %>
		          <a href="messageReply.jsp?fromPartType=<%= fromPartType %>&fromName=<%= fromName %>">
		        	  <button type="button">답장하기</button>
		          </a>
		          <%
		          }
		          %>
		         <a>
		         	<button type="button" onclick="deleteBtn()">삭제하기</button>
		         </a>
		         <a href="<%= pageName %>.jsp">
		         	<button type="button">목록</button>
		         </a>
		        </div>
	          <input type="hidden" name="read" value="읽음"> 
	          <input type="hidden" name="msg_no" value="<%= msg_no %>"> 
	          <input type="hidden" name="pageName" value="<%= pageName %>">
	        </form>
	      </div>
	    </div>
	</div>
	</section>
	
<script src="../script/messageDelBtn.js"></script>
</body>
</html>