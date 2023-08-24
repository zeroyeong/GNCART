<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="familyEvent.ConBean"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" />

<%    	
   	int con_no = Integer.parseInt(request.getParameter("con_no"));
	ConBean bean = new ConBean(); 
	conMgr.upCount(con_no);
	bean = conMgr.getBoard(con_no);
	String title = bean.getCon_title();
	String content = bean.getCon_content();
	String regdate = bean.getCon_regdate();
	String type = bean.getCon_type();
	String userPart = bean.getCon_userPart();
	String userName = bean.getCon_userName();
	String desdate = bean.getCon_desdate();
	String location = bean.getCon_location(); 
	String map = bean.getCon_map();
	String filename = bean.getCon_file();
	String writer = bean.getMem_name();
	int hit = bean.getCon_hit();
	int mem_no = bean.getMem_no();
	String part_type = bean.getPart_type();
	
	int memNo = (int)session.getAttribute("memNo");	
	int acNo = (int)session.getAttribute("acNo");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/condolencesDetail.css?Asddddfddd">
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
	        <h3>경조사 일정</h3>
	        <div class="writer">
	          <ul> 
	            <li>작성자</li>
	            <li><%= part_type %></li>
	            <li><%= writer %></li>
	          </ul>
	          <ul>
	            <li>작성일</li>
	            <li><%= regdate %></li>
	          </ul>
	        </div>
	      </div>
	      <div class="content">
	        <h3 class="caption"><%= title %></h3>
	        <form name="detailFrm" method="post" action="conDelete.jsp" class="detail">
	          <table>
	            <colgroup>
	              <col class="col1" />
	              <col class="col2" />
	              <col class="col3" />
	              <col class="col4" />
	            </colgroup>
	            <tr>
	              <th>종류</th>
	              <td><%= type %></td>
	              <th>날짜</th>
	              <td><%= desdate %></td>
	            </tr>
	            <tr>
	              <th>부서 / 이름</th>
	              <td colspan="3"><%= userPart %> / <%= userName %></td>
	            </tr>
	            <tr>
	              <th>장소 및 주소</th>
	              <td colspan="3">
	                <%= location %>
	              </td>
	            </tr>
	            <tr>
	              <th class="board-content">내용</th>
	              <td colspan="3"><textarea spellcheck="false"><%= content %></textarea></td>
	            </tr>
	            <%
	            if(map != null && !map.isEmpty()){  
	            %>
	            <tr>
	              <th>지도</th>
	              <td colspan="3">
	                <div id="map"></div>
	              </td>
	            </tr>
	            <%
	            }
	            %>
	            <%
			    if(filename != null && !filename.isEmpty()){  
				%>
	            <tr>
	              <th>첨부파일</th>
	              <td colspan="3">
	                <a id="filename" href="condolencesFiledown.jsp?filename=<%=filename%>"><%= filename %></a
	                >
	              </td>
	            </tr>
	            <%
	            }
	            %>
	          </table>
	          <div class="button">
	            <% 
	            if(mem_no == memNo){ 
	            %>
	          	<a href="condolencesRevise.jsp?con_no=<%=con_no%>">
	            	<button type="button">수정</button>
	            </a>
	            <%
	            } else if(mem_no == memNo || acNo == 2){
	            %>
	            <a><button type="button" onclick="deleteBtn()">삭제</button></a>
	            <%
	            } 
	            %>
             	<a href="condolences.jsp">
             		<button type="button">목록</button>
            	</a>
	          </div>
	          <input type="hidden" id="locationId" value="<%= location %>"/>
	          <input type="hidden" name="con_no" value="<%= con_no %>" />
	          <input type="hidden" name="pageName" value="condolencesDetail" />
	        </form>
	      </div>
	    </div>
	</div>
	</section>
	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24e23b8a98c1750309dd34a0c1ea57d3&libraries=services"></script>
<script src="../script/condolencesDetail.js"></script>

</body>
</html>