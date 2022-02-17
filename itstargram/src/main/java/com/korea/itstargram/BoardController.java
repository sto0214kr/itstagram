package com.korea.itstargram;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDAO;
import vo.BoardVO;

@Controller
public class BoardController {
	private BoardDAO daoB;
	
	public void setDaoB(BoardDAO daoB) {
		this.daoB = daoB;
	}
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	ServletContext ctx;
	
	@RequestMapping(value = "/test_b.do")
	public String a() {
		return HomeController.PATH + "alert_write.jsp";
	}
	
	@ResponseBody
	@RequestMapping(value = "/upload_photo.do")
	public String uploadPhoto(@RequestParam("files") MultipartFile[] files, @RequestParam("num") int num, ModelMap modelMap) {
		String webPath = "/client_resources/post/" + num + "/";
		String savePath = ctx.getRealPath(webPath);
		System.out.println(savePath);
		
		for(MultipartFile f: files) {
			String filename = f.getOriginalFilename();
			
			File file = new File(savePath, filename);
			if(!file.exists()) {
				file.mkdirs();
			}
			
			try {
				f.transferTo(file);
			} catch(IllegalStateException e) {
				e.printStackTrace();
				return "false";
			} catch(IOException e) {
				e.printStackTrace();
				return "false";
			}
		}
		
		return "true";
	}
	
	@ResponseBody
	@RequestMapping(value = "/upload_post.do")
	public String uploadPost(String content, int member_num, int num, String list) {
		daoB.insert(member_num, num, content);
		BoardVO vo = daoB.getByPhoto(num + "");
		System.out.println(vo.getContent());
		
		vo.setPhotos(list.substring(0, list.length() - 1));
		
		String webPath = "/client_resources/post/" + num;
		String savePath = ctx.getRealPath(webPath);
		
		String c_path = ctx.getRealPath("/client_resources/post/" + vo.getNum());
		
		File file = new File(savePath);
		File file2 = new File(c_path);
		System.out.println(file.renameTo(file2) + ", " + c_path);
		
		daoB.updateP(vo.getNum(), vo.getPhotos());
		
		return "";
	}
}
