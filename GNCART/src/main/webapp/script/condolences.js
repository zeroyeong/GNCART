/*

$(document).ready(function () {
	$('#example').DataTable();
});

*/

function deleteBtn(){
	
	if (confirm("정말 삭제 하시겠습니까?") == true) {
	document.listFrm.submit();
	} 
}

function urlBtn(con_no){
	
	var url = "condolencesDetail.jsp?con_no="
	url+= con_no;
	console.log("url = " + url);
	location.href=url;
}
