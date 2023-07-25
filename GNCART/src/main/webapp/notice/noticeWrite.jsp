<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.MemberBean" %>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");

	request.setCharacterEncoding("UTF-8");

	String Name = (String)session.getAttribute("memName");
	String No = (String)session.getAttribute("memNo");
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/noticeWrite.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
	
  <!-- sidebar include -->	
  <jsp:include page="../index/sidebar.jsp" flush="false"/>	

<section class="home-section">  
   <!-- top include -->
  <jsp:include page="../index/top.jsp" flush="false"/>
	

    <!--home-content-->  	
  <div class="home-content">
    <div id="container">
      <div id="title">
        <h2>공지사항</h2>
      </div>
      
      <hr>
      
      <form method="post" action="../noticeWrite" enctype="multipart/form-data" onsubmit="return writeNOT();">
        <table>
          <tr>
            <td class="tableTitle"><label>작성자</label></td>
            <td><input type="text" value="<%=Name%>"></td>
            <input type="hidden" name="MEM_NO" value="<%=No%>">
            <td class="tableTitle"><label>작성일</label></td>
            <td><input type="text" id="currentDateInput" readonly></td> <!--작성일 나오게-->
          </tr>
          <tr>
            <td class="tableTitle"><label>말머리</label></td>
            <td><select name="NOTSUB_NO">
              <option value="1">공지</option>
              <option value="2">긴급</option>
              <option value="3">필독</option>
            </select></td>
            <td class="tableTitle"><label>해당 부서</label></td>
            <td><select name="#">
              <option value="1">부서 1</option>
              <option value="2">부서 2</option>
              <option value="3">부서 3</option>
            </select></td>
          </tr>
          <tr>
            <td class="tableTitle"><label>제목</label></td>
            <td colspan="3"><input type="text" id="not_title" name="NOT_TITLE"></td> <!--작성자 이름 나오게-->
          </tr>
          <tr>
            <td class="tableTitle detail"><label>상세 내용</label></td>
            <td colspan="3"><textarea id="not_content" name="NOT_CONTENT"></textarea></td>
          </tr>
          <tr>
            <td class="tableTitle"><label>첨부 파일</label></td>
            <td colspan="3"><input type="file" name="NOT_FILENAME"></td>
           </tr>
        </table>
        <div id="btns">
           <input type="submit" value="등록하기" style="text-align:center">
          <button><a href="notice.jsp">뒤로가기</a></button>
        </div>
      </form>
  </div>
  </section>

<script src="../script/indexScript.js"></script>  
<script src="../script/noticeJs.js"></script>
<script>
    function getCurrentDate() {
      var currentDate = new Date();
      var year = currentDate.getFullYear();
      var month = String(currentDate.getMonth() + 1).padStart(2, '0');
      var day = String(currentDate.getDate()	).padStart(2, '0');

      return year + '-' + month + '-' + day;
    }

    var currentDateInput = document.getElementById('currentDateInput');
    currentDateInput.value = getCurrentDate();
</script>
</body>
</html>