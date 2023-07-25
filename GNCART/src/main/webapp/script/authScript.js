/*authVacation */
function lineBtn() {

var popupUrl = "authLine.jsp";
var popupOptions = "width=500,height=400,scrollbars=yes";

window.open(popupUrl, "Line 팝업", popupOptions);
}
  
/*auth */
var modalBackground = document.getElementById('modalBackground');
function showModal() {
    modalBackground.style.display = 'block';
}

function hideModal() {
    modalBackground.style.display = 'none';
}

function btnClick(option) {
    if (option === 'vacation') {
   
        var url = "authVacation.jsp";
        var windowOptions = "width=800,height=800,scrollbars=yes,resizable=yes";

        window.open(url, "_blank", windowOptions);
    } else if (option === 'work') {
        var url = "authWork.jsp";
        var windowOptions = "width=800,height=800,scrollbars=yes,resizable=yes";

        window.open(url, "_blank", windowOptions);
    }
}