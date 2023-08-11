var chatSlider = document.getElementById('chatSlider'); //chatSlieder toggle toggle state

var toPartType = document.getElementById("toPartType");
var toName = document.getElementById("toName");
var fromPartType = document.getElementById("fromPartType");
var fromName = document.getElementById("fromName");


//채팅 p태크 생성
var chatRoom = document.getElementById("chatRoom");
var sendContent = document.getElementById("sendContent"); 



//유저찾기
var searchbar = document.getElementById("searchbar");
var allList = document.getElementById("allList");
var searchList = document.getElementById("searchList");
var keyWord = document.getElementById("keyWord");

//chat Pops
var listChatPop = document.querySelector('.listChatPop');
var chatPop = document.querySelector('.chatPop');
var openPop = document.getElementById("openPop"); 

//socket
var webSocket =  "";
var url = "ws://localhost:8080/GNCART/WebSocket/" + fromPartType.value + "/" + fromName.value;




//socket
webSocket = new WebSocket(url);
   
webSocket.onerror = function(event) { onError(event) };
webSocket.onopen = function(event) { onOpen(event) };
webSocket.onmessage = function(event) { onMessage(event) };

//열었을때
function onOpen(event) {//hidden값으로 채팅인지 알림인지 구분하기
	if(toName.value == ""){
		console.log(fromName.value + " 웹소켓 접속!!");
	}else{
		console.log("fromName = " + fromName.value +" toName = " + toName.value + " 연결 성공!");	
		chatRoom.scrollTop = chatRoom.scrollHeight; // 스크롤 항상 아래로
	}	
}

//받을때
function onMessage(event) {
    var message = event.data;
    var messageParts = message.split("/", 4);
    var type = messageParts[0];
    var toPartType = messageParts[1];
    var toName = messageParts[2];
    var content = messageParts[3];
    
    if(type == "chat"){	
	    handleMessage(toName,content);
	}
	
    
}

function onError(event) {
  alert(event.data);
}

//메시지 받았을때
function handleMessage(toUser,content) {  
    let new_pTag = document.createElement('p');
    let new_br = document.createElement('br');
       new_pTag.setAttribute('class', 'from-them');
    new_pTag.innerHTML = toUser+ ": " + content;
    
    chatRoom.appendChild(new_pTag);
    chatRoom.appendChild(new_br);        
 
    chatRoom.scrollTop = chatRoom.scrollHeight;
}

//메시지 보낼때
function send(){
      
    let new_pTag = document.createElement('p');
    let new_br = document.createElement('br');
       new_pTag.setAttribute('class', 'from-me');
    new_pTag.innerHTML ="나 : " + sendContent.value;
    webSocket.send("chat" +"/"+ toPartType.value +"/"+ toName.value + "/" + sendContent.value);
    chatRoom.appendChild(new_pTag);
    chatRoom.appendChild(new_br);
    sendContent.value ="";
    
    chatRoom.scrollTop = chatRoom.scrollHeight;
    
 }
        
/* chat 상대 연결 */
function dblclick(toPartType, toName){
  
  document.getElementById("toPartType").value = toPartType;
  document.getElementById("toName").value = toName;  

  openPop.value = "chatPop";
  document.chatFrm.submit();
}

//보내기 엔터
function enter() {
    // keyCode 13은 엔터이다.
    if(event.keyCode === 13) {
      // 서버로 메시지 전송
       send();
      // form에 의해 자동 submit을 막는다.
      return false;
    }
    return true;
}

//상대 정해지면 chat 창으로 이동
if(toPartType.value != null && toPartType.value != ""){
	listChatPop.style.display = 'none';
	chatPop.style.display = 'block';

}else{
	listChatPop.style.display = 'block';
	chatPop.style.display = 'none';
}



/* 유저 찾기 */
var searchk = false;


if(searchbar.value == "" && keyWord.value != ""){
	searchbar.value = keyWord.value;
}

if(searchbar.value == ""){
	allList.style.display = 'block';
	searchList.style.display= 'none';
	keyWord.value = "";
	searchk = false;
}else{
	allList.style.display = 'none';
	searchList.style.display= 'block';
	searchbar.value = keyWord.value;
	searchk = true;
}


function userSearch(){
	
	if(searchbar.value == ""){
		keyWord.value = "";
	}else{
		keyWord.value = searchbar.value;
	}

    openPop.value = "listChatPop";
	document.chatFrm.submit();
}

function searchEnter() {
    // keyCode 13은 엔터이다.
    if(event.keyCode === 13) {
		userSearch();
      return false;
    }
    return true;
}
/* 유저 찾기 */

//chat open state
if(document.getElementById("chatState") != null){
	var chatState = document.getElementById("chatState");
	if(chatState.value == "open"){
		 chatSlider.classList.toggle('active');
	}
}

//chat toggle
function toggleChat() {
    chatSlider.classList.toggle('active');
    
    var chatState = "";
    if(document.getElementById("chatState") != null){
		chatState = document.getElementById("chatState");
		
		if(chatState.value == "open"){
			chatState.value = "close";
		}else{
			chatState.value = "open";
		}
	}
}


//chat 옆으로 이동
function slideChatPop() {
    var listChatPop = document.querySelector('.listChatPop');

    if (listChatPop.style.display === 'none' || listChatPop.style.display === '') {
        listChatPop.style.display = 'block';
    } else {
        listChatPop.style.display = 'none';
    }
}













