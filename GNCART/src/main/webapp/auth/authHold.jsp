<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="auth.AuthBean"%>
<%@ page import="java.util.Vector"%>
<jsp:useBean id="aMgr" class="auth.AuthMgr" />
<jsp:useBean id="mMgr" class="login.MemberMgr"/>
<%
  if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
    response.sendRedirect("../login.jsp");
%>
<% int leNo = (int)session.getAttribute("leNo"); %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GNC:ART</title>
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/auth.css">
    <!--boxIcons CDN Link-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

 
<body>
  <!-- sidebar include -->
  <jsp:include page="../index/sidebar.jsp" flush="false" />

  <section class="home-section">
    <!-- top include -->
    <jsp:include page="../index/top.jsp" flush="false" />

     <!--home-content-->
  <div class="container-fluid">
    <div class="card shadow mb-4">
      <div class="card-header py-3">
          <h5>결재 대기</h5>
      </div>
      <div class="card-body">
          <div>
              <table id="example" class="table table-striped" style="width:100%">
                  <thead>
                      <tr>
                          <th>문서번호</th>
                          <th>문서명</th>
                          <th>작성자</th>
                          <th>유형</th>
                          <th>신청일</th>
                          <th>결재일</th>
                      </tr>
                  </thead>
                  <tfoot>
                      <tr>
                        <th>문서번호</th>
                        <th>문서명</th>
                        <th>작성자</th>
                        <th>유형</th>
                        <th>신청일</th>
                        <th>결재일</th>
                      </tr>
                  </tfoot>
                  <tbody>
                  <%
                  Vector<AuthBean> vlist = null; 
                  vlist = aMgr.getAuthList();
                  if (vlist.isEmpty()) {
                	  out.println("등록된 게시글이 없습니다.");
                  } else {
                  %>
				<%    for (int i=0; i<vlist.size(); i++) { 
                      AuthBean bean = vlist.get(i);
                      int DOC_NO = bean.getDOC_NO();
                      String DOC_NAME = bean.getDOC_NAME();
                      String MEM_NAME = bean.getMEM_NAME();
                      int DOC_STATES = bean.getDOC_STATES();
                      String DOC_REGDATE = bean.getDOC_REGDATE();
                      String DOC_APPDATE = bean.getDOC_APPDATE(); 
                      int DOC_TYPE = bean.getDOC_TYPE();
                      int DOC_APPTURN = bean.getDOC_APPTURN();
                      
                      
                      if (leNo == 3) {
                      if (DOC_STATES == 0) {
                  %>
                      <tr>
                          <td><%=DOC_NO %></td>
                          <%if (DOC_TYPE == 1) {%>
                          <td><a href="javascript:VACview('<%=DOC_NO%>')"><%=DOC_NAME %></a></td>
                          <% } else if (DOC_TYPE == 2) { %>
                          <td><a href="javascript:BUSview('<%=DOC_NO%>')"><%=DOC_NAME %></a></td>
                          <% } %>
                          <td><%=MEM_NAME %></td>
                          <%if(DOC_STATES == 0) {%>
                        	  <td>대기</td>
                          <%} else if(DOC_STATES == 1 || DOC_APPTURN == 1) {%>
                          	  <td>승인</td>
                          <%} else if(DOC_STATES == 2) { %>
                          	  <td>반려</td>
                          <%} else { %>
                          	  <td>종결</td>
                          <%} %>
                          <td><%=DOC_REGDATE %></td>
                          <%if(DOC_APPDATE == null) {%>
                          	  <td>결재대기중</td>
                          <%} %>
                      </tr>
                      <%} %>
                  <%} else if (leNo == 4) {
                  	if (DOC_STATES == 1) {
                  %>
                                        <tr>
                          <td><%=DOC_NO %></td>
                          <%if (DOC_TYPE == 1) {%>
                          <td><a href="javascript:VACview('<%=DOC_NO%>')"><%=DOC_NAME %></a></td>
                          <% } else if (DOC_TYPE == 2) { %>
                          <td><a href="javascript:BUSview('<%=DOC_NO%>')"><%=DOC_NAME %></a></td>
                          <% } %>
                          <td><%=MEM_NAME %></td>
                          <%if(DOC_STATES == 0) {%>
                        	  <td>대기</td>
                          <%} else if(DOC_STATES == 1 || DOC_APPTURN == 1) {%>
                          	  <td>승인</td>
                          <%} else if(DOC_STATES == 2) { %>
                          	  <td>반려</td>
                          <%} else { %>
                          	  <td>종결</td>
                          <%} %>
                          <td><%=DOC_REGDATE %></td>
                          <%if(DOC_APPDATE == null) {%>
                          	  <td>결재대기중</td>
                          <%} %>
                      </tr>
                      <%} %>
           		   <%} %>
               <%}%>
         	 <%}%>
                  </tbody>
              </table>
              <div id="btns">
              	<button><a href="authHold.jsp">대기</a></button>
              	<button><a href="authApproval.jsp">승인</a></button>
              	<button><a href="authReturn.jsp">반려</a></button>
              </div>
          </div>
      </div>
  </div>
  </div>
  </section>
  
  <form name="VACviewFrm" method="get"><input type="hidden" name="DOC_NO"></form>
  <form name="BUSviewFrm" method="get"><input type="hidden" name="DOC_NO"></form>

    <script src="../script/indexScript.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
	<script src="../script/authScript.js"></script>
	<script src="../script/notice.js"></script>
	<script>
	function VACview(DOC_NO) {
	    const width = 800;
	    const height = 800;
	    const left = (window.screen.width - width) / 2;
	    const top = (window.screen.height - height) / 2;

	    const popupOptions = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
	    window.open("authVacationView.jsp?DOC_NO=" + DOC_NO, "_blank", popupOptions);
	}
	function BUSview(DOC_NO){
		const width = 800;
	    const height = 800;
	    const left = (window.screen.width - width) / 2;
	    const top = (window.screen.height - height) / 2;

	    const popupOptions = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
	    window.open("authBusinessView.jsp?DOC_NO=" + DOC_NO, "_blank", popupOptions);
	}
	</script>
</body>

</html>