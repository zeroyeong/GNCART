<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="login.MemberMgr" />
<% 
String Name = (String)session.getAttribute("memName");
Integer No = (Integer)session.getAttribute("memNo");
String Part = (String)session.getAttribute("parttype");
int PartNo = (int)session.getAttribute("partNo");
%> 
 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/freeadd.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  
</head>
<body> 
  <!-- sidebar include -->	
  <jsp:include page="../index/sidebar.jsp" flush="false"/>	

<section class="home-section">
   <!-- top include -->
  <jsp:include page="../index/top.jsp" flush="false"/>
	
  <!--home-content-->  
  <div class="home-content">
    <div id="container">
      <div id="title">
        <h3>자유게시판</h3>
      </div>      
	      <div class="content">
	        <form name="postFrm" method="post" action="boardPost" enctype="multipart/form-data">
	        <div class="content">
	          <table>
              <colgroup>
                <col class="col1" />
                <col class="col2" />
                <col class="col3" />
                <col class="col4" />
              </colgroup>
              <tr>
                <td><span>제목</span></td>
                <td colspan="3">
                  <input id="detailTitle" name="FREE_TITLE" required />
                </td>  
              </tr>
              <tr>
                <td><span>날짜</span></td>
                <td><input type="text" id="currentDateInput" readonly></td>
              </tr>
              <tr>
                <td><span>부서 / 이름</span></td>
                <td colspan="3">
                  <div class="user">
					<input type="text" value="<%=Part %> / <%=Name%>" readonly>
					<input type="hidden" name="MEM_NO" value="<%=No%>">
					<input type="hidden" name="PART_NO" value="<%=PartNo%>">
                  </div>
                </td>
              </tr>
              <tr>
                <td><span class="memeo">내용</span></td>
                <td colspan="3">
                  <textarea
                    name="FREE_CONTENT"
                    id="detailContent"
                    rows="10"
                  ></textarea>
                </td>
              </tr>
              <tr>
                <td><span>첨부파일</span></td>
                <td colspan="3">
                  <div class="file">
                    <input
                      type="text"
                      id="filename"
                      placeholder="첨부파일"
                      readonly
                    />
                    <label for="file">파일찾기</label> 
                    <input
                      type="file"
                      id="file"
                      name="FREE_FILENAME"
                      onclick="findFile()"
                    />
                  </div>
                </td>
              </tr>
            </table>
	          <div class="button">
	            <button type="submit">작성하기</button>
	            <a href="free.jsp">
	         	   <button type="button">목록</button>
	            </a>
	          </div>
	          </div>
	        </form>
	      </div>
	    </div>
	</div>

	</section>

<script src="../script/free.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script src="../script/indexScript.js"></script>

</script>
</body>
</html>
