<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@ page import="notice.NoticeBean"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr" /> 

<% 
request.setCharacterEncoding("UTF-8");
Vector<NoticeBean> blist = null; 
blist = nMgr.getBoardList();
%> 
<!DOCTYPE html>
<html lang="ko">
<head> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/notice.css">


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
        <h3>공지사항</h3>
        <!-- <div class="button">
	          상단 버튼을 원하시는 분들은
	          여기다가 추가하면 자동스타일 적용 됩니당
	        </div> -->
      </div>
      <div class="content">
        <div class="tableMenu">

        </div>
        <form method="post" action="noticeChk.jsp" id="noticeForm">
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
            	NoticeBean bean = new NoticeBean(); 
                bean = blist.get(i);
                int NOT_NO = bean.getNOT_NO();
                String NOT_TITLE = bean.getNOT_TITLE();
                int NOT_HIT = bean.getNOT_HIT();
                String NOT_DATE = bean.getNOT_DATE();
                int MEM_NO = bean.getMEM_NO();
                String MEM_NAME = bean.getMEM_NAME(); 
                int NOTSUB_NO = bean.getNOTSUB_NO();
                String NOT_SUB = bean.getNOT_SUB();
                String MEM_ID = bean.getMEM_ID();
              %>
              <tr>
                <td>
                  <input type="checkbox" name="chk" value="<%=NOT_NO %>,<%=MEM_ID %>">
                </td>
                <td><%=NOT_NO %></td>
                <td>
                  <a href="javascript:view('<%=NOT_NO%>')"><b>[<%=NOT_SUB%>] </b><%=NOT_TITLE %></a>
                </td>
                <td><%=MEM_NAME%></td>
                <td><%=NOT_HIT%></td>
                <td><%=NOT_DATE%></td>
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
              <button type="button">
                <a href="noticeWrite.jsp">글쓰기</a>
              </button>
				<button class="del" type="button" onclick="submitForm()">삭제</button>
            </div>
          </div>
        </form>
      </div>
    </div>
	</div>		
 	</section>
 	
 	<form name="listFrm" method="post"></form>
	<form name="viewFrm" method="get"><input type="hidden" name="NOT_NO"></form>
 	
<script src="../script/boardPagenation.js"></script>
<script src="../script/noticeScript.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

</body>
</html>