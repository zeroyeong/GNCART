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
