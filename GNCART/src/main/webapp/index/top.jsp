<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="chat.ChatBean"%>
<%@page import="alert.AlertBean"%>
<%@page import="management.ManagementBean"%>
<jsp:useBean id="chatMgr" class="chat.ChatMgr" />
<jsp:useBean id="alertMgr" class="alert.AlertMgr" />
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<%
Vector<AlertBean> alist = new Vector<AlertBean>();

int alertNo = 0;
String fromName = "";
String massege = "";

String myName = (String) session.getAttribute("memName");
%>

<link rel="stylesheet" href="../css/chat.css">

<nav>
	<div class="alert-icon">
		<i class='bx bx-message-dots bx-flip-horizontal chatIcon' onclick="toggleChat()"></i>
		<div class="chatRedIcon"></div>
		<jsp:include page="../chat/chat.jsp" flush="false" />
		<i class='bx bx-bell' onclick="alertToggle()"></i>
		<div class="redIcon"></div>
		<div class="alertBell-dropdown">
			<ul id="alertList">
				<%
				alist = alertMgr.checkAlert(myName);
				for (int i = alist.size() - 1; i >= 0; i--) {
		            AlertBean abean = alist.get(i);
		            alertNo = abean.getALERT_NO();
		            fromName = abean.getALERT_FROM();
		            massege = abean.getALERT_MESSAGE();
				%>
				<li><a href="../auth/authHold.jsp?alertNo=<%=alertNo%>"><%=fromName%><%=massege%></a></li>
				<%
				} //for
				%>
			</ul>
		</div>
	</div>

	<div class="profile-details">
		<a href="#"><img src="../images/profile.jpg" alt="" /></a> 
		<span class="admin_name"><%=session.getAttribute("leLevel")%> <%=session.getAttribute("memName")%></span>
	</div>
</nav>

<script src="../script/webSocket.js"></script>    
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>     
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<script>
/*직급으로 결재신청 숨기기*/
document.addEventListener("DOMContentLoaded", function() {

	var userLevel = <%=session.getAttribute("leNo")%>;
	var authHoldLink = document.querySelector('a[href="../auth/authHold.jsp"]').parentNode;
	if (userLevel === 1 || userLevel === 2) {
		authHoldLink.style.display = "none";
	}
	
	//드랍다운 목록이 있을시에만 block
	var redIcon = document.querySelector('.redIcon');
	if (<%= alist.size() %> == 0) {
		redIcon.style.display = "none";
	}else{
		redIcon.style.display = "block";
	}
});
</script>