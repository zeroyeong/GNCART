<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.MemberBean" %>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>
<%
    // 세션에서 로그인 정보 가져오기
    String id = (String) session.getAttribute("idKey");
    String pw = (String) session.getAttribute("pwKey");
    String name = mMgr.nameFind(id, pw);
    
    // 로그인 안했을 시 로그인 페이지로 리다이렉트
    if (id == null || pw == null) {
        response.sendRedirect("../login.jsp"); 
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GNC:ART</title>
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/auth.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"
        integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
    <!--boxIcons CDN Link-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

 
<body>
  <!-- sidebar include -->
  <jsp:include page="../index/sidebar.jsp" flush="false" />

  <section class="home-section">
    <!-- top include -->
    <jsp:include page="../index/top.jsp" flush="false" />

     <!--home-content-->
        <div class="home-content">
            <div class="auth-board-boxes">
                <div class="auth-box">
                    <div class="title"><a href="#">결재 신청</a></div>
                    <button class="authBtn" type="submit" value="결재신청" onclick="showModal()">+ 작성하기</button>

                    <div class="modal-background" id="modalBackground">
                        <div class="modal-content">
                            <div class="modal-close" onclick="hideModal()">&#10006;</div>
                            <button class="modalBtn" type="button" onclick="btnClick('vacation')">휴가</button>
                            <button class="modalBtn" type="button" onclick="btnClick('work')">업무</button>
                        </div>
                    </div>

                    <br>
                    <div class="auth-details">
                        <table>
                            <thead>
                                <tr>
                                    <th>문서번호</th>
                                    <th>문서명</th>
                                    <th>작성자</th>
                                    <th>유형</th>
                                    <th>상태</th>
                                    <th>신청일</th>
                                    <th>결재일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                                <tr onclick="window.location.href='#';">
                                    <td>6</td>
                                    <td>휴가신청합니다</td>
                                    <td>김대리</td>
                                    <td>휴가</td>
                                    <td>대기</td>
                                    <td>2023-06-27</td>
                                    <td>2023-07-01</td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="6">
                                        <div class="page">
                                            <a href="#">이전</a>
                                            <a href="#">1</a>
                                            <a href="#">2</a>
                                            <a href="#">3</a>
                                            <a href="#">4</a>
                                            <a href="#">5</a>
                                            <a href="#">6</a>
                                            <a href="#">7</a>
                                            <a href="#">8</a>
                                            <a href="#">9</a>
                                            <a href="#">10</a>
                                            <a href="#">다음</a>
                                        </div>
                                    </td>
                                </tr>
                            </tfoot>

                        </table>
                    </div>
                </div>
            </div>
        </div>

    </section>

    <script src="../00index/indexScript.js"></script>

    <script>
        var modalBackground = document.getElementById('modalBackground');
        function showModal() {
            modalBackground.style.display = 'block';
        }

        function hideModal() {
            modalBackground.style.display = 'none';
        }

        function btnClick(option) {
            if (option === 'vacation') {
                // 결재 페이지의 URL을 지정합니다. 필요에 따라 URL을 수정하세요.
                var url = "authVacation.jsp";

                // 팝업 창의 옵션을 설정합니다.
                var windowOptions = "width=800,height=700,scrollbars=yes,resizable=yes";

                // 팝업 창을 엽니다.
                window.open(url, "_blank", windowOptions);
            } else if (option === 'work') {
                // 결재 페이지의 URL을 지정합니다. 필요에 따라 URL을 수정하세요.
                var url = "authWork.jsp";

                // 팝업 창의 옵션을 설정합니다.
                var windowOptions = "width=800,height=700,scrollbars=yes,resizable=yes";

                // 팝업 창을 엽니다.
                window.open(url, "_blank", windowOptions);
            }
        }
    </script>
</body>

</html>