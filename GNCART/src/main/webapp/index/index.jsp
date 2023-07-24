<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="login.MemberBean" %>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>
<% // 세션에서 로그인 정보 가져오기 
	String id=(String) session.getAttribute("idKey"); String pw=(String)
	session.getAttribute("pwKey"); String name=mMgr.nameFind(id, pw); 
	// 로그인 안했을 시 로그인 페이지로 리다이렉트 
	if (id==null||pw==null) { response.sendRedirect("../00login/login.jsp"); }
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate" );
	response.setHeader("Pragma", "no-cache" ); response.setHeader("Expires", "0" );
%>
<!DOCTYPE html>
<html lang="ko">
 
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNC:ART</title>
  <link rel="stylesheet" href="../css/index.css">
  <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>	
  <!--boxIcons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

<body>
  <!-- sidebar include -->
  <jsp:include page="sidebar.jsp" flush="false" />

  <section class="home-section">
    <!-- top include -->
    <jsp:include page="top.jsp" flush="false" />


    <!--home-content-->
    <div class="home-content">
      <div class="overview-boxes">
        <div class="box">
          <div class="right-side">
            <a href="#">
              <div class="box-topic">공지사항</div>
            </a>
            <div class="indicator">
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
            </div>
          </div>
        </div>
        <div class="box">
          <div class="right-side">
            <a href="#">
              <div class="box-topic">자유게시판</div>
            </a>
            <div class="indicator">
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
            </div>
          </div>
        </div>
        <div class="box">
          <div class="right-side">
            <a href="#">
              <div class="box-topic">경조사알림</div>
            </a>
            <div class="indicator">
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
              <p>123123123123</p>
            </div>
          </div>
        </div>
        <!--달력-->
        <table class="Calendar">
          <thead>
            <tr>
              <td onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
              <td colspan="5">
                <span id="calYear"></span>년
                <span id="calMonth"></span>월
              </td>
              <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
            </tr>
            <tr>
              <td class="sundayRed">일</td>
              <td>월</td>
              <td>화</td>
              <td>수</td>
              <td>목</td>
              <td>금</td>
              <td>토</td>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>

      <div class="board-boxes">
        <div class="schedule-box">
          <div class="title"><a href="#">회사일정</div></a>
          <div class="schedule-details">
            <ul class="details">
              <li class="topic">Date</li>
              <li><a href="#"> 2023. 06 . 08</a></li>
              <li><a href="#"> 2023. 06 . 08</a></li>
              <li><a href="#"> 2023. 06 . 08</a></li>
              <li><a href="#"> 2023. 06 . 08</a></li>
              <li><a href="#"> 2023. 06 . 08</a></li>
              <li><a href="#"> 2023. 06 . 08</a></li>
              <li><a href="#"> 2023. 06 . 08</a></li>
              <li><a href="#"> 2023. 06 . 08</a></li>
              <li><a href="#"> 2023. 06 . 08</a></li>
            </ul>
            <ul class="details">
              <li class="topic">B</li>
              <li><a href="#"> 3333333333333</a></li>
              <li><a href="#"> 33333333333333</a></li>
              <li><a href="#"> 33333333333333</a></li>
              <li><a href="#"> 33333333333333</a></li>
              <li><a href="#"> 33333333333333</a></li>
              <li><a href="#"> 33333333333333</a></li>
              <li><a href="#"> 33333333333333</a></li>
              <li><a href="#"> 33333333333333</a></li>
              <li><a href="#">3333333333333 3</a></li>
            </ul>
            <ul class="details">
              <li class="topic">C</li>
              <li><a href="#">1</a></li>
              <li><a href="#">1</a></li>
              <li><a href="#">1</a></li>
              <li><a href="#">1</a></li>
              <li><a href="#">1</a></li>
              <li><a href="#">1</a></li>
              <li><a href="#">1</a></li>
              <li><a href="#">1</a></li>
              <li><a href="#">1</a></li>
            </ul>
            <ul class="details">
              <li class="topic">D</li>
              <li><a href="#">2</a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">2</a></li>
            </ul>
          </div>
        </div>
        <div class="picture-box">
          <div class="title"><a href="#">행사사진</div></a>
          <ul class="picture-details">
            <li>
              <a href="#">
                <img src="images/p1.jpg" alt="">
                <span class="product">행사1</span>
              </a>
            </li>
            <li>
              <a href="#">
                <img src="images/p2.jpg" alt="">
                <span class="product">행사1</span>
              </a>
            </li>
            <li>
              <a href="#">
                <img src="images/p3.jpg" alt="">
                <span class="product">행사1</span>
              </a>
            </li>
            <li>
              <a href="#">
                <img src="images/p4.jpg" alt="">
                <span class="product">행사1</span>
              </a>
            </li>
            <li>
              <a href="#">
                <img src="images/p5.jpg" alt="">
                <span class="product">행사1</span>
              </a>
            </li>
            <li>
              <a href="#">
                <img src="images/p6.jpg" alt="">
                <span class="product">행사1</span>
              </a>
            </li>

            <li>
              <a href="#">
                <img src="images/p7.jpg" alt="">
                <span class="product">행사</span>
              </a>
            </li>
            <li>
              <a href="#">
                <img src="images/p8.jpg" alt="">
                <span class="product">행사1</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </section>

  <script src="../script/indexScript.js"></script>
</body>

</html>