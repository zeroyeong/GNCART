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
function down(NOT_FILENAME){
	document.downFrm.NOT_FILENAME.value=NOT_FILENAME;
	document.downFrm.submit();
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
    
    function findFile(){
    	$("#file").on('change',function(){
    	  var name = $("#file").val();
    	  $("#filename").val(name);
    	});
    }
    
 	  