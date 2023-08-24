<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<%@page import="chat.ChatBean"%>
<%@page import="management.ManagementBean"%>
<jsp:useBean id="chatMgr" class="chat.ChatMgr" />

<%
request.setCharacterEncoding("UTF-8");
Vector<ManagementBean> userList = new Vector<ManagementBean>();
Vector<ChatBean> chatList = new Vector<ChatBean>();

String toPartType = "";
String toName = "";
String fromPartType = "";
String fromName = "";
String chatState = "";
String keyWord = "";
String chatting = "";
String listPopState ="open";

boolean read = false;
if (request.getParameter("keyWord") != null) {
	keyWord = request.getParameter("keyWord");
}

if (request.getParameter("toPartType") != null) {
	toPartType = request.getParameter("toPartType");
}

if (request.getParameter("toName") != null) {
	toName = request.getParameter("toName");
}

if (session.getAttribute("parttype") != null) {
	fromPartType = (String) session.getAttribute("parttype");
}

if (session.getAttribute("memName") != null) {
	fromName = (String) session.getAttribute("memName");
}

if (request.getParameter("chatState") != null) {
	chatState = request.getParameter("chatState");
}

if (request.getParameter("listPopState") != null) {
	listPopState = request.getParameter("listPopState");
}

if (request.getParameter("chatting") != null) {
	chatting = request.getParameter("chatting");
}

//채팅방에서 서로 주고받은 메시지는 읽음 처리
if(!chatting.equals("")){
	String[] parts = chatting.split("/", 2);
	String toUserPartType = parts[0];
	String toUserName = parts[1];
	
	chatMgr.setRead(toUserPartType, toUserName, fromPartType, fromName);
}

boolean chatRead = false;
chatRead = chatMgr.getRead(fromPartType, fromName);
%>

<div class="slider" id="chatSlider">

	<div class="chatPop">
		<div class="chatTop">
			<i class="bx bx-menu menu-icon chatPopIcon" onclick="slideChatPop()"></i>
			<% 
			if(toName != "" && toPartType != ""){
			%>
				<p><%=toPartType%> / <%=toName%></p>			
			<% 
			}else{
			%>
				<p>대화 상대를 더블 클릭 해주세요</p>
			<%
			}//if
			%>
		</div>
		<div class="chat-room" id="chatRoom">
			<%
			if (toName != "" && toPartType != "") {
				chatList = chatMgr.callChat(toPartType, toName, fromPartType, fromName);
				chatMgr.setRead(toPartType, toName, fromPartType, fromName);
				chatRead = chatMgr.getRead(fromPartType, fromName);
				for (int i = 0; i < chatList.size(); i++) {
					ChatBean cbean = chatList.get(i);
					String chatToName = cbean.getChat_toName();
					String chatFromName = cbean.getChat_fromName();
					String chatContent = cbean.getChat_content();

					if (chatToName.equals(toName)) {
			%>
			<p class="from-me"> 나 : <%=chatContent%></p>
			<br>
			<%
					} else {
			%>
			<p class="from-them"> <%=chatFromName%> : <%=chatContent%></p>
			<br>
			<%
					} //if
			} // for
			} else {
			%>
			<p>대화 상대를 더블 클릭 해주세요</p>
			<%
			} //else
			%>
		</div>
		<div class="chatbox">
			<input id="sendContent" onkeydown="return enter()" />
			<button class="chatBtn" onclick="send()">전 송</button>
		</div>
	</div>

	<div class="listChatPop">
		<div class="listChatTop">
			<p>사원 목록</p>
		</div>
		<div class="searchBox">
			<input id="searchbar" onkeydown="return searchEnter()" autocomplete="off"/>
			<button class="searchBtn" onclick="userSearch()">찾 기</button>
		</div>
		<div class="chat-list" id="allList">
			<%
			
			userList = chatMgr.userInfo();

			for (int i = 0; i < userList.size(); i++) {
				ManagementBean mbean = userList.get(i);
				String userPartType = mbean.getPART_TYPE();
				String userName = mbean.getMEM_NAME();
				if(!userName.equals(fromName)){ 
			%>
			<hr>
			<div class="chatNameBox" id="<%=userName%>">
			<p ondblclick="dblclick('<%=userPartType%>','<%=userName%>')"><%=userPartType%> / <%=userName%></p>
			<%
			read = chatMgr.readState(fromPartType, fromName, userPartType, userName);
			if(read){
			%>
			<div class="chatListRedIcon" id="<%=userName%>Icon"></div>
			<% 
			}
			%>
			</div>
			<hr>
			<%
				}//for
			}//if
			%>
		</div>
		<div class="chat-list" id="searchList" style="display: none;">
			<%
			userList = chatMgr.userFind(keyWord);

			for (int i = 0; i < userList.size(); i++) {
				ManagementBean mbean = userList.get(i);
				String userPartType = mbean.getPART_TYPE();
				String userName = mbean.getMEM_NAME();
				if(!userName.equals(fromName)){
			%>
			<hr>
			<div class="chatNameBox">
			<p ondblclick="dblclick('<%=userPartType%>','<%=userName%>')"><%=userPartType%> / <%=userName%></p>
			<%
			read = chatMgr.readState(fromPartType, fromName, userPartType, userName);
			if(read){
			%>
			<div class="chatListRedIcon"></div>
			<% 
			}
			%>
			</div>
			<hr>
			<%
				}//if
			}//for
			%>
		</div>
	</div>
	
	<form name="chatFrm" method="post" target="_self" autocomplete="off">
		<!-- 히든 -->
		<input type="hidden" id="toPartType" name="toPartType" value="<%=toPartType%>"> 
		<input type="hidden" id="toName" name="toName" value="<%=toName%>"> 
		<input type="hidden" id="fromPartType" name="fromPartType" value="<%=fromPartType%>">
		<input type="hidden" id="fromName" name="fromName" value="<%=fromName%>"> 
		<input type="hidden" id="keyWord" name="keyWord" value="<%=keyWord%>"> 
		<input type="hidden" id="chatRead" name="chatRead" value="<%=chatRead%>">
		<input type="hidden" id="chatState" name="chatState" value="<%=chatState%>">
		<input type="hidden" id="listPopState" name="listPopState" value="<%=listPopState%>">
		<input type="hidden" id="chatting" name="chatting" value="<%=chatting%>">
	</form>		
</div>