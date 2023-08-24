<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="freeBoard.BoardMgr" />
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
	<%
		//read.jsp 페이지에서 filename 파라미터를 갖고 download.jsp 페이지로 이동함
		//filename 파라미터가 포함된 request객체 (요청객체) 등 총 4가지의 객체를 매개변수로 메서드 호출. 
		//request(요청 객체), response(응답 객체), out(출력 객체), pageContext(페이지정보 객체)
		  bMgr.downLoad(request, response, out, pageContext);
	%>
</body>
</html>   