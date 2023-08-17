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
var modalBackground = document.getElementById('modalBackground');
function showModal() {
    modalBackground.style.display = 'block';
}

function hideModal() {
    modalBackground.style.display = 'none';
}

/*휴가,업무 창 */
var isPopupOpen = false;
function btnClick(option) {
    if (!isPopupOpen) {
        isPopupOpen = true;
        
        var url = option === 'vacation' ? "authVacation.jsp" : "authBusiness.jsp";
        var _width = '800';
        var _height = '800';

        var _left = Math.ceil((window.screen.width - _width) / 2);
        var _top = Math.ceil((window.screen.height - _height) / 2);

        var newPopup = window.open(url, "_blank", 'width=' + _width + ', height=' + _height + ', left=' + _left + ', top=' + _top);
        
        newPopup.onbeforeunload = function () {
            isPopupOpen = false;
        };
    }
}

/*viewPopup*/
function vacView(DOC_NO) {

    var _width = '800';
    var _height = '800';

    var _left = Math.ceil((window.screen.width - _width) / 2);
    var _top = Math.ceil((window.screen.height - _height) / 2);

    window.open("authVacationView.jsp?DOC_NO=" + DOC_NO, "_blank",
        'width=' + _width + ', height=' + _height + ', left=' + _left + ', top=' + _top);
}

function busView(DOC_NO) {

    var _width = '800';
    var _height = '800';

    var _left = Math.ceil((window.screen.width - _width) / 2);
    var _top = Math.ceil((window.screen.height - _height) / 2);

    window.open("authBusinessView.jsp?DOC_NO=" + DOC_NO, "_blank",
        'width=' + _width + ', height=' + _height + ', left=' + _left + ', top=' + _top);
}