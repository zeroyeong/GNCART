<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/login.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js"/></script>
    <title>GNC:ART</title>
</head>
<body>
    <section class="login-form">
        <h1><a href="login.jsp">GNC:ART</a></h1>
        <form id="loginForm" name="loginForm" action="loginCheck.jsp" method="post">
            <div class="login">
                <input type="text" name="id" id="logId"  placeholder="ID" required>
                <input type="password" name="pw" id="logPW"  placeholder="Password" required>
                <button class="loginBtn" type="submit" value="로그인" onclick="loginCheck()"><b>Login</b></button>
            </div>
            <div class="logSave">
                <input type="checkbox" class="save_id" name="checkId" id="saveId" >
                <label for="saveId">Remember ID</label>
            </div>
        </form>
        <div class="caption">
            <a href="forgetPw.jsp">Forgot password?</a>
        </div>

   </section>
<script src="script/loginScript.js"></script>  

</body>
</html>