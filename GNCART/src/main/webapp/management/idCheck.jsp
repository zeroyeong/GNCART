<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<jsp:useBean id="mMgr" class="management.ManagementMgr"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ID �ߺ�Ȯ��</title>
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
      <h3 class="pageTitle">ID �ߺ�Ȯ��</h3>
      <button onclick="window.close()">��</button>
    </div>
      
    <form action="idCheck.jsp" method="post">
    	<p>
      �Է��Ͻ� ID <span><%=MEM_ID %></span> ��(��)<br />
      <%
			if(result){
				out.println("�̹� �����ϴ� ID�Դϴ�.");
		%>
		</p>
		<div class="no">
        <label>ID : </label><input name="MEM_ID" type="text" />
        <input type="submit" value="�ߺ�Ȯ��" />
      </div>
		<%
			}else{
				out.println("��� ������ ���̵��Դϴ�.");%>
		<div class="yes">
      <p>����Ͻðڽ��ϱ�?</p>
      <input type="button" value="����ϱ�" onclick="idCheck()" />
    </div>
			<%}
		%>
    </form>
  </div>
</body>
</html>