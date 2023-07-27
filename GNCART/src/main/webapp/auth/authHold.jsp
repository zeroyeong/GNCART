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
    <title>GNC:ART</title>
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/auth.css">
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
  <div class="container-fluid">
    <div class="card shadow mb-4">
      <div class="card-header py-3">
          <h5>결재 대기</h5>
      </div>
      <div class="card-body">
          <div>
              <table id="example" class="table table-striped" style="width:100%">
                  <thead>
                      <tr>
                          <th>문서번호</th>
                          <th>문서명</th>
                          <th>작성자</th>
                          <th>유형</th>
                          <th>신청일</th>
                          <th>결재일</th>
                      </tr>
                  </thead>
                  <tfoot>
                      <tr>
                        <th>문서번호</th>
                        <th>문서명</th>
                        <th>작성자</th>
                        <th>유형</th>
                        <th>신청일</th>
                        <th>결재일</th>
                      </tr>
                  </tfoot>
                  <tbody>
                      <tr>
                          <td> 1</td>
                          <td>제목을 입력해주세요</td>
                          <td>작성자를 입력하세요</td>
                          <td>0</td>
                          <td>2011/04/25</td>
                          <td>2011/04/25</td>
                      </tr>
                  </tbody>
              </table>
              <div id="btns">
              	<button>대기</button>
              	<button>승인</button>
              	<button>반려</button>
              </div>
          </div>
      </div>
  </div>
  </div>
  </section>

    <script src="../script/indexScript.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
	<script src="../script/authScript.js"></script>
	<script src="../script/notice.js"></script>
</body>

</html>