<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<nav>
	<div class="alert-icon">
		<i class='bx bx-message-dots bx-flip-horizontal chatIcon'></i> 
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