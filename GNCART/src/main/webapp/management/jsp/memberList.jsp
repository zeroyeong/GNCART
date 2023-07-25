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
		
	/*----------현재페이지와 블럭, 페이징 계산을 위한----------*/
	
	int start=0; //sql 쿼리문을 위한 변수
	int end=20; // sql 쿼리문을 위한 변수
	
	
	int nowPage=1;
	int nowBlock=1;
	
	int numPerPage=20;
	int pagePerBlock=15; //블럭당 페이지수
	
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int totalPage = (int)Math.ceil((double) totalRecord / numPerPage);
	int totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);

	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	
	start = (nowPage * numPerPage)-numPerPage;
	end = numPerPage;
	
	int listSize=0; //현재 읽어온 게시물 수
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../../css/index.css">
  <link rel="stylesheet" href="../../css/management.css">
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
        			<h3>사용자 조회</h3>
        		</div>
        	</div>
        	
        	<!-- _______________페이지 본문 시작_______________ -->
        	<div class="content">
        		<!--           memberFrm              -->
        		<form name="memberFrm" method="get" action="">
        			<table class="buttonT">
        				<tr>
        					<td>
        						<!-- memberFrm 의 submit 버튼 -->
        						<input type="button" value="사용자 수정" id="modifyBtn">
        						<div class="totalrecord">
        							전체 사용자 수 : <%=totalRecord %>
        						</div>
        					</td>
        				</tr>	
        			</table>
        			
        			<!-- DB 리스트 보이는 곳 -->
        			<table class="memberT">
        				<thead>
        					<tr>
        						<td></td>
				                <td>이름</td>
				                <td>ID</td>
				                <td>비밀번호</td>
				                <td>근로형태</td>
				                <td>내선번호</td>
				                <td>휴대전화</td>
				                <td>소속부서</td>
				                <td>직위</td>
				                <td>사번</td>
				                <td>입사일</td>
				                <td>상태</td>
	                		</tr>
        				</thead>
        				<tbody>
        				
        					<%
        						Vector<ManagementBean> vlist = mMgr.getMemberList(keyField, keyWord, start, end);
        					
        						listSize = vlist.size();
        						
        						if(vlist.isEmpty()){
        					%>
        					
        					<td colspan=12>등록된 정보가 없습니다.</td>
        					
        					<%
        						}else{
        							
        							for(int i=0; i<numPerPage; i++){
        								if(i==listSize) break;
        								
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
        						<td><input type="radio" name="modify" value="<%=MEM_NO%>" id="memNo""></td>
				              	<td><a href="javascript:read(<%=MEM_NO %>)"><%=MEM_NAME %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=MEM_ID %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=MEM_PW %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=WORK_TYPE %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=MEM_TEL %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=MEM_PHONE %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=PART_TYPE %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=LE_LEVEL %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=MEM_NO %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=MEM_DATE %></a></td>
				                <td><a href="javascript:read(<%=MEM_NO %>)"><%=AP_TYPE %></a></td>
        					</tr>
        					
        					<%
        							}
        					%> <!-- for 문 종료 -->
        					<%
        						}
        					%> <!-- if 문 종료 -->
        					
        				</tbody>
        			</table>
        		</form>
        		
				<table class="bottomtable">
					<tr>
						<td></td>
						<td>	
							<!-- 페이징 및 블럭 처리 Start--> 
				<%
	   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
	   				  int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
	   				  //하단 페이지 끝번호
	   				  if(totalPage !=0){
	    			  	if (nowBlock > 1) {%>
	    			  		<a href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%>&nbsp; 
	    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
	     			     	<a href="javascript:pageing('<%=pageStart %>')"> 
	     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
	     					[<%=pageStart %>] 
	     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
	    					<%}//for%>&nbsp; 
	    					<%if (totalBlock > nowBlock ) {%>
	    					<a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
	    			<%}%>&nbsp;  
	   			<%}%>
	 			<!-- 페이징 및 블럭 처리 End-->

						</td>
						<td>
							<!--           searchFrm : 검색              -->
							<form name="searchFrm" method="get" action="" class="search">
								<select name="keyField" id="keyField">
									<option value="">선택</option>
									<option value="MEM_NAME">이름</option>
									<option value="MEM_ID">ID</option>
									<option value="MEM_PHONE">휴대전화</option>
								</select>
									
								<input type="text" placeholder="검색할 정보를 선택해주세요." name="keyWord" id="keyWord">
								<input type="button" value="검색" id="searchFrmBtn" onClick="check();">
								<input type="hidden" name="nowPage" value="1">
							</form>
							<!--           [searchFrm : 검색] 끝              -->
						</td>
					</tr>
				</table>
        		
        		<!--           hidden input form              -->
        		
        		<form name="listFrm" method="post">
        			<input type="hidden" name="reload" value="ture">
        			<input type="hidden" name="nowPage" value="1">
        		</form>
        		
        		<form name="readFrm" method="get">
        			<input type="hidden" name="MEM_NO"> 
					<input type="hidden" name="nowPage" value="<%=nowPage%>">
        		</form>
        		
        	</div>
        	
		</div>
	</div>

<script src="../../script/indexScript.js"></script>
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
  if(searchFrm.keyField.value == ""){
	  alert("검색할 항목을 선택하세요.");
  	}else{
  		if(searchFrm.keyWord.value == ""){
  			alert("검색어를 입력하세요.");
  		}else{
  			searchFrm.submit();
  		}
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

function block(value){
	 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
	 document.readFrm.submit();
} 

/*-------memberFrm - submit-------*/
const memNo = document.querySelectorAll('#memNo');
memNo.forEach((t)=>{
	t.addEventListener('click', (e)=>{
		console.log(t.value);
	})
})

const modifyBtn = document.getElemntById('modifyBtn');
modifyBtn.addEventListener('click', function(){
	if(t.value==null){
		alert("수정할 사용자를 선택하세요.");
	}
	else{
		document.memberFrm.submit();
	}
})
</script>
</body>
</html>