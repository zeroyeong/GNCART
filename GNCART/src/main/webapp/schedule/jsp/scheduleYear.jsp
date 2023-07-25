<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../../css/index.css">
  <!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  
  <link rel="stylesheet" href="../../css//scheduleYear.css?ver2">
  
</head>
<body>
	
  <!-- sidebar include -->
  <jsp:include page="../../index/sidebar.jsp" flush="false" />

  <section class="home-section">
    <!-- top include -->
    <jsp:include page="../../index/top.jsp" flush="false" />
	

    <!--home-content-->  	
    <div class="home-content">
      <div id="container">
        <div id="title">
        <!----------------------------------->
        <!--------------타이틀--------------->
        <!----------------------------------->

        <div class="title">
          <h2>회사 일정</h2>
          <div class="btnBox">
            <div class="btns">
              <a href="scheduleMonth.jsp">월간일정</a>
              <a href="scheduleYear.jsp">연간일정</a>
              <a href="scheduleWeek.jsp">주간일정</a>
            </div>
            <div class="btns">
              <a href="#" onclick="popup()">일정추가</a>
            </div>
          </div>
        </div>

        <!----------------------------------->
        <!----------페이지 소제목------------>
        <!----------------------------------->

        <div class="smallTitle">
          <div class="yearBtn">
            <button type="button" onclick="prevYear();" class="prev"> < <span id="prevYear"></span>년</button>
            <h3><span id="calYear"></span>년</h3>
            <button type="button" onClick="nextYear();" class="next"><span id="nextYear"></span>년 ></button>
          </div>
        </div>

        <!----------------------------------->
        <!---------월별 일정표 시작---------->
        <!----------------------------------->

        <div class="scheduletable-list">
          <table class="scheduleList">
            <caption>1월</caption>
            <tr>
              <td class="date">날짜</td>
              <td calss="schedule">일정</td>
            </tr>
            <tr>
              <td><a href="#">...~....</a></td>
              <td><a href="#">...</a></td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </section>

<script src="../../script/indexScript.js"></script>
<script src="../script/titleYear.js"></script>
<script src="../script/popup.js"></script>
</body>
</html>