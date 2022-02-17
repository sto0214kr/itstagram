package directmessage.room;

import java.util.ArrayList;
import java.util.HashMap;

import javax.websocket.Session;

public class Room {
	private static ArrayList<Room> rooms = new ArrayList<Room>();
	
	public static Room[] getRooms() {
		return rooms.toArray(new Room[0]);
	}
	
// ==================================================
	
	public static Room get(int num) {
		for(int i = 0; i < rooms.size(); ++i) {
			Integer[] clients = rooms.get(i).getKeys();
			
			for(Integer c: clients) {
				if((int)c == num) return rooms.get(i);
			}
		}
		
		return null;
	}
	
// ==================================================
	
	private HashMap<Integer, Session> clients = new HashMap<Integer, Session>(); 
	
	public Integer[] getKeys() {
		return clients.keySet().toArray(new Integer[0]);
	}
	
	public Session[] getClients() {
		return clients.values().toArray(new Session[0]);
	}
}
