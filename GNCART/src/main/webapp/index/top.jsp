<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.MemberBean" %>
<jsp:useBean id="mMgr" class="login.MemberMgr"/>

    <nav>
      <div class="alert-icon">
        <i class='bx bx-bell' data-count="1"></i>
        <i class='bx bxs-message-dots'></i>
      </div> 

      <div class="profile-details">
        <a href="#"><img src="../images/profile.jpg" alt="" /></a>
        <span class="admin_name"><%= session.getAttribute("memName")%></span>
      </div>
    </nav>
   
   