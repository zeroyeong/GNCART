<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="auth.AuthBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="aMgr" class="auth.AuthMgr" />
<jsp:useBean id="mMgr" class="login.MemberMgr" />

<%
	request.setCharacterEncoding("UTF-8");
    if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
        response.sendRedirect("../login.jsp");
	int acNo = Integer.parseInt(session.getAttribute("acNo").toString());
%> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GNC:ART</title>
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/auth.css">
    <!--boxIcons CDN Link-->
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
</head>
<body>
    <!-- sidebar include -->
    <jsp:include page="../index/sidebar.jsp" flush="false" />

    <section class="home-section">
        <!-- top include -->
        <jsp:include page="../index/top.jsp" flush="false" />

        <!-- home-content -->
        <div class="container-fluid">
            <div class="container">
                <div class="title">
                    <h3>결재 반려</h3>
                </div>
                <div class="content">
                      <div class="tableMenu">
				         <div class="button">
		                    <a href="authHold.jsp"><button>대기</button></a> 
                            <a href="authApproval.jsp"><button>승인</button></a> 
                            <a href="authReturn.jsp"><button>반려</button></a>
				         </div>
		           	  </div>
		           	  <form method="post" action="authChk.jsp" id="authForm">
                    <table>
                       <colgroup>
				            <col class="col1 " />
			       	   </colgroup>
                        <thead>
                            <tr>
                            	<th></th>
                                <th>No.</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>유형</th>
                                <th>신청일</th>
                                <th>결재일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Vector<AuthBean> vlist = aMgr.getAuthList();
                                if (!vlist.isEmpty()) {
                                    for (int i = 0; i < vlist.size(); i++) {
                                        AuthBean bean = vlist.get(i);
                                        int DOC_NO = bean.getDOC_NO();
                                        String DOC_NAME = bean.getDOC_NAME();
                                        String MEM_NAME = bean.getMEM_NAME();
                                        int DOC_STATES = bean.getDOC_STATES();
                                        String DOC_REGDATE = bean.getDOC_REGDATE();
                                        String DOC_APPDATE = bean.getDOC_APPDATE(); 
                                        int DOC_TYPE = bean.getDOC_TYPE();
                                        int LINE_NO = bean.getLINE_NO();
                                        int VAC_NO = bean.getVAC_NO();
                                        int BUS_NO = bean.getBUS_NO();
                                        
                                        String linkFunction = (DOC_TYPE == 1) ? "vacView" : "busView";
                                        
                                        if (DOC_STATES == 2) {
                            %>
                        	    <tr class="authOnclick" onclick="javascript:<%= linkFunction %>(' <%= DOC_NO %> ')">
                                	<td><input type="checkbox" name="chk" class="myCheckbox" value="<%=LINE_NO %>,<%=VAC_NO %>,<%=BUS_NO %>"></td>
                                    <td><%= DOC_NO %></td>
	                                <% if (DOC_TYPE == 1) { %>
	                                    <td><%= DOC_NAME %></td>
	                                <% } else if (DOC_TYPE == 2) { %>
	                                    <td><%= DOC_NAME %></td>
	                                <% } %>
	                                <td><%= MEM_NAME %></td>
	                                <% if (DOC_STATES == 0) { %>
	                                    <td>대기</td>
	                                <% } else if (DOC_STATES == 1) { %>
	                                    <td>승인</td>
	                                <% } else if (DOC_STATES == 2) { %>
	                                    <td>반려</td>
	                                <% } else { %>
	                                    <td>종결</td>
	                                <% } %>
	                                <td><%= DOC_REGDATE %></td>
	                                <% if (DOC_APPDATE == null) { %>
	                                    <td>결재대기중</td>
	                                <% } %>
                            </tr>
                            <% } %>
                        <% } %> 
                      <%} %>
                    </tbody>
                    </table>
                    </form>
                    <div class="bottomMenu">
                        <div class="empty"></div>
            			 <ul class="pagination" id="pagenation">
            
           				 </ul>
                   	    <div class="button">
                            <% if(acNo == 2){%>
                            <button class="submitBtn" type="button" id="deleteButton" onclick="submitForm()">삭제</button>
                            <%} %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
 
    <form name="VACviewFrm" method="get"><input type="hidden" name="DOC_NO"></form>
    <form name="BUSviewFrm" method="get"><input type="hidden" name="DOC_NO"></form>

    <script src="../script/authScript.js"></script>
    <script src="../script/boardPagenation.js"></script>
</body>
</html>