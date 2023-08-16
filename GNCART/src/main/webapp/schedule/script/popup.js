/*********화면 가운데서 팝업*********/

function openCenter(doc,win,w,h){
  var left=(screen.availWidth-w)/2; //왼쪽 좌표
  var top=(screen.availHeight-h)/2; //위쪽 좌표
  var opt='left='+left+', top='+top+', width='+w+', height='+h; //창의 좌표값
  
  window.open(doc,win,opt); 
}

/*********팝업닫기*********/
function closeBox(){
  window.close();
}