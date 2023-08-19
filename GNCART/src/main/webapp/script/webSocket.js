var chatSlider = document.getElementById('chatSlider'); //chatSlieder toggle toggle state

var toPartType = document.getElementById("toPartType");
var toName = document.getElementById("toName");
var fromPartType = document.getElementById("fromPartType");
var fromName = document.getElementById("fromName");
var chatting = document.getElementById("chatting"); //서로 같은 방에서 chat중인지

//결재자에게
var toLineFirst = document.getElementById("LINE_FIRST");
var toLineSecond = document.getElementById("LINE_SECOND");

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
var listPopState = document.getElementById("listPopState"); 
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
	if(toName != null){	
		if(toName.value == ""){
			console.log(fromName.value + " 웹소켓 접속!!");
		}else{
			console.log("fromName = " + fromName.value +" toName = " + toName.value + " 연결 성공!");	
			chatRoom.scrollTop = chatRoom.scrollHeight; // 스크롤 항상 아래로
		}	
	}
}

//받을때
function onMessage(event) {
    var message = event.data;
    var messageParts = message.split("/", 5);
    var type = messageParts[0];
    var content = messageParts[3];

    if (type == "chat") {
        var toUserPartType = messageParts[1];
        var toUser = messageParts[2];
     
		if((toUserPartType != toPartType.value) || (toUser != toName.value)){
			updateChatBadge();
			chatRedIconAdd(toUser);
			chatting.value ="";
		}else{	
			chatting.value = toUserPartType + "/" + toUser;
			handleMessage(toUser, content);	
		}		
    }
    else if (type == "alert") {
        var firstName = messageParts[1];
        var secondName = messageParts[2];
        var alertNum = messageParts[4];

        handleAlert(firstName, secondName, content, alertNum);
    }
}

function onError(event) {
  alert(event.data);
}

//맨처음 안읽은 chat 있는지 확인
if(document.getElementById("chatRead") != null){	
	var chatRead = document.getElementById("chatRead");
	
	if(chatRead.value =="true"){
		updateChatBadge();
	}
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

//메시지 받았을때 chat redIcon 활성화
function updateChatBadge(){
	if(document.querySelector(".chatRedIcon") != null){
	    var chatRedIcon = document.querySelector(".chatRedIcon");
        chatRedIcon.style.display = "block";		
	}
}

function chatRedIconAdd(toUser) {
    var chatNameBox = document.getElementById(toUser);
    
    if(document.getElementById(toUser+"Icon") == null){		
	    var redIcon = document.createElement("div");
		redIcon.className = 'chatListRedIcon';
	  	chatNameBox.appendChild(redIcon);
	}
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

  listPopState.value = "close";
  keyWord.value ="";
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
if(toPartType != null){	
	if(toPartType.value != ""){
		if(listPopState.value === "close"){
			listChatPop.style.display = 'none';		
		}
		chatPop.style.display = 'block';
	}
}

/* 유저 찾기 */
var searchk = false;

if(searchbar != null && keyWord != null){
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
}

function userSearch(){
	
	if(searchbar.value == ""){
		keyWord.value = "";
	}else{
		keyWord.value = searchbar.value;
	}
	
 	listPopState.value = "open";
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
function chatToggle() {
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

//listchat 창 열기
function slideChatPop() {
    var listChatPop = document.querySelector('.listChatPop');

    if (listChatPop.style.display === 'none' || listChatPop.style.display === '') {
        listChatPop.style.display = 'block';
        listPopState.value = "open";
    } else {
        listChatPop.style.display = 'none';
        listPopState.value = "close";
    }
}


//alert 부분
//알림
function sendAlert(content) {
    if (toLineFirst != null && toLineSecond != null) {
        webSocket.send("alert" + "/" + toLineFirst.value + "/" + toLineSecond.value + "/" + content);
    }else{
		webSocket.send("alert" + "/" + "temp" + "/" + toLineSecond.value + "/" + content);
	}
}

//받을때
function handleAlert(firstName, secondName, content, alertNum) {
    var message = firstName + content;
    addAlert(message, alertNum);
    updateAlertBadge();
}

//보내기
function alertSend() {
    let alertContent = "님의 결재문서가 있습니다";
    sendAlert(alertContent);
}

// 새로운 알림 메시지를 생성하여 목록에 추가하는 함수
function addAlert(message, alertNum) {
    var dropdown = document.querySelector("#alertList");
    var url = document.createElement("a");
    url.href = "../auth/authHold.jsp?alertNo=" + alertNum;
    var li = document.createElement("li");
    li.textContent = message;
    url.appendChild(li);
    dropdown.insertBefore(url, dropdown.firstChild);
}

// 알림 아이콘 뱃지 업데이트 함수
function updateAlertBadge() {
    var redIcon = document.querySelector(".redIcon");
    var alertList = document.getElementById("alertList");

    if (redIcon != null && alertList != null && alertList.children.length > 0) {
        redIcon.style.display = "block";
    } else {
        redIcon.style.display = "none";
    }
}

//알림드롭박스 토글
function alertToggle() {
    var redIcon = document.querySelector('.redIcon'); 
    var dropdown = document.querySelector('.alertBell-dropdown');
    
	//redIcon이 block일때만 active
    if (redIcon.style.display === "block") {
        dropdown.classList.toggle('active');
    }
}