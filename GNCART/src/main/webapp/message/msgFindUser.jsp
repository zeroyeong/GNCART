<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector" %>
<%@page import="management.ManagementBean" %>
<jsp:useBean id="msgMgr" class="message.MsgMgr"/>
 
<%
request.setCharacterEncoding("UTF-8");
String keyWord = "";

if(request.getParameter("keyWord") != null){
	keyWord = request.getParameter("keyWord");
}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title> 
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/msgFindUser.css?asdfdff">
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
			<div id="container">
				<div id="title">
					<h2>지도 추가</h2>
				</div>

				<table>
				<form name="userFrm" method="post" action="msgFindUser.jsp">
					<tr>
						<td class="tableTitle">부서 / 이름</td>
						<td colspan="3">
							<div id="searchdiv">
								<input id="searchbar" placeholder="이름을 입력해 주세요" onClick="test()">
								<div id="btns">
									<button type="button" id="searchBtn" onClick="searchUser()">찾기</button>
								</div>
							</div>
						</td>
					</tr>				
					<input type="hidden" id="keyWord" name="keyWord" value="<%= keyWord %>">
				</form>	
					
					<tr id="allList">
						<td colspan="3">					
							<select id="selectAll" name="selectAll" onclick= "abctest()">
							<option> 선택해 주세요 </option>
					<%
						Vector<ManagementBean> mlist = msgMgr.userSearch();
					
						for(int i=0; i<mlist.size(); i++){

							ManagementBean mbean = new ManagementBean();
							mbean = mlist.get(i);
							
							String MEM_NAME = mbean.getMEM_NAME();
							String PART_TYPE = mbean.getPART_TYPE();					
					%>
							<option value= "<%= i+1 %>" ><%= PART_TYPE %> / <%= MEM_NAME %></option>
					<%
					}//for
					%>
							</select>
						</td>
					</tr>
						<tr id="searchList" style="display: none" >
						<td colspan="3">					
							<select id="selectKeyword" name="selectKeyword" onclick= "abctest()">
					<%
						Vector<ManagementBean> ulist = msgMgr.userFind(keyWord); 
						for(int i=0; i<ulist.size(); i++){
							ManagementBean ubean = new ManagementBean();
							ubean = ulist.get(i);	
							
							String MEM_NAME = ubean.getMEM_NAME();
							String PART_TYPE = ubean.getPART_TYPE();
					%>
						
							<option><%= PART_TYPE %> / <%= MEM_NAME %></option>
					<%
						}
					%>				
							</select>
						</td>
					</tr>
				</table>
				
				<div id="btns">
					<button onClick="sendUser()">저장</button>
				</div>
				<input type="hidden" id="user" name="user">
				
			</div>
		</div>
	</section>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24e23b8a98c1750309dd34a0c1ea57d3&libraries=services"></script>
	<script src="../script/indexScript.js"></script>
	<script src="../script/msgFindUser.js?after2"></script>

</body>
</html>