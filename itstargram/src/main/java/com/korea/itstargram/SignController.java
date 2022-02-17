package com.korea.itstargram;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.BoardDAO;
import dao.MemberDAO;
import vo.MemberVO;

@Controller
public class SignController {
	private BoardDAO daoB;
	private MemberDAO daoM;
	
	@Autowired
	HttpServletRequest request;
	
	public void setDaoB(BoardDAO daoB) {
		this.daoB = daoB;
	}
	
	public void setDaoM(MemberDAO daoM) {
		this.daoM = daoM;
	}
	
// ==================================================
	
	@RequestMapping(value = "/sign_up.do")
	public String signUp() {
		return HomeController.PATH + "/sign/sign_up.jsp";
	}
	
	@RequestMapping(value = "/sign_in.do")
	public String signIn() {
		return HomeController.PATH + "/sign/sign_in.jsp";
	}
	
	@ResponseBody
	@RequestMapping(value = "/sign_upA.do")
	public String signUp(Model m, String email, String name, String id, String password) {
		MemberVO vo = new MemberVO();
		vo.setEmail(email);
		vo.setName(name);
		vo.setId(id);
		vo.setPwd(password);
		
		MemberVO emailC = daoM.getByEmail(email);
		if(emailC != null) return "no_email";
		
		MemberVO idC = daoM.getByID(id);
		if(idC != null) return "no_id";
		
		int result = daoM.insert(vo);
		if(result == 0) { // failed
			return "failed";
		}
		
		vo = daoM.getByEmail(email);
		
		return vo.getNum() + "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/sign_inA.do")
	public String signIn(Model m, String id, String password) {
		MemberVO idC;
		
		String emailP = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
		String phoneP = "^[0-9]*$";
		
		if(Pattern.matches(emailP, id)) idC = daoM.getByEmail(id);
		else if(Pattern.matches(phoneP, id)) idC = daoM.getByPhone(id);
		else idC = daoM.getByID(id);
		
		
		if(idC == null) return "no_id";
		if(idC.getPwd().equals(password)) {
			request.getSession().setAttribute("me", idC);
			return idC.getNum() + "";
		}
		
		return "no_pwd";
	}
	
	@RequestMapping(value = "/sign_out")
	public String signOut(Model m) {
		request.getSession().removeAttribute("me");
		return "redirect:sign_in.do";
	}
}
