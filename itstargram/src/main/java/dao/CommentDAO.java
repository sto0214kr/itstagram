package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.CommentVO;

public class CommentDAO {
	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}

// ==================================================
	
	public List<CommentVO> getList() {
		return session.selectList("comment.getList");
	}
	
	public List<CommentVO> getList(int ref_board, int ref_comment) {
		HashMap<String, Integer> params = new HashMap<String, Integer>();
		params.put("ref_board", ref_board);
		params.put("ref_comment", ref_comment);
		
		return session.selectList("comment.getList-ref_board", params);
	}
	
	public CommentVO get(int num) {
		return session.selectOne("comment.get", num);
	}
	
	public int getNum(int ref_board) {
		return session.selectOne("comment.getNum-a", ref_board);
	}
	
	public int getNum(int ref_board, int ref_comment) {
		HashMap<String, Integer> params = new HashMap<String, Integer>();
		params.put("ref_board", ref_board);
		params.put("ref_comment", ref_comment);
		
		return session.selectOne("comment.getNum-b", params);
	}
	
	public CommentVO getNew() {
		return session.selectOne("comment.getNew");
	}
	
	public int add(CommentVO vo) {
		return session.insert("comment.add", vo);
	}
	
	public int remove(int num) {
		return session.delete("comment.delete", num);
	}
}
