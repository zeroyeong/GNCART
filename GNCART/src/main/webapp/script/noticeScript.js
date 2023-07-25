function list() {
	document.listFrm.action = "notice.jsp";
	document.listFrm.submit();
}
function view(NOT_NO){
	document.viewFrm.NOT_NO.value=NOT_NO;
	document.viewFrm.action="noticeView.jsp";
	document.viewFrm.submit();
}
function submitForm() {
    document.getElementById("noticeForm").submit();
}
function checkAll() {
    var checkboxes = document.getElementsByName("chk");
    var selectAllCheckbox = document.getElementsByName("all")[0];
    
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = selectAllCheckbox.checked;
    }
}
function check() {
	   document.ReviseFrm.submit();
	}
function down(NOT_FILENAME){
	document.downFrm.NOT_FILENAME.value=NOT_FILENAME;
	document.downFrm.submit();
}    
    function writeNOT() {
    	  var title = document.getElementById("not_title").value;
    	  var content = document.getElementById("not_content").value;

    	  if (title.trim() === "") {
    	    alert("제목을 입력해주세요");
    	    document.getElementById("not_title").focus();
    	    return false;
    	  }

    	  if (content.trim() === "") {
    	    alert("내용을 입력해주세요");
    	    document.getElementById("not_content").focus();
    	    return false;
    	  }
    	  return true;
    	}