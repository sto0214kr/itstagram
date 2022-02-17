package util;

public class Util {
	public static boolean has(Integer[] data, int target) {
		for(int i: data) {
			if(i == target) return true;
		}
		
		return false;
	}
}
