<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="auth.AuthBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="alertMgr" class="alert.AlertMgr" />
<jsp:useBean id="aMgr" class="auth.AuthMgr" />
<jsp:useBean id="mMgr" class="login.MemberMgr" />

<%
    if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
        response.sendRedirect("../login.jsp");

    int leNo = (int) session.getAttribute("leNo");

    int alertNo = 0;
    int acNo = Integer.parseInt(session.getAttribute("acNo").toString());
    if (request.getParameter("alertNo") != null && Integer.parseInt(request.getParameter("alertNo")) != 0) {
        alertNo = Integer.parseInt(request.getParameter("alertNo"));
        alertMgr.updateAlert(alertNo);
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GNC:ART</title>
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/auth.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
</head>
<body>
	<!-- sidebar include -->
	<jsp:include page="../index/sidebar.jsp" flush="false" />

	<section class="home-section">
		<!-- top include -->
		<jsp:include page="../index/top.jsp" flush="false" />

		<!--home-content-->
        <div class="container-fluid">
            <div class="container">
                <div class="title">
                    <h3>결재 대기</h3>
                </div>
                <div class="content">
                   <div class="tableMenu">
			         <div class="button">
	                    <a href="authHold.jsp"><button>대기</button></a> 
                           <a href="authApproval.jsp"><button>승인</button></a> 
                           <a href="authReturn.jsp"><button>반려</button></a>
			         </div>
	         	   </div>
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
                                        int DOC_APPTURN = bean.getDOC_APPTURN();
	
                                        String linkFunction = (DOC_TYPE == 1) ? "vacView" : "busView";

                                        boolean isApprover = (leNo == 3 && DOC_STATES == 0) || (leNo == 4 && DOC_STATES == 0);

                                        if (isApprover) {
                            %>
                            <tr class="authOnclick" onclick="javascript:<%= linkFunction %>(' <%= DOC_NO %> ')">
                                <td><input type="checkbox" class="myCheckbox" value="<%= DOC_NO%>"/></td>
                                <td><%= DOC_NO %></td>
                                <td><%= DOC_NAME %></td>
                                <td><%= MEM_NAME %></td>
                                <td>
                                    <%
                                        if (DOC_STATES == 0) { out.println("대기"); }
                                        else if (DOC_STATES == 1 || DOC_APPTURN == 1) { out.println("승인"); }
                                        else if (DOC_STATES == 2) { out.println("반려"); }
                                        else { out.println("종결"); }
                                    %>
                                </td>
                                <td><%= DOC_REGDATE %></td>
                                <td>
                                    <%
                                        if (DOC_APPDATE == null) { out.println("결재대기중"); }
                                    %>
                                </td>
                            </tr>
                            <%
                                        }
                                    }
                                }
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
					        <% if (acNo == 2) { %>
					        <form action="../authServlet" method="post" id="deleteForm">
					            <input type="hidden" name="action" value="busdelete">
					            <button class="submitBtn" type="button" id="deleteButton">삭제</button>
					        </form>
					        <% } %>
					    </div>
					</div>
                </div>
            </div>
        </div>
    </section>

    <form name="VACviewFrm" method="get"><input type="hidden" name="DOC_NO"></form>
    <form name="BUSviewFrm" method="get"><input type="hidden" name="DOC_NO"></form>

    <script src="../script/authScript.js?qwe"></script>
</body>
</html>