<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>
<%
  if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
    response.sendRedirect("../login.jsp");
%>
<%
request.setCharacterEncoding("UTF-8");

String Name = (String)session.getAttribute("memName");
int le = (int)session.getAttribute("leNo");
int part = (int)session.getAttribute("partNo");
int No = (int)session.getAttribute("memNo");

String leValue = "";

if (le == 1) {
	leValue ="사원";
} else if (le == 2) {
	leValue ="대리";
} else if (le == 3) {
	leValue = "팀장";
} else { 
	leValue = "부장";
}
String PartValue = "";

if (part == 1) {
	PartValue ="경영지원팀";
} else if (part == 2) {
	PartValue = "개발팀";
} else if (part == 3) {
	PartValue = "홍보팀";
} else if (part == 4) {
	PartValue = "영업팀";
} else if (part == 5) {
	PartValue = "서비스지원팀";
} else {
	PartValue = "전체부서";
}
%>
<%//결재선 선택값가져오기
 String teamLeader = request.getParameter("line1");
 String manager = request.getParameter("line2");
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

    <form action="../busWrite" method="post">
        <button class="lineBtn" onclick="busLineBtn()">결재선</button>
        <div class="lineContainer">
            <table>
                <tr>
					<th><span>팀장</span> 
					<% if (teamLeader != null) {
					%> <span><%= teamLeader %></span> <% 
					} %>
					</th>

					<th><span>부장</span>
					<% if (manager != null) {
					%> <span><%= manager %></span> <% 
					} %>
					</th>
                </tr>
                <tr>
                    <th></th>
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
                <td><input type="text"  value="<%=leValue%>" readonly></td>
            </tr>
            <tr>
                <td><label for="department">소속 부서</label></td>
                <td><input type="text"  value="<%=PartValue%>" readonly></td>
            </tr>
            <tr>
                <td><label for="WORK_DETAIL">업무 내용</label></td>
                <td colspan="3"><textarea name="BUS_DETAIL" rows="10" cols="50"></textarea></td>
            </tr>
            <tr>
                <td><label for="WORK_SPECIAL">특이사항</label></td>
                <td colspan="3"><textarea name="BUS_SPECIAL" rows="5" cols="50"></textarea></td>
            </tr>
        </table>
        <br>

        <button class="submitBtn" type="submit">작성완료</button>
    </form>

    <script src="../script/authScript.js"></script>
</body>

</html>