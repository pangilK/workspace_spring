package com.bitc.file.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bitc.file.vo.FileVO;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class FileController {
	
	private final String uploadPath;
	private final String uploadDir;
	// application context
	private final ServletContext context;
	
	private String realPath;
	
	// Bean 사용 준비가 완료되면 최초에 한번 호출 되는 method
	@PostConstruct
	public void initPath() {
		
		realPath = context.getRealPath(File.separator+uploadDir);
		System.out.println(realPath);
		
		File file = new File(realPath);
		if(!file.exists()) {
			// 디렉토리 생성
			file.mkdirs();
			System.out.println("디렉토리 생성 완료");
		}
		System.out.println("file Controller 생성 및 사용준비 완료");
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	@GetMapping("uploadForm")
	public void uploadForm(){}
	
	@GetMapping("uploadAjax")
	public void uploadAjax(){}
	
	@PostMapping("uploadForm")
	public String uploadForm(
			@RequestParam("file") MultipartFile file,
			Model model) throws IOException{
		if(!file.isEmpty()) {
			System.out.printf("File Name : %s %n",file.getOriginalFilename());
			System.out.printf("File Size : %s %n",file.getSize());
			System.out.printf("File type : %s %n",file.getContentType());
			
			byte[] bytes = file.getBytes();
			
			String savedName = uploadFile(file.getOriginalFilename(), bytes);
			model.addAttribute("savedName",savedName);
			
			/* 
			 	File f = new File(uploadPath,file.getOriginalFilename());
			 	file.transferTo(f); 
			 */
			
			/*	
			    FileOutputStream fos = new FileOutputStream(f);
				fos.write(bytes);
				fos.flush();
				fos.close();
			*/
		}
		return "uploadResult";
	}
	
	/**
	 * 파일 업로드 후 업로드 된 파일 이름 반환
	 */
	public String uploadFile(String original,byte[] fileData) throws IOException {
		String savedName = "";
		UUID uuid = UUID.randomUUID();
		// 32개의 랜덤한 문자 + 4개의 - 조합 해서 == 36개의 문자
		System.out.println(uuid);
		savedName = uuid.toString().replace("-","")+"_"+original;
		System.out.println(savedName);
		// Spring에서 제공하는 파일 헬퍼 객체
		FileCopyUtils.copy(fileData, new File(realPath,savedName));
		
		return savedName;
	}
	
	@PostMapping("uploadForm1")
	public String uploadForm1(@RequestParam("file") MultipartFile[] files,Model model) throws Exception{
		List<String> saves = new ArrayList<>();
		for(MultipartFile f : files) {
			String savedName = uploadFile(f.getOriginalFilename(),f.getBytes());
			saves.add(savedName);
		}
		model.addAttribute("saves",saves);
		return "uploadResult";
	}
	
	@PostMapping("uploadForm2")
	public String uploadForm2(MultipartHttpServletRequest request,Model model) throws Exception{
		String auth = request.getParameter("auth");
		String content = request.getParameter("content");
		MultipartFile file = request.getFile("file");
		MultipartFile file1 = request.getFile("file1");
		String[] saves = new String[2];
		saves[0] = uploadFile(file.getOriginalFilename(),file.getBytes());
		saves[1] = uploadFile(file1.getOriginalFilename(),file1.getBytes());
		model.addAttribute("auth",auth);
		model.addAttribute("content",content);
		model.addAttribute("saves",saves);
		return "uploadResult";
	}
	
	@PostMapping("uploadForm3")
	public String uploadForm3(FileVO vo,Model model) throws Exception {
		List<String> saves = new ArrayList<>();
		saves.add(uploadFile(vo.getFile().getOriginalFilename(),vo.getFile().getBytes()));
		
		for(MultipartFile f : vo.getFiles()) {
			String savedName = uploadFile(f.getOriginalFilename(), f.getBytes());
			saves.add(savedName);
		}
		
		model.addAttribute("saves",saves);
		model.addAttribute("auth",vo.getAuth());
		model.addAttribute("content",vo.getContent());
		System.out.println(vo);
		return "uploadResult";
	}
}
