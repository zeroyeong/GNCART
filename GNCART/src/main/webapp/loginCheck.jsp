<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>

<%
	  request.setCharacterEncoding("UTF-8");
	  String id = request.getParameter("id");
	  String pw = request.getParameter("pw");
	  
	  String url = "login.jsp";
	  String msg = "로그인에 실패";
	  
	  //MemberMgr 클래스 loginMember() 메서드 호출 하여 결과값은 boolean 타입 으로 return 
	  boolean result = mMgr.loginMember(id,pw,request);
	  
	  if(result){
		//result 결과값이 true 일때 
	    session.setAttribute("idKey",id);
	    session.setAttribute("pwKey",pw);
		
	    //관리자 페이지로 로그인 	
	    if(mMgr.acNum == 2){
	    	msg = "관리자 로그인 성공";
	        url = "management/managementIndex/jsp/managementIndex.jsp";
	    }
	    
	    //일반로그인
	    else{
	    	msg = "로그인에 성공";
			url = "index/index.jsp";
	    }
	  }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		alert("<%=msg%>");	
		location.href="<%=url%>";
	</script>
</body>
</html>