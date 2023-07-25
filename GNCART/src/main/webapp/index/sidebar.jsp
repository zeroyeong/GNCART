<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!--sidebar-->
  <div class="sidebar">
    <div class="logo-details">
      <i class="bx bx-menu menu-icon sidebarBtn"></i>
      <span class="logo_name">GNC:ART</span>
    </div>
    <ul class="nav-links">
      <li>
        <a href="../index/index.jsp">
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
        <a href="#">
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
        <a href="#">
          <i class='bx bxs-balloon icon'></i>
          <span class="links_name">행사사진</span>
        </a>
      </li>
      <li>
        <a href="#">
          <i class='bx bx-calendar-check icon'></i>
          <span class="links_name">회사일정</span>
        </a>
      </li>
      <li>
        <a href="" class="dropAuth">
          <i class='bx bx-paper-plane dropBtn'></i>
          <span class="links_name">결재</span>
        </a>
      </li>
      <div class="dropdown">
        <li><a href="../auth/auth.jsp">결재 신청</a></li>
        <li><a href="../auth/authHold.jsp">결재 승인</a></li>
      </div>
      <li>
        <a href="http://localhost:8080/GNCART/mypage/mypageMain.jsp">
          <i class='bx bx-info-circle icon'></i>
          <span class="links_name">My Page</span>
        </a>
      </li>
      <li class="log_out">
        <a href="../logOut.jsp">
          <i class="bx bx-log-out"></i>
          <span class="links_name">Logout</span>
        </a>
      </li>
    </ul>
  </div>