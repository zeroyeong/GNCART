// 변수 선언

const showTable = 10; //페이지당 보여줄 표 수
const totalTable = document.querySelectorAll("tbody tr").length; //전체 표 수
const table = document.querySelectorAll("tbody tr"); //표 리스트
console.log(table);
const totalPage = Math.ceil(totalTable / showTable); //전체 페이지 수 (Math.ceil로 무조건 소수점 올림)
console.log(totalPage);
const pages = document.getElementById("pagenation"); //페이지 버튼이 생성될 공간
console.log(pages);

// 페이지 버튼 생성

for (let i = 1; i <= totalPage; i++) {
  let btn = document.createElement("button");
  btn.innerHTML =  `<a href=""><li>${i}</li></a>`;

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
  let start = idx * showTable; //보여줄 표 시작번호 : idx는 인덱스값이기 때문에 0부터 접근해야함.
  console.log(start);
  let end = start + showTable; //보여줄 표 끝 번호
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
