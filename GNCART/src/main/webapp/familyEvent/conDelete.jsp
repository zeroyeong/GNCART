<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr" /> 

<% 
request.setCharacterEncoding("UTF-8");
 
String checkedList [] = request.getParameterValues("check");
String conNum = request.getParameter("con_no");

String pageName = request.getParameter("pageName");
int memNo = (int)session.getAttribute("memNo");
int acNo = (int)session.getAttribute("acNo");
%> 
<!DOCTYPE html>
<html lang="ko">
<head> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<%
 
//선택된 게시글이 없을때
if(checkedList == null && pageName.equals("condolences")){
%>
	<script type="text/javascript">
    	alert("선택된 게시글이 없습니다.");
    </script>
<%	
}
//게시판 에서 삭제 
if(checkedList != null){ 
	boolean myboard = true;

	myboard = conMgr.checkBoard(checkedList, memNo); //게시판에서 체크한 항목이 내가 작성한 글인지 확인
	
	if(acNo == 2){
		myboard = true;
	}
	
	if(myboard){
		conMgr.deleteBoard(checkedList); //삭제 
%>
		<script type="text/javascript">
			alert("선택된 게시글이 삭제되었습니다.");
		</script>
<% 		
	} else {
%>		
		<script type="text/javascript">
			alert("본인이 작성한 게시글만 삭제가 가능합니다.");
		</script>
<% 	
	}
}
//본인글에 들어가서 삭제 
else if(conNum != null && conNum != ""){ 
	int con_no =Integer.parseInt(conNum); 
	conMgr.deleteBoard(con_no);
%>
	<script type="text/javascript">
		alert("게시글이 삭제되었습니다.");
	</script>
<%
}
%>

<script type="text/javascript">
location.href="condolences.jsp";
</script>


</body>
</html>