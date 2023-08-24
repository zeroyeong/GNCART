<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector" %>
<%@page import="management.ManagementBean" %>
<jsp:useBean id="conMgr" class="familyEvent.ConMgr"/>
 
<%
//로그인 안했을 시 로그인 페이지로 리다이렉트 
if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null) {
	response.sendRedirect("../login.jsp");
	return; 
}

//캐시 설정(로그아웃 하고 뒤로가기시 인덱스 접근 차단)
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

request.setCharacterEncoding("UTF-8");
String keyWord = "";

if(request.getParameter("keyWord") != null){
	keyWord = request.getParameter("keyWord");
}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/conPopup.css">
 
</head>
<body style="background-color: #96969648">
	<div class="container">
      <div class="title">
        <h3>사원찾기</h3>
        <span>×</span>
        <!-- x버튼 클릭시 windouw.close() 실행될 수 있도록 해주시면 깔끔할거같습니당! 
        필요없다면 삭제해도 무방합니다.-->
      </div>
      <div class="content">
        <form name="userFrm" method="post" action="conAddUser.jsp" autocomplete="off">  
        <table>      
          <tr>
            <td>부서 / 이름</td>
            <td><input type="text" id="searchbar" placeholder="이름을 입력해 주세요" onClick="test()" autocomplete="off"></td>
            <td>
              <button type="button" id="searchBtn" onClick="searchUser()">찾기</button>
            </td>
          </tr>        
          <tr id="allList">
            <td colspan="3">
              <select id="selectAll" name="selectAll" onclick= "abctest()">
                <option> 선택해 주세요 </option>
                <%
                  Vector<ManagementBean> mlist = conMgr.userSearch();
                
                  for(int i=0; i<mlist.size(); i++){
      
                    ManagementBean mbean = new ManagementBean();
                    mbean = mlist.get(i);
                    
                    String MEM_NAME = mbean.getMEM_NAME();
                    String PART_TYPE = mbean.getPART_TYPE();					
                %>
                <option value= "<%= i+1 %>" ><%= PART_TYPE %> / <%= MEM_NAME %></option>
                <%
                }//for
                %>
              </select>
            </td>
          </tr>
          
          <tr id="searchList" style="display: none">
            <td colspan="3">
				<select id="selectKeyword" name="selectKeyword" onclick= "abctest()">
                <%
                  Vector<ManagementBean> ulist = conMgr.userFind(keyWord);
                  for(int i=0; i<ulist.size(); i++){
                    ManagementBean ubean = new ManagementBean();
                    ubean = ulist.get(i);	
                    
                    String MEM_NAME = ubean.getMEM_NAME();
                    String PART_TYPE = ubean.getPART_TYPE();
                %>                
                <option><%= PART_TYPE %> / <%= MEM_NAME %></option>
                <%
                  }
                %>				
              </select>
            </td>
          </tr>

        </table>
        <div class="button">
          <input type="button" onClick="sendUser()" value="저장" />
        </div>
        <input type="hidden" id="user" name="user">
        <input type="hidden" id="keyWord" name="keyWord" value="<%= keyWord %>">
        </form>	
      </div>
    </div>

<script src="../script/conaddUser.js"></script>

</body>
</html>