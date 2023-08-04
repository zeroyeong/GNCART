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
int No = (int)session.getAttribute("memNo");
String leLevel = (String)session.getAttribute("leLevel");
String parttype = (String)session.getAttribute("parttype");
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

    <form action="../authWrite" method="post" onsubmit="return chkLine();">
        <button type="button" class="lineBtn" onclick="busLineBtn()">결재선</button>
        <div class="lineContainer">
            <table>
            <tr>
               <th><span>팀장</span> 
				<% if (teamLeader != null) { %>
 			    <input id="LINE_FIRST" type="hidden" name="LINE_FIRST" value="<%= teamLeader %>"> <%=teamLeader %>
				<% } else { %>
 			    <input id="LINE_FIRST" type="hidden" name="LINE_FIRST" value="">
				<% } %>
                </th>

               <th><span>부장</span>
				<% if (manager != null) { %>
  			 	<input id="LINE_SECOND" type="hidden" name="LINE_SECOND" value="<%= manager %>"> <%=manager %>
				<% } else { %>
    			<input id="LINE_SECOND" type="hidden" name="LINE_SECOND" value="">
				<% } %>
               </th>
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
                <td><input type="text"  value="<%=leLevel%>" readonly></td>
            </tr>
            <tr>
                <td><label for="department">소속 부서</label></td>
                <td><input type="text"  value="<%=parttype%>" readonly></td>
            </tr>
            <tr>
                <td><label for="WORK_DETAIL">업무 내용</label></td>
                <td colspan="3"><textarea name="BUS_DETAIL" id="BUS_DETAIL" rows="10" cols="50" required></textarea></td>
            </tr>
            <tr>
                <td><label for="WORK_SPECIAL">특이사항</label></td>
                <td colspan="3"><textarea name="BUS_SPECIAL" id="BUS_SPECIAL" rows="5" cols="50" required></textarea></td>
            </tr>
        </table>
        <br>
        <div style="text-align: center">
        <button class="submitBtn" type="submit" name="action" value="busWrite">작성</button>
        </div>
    </form>

    <script src="../script/authScript.js"></script>
    <script>
    function chkLine() {
        var first = document.getElementById("LINE_FIRST").value.trim();
        var second = document.getElementById("LINE_SECOND").value.trim();

        if (first === "" || second === "") {
            alert("결재선을 지정해주세요");
            return false;
        }
        return true;
    }
    </script>
</body>

</html>