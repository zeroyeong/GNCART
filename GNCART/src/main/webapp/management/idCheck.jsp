<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<jsp:useBean id="mMgr" class="management.ManagementMgr"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ID 중복확인</title>
<link rel="stylesheet" href="../css/idCheck.css" />
</head>

<%
	request.setCharacterEncoding("UTF-8");
	
	String MEM_ID = request.getParameter("MEM_ID");
	boolean result = mMgr.checkId(MEM_ID);
%>

<script>
	function idCheck(){
		opener.newFrm.MEM_ID.value='<%=MEM_ID%>';
		opener.newFrm.check.value=true;
		window.close();
		opener.newFrm.MEM_PW.focus();
		opener.console.log(opener.newFrm.check.value);
	}
</script>

<body>
	
	<div class="container">
    <div class="title">
      <h3 class="pageTitle">ID 중복확인</h3>
      <button onclick="window.close()">×</button>
    </div>
      
    <form action="idCheck.jsp" method="post">
    	<p>
      입력하신 ID <span><%=MEM_ID %></span> 는(은)<br />
      <%
			if(result){
				out.println("이미 존재하는 ID입니다.");
		%>
		</p>
		<div class="no">
        <label>ID : </label><input name="MEM_ID" type="text" />
        <input type="submit" value="중복확인" />
      </div>
		<%
			}else{
				out.println("사용 가능한 아이디입니다.");%>
		<div class="yes">
      <p>사용하시겠습니까?</p>
      <input type="button" value="사용하기" onclick="idCheck()" />
    </div>
			<%}
		%>
    </form>
  </div>
</body>
</html>