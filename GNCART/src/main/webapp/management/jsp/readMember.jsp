<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="management.ManagementBean" %>
<jsp:useBean id="mMgr" class="management.ManagementMgr"/>

<% 
	request.setCharacterEncoding("UTF-8");

// 	System.out.println("---------------read 입장!---------------");

	int MEM_NO = Integer.parseInt(request.getParameter("MEM_NO"));
	
	String nowPage = request.getParameter("nowPage"); 
	
	ManagementBean bean = mMgr.getMember(MEM_NO);
	
	String MEM_NAME=bean.getMEM_NAME();
	String MEM_ID=bean.getMEM_ID();
	String MEM_PW=bean.getMEM_PW();
	String AC_TYPE=bean.getAC_TYPE();
	String WORK_TYPE=bean.getWORK_TYPE();
	String MEM_DATE=bean.getMEM_DATE();
	String PART_TYPE=bean.getPART_TYPE();
	String LE_LEVEL=bean.getLE_LEVEL();
	String MEM_TEL=bean.getMEM_TEL();
	String MEM_MAIL=bean.getMEM_MAIL();
	String MEM_PHONE=bean.getMEM_PHONE();
	String MEM_ADD=bean.getMEM_ADD();
	String MEM_BIRTH=bean.getMEM_BIRTH();
	String MEM_AND=bean.getMEM_AND();
	String MEM_IMG=bean.getMEM_IMG();
	String AP_TYPE=bean.getAP_TYPE();
	
	session.setAttribute("bean", bean);
	
	%>

<!DOCTYPE html>
<html lang="ko">
 
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../../css/index.css">
  
  <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>	
  <!--boxIcons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  
  <!-- 현재 파일의 css -->
	<link rel="stylesheet" href="../../css/readMember.css?sdfss">
	
	<!-- 현재 파일 - includeTop css -->
	<link rel="stylesheet" href="include/include.css?odd">
	
	<script>
		function list(){
			document.listFrm.submit();
		}
		function down(MEM_IMG){
			 document.downFrm.MEM_IMG.value=MEM_IMG;
			 document.downFrm.submit();
		}
	</script>
	
</head>

<body>
  <!-- sidebar include -->
  <jsp:include page="../../index/sidebar.jsp" flush="false" />

  <section class="home-section">
    <!-- top include -->
    <jsp:include page="../../index/top.jsp" flush="false" />
	
	<!--_______________본문시작_______________-->
    <div class="home-content">
      <div class="member">
        <!-- management include top -->
        <jsp:include page="include/includeTop.jsp" />

        <div class="pageTitle">
          <h3>사용자 : <%=MEM_NAME%></h3>
          <div class="buttons">
            <input type="button" value="수정" onclick="memberUpdate()" />
            <input type="button" value="리스트" onclick="memberList()" />
          </div>
        </div>

        <div class="memberViewTable">
          <table class="memberTable">
            <tr>
              <td colspan="4">
                <% if(MEM_IMG != null && MEM_IMG != ""){ %>
                <img src="../filestorage/<%=MEM_IMG %>" alt="" />
                <% }else{ %>
                <img src="../filestorage/profile.jpg" />
                <% } %>
              </td>
            </tr>
            <tr>
              <td>사번</td>
              <td><%=MEM_NO %></td>
              <td>계정상태</td>
              <td><%=AP_TYPE %></td>
            </tr>
            <tr>
              <td>생년월일</td>
              <td><%=MEM_BIRTH %></td>
              <td>입사일</td>
              <td><%=MEM_DATE %></td>
            </tr>
            <tr>
              <td>부서</td>
              <td><%=PART_TYPE %></td>
              <td>직위</td>
              <td><%=LE_LEVEL %></td>
            </tr>
            <tr>
              <td>ID</td>
              <td><%=MEM_ID %></td>
              <td>PW</td>
              <td><%=MEM_PW %></td>
            </tr>
            <tr>
              <td>근로형태</td>
              <td><%=WORK_TYPE %></td>
              <td>내선번호</td>
              <td><%=MEM_TEL %></td>
            </tr>
            <tr>
              <td>휴대전화</td>
              <td><%=MEM_PHONE %></td>
              <td>e-mail</td>
              <td><%=MEM_MAIL %></td>
            </tr>
            <tr>
              <td>자택주소</td>
              <td colspan="3"><%=MEM_ADD %></td>
            </tr>
            <tr>
              <td>기타정보</td>
              <td colspan="3"><%=MEM_AND %></td>
            </tr>
            <tr>
              <td></td>
              <td></td>
              <td>계정구분</td>
              <td><%=AC_TYPE %></td>
            </tr>
          </table>
          <div>
            <table class="workInfo">
              <thead>
                <tr>
                  <td colspan="13"><%=MEM_NAME%> 님의 근태현황</td>
                </tr>
                <tr>
                  <td colspan="2">총 연차</td>
                  <td colspan="2">15개</td>
                  <td colspan="2">잔여 연차</td>
                  <td colspan="2">10개</td>
                  <td colspan="3"></td>
                  <td colspan="2"><button>상세보기</button></td>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td></td>
                  <td>1월</td>
                  <td>2월</td>
                  <td>3월</td>
                  <td>4월</td>
                  <td>5월</td>
                  <td>6월</td>
                  <td>7월</td>
                  <td>8월</td>
                  <td>9월</td>
                  <td>10월</td>
                  <td>11월</td>
                  <td>12월</td>
                </tr>
                <tr>
                  <td>지각</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>
                <tr>
                  <td>조퇴</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>
                <tr>
                  <td>병가</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>
                <tr>
                  <td>연차</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>
                <tr>
                  <td>월차</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
 	</div>
 </section>

  <script src="../../script/indexScript.js"></script>
  
  <script>
  	function memberUpdate(){
  		location.href="modify.jsp?nowPage=<%=nowPage %>&MEM_NO=<%=MEM_NO%>"
  	}
  	
  	function memberList(){
  		location.href="memberList.jsp"
  	}
  </script>
</body>
</html>