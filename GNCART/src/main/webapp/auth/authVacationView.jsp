<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<%@ page import="auth.AuthMgr"%>
<%@ page import="java.util.*"%>
<%@ page import="auth.AuthBean"%>
<jsp:useBean id="aMgr" class="auth.AuthMgr" />
<%
if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
    response.sendRedirect("../login.jsp");

request.setCharacterEncoding("UTF-8");
int DOC_NO = Integer.parseInt(request.getParameter("DOC_NO").trim());
AuthBean bean = aMgr.getAuth(DOC_NO);
String DOC_NAME = bean.getDOC_NAME();
String MEM_NAME = bean.getMEM_NAME();
String PART_TYPE = bean.getPART_TYPE();
String LE_LEVEL = bean.getLE_LEVEL();
String VAC_SDATE = bean.getVAC_SDATE();
String VAC_EDATE = bean.getVAC_EDATE();
int VAC_REASON = bean.getVAC_REASON();
String VAC_DETAIL = bean.getVAC_DETAIL();
int LINE_NO = bean.getLINE_NO();
String LINE_FIRST = bean.getLINE_FIRST();
String LINE_SECOND = bean.getLINE_SECOND();
int DOC_APPTURN = bean.getDOC_APPTURN();
int DOC_STATES = bean.getDOC_STATES();
int VAC_NO = bean.getVAC_NO();
String MEM_ID = bean.getMEM_ID();
int BUS_NO = bean.getBUS_NO();

String Name = (String)session.getAttribute("memName");
String ID = (String)session.getAttribute("memId");

String leLevel = (String)session.getAttribute("leLevel");

boolean firstApproved = aMgr.firstApproved(LINE_NO);
boolean secondApproved = aMgr.secondApproved(LINE_NO);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>휴가 신청서</title>
    <link rel="stylesheet" href="../css/authVacation.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
</head>

<body>
    <h2>휴가 신청서</h2>

    <form method="post" action="../authServlet">
        <div class="lineContainer">
            <table>
                <% if (!"팀장".equals(LE_LEVEL)) { %>
                <tr>
                    <th>
                        <span>팀장</span>
                        <input id="LINE_FIRST" type="hidden" name="LINE_FIRST"><%=LINE_FIRST%>
                    </th>
                    <th>
                        <span>부장</span>
                        <input id="LINE_SECOND" type="hidden" name="LINE_SECOND"><%=LINE_SECOND%>
                    </th>
                </tr>
                <% } else if ("팀장".equals(LE_LEVEL)) { %>
                <tr>
                    <th>
                        <span>부장</span>
                        <input id="LINE_SECOND" type="hidden" name="LINE_SECOND"><%=LINE_SECOND%>
                    </th>
                </tr>
                <% } %>
                <tr>
                    <th>
                        <% if (firstApproved) { %>
                        <img src="../images/stamp1.png" alt="">	
                        <% } else if (secondApproved) { %>
                        <img src="../images/stamp2.png" alt="">
                        <% } %>
                    </th>
                    <% if (!"팀장".equals(LE_LEVEL)) { %>
                    <th>
                        <% if (secondApproved) { %>
                        <img src="../images/stamp2.png" alt="">
                        <% } %>
                    </th>
                    <% } %>
                </tr>
            </table>
        </div>
        <table>
            <tr>
                <th>항목</th>
                <th colspan="3">내용</th>
            </tr>
            <tr>
                <td><label for="MEM_NAME">성명</label></td>
                <td><input type="text" value="<%=MEM_NAME%>" readonly></td>
            </tr>
            <tr>
                <td><label for="position">직급</label></td>
                <td><input type="text" value="<%=LE_LEVEL%>" readonly></td>
            </tr>
            <tr>
                <td><label for="department">소속 부서</label></td>
                <td><input type="text" value="<%=PART_TYPE%>" readonly></td>
            </tr>
            <tr>
                <td><label for="AUTH_SDATE">휴가 날짜</label></td>
                <td colspan="3"><input type="date" value="<%=VAC_SDATE%>" readonly>
                    ~ <input type="date" value="<%=VAC_EDATE%>" readonly></td>
            </tr>
            <tr>
                <td><label>휴가 사유</label></td>
                <td colspan="3">
                    <div class="radio-group">
                        <input type="radio" value="1" id="vacation_reason1" <% if(VAC_REASON == 1) { %>checked<% } %> disabled>
                        <label for="vacation_reason1">월차</label>
                        <input type="radio" value="2" id="vacation_reason2" <% if(VAC_REASON == 2) { %>checked<% } %> disabled>
                        <label for="vacation_reason2">연차</label>
                        <input type="radio" value="3" id="vacation_reason3" <% if(VAC_REASON == 3) { %>checked<% } %> disabled>
                        <label for="vacation_reason3">병가</label>
                        <input type="radio" value="4" id="vacation_reason4" <% if(VAC_REASON == 4) { %>checked<% } %> disabled>
                        <label for="vacation_reason4">기타</label>
                    </div>
                </td>
            </tr> 
            <tr>
                <td><label for="AUTH_PP">상세 사유</label></td>
                <td colspan="3"><textarea name="VAC_DETAIL" rows="10" cols="50" readonly><%=VAC_DETAIL %></textarea></td>
            </tr>
        </table>

        <br>

        <input type="hidden" name="LINE_NO" value="<%=LINE_NO %>">
        <input type="hidden" name="DOC_NO" value="<%=DOC_NO %>">
        <input type="hidden" name="VAC_NO" value="<%=VAC_NO %>">
        <input type="hidden" name="BUS_NO" value="<%=BUS_NO %>">

        <div style="text-align: center">
            <% if (MEM_ID.equals(ID)) { %>
            <% if (DOC_STATES != 3) { %>
            <button class="submitBtn" type="submit" name="action" value="vacdelete">삭제</button>
            <% } %>
            <% } %>
            <% if (Name.equals(LINE_FIRST) && DOC_APPTURN == 0) { %>
            <% if (DOC_STATES != 2) { %>
            <button class="submitBtn" type="submit" name="action" value="first">승인</button>
            <button class="submitBtn" type="submit" name="action" value="reject">반려</button>
            <% } %>
            <% } else if(Name.equals(LINE_SECOND) && DOC_APPTURN == 1) { %>
            <% if (DOC_STATES != 2) { %>
            <button class="submitBtn" type="submit" name="action" value="second">승인</button>
            <button class="submitBtn" type="submit" name="action" value="reject">반려</button>
            <% } %>
            <% } %>
        </div>
    </form>

    <script src="../script/authScript.js"></script>
</body>
</html>