function read(EVENT_NO) {
	document.readFrm.EVENT_NO.value = EVENT_NO;
	document.readFrm.action = "eventView.jsp";
	document.readFrm.submit();
}


function getCurrentDate() {
      var currentDate = new Date();
      var year = currentDate.getFullYear();
      var month = String(currentDate.getMonth() + 1).padStart(2, '0');
      var day = String(currentDate.getDate()	).padStart(2, '0');

      return year + '-' + month + '-' + day;
}
if(document.getElementById('currentDateInput') !=null){
	var currentDateInput = document.getElementById('currentDateInput');
	currentDateInput.value = getCurrentDate();
	}
    
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
    var newLabel = $('<label for="file' + fileIndex + '">파일찾기</label>');
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


//페이지 처리
// 변수 선언

const showTable = 32; //페이지당 보여줄 표 수
const view = showTable / 4;
const totalTable = document.querySelectorAll("table").length; //전체 표 수
const table = document.querySelectorAll("table"); //표 리스트
console.log("view = " +view);
console.log("totalTable = "+totalTable);
console.log("table = " + table);
const totalPage = Math.ceil(totalTable / view); //전체 페이지 수 (Math.ceil로 무조건 소수점 올림)
console.log("totalPage ="+totalPage);
const pages = document.getElementById("pagenation"); //페이지 버튼이 생성될 공간
console.log("pages = " + pages);

// 페이지 버튼 생성

for (let i = 1; i <= totalPage; i++) {
  let btn = document.createElement("button");
  btn.innerHTML =  `<li><a href="">${i}</a></li>`;

  pages.appendChild(btn);
}

const page = document.querySelectorAll("#pagenation li");
console.log(page);

page.forEach((t, idx) => {
  t.addEventListener("click", (e) => {
    e.preventDefault(); //a태그의 href속성 무시
    for (t of page) {
      t.classList.remove("active");
    }
    display(idx);
  });
});

// displayTable(idx)
// 버튼 클릭할때 보여줄 애들은 보여주고 안보일 애들은 display none
// 클릭한 버튼은 active 클래스 추가

function display(idx) {
  let start = idx * view; //보여줄 표 시작번호 : idx는 인덱스값이기 때문에 0부터 접근해야함.
  console.log(start);
  let end = start + view; //보여줄 표 끝 번호
  console.log(end);

  let array = [...table]; // querySelectorAll은 완전한 배열이 아니기때문에 배열로 만들어줌
  for (t of array) {
    t.style.display = "none";
  }

  let displayTable = array.slice(start, end); // 보여질 만큼의 인덱스값 저장
  for (dt of displayTable) {
    dt.style.display = ""; //display="block"으로 하면 화면이 엉킬 수 있음. none을 없애주기만

    page[idx].classList.add("active"); //클릭한 버튼엔 active클래스를 추가해준다.
  }
}

display(0);