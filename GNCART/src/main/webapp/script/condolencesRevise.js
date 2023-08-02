var type = document.getElementById("type");
var typeSelect = document.getElementById("typeSelect");

for(var i=0; i<type.options.length; i++){
	if(type.options[i].value == typeSelect.value){
		type.options[i].selected = true;
	}
}

function mapSearch() {
			
	url = "conAddMap.jsp?";
	window.open(url, "condolencesMap","width=900,height=700, left=400, top=150,scrollbars=yes");
}

function findFile(){
	$("#file").on('change',function(){
	  var name = $("#file").val();
	  $("#addfile").val(name);
	});
}

function userSearch() {
			
	url = "conAddUser.jsp?";
	window.open(url, "conAddUser","width=900,height=700, left=400, top=150,scrollbars=yes");
}

function deleteMap(){

	var loadMap = document.getElementById("loadMap");
	var changeFile = document.getElementById("changeMap");
	loadMap.style.display = 'none';
	changeMap.style.display = 'block';
		
	//주소 값 초기화
	var kakaoField = document.getElementById("kakaoField");
		kakaoField.value = "";	
	
	var locationId = document.getElementById("locationId");
		locationId.value = "";
		locationId.placeholder='지도에서 검색 해주세요';
		
	//겹치는 아이디 변경
	document.getElementsByName('filed')[0].setAttribute('id', 'filed');
}

function deleteFile(){

	var loadFile = document.getElementById("loadFile");
	var changeFile = document.getElementById("changeFile");
	loadFile.style.display = 'none';
	changeFile.style.display = 'block';
	
	var addfile = document.getElementById("addfile");
	var delFile = document.getElementById("delFile");
	delFile.value = addfile.value;
	
	console.log("delFile= " + delFile.value);
	addfile.value = "";
	
	//겹치는 아이디 변경
	document.getElementsByName('af')[0].setAttribute('id', 'af');
}

//히든타입 addressName filename 데이터
function reviseSubmit(){
	
	var kakaoField = document.getElementById("kakaoField");
	var addressName = document.getElementById("addressName");
	
	addressName.value = kakaoField.value;
		
	document.postFrm.submit();
}


