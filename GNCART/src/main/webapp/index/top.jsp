<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="java.util.Vector"%>
<%@page import="chat.ChatBean"%>
<%@page import="management.ManagementBean"%>
<jsp:useBean id="chatMgr" class="chat.ChatMgr" /> 	
<jsp:useBean id="mMgr" class="login.MemberMgr" />

 <link rel="stylesheet" href="../css/chat.css">

<nav>
	<div class="alert-icon">
		<i class='bx bx-message-dots bx-flip-horizontal chatIcon' onclick="toggleChat()"></i> 
<%-- 				 <jsp:include page="../chat/chat.jsp" flush="false" /> --%>
		<i class='bx bx-bell' data-count="0" onclick="alertToggle()"></i>
		<div class="alertBell-dropdown">
			<ul id="alertList">
				<li>3</li>
				<li>3</li>
				<li>3</li>
			</ul>
		</div>
	</div>

	<div class="profile-details">
		<a href="#"><img src="../images/<%=session.getAttribute("memImg")%>" alt="" /></a> 
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
	var authHoldLink = document
			.querySelector('a[href="../auth/authHold.jsp"]').parentNode;

	if (userLevel === 1 || userLevel === 2) {
		authHoldLink.style.display = "none";
	}
	
});
</script>