<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="familyEvent.ConBean"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" />  
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
Vector<ConBean> blist = null; 
blist = conMgr.getBoardList();

String pageName = "condolences";

%> 
<!DOCTYPE html>
<html lang="ko">
<head>  
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/condolences.css">


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
        <form name="listFrm" method="post" action="conDelete.jsp">
          <table>
            <colgroup>
              <col class="col1" />
              <col class="col2" />
              <col class="col3" />
              <col class="col4" />
              <col class="col5" />
              <col class="col6" />
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
              <tr class= "urlBtn">
                <td>
                  <input class="checkbox" name="check" type="checkbox" value="<%=con_no%>"/>
                </td>
                <td onclick="urlBtn(<%= con_no %>)"><%=con_no%></td>
                <td onclick="urlBtn(<%= con_no %>)"><%=title%></td>
                <td onclick="urlBtn(<%= con_no %>)"><%=wtriter%></td>
                <td onclick="urlBtn(<%= con_no %>)"><%=hit%></td>
                <td onclick="urlBtn(<%= con_no %>)"><%=regdate%></td>
              </tr>
              <%						
                } //for
              } //if 
              %>
            </tbody>
          </table>
          <div class="bottomMenu">
            <div class="empty"></div>
            <ul class="pagination" id="pagenation">
            
            </ul>
            <div class="button">
              <a href="condolencesAdd.jsp">
             	 <button type="button">글쓰기</button>
              </a>
              <button class="del" type="button" onclick="deleteBtn()">
                삭제
              </button>
            </div>
          </div>
          <input type="hidden" id="pageName" name="pageName" value="<%= pageName %>">
        </form>
      </div>
    </div>
	</div>		
 	</section>
<script src="../script/boardPagenation.js?asd"></script>
<script src="../script/condolences.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

</body>
</html>