<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<%@ page import="auth.AuthBean"%>
<jsp:useBean id="aMgr" class="auth.AuthMgr" />
<%
  if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
    response.sendRedirect("../login.jsp");

	request.setCharacterEncoding("UTF-8");
	int DOC_NO = Integer.parseInt(request.getParameter("DOC_NO"));
	AuthBean bean = aMgr.getAuth(DOC_NO);
	String DOC_NAME = bean.getDOC_NAME();
	String MEM_NAME = bean.getMEM_NAME();
	String PART_TYPE = bean.getPART_TYPE();
	String LE_LEVEL = bean.getLE_LEVEL();
	String BUS_DETAIL = bean.getBUS_DETAIL();
	String BUS_SPECIAL = bean.getBUS_SPECIAL();
	int LINE_NO = bean.getLINE_NO();
	String LINE_FIRST = bean.getLINE_FIRST();
	String LINE_SECOND = bean.getLINE_SECOND();
	int DOC_APPTURN = bean.getDOC_APPTURN();
	String MEM_ID = bean.getMEM_ID();
	int VAC_NO = bean.getVAC_NO();
	int BUS_NO = bean.getBUS_NO();
	
	String Name = (String)session.getAttribute("memName");
	String ID = (String)session.getAttribute("memId");
	
	boolean firstApproved = aMgr.firstApproved(LINE_NO);
	boolean secondApproved = aMgr.secondApproved(LINE_NO);
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>업무 보고서</title>
    <link rel="stylesheet" href="../css/authBusiness.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"
        integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

</head>

<body>
    <h2>업무 보고서</h2>

    <form action="../authServlet" method="post">
    <div class="lineContainer">
          <table>
            <tr>
               <th><span>팀장</span> 
 			    <input id="LINE_FIRST" type="hidden" name="LINE_FIRST"><%=LINE_FIRST%>
                </th>

               <th><span>부장</span>
  			 	<input id="LINE_SECOND" type="hidden" name="LINE_SECOND"><%=LINE_SECOND%>
               </th>
         	   	<tr>
 	   			<% if (firstApproved) { %>
                	<th><img src="../images/stamp1.png"></th>
                 <% } else { %>
                 <th></th>
                 <% } %>
				<% if (secondApproved) { %>
                	<th><img src="../images/stamp2.png"></th>
                 <% } else { %>
                 <th></th>
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
                <td><input type="text"  value="<%=LE_LEVEL%>" readonly></td>
            </tr>
            <tr>
                <td><label for="department">소속 부서</label></td>
                <td><input type="text"  value="<%=PART_TYPE%>" readonly></td>
            </tr>
            <tr>
                <td><label for="WORK_DETAIL">업무 내용</label></td>
                <td colspan="3"><textarea name="BUS_DETAIL" rows="10" cols="50" readonly><%=BUS_DETAIL %></textarea></td>
            </tr>
            <tr>
                <td><label for="WORK_SPECIAL">특이사항</label></td>
                <td colspan="3"><textarea name="BUS_SPECIAL" rows="5" cols="50" readonly><%=BUS_SPECIAL %></textarea></td>
            </tr>
        </table>
        <br>

		<input type="hidden" name="LINE_NO" value="<%=LINE_NO %>">
		<input type="hidden" name="DOC_NO" value="<%=DOC_NO %>">
		<input type="hidden" name="VAC_NO" value="<%=VAC_NO %>">
		<input type="hidden" name="BUS_NO" value="<%=BUS_NO %>">

		<div style="text-align: center">
		<%if (MEM_ID.equals(ID)) { %>
 		<button class="submitBtn" type="submit" name="action" value="busdelete">삭제</button>
 		<%} %>
 		<%if (Name.equals(LINE_FIRST) && DOC_APPTURN == 0) { %>
 		<button class="submitBtn" type="submit" name="action" value="first">승인</button>
 		<button class="submitBtn" type="submit" name="action" value="reject">반려</button>
 		<%} else if(Name.equals(LINE_SECOND) && DOC_APPTURN == 1) {%>
 		<button class="submitBtn" type="submit" name="action" value="second">승인</button>
 		<button class="submitBtn" type="submit" name="action" value="reject">반려</button>
 		<%} %>
 		</div>
    </form>

    <script src="../script/authScript.js"></script>
</body>

</html>