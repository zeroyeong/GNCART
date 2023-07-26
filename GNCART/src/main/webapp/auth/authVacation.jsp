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
    <title>휴가 신청서</title>
    <link rel="stylesheet" href="../css/authVacation.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"
        integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

</head>

<body>
    <h2>휴가 신청서</h2>

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
                <td><label for="AUTH_SDATE">휴가 날짜</label></td>
                <td colspan="3">
                    <input type="date" id="AUTH_SDATE" name="AUTH_SDATE" required>
                    ~
                    <input type="date" id="AUTH_EDATE" name="AUTH_EDATE" required>
                </td>
            </tr>
            <tr>
                <td><label>휴가 사유</label></td>
                <td colspan="3">
                    <div class="radio-group">
                        <input type="radio" id="vacation_reason1" name="vacation_reason" value="월차" required>
                        <label for="vacation_reason1">월차</label>

                        <input type="radio" id="vacation_reason2" name="vacation_reason" value="연차" required>
                        <label for="vacation_reason2">연차</label>

                        <input type="radio" id="vacation_reason3" name="vacation_reason" value="병가" required>
                        <label for="vacation_reason3">병가</label>

                        <input type="radio" id="vacation_reason4" name="vacation_reason" value="기타" required>
                        <label for="vacation_reason4">기타</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td><label for="AUTH_PP">상세 사유</label></td>
                <td colspan="3"><textarea id="AUTH_PP" name="AUTH_PP" rows="10" cols="50"></textarea></td>
            </tr>
        </table>
        <br>

        <button class="submitBtn" type="submit">작성완료</button>
    </form>

    <script src="../script/authScript.js"></script>
</body>

</html>