package com.korea.itstargram;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import dao.BoardDAO;
import dao.MemberDAO;
import vo.BoardVO;
import vo.MemberVO;

@Controller
public class ProfileController {
	private BoardDAO daoB;
	private MemberDAO daoM;
	
	public void setDaoB(BoardDAO daoB) {
		this.daoB = daoB;
	}
	
	public void setDaoM(MemberDAO daoM) {
		this.daoM = daoM;
	}
	
// ==================================================
	
	@Autowired
	ServletContext ctx;
	
	@RequestMapping(value = "/profile.do")
	public String profile(Model m, int num) {
		MemberVO vo = daoM.get(num);
		vo.setPwd("");
		
		m.addAttribute("vo", vo);
		m.addAttribute("start", daoB.getCount(num));
		
		return HomeController.PATH + "profile/profile_home.jsp";
	}
	
	@ResponseBody
	@RequestMapping(value = "/profile_update.do", produces = "text/plain;charset=UTF-8")
	public String updateProfile(int num, int start) {
		List<BoardVO> list = daoB.getList(num, start);
		
		return new Gson().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping(value = "/upload_profile.do")
	public String uploadProfile(@RequestParam("files") MultipartFile files, @RequestParam("num") int num, Model m) {
		String webPath = "/client_resources/profile/" + num + "/";
		String savePath = ctx.getRealPath(webPath);
		
		String filename = files.getOriginalFilename();
		
		File file = new File(savePath, filename);
		if(!file.exists()) {
			file.mkdirs();
		}
		
		MemberVO vo = daoM.get(num);
		vo.setProfile(filename);
		daoM.updateProfile(vo);
		System.out.println(vo.getProfile());
		
		m.addAttribute("vo", vo);
		
		try {
			files.transferTo(file);
		} catch(IllegalStateException e) {
			e.printStackTrace();
			return "false";
		} catch(IOException e) {
			e.printStackTrace();
			return "false";
		}
		
		return "true";
	}
}
