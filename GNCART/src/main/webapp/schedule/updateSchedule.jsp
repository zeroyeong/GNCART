<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="schedule.ScheduleBean"
    import="java.util.*"%>
<jsp:useBean id="sMgr" class="schedule.ScheduleMgr" />

<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8"> 
<title>GNC:ART - 일정수정</title>
<link rel="stylesheet" href="../css/scheduleAdd.css">
</head>
<body>  

	<%
		int SCHE_NO = Integer.parseInt(request.getParameter("SCHE_NO"));
		
		ScheduleBean bean = (ScheduleBean) session.getAttribute("bean");
		
		String SCHE_NAME = bean.getSCHE_NAME();
		String SCHE_START_DATE = bean.getSCHE_START_DATE();
		String SCHE_END_DATE = bean.getSCHE_END_DATE();
		String SCHE_DETAIL = bean.getSCHE_DETAIL();
		String SCHE_FILE = bean.getSCHE_FILE();
		
		int TYPE_NO = bean.getTYPE_NO();
		String TYPE_TYPE = bean.getTYPE_TYPE();
		int PART_NO = bean.getPART_NO();
		String PART_TYPE =bean.getPART_TYPE();
		int ST_NO = bean.getST_NO();
		String ST_TIME = bean.getST_TIME();
		int END_NO = bean.getEND_NO();
		String END_TIME = bean.getEND_TIME();
	%>
	
	<div class="container">
	
		<!----------------타이틀---------------> 
		<div class="top">
		<h3 class="title">일정 내용</h3>
		<a href="#" id="closeBtn" onclick="closeBox()">×</a>
		</div>
			
		<!----------------본문---------------->
		<div class="content"> 
			<form name="updateSche" method="post" action="../UpdateScheduleServlet" enctype="multipart/form-data">
			
				<!-- submit에 SCHE_NO 값을 넘기기 위한 hidden input -->
				<input type="hidden" value="<%=SCHE_NO %>" name="SCHE_NO">
				
				<table>
					<tr>
						<td>일정종류</td>
						<td>
							<select id="sche_type" name="TYPE_NO">
								<option>선택</option>
								<%
								Vector<ScheduleBean> typeList = sMgr.getTypeList();
									
								if(typeList.isEmpty()){
								%>
								
								<option>등록된 type이 없습니다.</option>
									
								<%
									}else{ 
										for(int i=0; i<typeList.size(); i++){
											ScheduleBean typeBean = new ScheduleBean();
											typeBean = typeList.get(i);
											
											int TYPENO = typeBean.getTYPE_NO();
											String TYPETYPE = typeBean.getTYPE_TYPE();
									
											if(TYPENO == TYPE_NO){
								%>
								
								<option value="<%=TYPENO%>" selected><%=TYPETYPE %></option>
								
								<%	}else{%>
								
								<option value="<%=TYPENO%>"><%=TYPETYPE %></option>
								
								<%
										}
									}
								}
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td>일정 제목</td>
						<td>
							<input type="text" id="sche_title" name="SCHE_NAME" value="<%=SCHE_NAME %>" required>
						</td>
					</tr>
					<tr>
						<td>해당 부서</td>
						<td>
							<select id="sceh_part" name="PART_NO">
								<option>선택</option>
								<%
								Vector<ScheduleBean> partList = sMgr.getPartList();
								
								if(partList.isEmpty()){
								%>
								
								<option>등록된 type이 없습니다.</option>
								
								<%}else{ 
									for(int i=0; i<partList.size(); i++){
										ScheduleBean partBean = new ScheduleBean();
										partBean = partList.get(i);
										
										int PARTNO = partBean.getPART_NO();
										String PARTTYPE = partBean.getPART_TYPE();
									
										if(PARTNO == PART_NO){
								%>
								
								<option value="<%=PARTNO%>" selected><%=PARTTYPE %></option>
								
								<%	}else{%>
								
								<option value="<%=PARTNO%>"><%=PARTTYPE %></option>
								
								<%
										}
									}
								}
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td>시작</td>
						<td>
							<div class="time">
								<input id="sche_date_start" name="SCHE_START_DATE" type="date" value="<%=SCHE_START_DATE %>" required>
								<select id="sche_start_titme" name="ST_NO">
									<option>선택</option>
									<%
									Vector<ScheduleBean> sttimeList = sMgr.getSttimeList();
									
									if(sttimeList.isEmpty()){
									 %>
									 
									 <option>등록된 시간이 없습니다.</option>
									 	
									<%	}else{
										for(int i=0; i<sttimeList.size(); i++){
											ScheduleBean stBean = new ScheduleBean();
											stBean = sttimeList.get(i);
										
											int STNO = stBean.getST_NO();
											String STTIME = stBean.getST_TIME();
										
											if(STNO == ST_NO){
									%>
									
									<option value="<%=STNO%>" selected><%=STTIME %></option>
									
									<%
											}else{
									%>
									
									<option value="<%=STNO%>"><%=STTIME %></option>
									
									<%
											}
										}
									}
									%>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<td>종료</td>
						<td>
							<div class="time">
								<input id="sche_date_end" name="SCHE_END_DATE" type="date" value="<%=SCHE_END_DATE %>" required>
								<select id="sche_end_titme" name="END_NO">
									<option>선택</option>
									<%
									Vector<ScheduleBean> endtimeList = sMgr.getEndTimeList();
									
									if(endtimeList.isEmpty()){
									%>
									
									<option>등록된 시간이 없습니다.</option>
									
									<%	}else{
									for(int i=0; i<endtimeList.size(); i++){
										ScheduleBean endBean = new ScheduleBean();
										endBean = endtimeList.get(i);
									
										int ENDNO = endBean.getEND_NO();
										String ENDTIME = endBean.getEND_TIME();
										
										if(ENDNO == END_NO){
									%>
									
									<option value="<%=ENDNO%>" selected><%=ENDTIME %></option>
									
									<%
										}else{
									%>
									
									<option value="<%=ENDNO%>"><%=ENDTIME %></option>
									
									<%
											}
										}
									}
									%>
								</select>
							</div>
						</td>
					</tr>
						<tr>
							<td>내용</td>
							<td>
								<textarea id="sche_detail" name="SCHE_DETAIL"><%=SCHE_DETAIL %></textarea>
							</td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td>
								<%
									if(SCHE_FILE != null && !SCHE_FILE.equals("")){
								%>
								<div id="fileInput" style="display:none;">
									<input type="file" name="SCHE_FILE2">
								</div>
								<div id="fileArea">
									<input name="SCHE_FILE1" value="<%=SCHE_FILE%>" id="file1"> <input type="button" value="삭제" onclick="delFile()">
									<input type="file" name="SCHE_FILE1" value="<%=SCHE_FILE%>" id="file1" style="display:none;">
					
								</div>
								<%
									} else{%>
									<input type="file" name="SCHE_FILE3">
								<%	
									} 
								%>
							</td>
						</tr>
				</table>
				
				<!-- submit을 위해 SCHE_NO 값을 담은 hidden input -->
				<input type="hidden" name="SCHE_NO" value="<%=SCHE_NO %>">
				<!----------------버튼---------------->
				<div class="button">
					<input type="button" value="저장" onclick="check()">
					<input type="reset" value="취소" onclick="history.go(-1)">
				</div>
			</form>
		</div>
	</div>

<!----------------------------------->
<!---------------스크립트-------------->
<!----------------------------------->
 
<script src="../script/popup.js"></script>
<script>
function check(){
	const title = document.getElementById('sche_title').value;
	const type = document.getElementById('sche_type').value;
	const part = document.getElementById('sceh_part').value;
	const start_date = document.getElementById('sche_date_start').value;
	const end_date = document.getElementById('sche_date_end').value;
	
	const st_no = document.getElementById('sche_start_titme').value;
	const end_no = document.getElementById('sche_end_titme').value;
	
	if(title == "" || type =="선택" || part == "선택" || start_date =="" || end_date == ""
			|| start_date>end_date || (start_date == end_date && st_no > end_no)){
		if(type == "선택"){
			alert("추가할 일정의 종류를 선택해 주세요.");
		}
		else if(title == ""){
			alert("추가할 일정의 제목을 입력해 주세요.");
		}
		else if(part == "선택"){
			alert("추가할 일정의 해당 부서를 선택해 주세요.");
		}
		else if(start_date == ""){
			alert("추가할 일정의 시작날짜를 입력해 주세요.");
		}
		else if(end_date == ""){
			alert("추가할 일정의 종료날짜를 입력해 주세요.");
		}
		else if(start_date>end_date){
			alert("일정의 종료날짜 또는 시작날짜가 잘못되었습니다.")
		}
		else if(start_date == end_date && st_no > end_no){
			alert("선택한 시간설정이 잘못되었습니다.")
		}
	}else{
		document.updateSche.submit();
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