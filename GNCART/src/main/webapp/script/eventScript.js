function getCurrentDate() {
      var currentDate = new Date();
      var year = currentDate.getFullYear();
      var month = String(currentDate.getMonth() + 1).padStart(2, '0');
      var day = String(currentDate.getDate()	).padStart(2, '0');

      return year + '-' + month + '-' + day;
}

	var currentDateInput = document.getElementById('currentDateInput');
	currentDateInput.value = getCurrentDate();
    
var fileIndex = 1;
var maxFiles = 5; 

function findFile(index) {
    var fileInput = $("#file" + index);
    var filenameInput = $("#filename" + index);
    var allowedExtensions = ["jpg", "jpeg", "png", "gif"];

    var selectedFile = fileInput[0].files[0];
    if (selectedFile) {
        var fileName = selectedFile.name;
        var fileExtension = fileName.split('.').pop().toLowerCase();

        if (allowedExtensions.indexOf(fileExtension) !== -1) {
            filenameInput.val(fileName);
        } else {
            alert("이미지 파일만 선택 가능합니다.");
            fileInput.val("");
            filenameInput.val("");
        }
    }
}

	function fileplus() {
   	 if (fileIndex >= maxFiles) {
        alert("최대 " + maxFiles + "개까지만 이미지 파일을 첨부할 수 있습니다.");
        return;
    }

    fileIndex++;

    var newInput = $('<input id="filename' + fileIndex + '" placeholder="첨부파일" readonly>');
    var newLabel = $('<label for="file' + fileIndex + '"></label>');
    var newFileInput = $('<input type="file" id="file' + fileIndex + '" name="NOT_FILENAME' + fileIndex + '" onchange="findFile(' + fileIndex + ')">');

    newInput.insertBefore("a[onclick='fileplus()']");
    newLabel.insertBefore("a[onclick='fileplus()']");
    newFileInput.insertBefore("a[onclick='fileplus()']");
}
    
    function notfile() {
  	  var fileInput = document.getElementById("file1");
  	  var filenameInput = document.getElementById("filename1");
    
    if (fileInput.files.length === 0 && filenameInput.value === "") {
        alert("최소 1개의 이미지파일을 첨부해주세요.");
        fileInput.click();
        return false; 
    }
}