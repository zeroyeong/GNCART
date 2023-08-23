/* mypage */

//전화번호
phone1.onclick = function() {
	document.getElementById("phone").innerHTML = "전화번호 변경";
	document.querySelector('#phone1').style.display = "none";
	document.querySelector('#phone2').style.display = "none";
	document.querySelector('#phone3').style.display = "block";
	document.querySelector('#phone4').style.display = "block";
	document.querySelector('#phone5').style.display = "block";
}
phone3.onclick = function() {
	document.getElementById("phone").innerHTML = "전화번호";
	document.querySelector('#phone1').style.display = "block";
	document.querySelector('#phone2').style.display = "block";
	document.querySelector('#phone3').style.display = "none";
	document.querySelector('#phone4').style.display = "none";
	document.querySelector('#phone5').style.display = "none";

	document.phone6.submit();
}
phone5.onclick = function() {
	document.getElementById("phone").innerHTML = "전화번호";
	document.querySelector('#phone1').style.display = "block";
	document.querySelector('#phone2').style.display = "block";
	document.querySelector('#phone3').style.display = "none";
	document.querySelector('#phone4').style.display = "none";
	document.querySelector('#phone5').style.display = "none";
}


//이메일
mail1.onclick = function() {
	document.getElementById("mail").innerHTML = "이메일 변경";
	document.querySelector('#mail1').style.display = "none";
	document.querySelector('#mail2').style.display = "none";
	document.querySelector('#mail3').style.display = "block";
	document.querySelector('#mail4').style.display = "block";
	document.querySelector('#mail5').style.display = "block";
}
mail3.onclick = function() {
	document.getElementById("mail").innerHTML = "이메일";
	document.querySelector('#mail1').style.display = "block";
	document.querySelector('#mail2').style.display = "block";
	document.querySelector('#mail3').style.display = "none";
	document.querySelector('#mail4').style.display = "none";
	document.querySelector('#mail5').style.display = "none";

	document.mail6.submit();
}
mail5.onclick = function() {
	document.getElementById("mail").innerHTML = "이메일";
	document.querySelector('#mail1').style.display = "block";
	document.querySelector('#mail2').style.display = "block";
	document.querySelector('#mail3').style.display = "none";
	document.querySelector('#mail4').style.display = "none";
	document.querySelector('#mail5').style.display = "none";
}


//생년월일
birth1.onclick = function() {
	document.getElementById("birth").innerHTML = "생년월일 변경";
	document.querySelector('#birth1').style.display = "none";
	document.querySelector('#birth2').style.display = "none";
	document.querySelector('#birth3').style.display = "block";
	document.querySelector('#birth4').style.display = "block";
	document.querySelector('#birth5').style.display = "block";
}
birth3.onclick = function() {
	document.getElementById("birth").innerHTML = "생년월일";
	document.querySelector('#birth1').style.display = "block";
	document.querySelector('#birth2').style.display = "block";
	document.querySelector('#birth3').style.display = "none";
	document.querySelector('#birth4').style.display = "none";
	document.querySelector('#birth5').style.display = "none";

	document.birth6.submit();
}
birth5.onclick = function() {
	document.getElementById("birth").innerHTML = "생년월일";
	document.querySelector('#birth1').style.display = "block";
	document.querySelector('#birth2').style.display = "block";
	document.querySelector('#birth3').style.display = "none";
	document.querySelector('#birth4').style.display = "none";
	document.querySelector('#birth5').style.display = "none";
}


//주소
add1.onclick = function() {
	document.getElementById("add").innerHTML = "주소 변경";
	document.querySelector('#add1').style.display = "none";
	document.querySelector('#add2').style.display = "none";
	document.querySelector('#add3').style.display = "block";
	document.querySelector('#add4').style.display = "block";
	document.querySelector('#add5').style.display = "block";
}
add3.onclick = function() {
	document.getElementById("add").innerHTML = "주소";
	document.querySelector('#add1').style.display = "block";
	document.querySelector('#add2').style.display = "block";
	document.querySelector('#add3').style.display = "none";
	document.querySelector('#add4').style.display = "none";
	document.querySelector('#add5').style.display = "none";

	document.add6.submit();
}
add5.onclick = function() {
	document.getElementById("add").innerHTML = "주소";
	document.querySelector('#add1').style.display = "block";
	document.querySelector('#add2').style.display = "block";
	document.querySelector('#add3').style.display = "none";
	document.querySelector('#add4').style.display = "none";
	document.querySelector('#add5').style.display = "none";
}


//비밀번호
pwd1.onclick = function() {
	document.getElementById("pwd").innerHTML = "비밀번호 변경";
	document.querySelector('#pwd1').style.display = "none";
	document.querySelector('#pwd2').style.display = "none";
	document.querySelector('#pwd3').style.display = "block";
	document.querySelector('#pwd4').style.display = "block";
	document.querySelector('#pwd5').style.display = "block";
	document.querySelector('#pwd6').style.display = "block";
	document.querySelector('#pwd8').style.display = "block";
	document.querySelector('#pwd10').style.display = "none";
	document.querySelector('#pwd11').style.display = "none";
	document.querySelector('#pwd12').style.display = "none";
}
pwd3.onclick = function() {
	document.getElementById("pwd").innerHTML = "비밀번호";
	document.querySelector('#pwd1').style.display = "inline-block";
	document.querySelector('#pwd2').style.display = "inline-block";
	document.querySelector('#pwd3').style.display = "none";
	document.querySelector('#pwd4').style.display = "none";
	document.querySelector('#pwd5').style.display = "none";
	document.querySelector('#pwd6').style.display = "none";
	document.querySelector('#pwd8').style.display = "none";
	document.querySelector('#pwd9').style.display = "none";
	document.querySelector('#pwd10').style.display = "block";
	document.querySelector('#pwd11').style.display = "none";
	document.querySelector('#pwd12').style.display = "none";

	pwd();

	document.pwd7.submit();
}
pwd6.onclick = function() {
	document.getElementById("pwd").innerHTML = "비밀번호";
	document.querySelector('#pwd1').style.display = "inline-block";
	document.querySelector('#pwd2').style.display = "inline-block";
	document.querySelector('#pwd3').style.display = "none";
	document.querySelector('#pwd4').style.display = "none";
	document.querySelector('#pwd5').style.display = "none";
	document.querySelector('#pwd6').style.display = "none";
	document.querySelector('#pwd8').style.display = "none";
	document.querySelector('#pwd9').style.display = "none";
	document.querySelector('#pwd10').style.display = "block";
	document.querySelector('#pwd11').style.display = "none";
	document.querySelector('#pwd12').style.display = "none";

	pwd();
}


//비밀번호 보이기
pwd8.onclick = function() {
	document.querySelector('#pwd4').type = "text";
	document.querySelector('#pwd5').type = "text";
	document.querySelector('#pwd8').style.display = "none";
	document.querySelector('#pwd9').style.display = "block";
}

pwd9.onclick = function() {
	document.querySelector('#pwd4').type = "password";
	document.querySelector('#pwd5').type = "password";
	document.querySelector('#pwd8').style.display = "block";
	document.querySelector('#pwd9').style.display = "none";
}

function pwd() {
	document.querySelector('#pwd4').type = "password";
	document.querySelector('#pwd5').type = "password";
}

// **** -> 비밀번호 표기
pwd10.onclick = function() {
	document.querySelector('#pwd2').style.display = "none";
	document.querySelector('#pwd12').style.display = "block";
	document.querySelector('#pwd10').style.display = "none";
	document.querySelector('#pwd11').style.display = "block";
}

// 비밀번호 표기 -> ****
pwd11.onclick = function() {
	document.querySelector('#pwd2').style.display = "block";
	document.querySelector('#pwd12').style.display = "none";
	document.querySelector('#pwd10').style.display = "block";
	document.querySelector('#pwd11').style.display = "none";
}

//출근하기
workStart.onclick = function() {
	document.workStart2.submit();
}

//퇴근하기
workEnd.onclick = function() {
	document.workEnd2.submit();
}

//퇴근 업데이트 후 근태 확인하기
workEnd1.onclick = function() {
	document.workEnd2.submit();
	window.open("workday/workdayCheck.jsp", "window_name", "width=540, height=570, location=no, status=no, scrollbars=yes");
}

//휴가 취소 하기
workRestCancel1.onclick = function() {
	document.workRestCancel2.submit();
}

//근태 확인하기
workStart1.onclick = function() {
	window.open("workday/workdayCheck.jsp", "window_name", "width=540, height=570, location=no, status=no, scrollbars=yes");
}