package directmessage;

import java.util.ArrayList;
import java.util.Collections;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;

import directmessage.vo.ChatPacket;

@ServerEndpoint("/chatserver")
public class MainServer {
	private static ArrayList<Session> clients = new ArrayList<Session>();
	
	public static Session[] getClients() {
		return clients.toArray(new Session[0]);
	}
	
// ==================================================
	
	{
		Collections.synchronizedList(clients);
	}
	
	public static boolean has(Session session) {
		for(int i = 0; i < clients.size(); ++i) {
			if(clients.get(i).equals(session)) return true;
		}
		
		return false;
	}
	
// ==================================================
	
	@OnOpen
	public void onOpen(Session session) {
		if(!MainServer.has(session)) {
			clients.add(session);
			
			System.out.println("Client connected...!");
			System.out.println("ID: " + session.getId());
			System.out.println();
		}
	}
	
	@OnMessage
	public void onMessage(Session session, String msg) {
		Gson gson = new Gson();
		
		ChatPacket packet = gson.fromJson(msg, ChatPacket.class);
		
		int type = packet.getType();
		
		switch(type) {
			case 1: { // 접속했을 때, 
				
			} break;
		}
	}
	
	@OnClose @OnError
	public void onClose(Session session) {
		clients.remove(session);
		
		System.out.println("Client closed...!");
		System.out.println("ID: " + session.getId());
		System.out.println();
	}
}
