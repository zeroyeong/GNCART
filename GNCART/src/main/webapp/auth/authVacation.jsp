<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>
<%@ page import="auth.AuthMgr"%>
<%@ page import="java.util.*"%>
<% 
	if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
	response.sendRedirect("../login.jsp");

	request.setCharacterEncoding("UTF-8");
	
	String Name = (String)session.getAttribute("memName");
	int No = (int)session.getAttribute("memNo");
	String leLevel = (String)session.getAttribute("leLevel");
	String parttype = (String)session.getAttribute("parttype");
	 
	//결재선 선택값가져오기
	String teamLeader = request.getParameter("line1");
	String manager = request.getParameter("line2");
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

    <form method="post" action="../authWrite" onsubmit="return chkLine()">
        <button type="button" class="lineBtn" onclick="vacLineBtn()">결재선</button>
	     <div class="lineContainer">
			<table> 
				<tr>
					<% if (!"팀장".equals(leLevel)) { %>
					<th>
						<span>팀장</span>
						<% if (teamLeader != null) { %> 
						<input id="LINE_FIRST" type="hidden" name="LINE_FIRST" value="<%= teamLeader %>"> <%=teamLeader %>
						<% } else { %> 
						<input id="LINE_FIRST" type="hidden" name="LINE_FIRST" value="">
						<% } %>
					</th>
					<% } %>
					<th>
						<span>부장</span>
						<% if (manager != null) { %> 
						<input id="LINE_SECOND" type="hidden" name="LINE_SECOND" value="<%= manager %>"> <%=manager %> 
						<% } else { %> 
						<input id="LINE_SECOND" type="hidden" name="LINE_SECOND" value="">
						<% } %>
					</th>
				</tr>
				<tr>
					<% if (!"팀장".equals(leLevel)) { %>
					<th></th>
					<%} %>
					<th></th>
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
            <td><input type="text" value="<%=Name%>" readonly></td>
            <input type="hidden" name="MEM_NO" value="<%=No%>">
         </tr>
         <tr>
            <td><label for="position">직급</label></td>
            <td><input type="text" value="<%=leLevel%>" readonly></td>
         </tr>
         <tr>
            <td><label for="department">소속 부서</label></td>
            <td><input type="text" value="<%=parttype%>" readonly></td>
         </tr>
         <tr>
            <td><label for="AUTH_SDATE">휴가 날짜</label></td>
            <td colspan="3"><input type="date" name="VAC_SDATE" required>
               ~ <input type="date" name="VAC_EDATE" required></td>
         </tr>
         <tr>
            <td><label>휴가 사유</label></td>
            <td colspan="3">
               <div class="radio-group">
                  <input type="radio" name="VAC_REASON" value="1" required>
                  <label for="vacation_reason1">월차</label> 
                  
                  <input type="radio" name="VAC_REASON" value="2" required> 
                  <label for="vacation_reason2">연차</label> 
                  
                  <input type="radio" name="VAC_REASON" value="3" required> 
                  <label for="vacation_reason3">병가</label> 
                  
                  <input type="radio" name="VAC_REASON" value="4" required> 
                  <label for="vacation_reason4">기타</label>
               </div>
            </td>
         </tr>
         <tr>
            <td><label for="AUTH_PP">상세 사유</label></td>
            <td colspan="3"><textarea name="VAC_DETAIL" rows="10" cols="50" required></textarea></td>
         </tr>
      </table>
      <br>
      
      <div style="text-align: center">
      <button class="submitBtn" type="submit" name="action" value="vacWrite" onclick="alertSend()">작성</button>
      </div>
        <input type="hidden" id="fromPartType" name="fromPartType" value="<%=parttype%>">
		<input type="hidden" id="fromName" name="fromName" value="<%=Name%>"> 
   </form>
   <script src="../script/webSocket.js"></script>
   <script src="../script/authScript.js"></script>
</body>

</html>