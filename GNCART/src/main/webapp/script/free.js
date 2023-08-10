function list() {
	document.listFrm.action = "free.jsp";
	document.listFrm.submit();
}
function view(FREE_NO){
	document.viewFrm.FREE_NO.value=FREE_NO;
	document.viewFrm.action="freeread.jsp";
	document.viewFrm.submit();
}
function down(FREE_FILENAME){
	document.downFrm.FREE_FILENAME.value=FREE_FILENAME;
	document.downFrm.submit();
}    
    function write() {
    	  var title = document.getElementById("subject").value;
    	  var content = document.getElementById("content").value;

    	  if (title.trim() === "") {
    	    alert("제목을 입력해주세요");
    	    document.getElementById("subject").focus();
    	    return false;
    	  }

    	  if (content.trim() === "") {
    	    alert("내용을 입력해주세요");
    	    document.getElementById("content").focus();
    	    return false;
    	  }
    	  return true;
    	}   
        function getCurrentDate() {
      var currentDate = new Date();
      var year = currentDate.getFullYear();
      var month = String(currentDate.getMonth() + 1).padStart(2, '0');
      var day = String(currentDate.getDate()	).padStart(2, '0');

      return year + '-' + month + '-' + day;
}

    var currentDateInput = document.getElementById('currentDateInput');
    currentDateInput.value = getCurrentDate();
  