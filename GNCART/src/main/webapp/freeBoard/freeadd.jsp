<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
    <%
	request.setCharacterEncoding("UTF-8");

	String Name = (String)session.getAttribute("memName");
	Integer No = (Integer)session.getAttribute("memNo");
	
	if(No == null) {
%>
<script>
	alert("로그인이 되어있지않습니다.");
	window.location.href = "../login.jsp";
</script>
<%
	return;
	}   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/freeadd.css">
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
        <h2>자유게시판</h2>
      </div>      
      <hr>   
      <form name="postFrm" method="post" action="boardPost" enctype="multipart/form-data">
        <table>
          <tr>
            <td class="tableTitle"><label>작성자</label></td>
            <td><input type="text" value="<%=Name%>"></td>
            <input type="hidden" name="MEM_NO" value="<%=No%>">
			<td class="tableTitle"><label>해당부서</label></td>
			<td><select name="PART_NO">
					<option value="1">경영지원팀</option>
					<option value="2">개발팀</option>
					<option value="3">홍보팀</option>
					<option value="4">영업팀</option>
					<option value="5">서비스지원팀</option>
					<option value="6">전체부서</option>
			</select></td>
          </tr>
          <tr>
            <td class="tableTitle"><label>제목</label></td>
            <td colspan="3"><input type="text" id="FREE_TITLE" name="FREE_TITLE"></td> <!--작성자 이름 나오게-->
          </tr>
          <tr>
            <td class="tableTitle detail"><label>상세 내용</label></td>
            <td colspan="3"><textarea id="FREE_CONTENT" name="FREE_CONTENT"></textarea></td>
          </tr>
          <tr>
            <td class="tableTitle"><label>첨부 파일</label></td>
            <td colspan="3"><input type="file" name="FREE_FILENAME"></td>
           </tr>
        </table>
        <div id="btns">
           <input type="submit" value="등록하기" style="text-align:center">
          <button><a href="free.jsp">뒤로가기</a></button>
        </div>
      </form>
  </div>
  </section>
<script src="../script/free.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script src="../script/indexScript.js"></script>

</script>
</body>
</html>
