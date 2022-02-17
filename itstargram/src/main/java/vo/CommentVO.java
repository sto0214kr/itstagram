package vo;

public class CommentVO {
	private int num;
	private int member_num;
	private int ref_board, ref_comment;
	private String content, regdate;
	private int hearts;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}

	public int getRef_board() {
		return ref_board;
	}

	public void setRef_board(int ref_board) {
		this.ref_board = ref_board;
	}

	public int getRef_comment() {
		return ref_comment;
	}

	public void setRef_comment(int ref_comment) {
		this.ref_comment = ref_comment;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getHearts() {
		return hearts;
	}

	public void setHearts(int hearts) {
		this.hearts = hearts;
	}
}
