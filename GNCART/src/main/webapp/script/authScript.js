/*authVacation*/
function vacLineBtn() {

    var popupUrl = "authVacationLine.jsp";

    var _width = '400';
    var _height = '390';

    var _left = Math.ceil((window.screen.width - _width) / 2);
    var _top = Math.ceil((window.screen.height - _height) / 2);

    window.open(popupUrl, "Line 팝업", 'width=' + _width + ', height=' + _height + ', left=' + _left + ', top=' + _top);
}

/*authBusiness*/
function busLineBtn() { 
    var popupUrl = "authBusinessLine.jsp";
    var _width = '400';
    var _height = '390';

    var _left = Math.ceil((window.screen.width - _width) / 2);
    var _top = Math.ceil((window.screen.height - _height) / 2);

    window.open(popupUrl, "LinePopup", 'width=' + _width + ', height=' + _height + ', left=' + _left + ', top=' + _top);
}

/*authVacation,authBusiness*/
function chkLine() {
    var first = document.getElementById("LINE_FIRST").value.trim();
    var second = document.getElementById("LINE_SECOND").value.trim();

    if (first === "" || second === "") {
        alert("결재선을 지정해주세요");
        return false;
    }
    return true;
}

/*authBusinessLine*/
function busSubmit() {
    window.opener.name = "authBusiness.jsp"; // 부모창의 이름 설정
    document.busForm.target = "authBusiness.jsp"; // 타켓을 부모창으로 설정
    document.busForm.action = "../auth/authBusiness.jsp";
    document.busForm.submit();
    self.close();
}

/*authVacationLine*/
function vacSubmit() {
    window.opener.name = "authVacation.jsp"; // 부모창의 이름 설정
    document.vacForm.target = "authVacation.jsp"; // 타켓을 부모창으로 설정
    document.vacForm.action = "../auth/authVacation.jsp";
    document.vacForm.submit();
    self.close();
}

/*auth modal*/
// 모달 백그라운드 요소 가져오기
var modalBackground = document.getElementById('modalBackground');

// 모달 표시 함수
function showModal() {
    modalBackground.style.display = 'block';
}

// 모달 숨기기 함수
function hideModal() {
    modalBackground.style.display = 'none';
    closePopup();
}

/*휴가,업무 창 */
// 열린 팝업 창에 대한 참조 저장
var newPopup = null;

// '휴가' 또는 '업무' 버튼 클릭 시 함수
function btnClick(option) {
    var url = option === 'vacation' ? "authVacation.jsp" : "authBusiness.jsp";
    openPopup(url);
}

/*viewPopup*/
// URL을 통해 뷰 팝업 열기
function openViewPopup(url) {
    openPopup(url);
}

// 팝업 열기 함수
function openPopup(popupUrl) {
    var _width = '800';
    var _height = '800';

    var _left = Math.ceil((window.screen.width - _width) / 2);
    var _top = Math.ceil((window.screen.height - _height) / 2);

    newPopup = window.open(popupUrl, "_blank", 'width=' + _width + ', height=' + _height + ', left=' + _left + ', top=' + _top);
}

// 팝업 닫기 함수
function closePopup() {
    if (newPopup) {
        newPopup.close();
    }
}

// '휴가' 뷰 팝업 열기
function vacView(DOC_NO) {
    openViewPopup("authVacationView.jsp?DOC_NO=" + DOC_NO);
}

// '업무' 뷰 팝업 열기
function busView(DOC_NO) {
    openViewPopup("authBusinessView.jsp?DOC_NO=" + DOC_NO);
}
// '체크박스'로 삭제
function submitForm() {
    document.getElementById("authForm").submit();
}

//체크박스 클릭스 팝업 안열리게
document.querySelector('.myCheckbox').onclick = function(event) {
    event.stopPropagation(); // 이벤트 전파 중지
};