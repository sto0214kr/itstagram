package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.MemberVO;

public class MemberDAO {
	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}

// ==================================================
	
	public List<MemberVO> getList() {
		return session.selectList("m.s_list");
	}
	
	public MemberVO get(int num) {
		return session.selectOne("m.s_one", num);
	}
	
	public MemberVO getByID(String id) {
		return session.selectOne("m.s_one_id", id);
	}
	
	public MemberVO getByEmail(String email) {
		return session.selectOne("m.s_one_email", email);
	}
	
	public MemberVO getByPhone(String email) {
		return session.selectOne("m.s_one_phone", email);
	}
	
	public String getName(int num) {
		return session.selectOne("m.s_name", num);
	}
	
	public int updateFollow(MemberVO vo) {
		return session.update("m.u_follow", vo);
	}
	
	public int updateProfile(MemberVO vo) {
		return session.update("m.u_profile", vo);
	}
	
	public int insert(MemberVO vo) {
		return session.insert("m.i", vo);
	}
}