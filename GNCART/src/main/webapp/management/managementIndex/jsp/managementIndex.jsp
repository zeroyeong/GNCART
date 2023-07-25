<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GNC:ART</title>
<link rel="stylesheet" href="../css/style.css">

<!--Boxicons CDN Link-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  
</head>
<body>
  <!--sidebar-->
  <div class="sidebar">
    <div class="logo-details">
      <i class="bx bx-menu menu-icon sidebarBtn"></i>
      <span class="logo_name">GNC:ART</span>
    </div>
    <ul class="nav-links">
      <li>
        <a href="indexManagement.jsp" >
          <i class='bx bx-home-alt icon'></i>
          <span class="links_name">Home</span>
        </a>
      </li>
      <li>
        <a href="#">
          <i class='bx bxs-notification icon'></i>
          <span class="links_name">공지사항</span>
        </a>
      </li>
      <li>
        <a href="notice/notice.jsp">
          <i class='bx bx-clipboard icon'></i>
          <span class="links_name">자유게시판</span>
        </a>
      </li>
      <li>
        <a href="#">
          <i class='bx bx-message-alt-error icon'></i>
          <span class="links_name">경조사알림</span>
        </a>
      </li>
      <li>
        <a href="event/event.jsp">
          <i class='bx bxs-balloon icon'></i>
          <span class="links_name">행사사진</span>
        </a>
      </li>
      <li>
        <a href="schedule/scheduleMonth.jsp">
          <i class='bx bx-calendar-check icon'></i>
          <span class="links_name">회사일정</span>
        </a>
      </li>
      <li>
        <a href="#">
          <i class='bx bx-paper-plane'></i>
          <span class="links_name">결재</span>
        </a>
      </li>
      <li>
        <a href="mypage/mypage.jsp">
          <i class='bx bx-info-circle icon'></i>
          <span class="links_name">My Page</span>
        </a>
      </li>
      <li>
        <a href="management.jsp">
          <i class="bx bx-cog"></i>
          <span class="../../jsp/management.jsp">Management</span>
        </a>
      </li>

      <li class="log_out">
        <a href="login/login.jsp">
          <i class="bx bx-log-out"></i>
          <span class="links_name">Logout</span>
        </a>
      </li>

    </ul>
  </div>
  <!--home-top--->
  <section class="home-section">
    <nav>
      <div class="search-box">
        <input type="text" placeholder="Search..." />
        <i class="bx bx-search"></i>
      </div>
      <div class="profile-details">
        <a href="management.jsp"><img src="../images/profile.jpg" alt="" /></a>
        <span class="admin_name">관리자페이지</span>
      </div>
    </nav>

  <!--home-content-->  
    <div class="home-content">
      <div class="overview-boxes">
        <div class="box">
          <div class="right-side">
            <a href="#"><div class="box-topic">공지사항</div></a>
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
            </div>
          </div>
        </div>
        <div class="box">
          <div class="right-side">
            <a href="notice/notice.jsp"><div class="box-topic">자유게시판</div></a>
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
            </div>
          </div>
        </div>
        <div class="box">
          <div class="right-side">
            <a href="#"><div class="box-topic">경조사알림</div></a>
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
            </div>
          </div>
        </div>
        <div class="box">
          <div class="right-side">
            <a href="mypage/mypage.jsp"><div class="box-topic">My Page</div></a>
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
            </div>
          </div>
        </div>
      </div>

      <div class="board-boxes">
        <div class="schedule-box">
          <div class="title"><a href="schedule/scheduleMonth.jsp">회사일정</div></a>
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
          <div class="title"><a href="event/event.jsp">행사사진</div></a>
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

<script src="../script/script.js"></script>  
</body>
</html>