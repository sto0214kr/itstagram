package com.korea.itstargram;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import dao.CommentDAO;
import dao.MemberDAO;
import vo.CommentVO;

@Controller
public class CommentController {
	private CommentDAO daoC;
	private MemberDAO daoM;
	
	public void setDaoC(CommentDAO daoC) {
		this.daoC = daoC;
	}
	
	public void setDaoM(MemberDAO daoM) {
		this.daoM = daoM;
	}
	
// ==================================================
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	ServletContext ctx;
	
// ==================================================
	
	@RequestMapping(value = "/comment_test.do")
	public String test() {
		return HomeController.PATH + "alert_post.jsp";
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment_add.do", produces = "text/plain;charset=UTF-8")
	public String add(int member_num, int ref_board, int ref_comment, String content) {
		CommentVO vo = new CommentVO();
		
		vo.setMember_num(member_num);
		vo.setRef_board(ref_board);
		vo.setRef_comment(ref_comment);
		vo.setContent(content);
		
		int result = daoC.add(vo);
		return new Gson().toJson(daoC.getNew()); // add_list
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment_list.do", produces = "text/plain;charset=UTF-8")
	public String list(int ref_board, int ref_comment) {
		List<CommentVO> list = daoC.getList(ref_board, ref_comment);
		Map<Integer, String> names = new HashMap<Integer, String>();
		
		for(int i = 0; i < list.size(); ++i) {
			names.put(list.get(i).getMember_num(), daoM.getName(list.get(i).getMember_num()));
		}
		
		List<Object> result = new ArrayList<Object>();
		result.add(list);
		result.add(names);
		
		return new Gson().toJson(result);
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment_num.do", produces = "text/plain;charset=UTF-8")
	public String number(int ref_board, int ref_comment) {
		if(ref_comment == 0) {
			return daoC.getNum(ref_board) + "";
		} else {
			int a = daoC.getNum(ref_board, ref_comment);
			return a + "";
		}
	}
}
