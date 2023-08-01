/****************************************/
/***************월별 스타일**************/
/****************************************/

const month = document.querySelectorAll('#month a'); //월 a태그들을 모두 선택

    /******월 클릭시 nowMonth 바뀌도록******/
    month.forEach((t) => {
        t.addEventListener('click', (e) => {
            e.preventDefault();
            const target = e.currentTarget;

            nowMonth = new Date(nowMonth.getFullYear(), parseInt(t.attributes[1].value) - 1, nowMonth.getDate());
            buildCalendar();
        });
    });

    /*********active클래스를 입혀서 스타일 적용***********/
    function monthActive(idx) {
        month.forEach(t => t.classList.remove('active'));
        month[idx].classList.add('active');
    }



/****************************************/
/*****************캘린더*****************/
/****************************************/

	window.onload = function () { buildCalendar();}
	let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
    let today = new Date();     // 페이지를 로드한 날짜를 저장

    // 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
    function buildCalendar() {
        monthActive(nowMonth.getMonth());
        
        let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);     // 이번달 1일
        let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);  // 이번달 마지막날

        document.getElementById("prevYear").innerText = nowMonth.getFullYear() - 1;  // 년 숫자 갱신
        document.getElementById("nextYear").innerText = nowMonth.getFullYear() + 1;  // 년 숫자 갱신

        let tbody_Calendar = document.querySelector(".Calendar > tbody");
        document.getElementById("calYear").innerText = nowMonth.getFullYear();             // 연도 숫자 갱신
        document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);  // 월 숫자 갱신

        while (tbody_Calendar.rows.length > 0) {                        // 이전 출력결과가 남아있는 경우 초기화
            tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
        }

        let nowRow = tbody_Calendar.insertRow();        // 첫번째 행 추가          

        for (let j = 0; j < firstDate.getDay(); j++) {  // 이번달 1일의 요일만큼
            let nowColumn = nowRow.insertCell();        // 열 추가
        }

        for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {   // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  

            let nowColumn = nowRow.insertCell();        // 새 열을 추가하고
            nowColumn.innerText = leftPad(nowDay.getDate());      // 추가한 열에 날짜 입력


            if (nowDay.getDay() == 0) {                 // 일요일인 경우 글자색 빨강으로
                nowColumn.style.color = "red";
            }
            if (nowDay.getDay() == 6) {                 // 토요일인 경우 글자색 파랑으로 하고
                nowColumn.style.color = "blue";
                nowRow = tbody_Calendar.insertRow();    // 새로운 행 추가
            }


            if (nowDay < today) {                       // 지난날인 경우
                nowColumn.className = "pastDay";
                nowColumn.onclick = function () { choiceDate(this); }
            }
            else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) { // 오늘인 경우          
                nowColumn.className = "today";
                nowColumn.onclick = function () { choiceDate(this); }
            }
            else {                                      // 미래인 경우
                nowColumn.className = "futureDay";
                nowColumn.onclick = function () { choiceDate(this); }
            }
        }
    }

    // 이전달 버튼 클릭
    function prevCalendar() {
        nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());   // 현재 달을 1 감소
        buildCalendar();    // 달력 다시 생성
    }
    // 다음달 버튼 클릭
    function nextCalendar() {
        nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());   // 현재 달을 1 증가
        buildCalendar();    // 달력 다시 생성
    }

    // input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
    function leftPad(value) {
        if (value < 10) {
            value = value;
            return value;
        }
        return value;
    }

    // 이전년 버튼 클릭
    function prevYearCalendar() {
        nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 12, nowMonth.getDate());   // 현재 달을 12 감소
        document.getElementById("prevYear").innerText = nowMonth.getFullYear() - 1;  // 년 숫자 갱신
        document.getElementById("nextYear").innerText = nowMonth.getFullYear() + 1;  // 년 숫자 갱신


        buildCalendar();    // 달력 다시 생성
    }
    // 다음년 버튼 클릭
    function nextYearCalendar() {
        nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 12, nowMonth.getDate());   // 현재 달을 12 증가
        document.getElementById("prevYear").innerText = nowMonth.getFullYear() - 1;  // 년 숫자 갱신
        document.getElementById("nextYear").innerText = nowMonth.getFullYear() + 1;  // 년 숫자 갱신
        buildCalendar();    // 달력 다시 생성
    }
    
    
