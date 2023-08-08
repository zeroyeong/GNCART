<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

	<div class="memberTop">
		<h2 class="title">관리자페이지</h2>
		<div class="memberMenu">
			<button onclick="memberList()">사용자 조회</button>
			<button onclick="addMember()">사용자 추가</button>
		</div>
	</div>
	
	<script>
	function memberList(){
		location.href="memberList.jsp";
	}
	
	function addMember(){
		location.href="newMember.jsp";
	}
	</script>