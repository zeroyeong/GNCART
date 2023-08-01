<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="schedule.ScheduleBean"%>
<jsp:useBean id="sMgr" class="schedule.ScheduleMgr" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GNC:ART - 상세일정</title>
<link rel="stylesheet" href="../../css//scheduleDetail.css">
</head>
<body>

<% 

	int SCHE_NO = Integer.parseInt(request.getParameter("SCHE_NO"));
	
	ScheduleBean bean = sMgr.getSchedule(SCHE_NO);
	
	int TYPE_NO = bean. getTYPE_NO(); //일정 종류
	String TYPE_TYPE = bean.getTYPE_TYPE();
	
	String SCHE_NAME=bean.getSCHE_NAME(); //일정 제목
	
	int PART_NO = bean.getPART_NO(); //일정 해당 부서
	String PART_TYPE = bean.getPART_TYPE();
	
	String MEM_NAME = bean.getMEM_NAME(); //작성자
	String SCHE_DATE = bean.getSCHE_DATE();
	
	String SCHE_DETAIL = bean.getSCHE_DETAIL(); //일정 상세내용
	
	String SCHE_FILE = bean.getSCHE_FILE(); //첨부파일
	
	String SCHE_START_DATE = bean.getSCHE_START_DATE(); //시작날짜
	
	int ST_NO = bean.getST_NO(); //시작 시간
	String ST_TIME = bean.getST_TIME();
	
	String SCHE_END_DATE = bean.getSCHE_END_DATE(); //종료날짜
	
	int END_NO = bean.getEND_NO(); //종료 시간
	String END_TIME = bean.getEND_TIME();
	
	session.setAttribute("bean", bean); // 수정을 위해서 session에 bean 정보 저장
%>

	<div class="container">
    <!----------------------------------->
    <!----------------타이틀--------------->
    <!----------------------------------->
	<div class="top">
	    <h3 class="title">일정 내용</h3>
    	<a href="#" id="closeBtn" onclick="closeBox()">×</a>
	</div>


    <!----------------------------------->
    <!----------------본문---------------->
    <!----------------------------------->

    <div class="content">        
        <table>
          <tr>
            <td>일정종류</td>
            <td><%=TYPE_TYPE%></td>
          </tr>
          <tr>
            <td>일정 제목</td>
            <td><%=SCHE_NAME%></td>
          </tr>
          <tr>
            <td>일정 기간</td>
            <td><%=SCHE_START_DATE%> <%=ST_TIME %>~ <%=SCHE_END_DATE %> <%=END_TIME %></td>
          </tr>
          <tr>
            <td>해당 부서</td>
            <td><%=PART_TYPE%></td>
          </tr>
          <tr>
            <td>최초 등록</td>
            <td>
              <%=MEM_NAME%> (<%=SCHE_DATE%>)
            </td>
          </tr>
          <tr>
            <td>내용</td> <!-- 내용이 있으면 내보내고 null이라면 그냥 아무것도 없이 둬라 -->
           	<%
           		if(SCHE_DETAIL != null){
           	%>
           	
           		<td>
           			<%=SCHE_DETAIL %>
           		</td>
           		
           	<%
           		}else{
           	%>
           		<td> </td>
           	<%
           		}
           	%>
          </tr>
          <tr>
            <td>첨부파일</td> <!-- 파일이 있으면 내보내고 null이라면 - 를 대신 출력해라 -->
           	<%
           		if(SCHE_FILE != null){%>
           		<td><a href="javascript:download(<%=SCHE_FILE%>)"></a></td>
           	<%
           		}else{
           	%>
           		<td>-</td>
           	<%
           		}
           	%>
          </tr>
        </table>
        <input type="hidden" name="SCHE_NO" value="<%=SCHE_NO %>"> <!-- 수정을 위한 SCHE_NO / hidden input -->

        <!----------------------------------->
        <!----------------버튼---------------->
        <!----------------------------------->

        <div class="button">
          <input type="button" value="수정" onclick="update()">
          <input type="button" value="삭제">
        </div>
    </div>
  </div>

  <!----------------------------------->
  <!---------------스크립트-------------->
  <!----------------------------------->

  <script src="../script/popup.js"></script>
  <script>
  	function update(){
  		location.href="updateSchedule.jsp?SCHE_NO=<%=SCHE_NO%>";
  	}
  </script>
</body>
</html>