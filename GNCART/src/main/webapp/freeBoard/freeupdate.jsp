<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeBoard.BoardBean"%>
<% 
	  //read.jsp 페이지에서 이동한 num, nowPage 파라미터를 받아 각 각 변수에 저장
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  
	  //session에 저장된 bean객체를 이용해서 게시물 정보를 각 각 변수에 저장 
	  BoardBean bean = (BoardBean)session.getAttribute("bean");
	  String FREE_TITLE = bean.getFREE_TITLE();
	  String MEM_NAME = bean.getMEM_NAME(); 
	  String FREE_CONTENT = bean.getFREE_CONTENT(); 
%>
<!DOCTYPE html>
<html>
<head> 
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/free.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
	<script>
		//패스워드 가 입력 되었는지 확인하는 check() 함수
		function check() {
		   if (document.updateFrm.pass.value == "") {
			 alert("수정을 위해 패스워드를 입력하세요.");
			 document.updateFrm.pass.focus();
			 return false;
			 }
		   document.updateFrm.submit();
		}
	</script>
</head>
<body>
  <!-- sidebar include -->	
  <jsp:include page="../index/sidebar.jsp" flush="false"/>	

<section class="home-section">
   <!-- top include -->
  <jsp:include page="../index/top.jsp" flush="false"/>
	

  <!--home-content-->  
    <div class="container-fluid">
      <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6>자유게시판</h6>
        </div>
	<div align="center"><br/><br/>
	<table width="600" cellpadding="3">
	  <tr>
	   <td height="21" align="center">수정하기</td>
	  </tr>
	</table>
	<!-- boardUpdate 로 url맵핑된 서블릿으로 이동한다. -->
	<form name="updateFrm" method="post" action="boardUpdate">
	<table width="600" cellpadding="7">
	 <tr>
	  <td>
	   <table>
	    <tr>
	     <td width="20%">성 명</td>
	     <td width="80%">
		  <input name="name" value="<%=MEM_NAME%>" size="30" maxlength="20">
		 </td>
		</tr>
		<tr>
	     <td>제 목</td>
	     <td>
		  <input name="subject" size="50" value="<%=FREE_TITLE%>" maxlength="50">
		 </td>
	    <tr>
	     <td>내 용</td>
	     <td>
		  <textarea name="content" rows="10" cols="50"><%=FREE_CONTENT%></textarea>
		 </td>
	    </tr>
		<tr>
	     <td>비밀 번호</td> 
	     <td><input type="password" name="pass" size="15" maxlength="15">
	      수정 시에는 비밀번호가 필요합니다.</td>
	    </tr>
		<tr>
	     <td colspan="2" height="5"><hr/></td>
	    </tr>
		<tr>
	     <td colspan="2">
		  <input type="button" value="수정완료" onClick="check()">
	      <input type="reset" value="다시수정"> 
	      <input type="button" value="뒤로" onClick="history.go(-1)">
		 </td>
	    </tr> 
	   </table>
	  </td>
	 </tr>
	</table>
	 <input type="hidden" name="nowPage" value="<%=nowPage %>">
	 <input type='hidden' name="num" value="<%=num%>">
	</form> 
	</div>
</body>
</html>