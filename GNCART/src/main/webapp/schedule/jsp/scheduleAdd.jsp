<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="schedule.ScheduleBean"
    import="java.util.*"
    import="java.time.*"%>
<jsp:useBean id="sMgr" class="schedule.ScheduleMgr" />

<%
	LocalDateTime date = LocalDateTime.now();
	int year = date.getYear();
	int day = date.getDayOfMonth();
	String month = "";
	
	if(date.getMonthValue()<10){
		month = "0"+date.getMonthValue();
	}else{
		month = date.getMonthValue()+"";
	}
	
	String SCHE_DATE = year+"-"+month+"-"+day;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GNC:ART - 일정추가</title>
<link rel="stylesheet" href="../../css/scheduleAdd.css?dsds">
</head>
<body>
	<div class="container">
    <!----------------------------------->
    <!----------------타이틀--------------->
    <!----------------------------------->
	
	<div class="topmenu">
		<h3 class="title">일정 추가</h3>
    	<a href="#" id="closeBtn" onclick="closeBox()">×</a>
	</div>   

    <!----------------------------------->
    <!----------------본문---------------->
    <!----------------------------------->

    <div class="content">
      <form name="newSchedule" method="post" action="../../schedule/newScheduleServlet" enctype="multipart/form-data">
        <ul>
          <li>
            <label for="sche_type">일정종류</label>
            <select id="sche_type" name="TYPE_NO">
            	<option>선택</option>
            	<%
            	Vector<ScheduleBean> typeList = sMgr.getTypeList();
            		
            	if(typeList.isEmpty()){
            	%>
            	<option>등록된 type이 없습니다.</option>
            	<%}else{ 
            		for(int i=0; i<typeList.size(); i++){
            		ScheduleBean typeBean = new ScheduleBean();
            		typeBean = typeList.get(i);
            		
            		int TYPE_NO = typeBean.getTYPE_NO();
            		String TYPE_TYPE = typeBean.getTYPE_TYPE();
            	%>
	              <option value="<%=TYPE_NO%>"><%=TYPE_TYPE %></option>
	            <%	}
            	}%>
            </select>
          </li>
          <li>
            <label for="sche_title">일정 제목</label>
            <input type="text" id="sche_title" name="SCHE_NAME" required>
          </li>
          <li>
            <label for="sceh_part">해당 부서</label>
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
            			
            			int PART_NO = partBean.getPART_NO();
            			String PART_TYPE = partBean.getPART_TYPE();
            	%>
	              <option value="<%=PART_NO%>"><%=PART_TYPE %></option>
	            <%	}
            	}%>
            </select>
          </li>
          <li>
            <label for="sche_date_start">시작</label>
            <div class="sche_date">
              <input id="sche_date_start" name="SCHE_START_DATE" type="date" required>
              <select id="sche_start_titme" name="SCHE_START_TIME">
                <option value="오전 09:00">오전 09:00</option>
                <option value="오전 09:30">오전 09:30</option>
                <option value="오전 10:00">오전 10:00</option>
                <option value="오전 10:30">오전 10:30</option>
                <option value="오전 11:00">오전 11:00</option>
                <option value="오전 11:30">오전 11:30</option>
                <option value="오후 12:00">오후 12:00</option>
                <option value="오후 12:30">오후 12:30</option>
                <option value="오후 01:00">오후 01:00</option>
                <option value="오후 01:30">오후 01:30</option>
                <option value="오후 02:00">오후 02:00</option>
                <option value="오후 02:30">오후 02:30</option>
                <option value="오후 03:00">오후 03:00</option>
                <option value="오후 03:30">오후 03:30</option>
                <option value="오후 04:00">오후 04:00</option>
                <option value="오후 04:30">오후 04:30</option>
                <option value="오후 05:00">오후 05:00</option>
                <option value="오후 04:30">오후 04:30</option>
                <option value="오후 06:00">오후 06:00</option>
              </select>
            </div>
          </li>
          <li>
            <label for="sche_date_end">종료</label>
            <div class="sche_date">
              <input id="sche_date_end" name="SCHE_END_DATE" type="date" required>
              <select id="sche_end_time" name="SCHE_END_TIME">
                <option value="오전 09:00">오전 09:00</option>
                <option value="오전 09:30">오전 09:30</option>
                <option value="오전 10:00">오전 10:00</option>
                <option value="오전 10:30">오전 10:30</option>
                <option value="오전 11:00">오전 11:00</option>
                <option value="오전 11:30">오전 11:30</option>
                <option value="오후 12:00">오후 12:00</option>
                <option value="오후 12:30">오후 12:30</option>
                <option value="오후 01:00">오후 01:00</option>
                <option value="오후 01:30">오후 01:30</option>
                <option value="오후 02:00">오후 02:00</option>
                <option value="오후 02:30">오후 02:30</option>
                <option value="오후 03:00">오후 03:00</option>
                <option value="오후 03:30">오후 03:30</option>
                <option value="오후 04:00">오후 04:00</option>
                <option value="오후 04:30">오후 04:30</option>
                <option value="오후 05:00">오후 05:00</option>
                <option value="오후 04:30">오후 04:30</option>
                <option value="오후 06:00">오후 06:00</option>
              </select>
            </div>
          </li>
          <li>
            <label for="sche_detail">내용</label>
            <textarea id="sche_detail" name="SCHE_DETAIL"></textarea>
          </li>
          <li>
            <label for="file">첨부파일</label>
            <input type="file" id="file" name="SCHE_FILE">
          </li>
        </ul>
        <!-- submit을 위한 hidden input - MEM_NO + SCHE_DATE -->
        <input type="hidden" value="1" name="MEM_NO"> <!-- value의 1은 관리자사용자인 김사장을 뜻한다. -->
        <input type="hidden" value="<%=SCHE_DATE %>" name="SCHE_DATE">

        <!----------------------------------->
        <!----------------버튼---------------->
        <!----------------------------------->
      
        <div class="button">
          <input type="button" value="저장" onclick="check()">
          <input type="reset" value="취소" onclick="closeBox()">
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
			
			if(title == "" || type =="선택" || part == "선택" || start_date =="" || end_date == ""){
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
			}else{
				document.newSchedule.submit();
			}
		}
	</script>
</body>
</html>