package directmessage.vo;

import vo.MemberVO;

public class ChatPacket {
	private int type;
	private MemberVO vo;
	private Object[] data;

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public MemberVO getVo() {
		return vo;
	}

	public void setVo(MemberVO vo) {
		this.vo = vo;
	}

	public Object[] getData() {
		return data;
	}

	public void setData(Object[] data) {
		this.data = data;
	}
	
	
}