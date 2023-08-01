<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="schedule.ScheduleBean"
    import="java.util.*"%>
<jsp:useBean id="sMgr" class="schedule.ScheduleMgr" />
 
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
		<h3 class="title">일정 수정</h3>
    	<a href="#" id="closeBtn" onclick="closeBox()">×</a>
	</div>   

    <!----------------------------------->
    <!----------------본문---------------->
    <!----------------------------------->

    <div class="content">
      <form name="newSchedule" method="post" action="../../schedule/updateScheduleServlet" enctype="multipart/form-data">
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
            		
            		int TYPENO = typeBean.getTYPE_NO();
            		String TYPETYPE = typeBean.getTYPE_TYPE();
            		
            		if(TYPENO == TYPE_NO){
            	%>
	              <option value="<%=TYPENO%>" selected><%=TYPETYPE %></option>
	            <%	}else{%>
	            <option value="<%=TYPENO%>"><%=TYPETYPE %></option>
            	<%	}
            	  }
            	}%>
            </select>
          </li>
          <li>
            <label for="sche_title">일정 제목</label>
            <input type="text" id="sche_title" name="SCHE_NAME" value="<%=SCHE_NAME %>" required>
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
            			
            			int PARTNO = partBean.getPART_NO();
            			String PARTTYPE = partBean.getPART_TYPE();
            			
            			if(PARTNO == PART_NO){
            	%>
	              <option value="<%=PARTNO%>" selected><%=PARTTYPE %></option>
	            <%	}else{%>
	              <option value="<%=PARTNO%>"><%=PARTTYPE %></option>
            	<%		}
           			}
           		}%>
            </select>
          </li>
          <li>
            <label for="sche_date_start">시작</label>
            <div class="sche_date">
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
          </li>
          <li>
            <label for="sche_date_end">종료</label>
            <div class="sche_date">
              <input id="sche_date_end" name="SCHE_END_DATE" type="date" value="<%=SCHE_END_DATE %>" required>
              <select id="sche_end_time" name="END_NO">
                <option>선택</option>
                <%
                	Vector<ScheduleBean> endList = sMgr.getEndTimeList();
                
                	if(endList.isEmpty()){
                %>
                <option>등록된 시간이 없습니다.</option>
                <%	}else{
                		for(int i=0; i<endList.size(); i++){
                			ScheduleBean endBean = new ScheduleBean();
                			endBean = endList.get(i);
                			
                			int endno = endBean.getEND_NO();
                			String endtime = endBean.getEND_TIME();
     
                			System.out.print("endlist = " + endList.toString());
                			
                			if(endno == END_NO){
                %>
                
                <option value="<%=endno%>" selected><%=endtime %></option>
                
                <%
                			}else{
                %>
                
                <option value="<%=endno%>"><%=endtime %></option>
                	
                <%
                			}
                		}
                	}
                %>
              </select>
            </div>
          </li>
          <li>
            <label for="sche_detail">내용</label>
            <textarea id="sche_detail" name="SCHE_DETAIL"><%=SCHE_DETAIL %></textarea>
          </li>
          <li>
            <label for="file">첨부파일</label>
            <input type="file" id="file" name="SCHE_FILE" value="<%=SCHE_FILE %>">
          </li>
        </ul>
        <!-- submit을 위한 hidden input - SCHE_NO -->
        <input type="hidden" value="<%=SCHE_NO %>" name="SCHE_NO">

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
					alert("수정할 일정의 종류를 선택해 주세요.");
				}
				else if(title == ""){
					alert("수정할 일정의 제목을 입력해 주세요.");
				}
				else if(part == "선택"){
					alert("수정할 일정의 해당 부서를 선택해 주세요.");
				}
				else if(start_date == ""){
					alert("수정할 일정의 시작날짜를 입력해 주세요.");
				}
				else if(end_date == ""){
					alert("수정할 일정의 종료날짜를 입력해 주세요.");
				}
			}else{
				document.newSchedule.submit();
			}
		}
	</script>
</body>
</html>