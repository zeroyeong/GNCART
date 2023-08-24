<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="management.ManagementBean"    
    import="java.util.Vector"%>
    	
<jsp:useBean id="mMgr" class="management.ManagementMgr"/>
 
<%
	request.setCharacterEncoding("UTF-8");

	int MEM_NO = Integer.parseInt(request.getParameter("MEM_NO"));
	String nowPage = request.getParameter("nowPage");
	
	ManagementBean bean = mMgr.getMember(MEM_NO);
	
	String MEM_NAME=bean.getMEM_NAME();
	String MEM_ID=bean.getMEM_ID();
	String MEM_PW=bean.getMEM_PW();
	String MEM_DATE=bean.getMEM_DATE();
	String MEM_TEL=bean.getMEM_TEL();
	String MEM_MAIL=bean.getMEM_MAIL();
	String MEM_PHONE=bean.getMEM_PHONE();
	String MEM_ADD=bean.getMEM_ADD();
	String MEM_BIRTH=bean.getMEM_BIRTH();
	String MEM_AND=bean.getMEM_AND();
	String MEM_IMG=bean.getMEM_IMG();
	
	int AC_NO=bean.getAC_NO(); 
	String AC_TYPE=bean.getAC_TYPE();
	
	int WORK_NO=bean.getWORK_NO();
	String WORK_TYPE=bean.getWORK_TYPE();
	
	int PART_NO=bean.getPART_NO();
	String PART_TYPE=bean.getPART_TYPE();
	
	int LE_NO=bean.getLE_NO();
	String LE_LEVEL=bean.getLE_LEVEL();
	
	int AP_NO=bean.getAP_NO();
	String AP_TYPE=bean.getAP_TYPE();
	%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  
  <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>	
  <!--boxIcons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  
    <!-- 현재 파일의 css -->
	  <link rel="stylesheet" href="../css/newMember.css?l">
	
	<!-- 현재 파일 - includeTop css -->
	<link rel="stylesheet" href="include/include.css?l">
</head>

<body>
  <!-- sidebar include -->
  <jsp:include page="../index/sidebar.jsp" flush="false" />

  <section class="home-section">
    <!-- top include -->
    <jsp:include page="../index/top.jsp" flush="false" />
  <!--_______________본문시작_______________-->  	
	<div class="home-content">
		<div class="member">
     	 <!-- management include top -->		
   		 <jsp:include page="include/includeTop.jsp" />

      	<div class="pageTitle">
	        <h3>사용자 수정</h3>
      	</div>

        <form class="memberViewTable" name="updateFrm" method="post" action="../MemberUpdateServlet" enctype="multipart/form-data">
					
					<p>- 프로필 사진 권장 최대 사이즈는 330*330px (10MB 미만)입니다.</p>
          
          <table>
          <colgroup>
          	<col>
          	<col>
          	<col>
          </colgroup>
		        <tr>
		          <td rowspan="4">
		          	<%
		          		if(MEM_IMG != null && !MEM_IMG.equals("")){%>
		          			<div id="fileInput" style="display:none;">
		          				<img src="../images/profile.jpg" id="memImg">
											<input type="file" name="MEM_IMG2" accept="image/*" onchange="changePic(event)">
										</div>
								<div id="fileArea">
									<img src="../images/<%=MEM_IMG%>" id="memImg">
									<input name="MEM_IMG1" value="<%=MEM_IMG%>" id="file1"> <input type="button" value="삭제" onclick="delFile()">
									<input type="file" name="MEM_IMG1" value="<%=MEM_IMG%>" id="file1" style="display:none;">
								</div>
								<%
									} else{%>
									<img src="../images/profile.jpg" id="memImg">
									<input type="file" name="MEM_IMG3" accept="image/*" onchange="changePic(event)">
								<%	
									} 
								%>
		          		
		          </td>
		          <td>이름</td>
		          <td><input name="MEM_NAME" type="text" value="<%=MEM_NAME%>"></td>
		        </tr>
		        <tr>
		          <td>ID</td>
		          <td><input name="MEM_ID" type="text" value="<%=MEM_ID%>"></td>
		        </tr>
		        <tr>
		          <td>비밀번호</td>
		          <td><input name="MEM_PW" type="text" value="<%=MEM_PW%>"></td>
		        </tr>
		        <tr>
		          <td>계정구분</td>
		          <td>
		          
		          	<%
		          		if(AC_NO==1){%>
		          	  <input type="radio" name="AC_NO" value="1" checked><span>일반사용자</span>
			          &nbsp;&nbsp; 
			          <input type="radio" name="AC_NO" value="2"><span>관리자사용자</span>
		          	<%}else{%>
			          <input type="radio" name="AC_NO" value="1"><span>일반사용자</span>
			          &nbsp;&nbsp; 
			          <input type="radio" name="AC_NO" value="2" checked><span>관리자사용자</span>
			        <%} %>
		          </td>
		        </tr>
		        <tr>
		          <td>사번</td>
		          <td colspan="2"><input name="MEM_NO" readonly type="text" value="<%=MEM_NO%>"></td>
		        </tr>
		        <tr>
		          <td>근로형태</td>
		          <td colspan="2">
		          	<%
		          		if(WORK_NO==1){%>
		          	  <input type="radio" name="WORK_NO" value="1" checked><span>정규직</span>
			          &nbsp;&nbsp; 
			          <input type="radio" name="WORK_NO" value="2"><span>계약직</span>
		          	<%}else{%>
			          <input type="radio" name="WORK_NO" value="1"><span>정규직</span>
			          &nbsp;&nbsp; 
			          <input type="radio" name="WORK_NO" value="2" checked><span>계약직</span>
			        <%} %>
		          </td>
		        </tr>
		        <tr>
		        <td>사용자 상태</td>
		        <td colspan="2">
		        	<select name="AP_NO">
		        		<option>선택</option>
		        		<%
							Vector<ManagementBean> aplist = mMgr.getAcpositionList();
							
							if(aplist.isEmpty()){
						%>
						<option>등록된 type이 없습니다.</option>
						<%
							}else{
								for(int i=0; i<aplist.size(); i++){
									ManagementBean APbean=new ManagementBean();
									
									APbean=aplist.get(i);
									
									int APNO = APbean.getAP_NO();
									String APTYPE = APbean.getAP_TYPE();
									
									if(APNO == AP_NO){	
						%>
						<option value="<%=APNO%>" selected><%=APTYPE %></option>
						<%
									} else {
						%>
							
							<option value="<%=APNO%>"><%=APTYPE %></option>
						<%
									}
								}
							}
						%>
		        	</select>
		        </td>
		        </tr>
		        <tr>
		          <td>입사일</td>
		          <td colspan="2"><input name="MEM_DATE" type="text" value="<%=MEM_DATE%>" placeholder="-포함해서 입력 ex) 2023-07-17"></td>
		        </tr>
		        <tr>
		          <td>소속부서</td>
		          <td colspan="2">
		          	<select name="PART_NO" id="part">
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
									
									int PNO = PARTbean.getPART_NO();
									String PTYPE = PARTbean.getPART_TYPE();
									
									if(PNO == PART_NO){	
						%>
						<option value="<%=PNO%>" selected><%=PTYPE %></option>
						<%
									} else {
						%>
							
							<option value="<%=PNO%>"><%=PTYPE %></option>
						<%
									}
								}
							}
						%>
		          	</select>
		          </td>
		        </tr>
		        <tr>
		          <td>직위</td>
		          <td colspan="2">
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
									int LNO = LEbean.getLE_NO();
									String LLEVEL=LEbean.getLE_LEVEL();
									
									if(LNO == LE_NO){	
						%>
						<option value="<%=LNO%>" selected><%=LLEVEL %></option>
						<%
									} else {
						%>
							
							<option value="<%=LNO%>"><%=LLEVEL %></option>
						<%
									}
								}
							}
						%>
		          	</select>
		          </td>
		        </tr>
		        <tr>
		          <td>내선번호</td>
		          <td colspan="2"><input name="MEM_TEL" type="text" value="<%=MEM_TEL%>"></td>
		        </tr>
		        <tr>
		          <td>이메일</td>
		          <td colspan="2"><input name="MEM_MAIL" type="text" value="<%=MEM_MAIL%>" type="email"></td>
		        </tr>
		        <tr>
		          <td>휴대전화</td>
		          <td colspan="2"><input name="MEM_PHONE" type="text" value="<%=MEM_PHONE%>"  placeholder="-포함해서 입력"></td>
		        </tr>
		        <tr>
		          <td>자택주소</td>
		          <td colspan="2"><input name="MEM_ADD" type="text" value="<%=MEM_ADD%>"></td>
		        </tr>
		        <tr>
		          <td>생년월일</td>
		          <td colspan="2"><input name="MEM_BIRTH" type="text" value="<%=MEM_BIRTH%>" type="text"  placeholder="-포함해서 입력 ex) 1998-01-01"></td>
		        </tr>
		        <tr>
		          <td>기타정보</td>
		          <td colspan="2"><textarea name="MEM_AND"><%=MEM_AND%></textarea></td>
		        </tr>
		      </table>
						
						<!-- submit을 위해 MEM_NO 값을 담은 hidden input -->
            <input type="hidden" name="MEM_NO" value="<%=MEM_NO%>">
            <input type="hidden" name="nowPage" value="<%=nowPage %>">

						<!----------------버튼---------------->
            <div class='buttons'>
              <input type="button" value="저장" onclick="check()"/>
	          	<input type="reset" value="다시수정" />
              <input type="button" value="뒤로" onclick="history.go(-1)">
            </div>

          </form>

	     </div>     
	</div>
</body>
</html>

<script src="../script/indexScript.js"></script>

<script>

/*__________이미지 미리보기__________*/
function changePic(event) {
    var reader = new FileReader();

    reader.onload = function (event) {
      let img = document.getElementById("memImg");
      img.setAttribute("src", event.target.result);
    };

    reader.readAsDataURL(event.target.files[0]);
  }

/*__________submit__________*/
function check(){
	const part = document.getElementById('part').value;
	const level = document.getElementById('level').value;
	
	if(part == "" || level =="선택"){
		if(part == "선택"){
			alert("소속부서를 확인해 주세요.");
		}
		else if(level == ""){
			alert("직급을 확인해 주세요.");
		}
	}else{
		document.updateFrm.submit();
	}	
}

/*_____파일 삭제_____*/
 function delFile(){
	 document.getElementById('fileArea').style.display="none";
	 document.getElementById('fileInput').style.display="block";
	 document.getElementById('file1').value="";
}	 
</script>
</body>
</html>