package com.korea.itstargram;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import dao.BoardDAO;
import dao.CommentDAO;
import dao.MemberDAO;
import util.Util;
import vo.BoardVO;
import vo.MemberVO;

@Controller
public class HomeController {
	public static final String PATH = "/WEB-INF/views/";
	
	private BoardDAO daoB;
	private CommentDAO daoC;
	private MemberDAO daoM;
	
	@Autowired
	HttpServletRequest request;
	
	public void setDaoB(BoardDAO daoB) {
		this.daoB = daoB;
	}

	public void setDaoC(CommentDAO daoC) {
		this.daoC = daoC;
	}

	public void setDaoM(MemberDAO daoM) {
		this.daoM = daoM;
	}
	
// ==================================================
	
	public HomeController() {
		
	}

	@RequestMapping(value = {"/", "home.do"})
	public String home(Model model) {
		HttpSession session = request.getSession();
//		session.setAttribute("me", daoM.get(1));
		
		if(session.getAttribute("me") != null)
			model.addAttribute("start", daoB.getCount(((MemberVO)session.getAttribute("me")).getFollowings()));
		
		return PATH + "home.jsp";
	}
	
	@RequestMapping("a")
	public String a() {
		return PATH + "alert_write.jsp";
	}
	
	@ResponseBody
	@RequestMapping(value = "/get_vo.do", produces = "text/plain;charset=UTF-8")
	public String getVO(int num) {
		System.out.println(num);
		MemberVO vo = daoM.get(num);
		
		return new Gson().toJson(vo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/follow.do", produces = "text/plain;charset=UTF-8")
	public String follow(int num, boolean type) {
		HttpSession session = request.getSession();
		
		MemberVO me = (MemberVO)session.getAttribute("me");
		if(me == null) return "sign_in";
		
		MemberVO target = daoM.get(num);
		
		Integer[] followers = target.getFollowers();
		Integer[] followings = me.getFollowings();
		
		if(followings == null || Util.has(followings, num) == false) {
			if(type == false) return "no";
			
			if(followings == null) followings = new Integer[1];
			else followings = Arrays.copyOf(followings, followings.length + 1);
			
			followings[followings.length - 1] = num;
			me.setFollowings(followings);
			
			if(followers == null) followers = new Integer[1];
			else followers = Arrays.copyOf(followers, followers.length + 1);
			
			followers[followers.length - 1] = me.getNum();
			target.setFollowers(followers);
			
			daoM.updateFollow(me);
			daoM.updateFollow(target);
			
			return "yes";
		} else {
			if(type == false) return "yes";
			
			List<Integer> list = new ArrayList<Integer>(Arrays.asList(followings)); // followings
			list.remove((Integer)num);
			followings = list.toArray(new Integer[0]);
			me.setFollowings(followings);
			
			if(followers == null) followers = new Integer[1];
			
			list = new ArrayList<Integer>(Arrays.asList(followers)); // followers
			list.remove((Integer)me.getNum());
			followers = list.toArray(new Integer[0]);
			target.setFollowers(followers);
			
			daoM.updateFollow(me);
			daoM.updateFollow(target);
			
			return "no";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/home_update.do", produces = "text/plain;charset=UTF-8")
	public String list(int start) {
		MemberVO vo = (MemberVO)request.getSession().getAttribute("me");
		Integer[] f = vo.getFollowings();
		
		Map<Integer, MemberVO> listName = new HashMap<Integer, MemberVO>();
		for(int i: f) {
			listName.put(i, daoM.get(i));
		}
		
		List<BoardVO> list = daoB.getList(start, f);
		
		List<Object> result = new ArrayList<Object>();
		result.add(listName);
		result.add(list);
		
		return new Gson().toJson(result);
	}
	
	@ResponseBody
	@RequestMapping(value = "/add_heart.do", produces = "text/plain;charset=UTF-8")
	public String addHeart(int num, int member_num, boolean type) {
		BoardVO vo = daoB.get(num);
		
		if(vo.getHearts() == null) {
			if(type) {
				vo.setHearts("" + member_num);
				daoB.updateHearts(vo);
				return "true/1";
			} else {
				return "false/0";
			}			
		} else if(vo.getHearts().indexOf(member_num + "") == -1) {
			if(type) {
				vo.setHearts(vo.getHearts() + "/" + member_num);
				daoB.updateHearts(vo);
				return "true/" + vo.getHearts().split("/").length;	
			} else {
				return "false/" + (vo.getHearts().split("/").length);
			}
		} else {
			if(type) {
				List<String> hearts = new ArrayList<String>(Arrays.asList(vo.getHearts().split("/")));
				
				for(int i = 0; i < hearts.size(); ++i) {
					if(hearts.get(i).equals(member_num + "")) {
						hearts.remove(i);
						
						String r = hearts.size() > 0 ? hearts.get(0) : "";
						for(i = 1; i < hearts.size(); ++i) {
							r += "/" + hearts.get(i);
						}
						
						vo.setHearts(r);
						daoB.updateHearts(vo);
						return "false/" + (vo.getHearts().split("/").length - 1);
						
					}
				}
			} else return "true/" + vo.getHearts().split("/").length;
		}
		
		return "false/0";
	}
}
