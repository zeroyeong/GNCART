<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="management.ManagementBean"
    import="java.util.Vector"%>

<jsp:useBean id="mMgr" class="management.ManagementMgr"/> 

<%
	/*------------페이지 하단 searchFrm input-------------*/
	String keyField="";
	String keyWord="";
	
	if(request.getParameter("keyWord")!=null){
		keyWord=request.getParameter("keyWord");
		keyField=request.getParameter("keyField");
	} 
	
	/*-----새로고침을 위한 listFrm (hidden input)-----*/
	if(request.getParameter("reload")!=null){
			
		if(request.getParameter("reload").equals("true")){
			keyWord="";
			keyField="";
		}
	}
	
	/*------------------레코드 수 계산--------------------*/
	
	int totalRecord=mMgr.getTotalCount(keyField, keyWord);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../../css/index.css">
  <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>	
  <!--boxIcons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<!-- 현재 파일의 css -->
<link rel="stylesheet" href="../../css/management.css?asdasdad">

<!-- 현재 파일 - includeTop css -->
<link rel="stylesheet" href="include/include.css?oohh">

</head>

<body>
  <!-- slide bar include -->
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
        <h3>사용자 조회</h3>
      </div>

      <div class="memberTable">
        <div class="tableTop">
          <div class="tableBtn">
            <button onclick="memCheck()">사용자 수정</button>
          </div>

          <div class="totalMember">전체 사용자 수: <span><%=totalRecord %></span></div>
        </div>

        <div class="memberListTable">
          <table>
          <colgroup>
	         	<col class="col1">
					  <col class="col2">
					  <col class="col3">
					  <col class="col4">
					  <col class="col5">
					  <col class="col6">
					  <col class="col7">
					  <col class="col8">
					  <col class="col9">
					  <col class="col10">
					  <col class="col11">
					  <col class="col12">
          </colgroup>
            <thead>
              <tr>
                <td></td>
                <td>사번</td>
                <td>이름</td>
                <td>입사일</td>
                <td>근로형태</td>
                <td>소속부서</td>
                <td>직위</td>
                <td>내선번호</td>
                <td>휴대전화</td>
                <td>ID</td>
                <td>비밀번호</td>
                <td>상태</td>
              </tr>
            </thead>
            <tbody>
            
            <%
	            Vector<ManagementBean> vlist = mMgr.getMemberList(keyField, keyWord);
							if(vlist.isEmpty()){
            %>
            
            <tr>
            	<td colspan=12 style="text-align:center;">등록된 정보가 없습니다.</td>
            </tr>
            
            <%
        						}else{
        							
        							for(int i=0; i<vlist.size(); i++){
        								if(i==vlist.size()) break;
        								
        								ManagementBean bean = new ManagementBean();
        								bean = vlist.get(i);
        								
        								int MEM_NO=bean.getMEM_NO();
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
        								String AC_TYPE=bean.getAC_TYPE();
        								String WORK_TYPE=bean.getWORK_TYPE();
        								String PART_TYPE=bean.getPART_TYPE();
        								String LE_LEVEL=bean.getLE_LEVEL();
        								String AP_TYPE=bean.getAP_TYPE();
    					%>
            
              <tr>
                <td>
                  <input type="radio" name="MEM_NO" value="<%=MEM_NO%>" onclick="update(<%=MEM_NO %>)" />
                </td>
                <td onclick="read(<%=MEM_NO%>)"><%=MEM_NO %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=MEM_NAME %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=MEM_DATE %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=WORK_TYPE %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=PART_TYPE %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=LE_LEVEL %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=MEM_TEL %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=MEM_PHONE %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=MEM_ID %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=MEM_PW %></td>
                <td onclick="read(<%=MEM_NO%>)"><%=AP_TYPE %></td>
              </tr>
              
              <%	}%> <!-- for 문 종료 -->
     					<%}%> <!-- if 문 종료 -->
        					
            </tbody>
          </table>
        </div>

        <div class="tableInfo">
          <div class="empty"></div>

          <div id="pagenation">
					</div>

					<!--           searchFrm : 검색              -->
          <div class="search">
          	<form name="searchFrm" method="get" action="" class="search">
	          	<select name="keyField" id="keyField">
	              <option selected>선택</option>
	              <option value="MEM_NAME">이름</option>
								<option value="MEM_ID">ID</option>
								<option value="MEM_PHONE">휴대전화</option>
	            </select>
	            
	            <input type="text" placeholder="검색할 정보를 선택해주세요." name="keyWord" id="keyWord" />
	            <input type="button" value="검색" id="searchFrmBtn" onClick="check();" />
	            <input type="hidden" name="nowPage" value="1">
            </form> 
          </div>
          <!--           [searchFrm : 검색] 끝              -->
          
          <!--           hidden input form              -->
        		
       		<form name="listFrm" method="post">
       			<input type="hidden" name="reload" value="ture">
       			<input type="hidden" name="nowPage" value="1">
       		</form>
       		
       		<form name="readFrm" method="get">
       			<input type="hidden" name="MEM_NO"> 
       		</form>
       	
	       	<form id="updateF" method="get">
	       		<input type="hidden" name="MEM_NO" id="memNo">
	       	</form>
          
        </div>
      </div>
    </div>
	</div>
	</section>

<script src="../../script/indexScript.js"></script>
<script src="../script/pagenation.js"></script>

<script>
/*----------사용자 조회로 이동----------*/

function read(MEM_NO){
	document.readFrm.MEM_NO.value=MEM_NO;
	document.readFrm.action="readMember.jsp";
	document.readFrm.submit();
}

/*--------searchFrm - placeholder--------*/

document.addEventListener("DOMContentLoaded", () => {
	let keyField =  document.getElementById('keyField');
	
	keyField.addEventListener("click", () => {
		let keyWord=document.getElementById('keyWord');
		switch(keyField.value){
			case "MEM_NAME" : keyWord.placeholder="이름을 입력해 주세요."; break;
			case "MEM_ID" : keyWord.placeholder="ID를 입력해 주세요."; break;
			case "MEM_PHONE" : keyWord.placeholder="-을 포함해서 입력해 주세요."; break;
			default : keyWord.placeholder="검색할 정보를 선택해 주세요.";
		}
	});
});


/*--------searchFrm - submit--------*/

function check() {
	const keyField = searchFrm.keyField.value;
	const keyWord = searchFrm.keyWord.value;
	
	if(keyField == "선택" || keyWord == ""){
		if(keyField == "선택"){
			alert("검색할 항목을 선택하세요.");
		}
		else if(keyWord == ""){
			alert("검색어를 입력하세요.");
		}
	} else{
		searchFrm.submit();
	}
}


/*-------새로고침을 위한 list Frm------*/
function list(){
	listFrm.action="memberList.jsp";
	listFrm.submit();
}

/*-------Pagination------*/
function pageing(page) {
	document.readFrm.nowPage.value = page;
	document.readFrm.submit();
}

/*------ updateF submit -------*/

function update(MEM_NO){
	console.log(MEM_NO);
	document.getElementById("memNo").value=MEM_NO;
	
}

function memCheck(){
	const memNo = document.getElementById("memNo").value;
	
	if(memNo == null || memNo == ""){
		alert("수정할 사용자를 선택하세요!");
	}else{
		document.getElementById("updateF").action="modify.jsp";
		document.getElementById("updateF").submit();
	}
}
</script>
</body>
</html>