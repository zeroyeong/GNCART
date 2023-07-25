/*Remember ID */
$(document).ready(function () {
    var key = getCookie("idChk");
    if (key != "") {
        $("#logId").val(key);
    }

    if ($("#logId").val() != "") {
        $("#saveId").attr("checked", true);
    }

    $("#saveId").change(function () {
        if ($("#saveId").is(":checked")) {
            setCookie("idChk", $("#logId").val(), 7);
        } else {
            deleteCookie("idChk");
        }
    });

    $("#logId").keyup(function () {
        if ($("#saveId").is(":checked")) {
            setCookie("idChk", $("#logId").val(), 7);
        }
    });
});
function setCookie(cookieName, value, exdays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

function deleteCookie(cookieName) {
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if (start != -1) {
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if (end == -1) end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

/*loginCheck.jsp */
function loginCheck() {
    if (document.loginFrm.id.value == "") {
        alert("아이디를 입력해 주세요.");
        document.loginFrm.id.focus();
        return;
    }
    if (document.loginFrm.pwd.value == "") {
        alert("비밀번호를 입력해 주세요.");
        document.loginFrm.pwd.focus();
        return;
    }
    document.loginFrm.submit();
}
