<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="familyEvent.ConBean"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" />  

<% 
request.setCharacterEncoding("UTF-8");
Vector<ConBean> blist = null; 
blist = conMgr.getBoardList();
%> 
<!DOCTYPE html>
<html lang="ko">
<head> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/NEWcondolences.css">


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
	        <h3>경조사 알림</h3>
	        <!-- <div class="button">
	          상단 버튼을 원하시는 분들은
	          여기다가 추가하면 자동스타일 적용 됩니당
	        </div> -->
	      </div>
	      <div class="content">       
	        <div class="tableMenu">
	           <div class="button">
	             <button class="del" type="button" onclick="deleteBtn()">삭제</button>
	          </div> 
	          <ul class="record">
	            <li>total</li>
	            <li><%= blist.size() %></li>
	          </ul>
	        </div>
	        <form name="listFrm" method="post" action="conDelete.jsp">
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
	                <th>작성자</th>
	                <th>조회수</th>
	                <th>등록일</th>
	              </tr>
	            </thead>
	            <tbody>
	              <tr>
	                <td><input type="checkbox" /></td>
	                <td>0</td>
	                <td>누구누구 결혼식</td>
	                <td>작성자</td>
	                <td>1--</td>
	                <td>2023-08-17</td>
	              </tr>
	              <%	                       
	              if(!blist.isEmpty()){
	                                              
	              for(int i = 0; i < blist.size(); i++){
	                ConBean bean = new ConBean(); 
	                bean = blist.get(i);
	                int con_no = bean.getCon_no();
	                String title = bean.getCon_title();
	                String regdate = bean.getCon_regdate();
	                String wtriter = bean.getMem_name();
	                int hit = bean.getCon_hit();
	                int mem_no = bean.getMem_no();
	              %>
	              <tr>
	                <td><input class="checkbox" name="check" type="checkbox" value="<%=con_no%>"></td>
	                <td><%=con_no%></td>
	                <td><a href="condolencesDetail.jsp?con_no=<%= con_no %>"><%=title%></a></td>
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
	          <div class="bottomMenu">
	            <div class="empty"></div>
	            <ul class="pagination">
	              <li class="active"><a href="">1</a></li>
	              <li><a href="">2</a></li>
	              <li><a href="">3</a></li>
	            </ul>
	            <div class="button">
	              <button type="button" ><a href="condolencesAdd.jsp">글쓰기</a></button>
	              <button class="del" type="button" onclick="deleteBtn()">삭제</button>
	            </div>
	          </div>
	        </form>
	      </div>
	    </div>
    </div>
			
 	</section>
 
<script src="../script/indexScript.js"></script>
<script src="../script/condolences.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

</body>
</html>