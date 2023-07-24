<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

    session.removeAttribute("idKey");
    session.removeAttribute("pwKey");

    // 세션 무효화
    session.invalidate();
    
    // 쿠키 삭제
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            cookie.setValue("");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);

        }
    }
    %>
    
    <script>
    location.replace("login.jsp");
    </script>