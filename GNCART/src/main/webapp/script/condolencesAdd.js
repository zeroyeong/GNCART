
function mapSearch() {
			
	url = "conAddMap.jsp?";
	window.open(url, "condolencesMap","width=900,height=700, left=400, top=150,scrollbars=yes");
}

function findFile(){
	$("#file").on('change',function(){
	  var name = $("#file").val();
	  $("#filename").val(name);
	});
}
