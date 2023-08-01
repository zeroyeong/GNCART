/*********화면 가운데서 팝업*********/

function openCenter(doc,win,w,h){
  var left=(screen.availWidth-w)/2; //왼쪽 좌표
  var top=(screen.availHeight-h)/2; //위쪽 좌표
  var opt='left='+left+', top='+top+', width='+w+', height='+h; //창의 좌표값
  
  window.open(doc,win,opt);
}

/**********************************/
/*************일정추가*************/
/**********************************/

function popup() {
  /*var popupCheck=window.open("scheduleAdd.jsp","","width=550, height=450");*/
  /*if(popupCheck==Null){
    alert("팝업차단을 해제해주세요!");
  }*/
  openCenter("scheduleAdd.jsp","",550,550)
}

/**********************************/
/*************일정보기*************/
/**********************************/
//function read(){
////	  openCenter("scheduleDetail.jsp","",550,550);
//	  document.scheduleFrm.submit();
//  }

//document.querySelectorAll('.scheduleList tr a').forEach((menu)=>menu.addEventListener('click',function(){
//  openCenter("scheduleDetail.jsp","",550,550)
//  
//}))
//
//function read(){
	  //document.scheduleFrm.action="scheduleDetail.jsp";
	  //document.scheduleFrm.submit();
  //}

/**********************************/
/*************팝업 닫기************/
/**********************************/

function closeBox(){
  window.close();
}