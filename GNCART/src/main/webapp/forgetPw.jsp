<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/forgetPw.css">
    <title>GNC:ART</title>
</head> 
<body>
    <section class="forgetPw">
        <h1><a href="forgetPw.jsp">GNC:ART</a></h1>
        <form action="ResetPasswordServlet" method="POST">
            <div class="login">
                <input type="text" name="logId" id="logId"  placeholder="ID" required>
                <input type="password" name="resetPw1" id="resetPw1" placeholder="New Password" required>
                <input type="password" name="resetPw2" id="resetPw2" placeholder="Confirm New Password" required>
                <button class="resetBtn" type="submit"><b>Password Reset</b></button>
            </div>  
        </form>
    </section>
</body>
</html>
