<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeBean"%>
<% 
	  //read.jsp 페이지에서 이동한 num, nowPage 파라미터를 받아 각 각 변수에 저장
	  int NOT_NO = Integer.parseInt(request.getParameter("NOT_NO"));
	  
	  //session에 저장된 bean객체를 이용해서 게시물 정보를 각 각 변수에 저장 
	  NoticeBean bean = (NoticeBean)session.getAttribute("bean");
	  String NOT_TITLE = bean.getNOT_TITLE();
	  String NOT_CONTENT = bean.getNOT_CONTENT(); 
	  String NOT_DATE = bean.getNOT_DATE();
	  int MEM_NO = bean.getMEM_NO();
	  int NOTSUB_NO = bean.getNOTSUB_NO();
	  String MEM_NAME = bean.getMEM_NAME();
	  String NOT_SUB = bean.getNOT_SUB();
	  
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/noticeWrite.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
  <!-- sidebar include -->	
  <jsp:include page="../index/sidebar.jsp" flush="false"/>	

   <!-- top include -->
  <jsp:include page="../index/top.jsp" flush="false"/>
	

  <!--home-content-->  
  <div class="home-content">
    <div id="container">
      <div id="title">
        <h2>공지사항</h2>
      </div>
      
      <hr>
      
      <form name="ReviseFrm" method="post" action="../noticeRevise">
        <table>
          <tr>
            <td class="tableTitle"><label for="#">작성자</label></td>
            <td><input type="text" id="#" name="MEM_NO" value="<%=MEM_NAME%>" readonly></td> <!--작성자 이름 나오게-->
            <td class="tableTitle"><label for="#">작성일</labe></td>
            <td><input type="text" id="#" name="NOT_DATE" value="<%=NOT_DATE%>" readonly></td> <!--작성일 나오게-->
          </tr>
          <tr>
            <td class="tableTitle"><label for="#">말머리</label></td>
            <td><select id="#" name="NOTSUB_NO">
   			 <option value="1" <%= (NOTSUB_NO == 1) ? "selected" : "" %>>공지</option>
  	 		 <option value="2" <%= (NOTSUB_NO == 2) ? "selected" : "" %>>긴급</option>
    		 <option value="3" <%= (NOTSUB_NO == 3) ? "selected" : "" %>>필독</option>
            </select></td>
            <td class="tableTitle"><label for="#">해당 부서</label></td>
            <td><select id="#" name="#">
              <option value="part1">부서 1</option>
              <option value="part1">부서 2</option>
              <option value="part1">부서 3</option>
            </select></td>
          </tr>
          <tr>
            <td class="tableTitle"><label>제목</label></td>
            <td colspan="3"><input type="text" id="#" name="NOT_TITLE" value="<%=NOT_TITLE%>"></td> <!--작성자 이름 나오게-->
          </tr>
          <tr>
            <td class="tableTitle detail"><label for="#">상세 내용</label></td>
            <td colspan="3"><textarea id="#" name="NOT_CONTENT"><%=NOT_CONTENT%></textarea></td>
          </tr>
          <tr>
            <td class="tableTitle"><label for="#">첨부 파일</label></td>
            <td colspan="3"><input type="file" id="#" name="NOT_FILENAME"></td>
          </tr>
        </table>
        <div id="btns">
          <input type="button" value="수정하기" onClick="check()">
          <button><a href="noticeDelete.jsp?=&NOT_NO=<%=NOT_NO%>">삭제하기</a></button>
        </div>
      </div>
        <input type='hidden' name="NOT_NO" value="<%=NOT_NO%>">
      </form>
  </div>
  </section>


<script src="../script/indexScript.js"></script>  
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>  
<script>
		function check() {
		   document.ReviseFrm.submit();
		}
</script>

</body>
</html>