<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		  request.setCharacterEncoding("UTF-8");
		  String id = request.getParameter("id");
		  String pw = request.getParameter("pw");
		  
		  String url = "login.jsp";
		  String msg = "로그인에 실패";
		  
		  //MemberMgr 클래스 loginMember() 메서드 호출 하여 결과값은 boolean 타입 으로 return 
		  boolean result = mMgr.loginMember(id,pw);
		  String name = mMgr.nameFind(id, pw);
		  
		  
		  if(result){
			//result 결과값이 true 일때 
		    session.setAttribute("idKey",id);
		    session.setAttribute("pwKey",pw);
			
		    msg = "로그인에 성공";
			
			url = "index/index.jsp";
			
		  }
	%>
</body>
</html>
<script>
	alert("<%=msg%>");	
	location.href="<%=url%>";
</script>