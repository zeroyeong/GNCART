/*--------memberFrm - submit-------*/

function memCheck(){
	console.log(document.memberFrm.value);
}

/*----------사용자 조회로 이동----------*/

function read(MEM_NO){
	document.readFrm.MEM_NO.value=MEM_NO;
	document.readFrm.action="readMember.jsp";
	document.readFrm.submit();
}

/*--------searchFrm - placeholder--------*/

document.addEventListener("DOMContentLoaded", () => {
	let keyField =  document.getElementById('keyField');
	
	keyField.addEventListener("click", () => {
		let keyWord=document.getElementById('keyWord');
		switch(keyField.value){
			case "MEM_NAME" : keyWord.placeholder="이름을 입력해 주세요."; break;
			case "MEM_ID" : keyWord.placeholder="ID를 입력해 주세요."; break;
			case "MEM_PHONE" : keyWord.placeholder="-을 포함해서 입력해 주세요."; break;
			default : keyWord.placeholder="검색할 정보를 선택해 주세요.";
		}
	});
});
 

/*--------searchFrm - submit--------*/

function check() {
  if(searchFrm.keyField.value == ""){
	  alert("검색할 항목을 선택하세요.");
  	}else{
  		if(searchFrm.keyWord.value == ""){
  			alert("검색어를 입력하세요.");
  		}else{
  			searchFrm.submit();
  		}
  	}
}


/*-------새로고침을 위한 list Frm------*/
function list(){
	listFrm.action="memberList.jsp";
	listFrm.submit();
}




/* [modify.js]          <input value="수정"> */

function modify(){
	document.getElementById('modify').addEventListener("click",function(){
		location.href="../jsp/modify.js";
	})
}