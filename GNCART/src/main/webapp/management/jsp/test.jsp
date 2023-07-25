<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="management.ManagementBean"    
    import="java.util.Vector"%>
    	
<jsp:useBean id="mMgr" class="management.ManagementMgr"/>

<%
 //로그인 안했을 시 로그인 페이지로 리다이렉트 
 if (session.getAttribute("idKey") == null || session.getAttribute("pwKey") == null)
    response.sendRedirect("../../login.jsp");

 // 캐시 설정
 response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate" ); 
 response.setHeader("Pragma", "no-cache" ); 
 response.setHeader("Expires", "0" ); 
%>

<!DOCTYPE html>
<html lang="ko">
 
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../../css/index.css">
  <link rel="stylesheet" href="../css/newMember.css">
  <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>	
  <!--boxIcons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

<body>
  <!-- sidebar include -->
  <jsp:include page="../../index/sidebar.jsp" flush="false" />

  <section class="home-section">
    <!-- top include -->
    <jsp:include page="../../index/top.jsp" flush="false" />


    <!--_______________본문시작_______________-->  	
	<div class="home-content">
		<div id="container">
        	
        	<!--            페이지 타이틀            -->
        	<div class="title">
        		<h2>관리자 페이지</h2>
        		
        		<div class="btns">
        			<a href="memberList.jsp">사용자 조회</a>
        			<a href="newMember.jsp">사용자 추가</a>
        		</div>
        		
        		<div class="smallTitle">
        			<h3>사용자 추가</h3>
        		</div>
        	</div>
        	
        	<div class="content">
          <div class="caution">
            <p>- 프로필 사진 권장 최대 사이즈는 330*330px (10MB 미만)입니다.</p>
          </div>

          <form name="newFrm" method="post" action="../../management/NewMemberServlet" enctype="multipart/form-data">
              <table>
		        <tr>
		          <td rowspan="4" class="mem-img">
					<input type="file" name="MEM_IMG">
				  </td>
		          <td class="secondTd">이름</td>
		          <td><input name="MEM_NAME" type="text" required id="name"></td>
		        </tr>
		        <tr>
		          <td>ID</td>
		          <td><input name="MEM_ID" type="text" required id="id"></td>
		        </tr>
		        <tr>
		          <td>비밀번호</td>
		          <td><input name="MEM_PW" type="text" required id="pw"></td>
		        </tr>
		        <tr>
		          <td>계정구분</td>
		          <td>
			          <input type="radio" name="AC_NO" value="1" checked><span>일반사용자</span>
			          &nbsp;&nbsp; 
			          <input type="radio" name="AC_NO" value="2"><span>관리자사용자</span>
		          </td>
		        </tr>
		      </table>

		      <table>
<!-- 		        <tr> -->
<!-- 		          <td class="firtstTd">사번</td> -->
<!-- 		          <td><input name="MEM_NO" readonly type="text"></td> -->
<!-- 		        </tr> -->
		        <tr>
		          <td>근로형태</td>
		          <td>
			          <input type="radio" name="WORK_NO" value="1" checked><span>정규직</span>
			          &nbsp;&nbsp; 
			          <input type="radio" name="WORK_NO" value="2"><span>계약직</span>
		          </td>
		        </tr>
		        <tr>
		          <td>입사일</td>
		          <td><input name="MEM_DATE" type="text" id="date" required placeholder="-포함해서 입력 ex) 2023-07-17"></td>
		        </tr>
		        <tr>
		          <td>소속부서</td>
		          <td>
		          	<select name="PART_NO"  id="part">
		          		<option>선택</option>
			          	<%
							Vector<ManagementBean> partlist = mMgr.getPartList();
							
							if(partlist.isEmpty()){
						%>
						<option>등록된 type이 없습니다.</option>
						<%
							}else{
								for(int i=0; i<partlist.size(); i++){
									ManagementBean PARTbean=new ManagementBean();
									
									PARTbean=partlist.get(i);
									
									int PART_NO = PARTbean.getPART_NO();
									String PART_TYPE = PARTbean.getPART_TYPE();
									
						%>
						<option value="<%=PART_NO%>"><%=PART_TYPE %></option>
						<%
								}
							}
						%>
		          	</select>
		          </td>
		        </tr>
		        <tr>
		          <td>직위</td>
		          <td>
		          	<select name="LE_NO" id="level">
		          		<option>선택</option>
			          	<%
							Vector<ManagementBean> lelist = mMgr.getLevelList();
							
							if(lelist.isEmpty()){
						%>
						<option>등록된 type이 없습니다.</option>
						<%
							}else{
								for(int i=0; i<lelist.size(); i++){
									ManagementBean LEbean=new ManagementBean();
									LEbean=lelist.get(i);
									int LE_NO = LEbean.getLE_NO();
									String LE_LEVEL=LEbean.getLE_LEVEL();
						%>
						<option value="<%=LE_NO%>"><%=LE_LEVEL %></option>
						<%
								}
							}
						%>
		          	</select>
		          </td>
		        </tr>
		        <tr>
		          <td>내선번호</td>
		          <td><input name="MEM_TEL" type="text"></td>
		        </tr>
		        <tr>
		          <td>이메일</td>
		          <td><input name="MEM_MAIL" type="text" type="email"></td>
		        </tr>
		        <tr>
		          <td>휴대전화</td>
		          <td><input name="MEM_PHONE" type="text" placeholder="-포함해서 입력"></td>
		        </tr>
		        <tr>
		          <td>자택주소</td>
		          <td><input name="MEM_ADD" type="text"></td>
		        </tr>
		        <tr>
		          <td>생년월일</td>
		          <td><input name="MEM_BIRTH" type="text" type="text"  placeholder="-포함해서 입력 ex) 1998-01-01"></td>
		        </tr>
		        <tr>
		          <td>기타정보</td>
		          <td><textarea name="MEM_AND"></textarea></td>
		        </tr>
		      </table>

            <div class='button'>
              <input type="button" value="저장" onclick="check()">
              <input type="reset" value="재입력">
              <input type="button" value="리스트" onclick="javascript:location.href='memberList.jsp">
            </div>
            <!-- acposition 테이블을 위한 hidden input -->
            <input type="hidden" name="AP_NO" value="1">
          </form>
        </div> 
	     </div>     
	</div>
  </section>

  <script src="../../script/indexScript.js"></script>
  <script>
  <script>
	function check(){
		const name = document.getElementById('name').value;
		const id = document.getElementById('id').value;
		const pw = document.getElementById('pw').value;
		const date = document.getElementById('date').value;
		const part = document.getElementById('part').value;
		const level = document.getElementById('level').value;
		
		console.log(name);
		console.log(id);
		console.log(pw);
		console.log(date);
		console.log(part);
		console.log(level);
		
		console.log(name=="");
		
		if(name == "" || id == "" || pw == "" || date == "" || part == "선택" || level == "선택"){

			if(name == ""){
				alert("사용자의 이름을 입력해 주세요.");
			}
			else if(id == ""){
				alert("사용자의 ID를 입력해 주세요.");
			}
			else if(pw == ""){
				alert("사용자의 비밀번호를 입력해 주세요.");
			}
			else if(date == ""){
				alert("사용자의 입사일을 입력해 주세요.");
			}
			else if(part == ""){
				alert("사용자의 부서를 선택해 주세요.");
			}
			else if(level == ""){
				alert("사용자의 직급을 선택해 주세요.");
			}
			
		}else{
			document.newFrm.submit();
		}
	}
</script>
  </script>
</body>

</html>