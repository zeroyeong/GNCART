<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="auth.AuthBean"%>
<%@ page import="java.util.Vector"%>
<jsp:useBean id="manageMgr" class="management.ManagementBean" />
<jsp:useBean id="aMgr" class="auth.AuthMgr" />
<jsp:useBean id="mMgr" class="login.MemberMgr"/>

<%
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
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
                    <h3>결재 신청</h3>
                </div>
                <div class="content">
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
                            if (vlist.isEmpty()) {
                            } else {
                                String memId = (String) session.getAttribute("memId");

                                for (int i = 0; i < vlist.size(); i++) {
                                    AuthBean bean = vlist.get(i);
                                    int DOC_NO = bean.getDOC_NO();
                                    String DOC_NAME = bean.getDOC_NAME();
                                    String MEM_NAME = bean.getMEM_NAME();
                                    int DOC_STATES = bean.getDOC_STATES();
                                    String DOC_REGDATE = bean.getDOC_REGDATE();
                                    String DOC_APPDATE = bean.getDOC_APPDATE();
                                    String MEM_ID = bean.getMEM_ID();
                                    int DOC_TYPE = bean.getDOC_TYPE();
                                    String linkFunction = (DOC_TYPE == 1) ? "vacView" : "busView";

                                    if (MEM_ID.equals(memId)) {
                        %>
                                        <tr class="authOnclick" onclick="javascript:<%= linkFunction %>('<%= DOC_NO %> ')">
                           				    <td><input type="checkbox" class="myCheckbox"/></td>
                                            <td><%= DOC_NO %></td>
                                            <td><%= DOC_NAME %></td>
                                            <td><%= MEM_NAME %></td>
                                            <td>
                                                <% if (DOC_STATES == 0) { %>
                                                대기
                                                <% } else if (DOC_STATES == 1) { %>
                                                승인
                                                <% } else if (DOC_STATES == 2) { %>
                                                반려
                                                <% } else { %>
                                                결재완료
                                                <% } %>
                                            </td>
                                            <td><%= DOC_REGDATE %></td>
                                            <td>
                                                <% if (DOC_APPDATE == null) { %>
                                                결재대기중
                                                <% } else { %>
                                                <%= DOC_APPDATE %>
                                                <% } %>
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
            			 <ul class="pagination" id="pagenation">
            
           				 </ul>
                        <div class="button">
                            <button class="authBtn" type="submit" value="결재신청" onclick="showModal()">작성</button>
                       
                            <% if(acNo == 2){%>
                            <button class="del">삭제</button>
                            <%} %>
                            
                            <div class="modal-background" id="modalBackground">
                                <div class="modal-content">
                                    <div class="modal-close" onclick="hideModal()">&#10006;</div>
                                    <button class="modalBtn" type="button" onclick="btnClick('vacation')">휴가</button>
                                    <button class="modalBtn" type="button" onclick="btnClick('business')">업무</button>
                                </div>
                            </div>  
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