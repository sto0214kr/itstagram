package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;

import vo.BoardVO;
import vo.MemberVO;

public class BoardDAO {
	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}

// ==================================================

	public List<BoardVO> getList(int member_num) {
		return session.selectList("b.s_list_a", member_num);
	}
	
	public List<BoardVO> getList(int member_num, int start) {
		HashMap<String, Integer> params = new HashMap<String, Integer>();
		params.put("member_num", member_num);
		params.put("start", start);
		
		return session.selectList("b.s_list_b", params);
	}
	
	public List<BoardVO> getList(int start, Integer[] array) {
		if(array.length == 0 || array == null) return null;
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("arr", array);
		
		List<BoardVO> list = session.selectList("b.s_list_following", params);
		
		return list;
	}
	
	public BoardVO get(int num) {
		return session.selectOne("b.s", num);
	}
	
	public BoardVO getByPhoto(String num) {
		return session.selectOne("b.s_photoNum", num);
	}
	
	public int getCount(int member_num) {
		return session.selectOne("b.s_count", member_num);
	}
	
	public int getCount(Integer[] array) {
		if(array.length == 0 || array == null) return 0;
		return session.selectOne("b.s_count_following", array);
	}
	
	public int updateHearts(BoardVO vo) {
		return session.update("b.u_hearts", vo);
	}
	
	public int insert(int member_num, int p_num, String content) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("member_num", member_num);
		params.put("content", content);
		params.put("p_num", p_num + "");
		
		return session.insert("b.i", params);
	}
	
	public int updateP(int num, String photos) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("num", num);
		params.put("photos", photos);
		
		return session.update("b.u_photos", params);
	}
}
