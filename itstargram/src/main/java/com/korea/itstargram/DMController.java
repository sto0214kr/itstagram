package com.korea.itstargram;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.MemberDAO;

@Controller
public class DMController {
	private MemberDAO daoM;
	
	public void setDaoM(MemberDAO daoM) {
		this.daoM = daoM;
	}
	
// ==================================================
	
	@RequestMapping(value = "/dm.do")
	public String dm() {
		return HomeController.PATH + "dm/dm_home.jsp";
	}
}
