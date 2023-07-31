var searchbar = document.getElementById("searchbar");
var allList = document.getElementById("allList");
var keyWord = document.getElementById("keyWord");

var selectAll = document.getElementById("selectAll");	
var selectKeyword = document.getElementById("selectKeyword");

var searchk = false;


if(searchbar.value == "" && keyWord.value != ""){
	searchbar.value = keyWord.value;
}

if(searchbar.value == ""){
	allList.style.display = 'table-row';
	searchList.style.display= 'none';
	keyWord.value = "";
	searchk = false;
}else{
	allList.style.display = 'none';
	searchList.style.display= 'table-row';
	searchbar.value = keyWord.value;
	searchk = true;
}

function test(){
	
	console.log("searchbar.value" + searchbar.value);
}


function searchUser(){
	
	if(searchbar.value == ""){
		keyWord.value = "";
	}else{
		keyWord.value = searchbar.value;
	}
	
	document.userFrm.submit();
}


searchbar.addEventListener("keydown", function (event) {
  if (event.keyCode === 13) {
    event.preventDefault();
    document.getElementById("searchBtn").click();
    
    console.log("엔터");
  }
});



//로그찍는용
function abctest(){
	
	var user = window.opener.document.getElementById("user");

	if(!searchk){
		user = selectAll.options[selectAll.selectedIndex].text;
	} else {
		user = selectKeyword.options[selectKeyword.selectedIndex].text;
	}

}

function sendUser(){
	
	var user = window.opener.document.getElementById("user");

	if(!searchk){
		user = selectAll.options[selectAll.selectedIndex].text;
	} else {
		user = selectKeyword.options[selectKeyword.selectedIndex].text;
	}

	
	window.opener.document.getElementById("user_part_name").value = user;

	if(user == "선택해 주세요"){
		alert("선택한 부서 이름이 없습니다.");
	}else{		
		self.close();
	}
}
	
