
function userSearch() {
			
	url = "msgFindUser.jsp?";
	window.open(url, "msgFindUser","width=850,height=300, left=400, top=150,scrollbars=yes");
}


function findFile(){
	$("#file").on('change',function(){
	  var name = $("#file").val();
	  $("#filename").val(name);
	});
}
