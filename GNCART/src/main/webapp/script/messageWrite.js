
function userSearch() {
			
	url = "msgFindUser.jsp?";
	window.open(url, "conAddUser","width=900,height=700, left=400, top=150,scrollbars=yes");
}


function findFile(){
	$("#file").on('change',function(){
	  var name = $("#file").val();
	  $("#filename").val(name);
	});
}
