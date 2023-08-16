package common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import alert.AlertBean;
import alert.AlertMgr;
import chat.ChatBean;
import chat.ChatMgr;

@ServerEndpoint("/WebSocket/{fromPartType}/{fromName}")
public class WebSocket{

	private static Map<String, Session> userSessions = new HashMap<>();

	@OnMessage
	public void onMessage(String message, Session session,@PathParam("fromPartType") String fromPartType, @PathParam("fromName") String fromName) throws IOException {


		System.out.println(message);
		String[] parts = message.split("/", 4);

		if (parts.length != 4) {
			System.out.println("잘못된 형식의 메시지");
			return;
		}
		String type = parts[0];
		String content = parts[3];
		if(type.equals("alert")) {
			String toLineFirst = parts[1];
			String toLineSecond = parts[2];
	
			//소켓에 들어와있는 유저찾는 
			Session toSession1 = userSessions.get(toLineFirst);
			Session toSession2 = userSessions.get(toLineSecond);

			AlertMgr alertMgr = new AlertMgr();
			AlertBean abean = new AlertBean();
			
			if (toSession1 == null || !toSession1.isOpen()) {
				//db 저장		
				abean.setALERT_FROM(fromName);
				abean.setALERT_TO(toLineFirst);
				abean.setALERT_MESSAGE(content);
				abean.setALERT_STATE("안읽음");
				
				alertMgr.insertAlert(abean);

			}else {
				abean.setALERT_FROM(fromName);
				abean.setALERT_TO(toLineFirst);
				abean.setALERT_MESSAGE(content);
				abean.setALERT_STATE("안읽음");
				
				alertMgr.insertAlert(abean);

				toSession1.getBasicRemote().sendText(type + "/" + fromName +"/"+ toLineFirst + "/" + content); 
			}
			if (toSession2 == null || !toSession2.isOpen()) {
				//db 저장
				abean.setALERT_FROM(toLineFirst);
				abean.setALERT_TO(toLineSecond);
				abean.setALERT_MESSAGE(content);
				abean.setALERT_STATE("안읽음");
				
				alertMgr.insertAlert(abean);
	
			}else {
				//db저장
				abean.setALERT_FROM(toLineFirst);
				abean.setALERT_TO(toLineSecond);
				abean.setALERT_MESSAGE(content);
				abean.setALERT_STATE("안읽음");
				
				alertMgr.insertAlert(abean);

				toSession2.getBasicRemote().sendText(type + "/" + fromName +"/"+ toLineFirst + "/" + content); 
			}
		}



		// 모든 조건을 만족하는 경우 메시지 전송
		if(type.equals("chat")) { //타입이 채팅일때
			String toPartType = parts[1];
			String toName = parts[2];
			//상대 이름으로 상대 세션 찾기
			Session toSession = userSessions.get(toName);

			ChatMgr chatMgr = new ChatMgr();
			ChatBean cbean = new ChatBean();

			cbean.setChat_toPartType(toPartType);
			cbean.setChat_toName(toName);
			cbean.setChat_fromPartType(fromPartType);
			cbean.setChat_fromName(fromName);
			cbean.setChat_content(content);


			if (toSession == null || !toSession.isOpen()) {
				// 유효하지 않은 대상 사용자에 대한 처리
				// 대상 사용자의 세션이 끊어진 경우에 대한 처리
				chatMgr.insertChat(cbean);
				return;
			}		
			chatMgr.insertChat(cbean);
			toSession.getBasicRemote().sendText(type + "/" + toPartType +"/"+ toName + "/" + content);   
		}
	}

	@OnClose
	public void onClose(Session session, @PathParam("fromName") String fromName) {
		userSessions.remove(fromName);
		System.out.println("WebSocket User disconnected: " + fromName);
	}


	@OnOpen
	public void onOpen(Session session, @PathParam("fromName") String fromName) {

		session.getUserProperties().put("fromName", fromName); // 사용자명을 세션에 저장
		userSessions.put(fromName, session);
		System.out.println("WebSocket User connected: " + fromName);

		String username2 = (String) session.getUserProperties().get("fromName");

	}


}