<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>
<%
  if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
    response.sendRedirect("../login.jsp");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>업무 보고서</title>
    <link rel="stylesheet" href="../css/authWork.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"
        integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

</head>

<body>
    <h2>업무 보고서</h2>

    <form action="#" method="post">
        <button class="lineBtn" onclick="lineBtn()">결재선</button>
        <div class="lineContainer">
            <table>
                <tr>
                    <th><span>팀장</span></th>
                    <th><span>부장</span></th>
                </tr>
                <tr>
                    <th><img src="../images/stamp1.png" alt="팀장 도장"></th>
                    <th><img src="../images/stamp2.png" alt="부장 도장"></th>
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
                <td><input type="text" id="MEM_NAME" name="MEM_NAME"></td>
            </tr>
            <tr>
                <td><label for="position">직급</label></td>
                <td><input type="text" id="position" name="position"></td>
            </tr>
            <tr>
                <td><label for="department">소속 부서</label></td>
                <td><input type="text" id="department" name="department"></td>
            </tr>
            <tr>
                <td><label for="WORK_DETAIL">업무 내용</label></td>
                <td colspan="3"><textarea id="WORK_DETAIL" name="WORK_DETAIL" rows="10" cols="50"></textarea></td>
            </tr>
            <tr>
                <td><label for="WORK_SPECIAL">특이사항</label></td>
                <td colspan="3"><textarea id="WORK_SPECIAL" name="WORK_SPECIAL" rows="5" cols="50"></textarea></td>
            </tr>
        </table>
        <br>

        <button class="submitBtn" type="submit">작성완료</button>
    </form>

    <script src="../script/authScript.js"></script>
</body>

</html>