<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<%
		//read.jsp 페이지에서 filename 파라미터를 갖고 download.jsp 페이지로 이동함
		//filename 파라미터가 포함된 request객체 (요청객체) 등 총 4가지의 객체를 매개변수로 메서드 호출. 
		//request(요청 객체), response(응답 객체), out(출력 객체), pageContext(페이지정보 객체)
		  nMgr.downLoad(request, response, out, pageContext);
	%>
</body>
</html>