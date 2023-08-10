<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeBoard.replyDAO" %>
<jsp:useBean id="reply" class="freeBoard.reply" scope="page"/>
<jsp:setProperty name="reply" property="replyContent"/>
<%@ page import="java.io.PrintWriter" %>
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
	<%
	
		request.setCharacterEncoding("UTF-8");
		
	
		int MEM_NO=1;   	
	
		int FREE_NO=1;
		if(request.getParameter("FREE_NO")!=null){
			FREE_NO=Integer.parseInt(request.getParameter("FREE_NO"));
		}
	
		String MEM_NAME=null;
		if(session.getAttribute("MEM_NAME")!=null){
			MEM_NAME=(String)session.getAttribute("MEM_NAME");
		}
		if(MEM_NAME==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}	
		else{
			if(reply.getReplyContent()==null){
				PrintWriter script= response.getWriter();
				script.println("<script>");
				script.println("alert('댓글을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				replyDAO replyDAO=new replyDAO();
				int result = replyDAO.write(MEM_NAME, FREE_NO, reply.getReplyContent(), MEM_NO);
				if(result==-1){
					PrintWriter script= response.getWriter();
					script.println("<script>");
					script.println("alert('댓글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					String url="../freeread.jsp?FREE_NO="+FREE_NO;
					PrintWriter script= response.getWriter();
					script.println("<script>");
					script.println("location.href='"+url+"'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>