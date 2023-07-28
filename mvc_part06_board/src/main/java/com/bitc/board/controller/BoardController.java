package com.bitc.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitc.board.service.BoardService;
import com.bitc.board.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService bs;
	BoardVO vo;
	
	/* "게시글 작성 페이지 요청" */
	// @RequestMapping(value="/register",method=RequestMethod.GET)
	@GetMapping("board/register")
	public String register()throws Exception{
		// /board/register
		// WEB-INF/views/board/register.jsp
		System.out.println("게시글 작성 페이지 요청");
		vo = new BoardVO();
		
		return "board/register";
	}
	
	/**
	 * 게시글 등록 요청 처리 추가
	 * @throws Exception 
	 */
	@PostMapping("board/register")
	public String register(String title,String content,String writer,BoardVO vo,HttpSession session) throws Exception {
		String message = bs.regist(vo);
		session.setAttribute("message",message);
		return "board/listPage";
	}
	
	
	/**
	 * 게시글 상세보기 요청 처리 - 게시글 번호
	 * @throws Exception 
	 */
	@GetMapping("board/read")
	public String read(@RequestParam("bno") int bno, Model model) throws Exception {
	    System.out.println("게시글 상세 페이지 요청 - bno: " + bno);
	    
	    BoardVO board = bs.read(bno);
	    bs.updateCnt(bno);
	    model.addAttribute("boardVO", board);

	    return "board/read";
	}
	/**
	 * 게시글 수정 페이지 요청
	 * - 게시글 수정 화면 출력 
	 * @throws Exception 
	 */
	@GetMapping("board/modify")
	public String modify(int bno, Model model) throws Exception {
		
		BoardVO board = bs.read(bno);
		model.addAttribute("boardVO", board);
		
		return "board/modify";
	}
	
	
	/**
	 * 게시글 수정 처리 요청
	 * 게시글 수정 완료 후 redirect - 수정게시글 상세보기 페이지 이동
	 */
	@PostMapping("board/modify")
	public String modfiy(int bno,String title,String content,String writer,BoardVO vo) throws Exception {
		return bs.modify(vo);
	}

	/**
	 * 게시글 삭제 완료 후 listPage 페이지 로 이동 - redirect 
	 * @throws Exception 
	 */
	@GetMapping("board/remove")
	public String remove(int bno) throws Exception {
		return bs.remove(bno);
	}
	
	/**
	 *  페이징 처리 된 게시글 출력 페이지
	 *  param : 요청 page, perPageNum 
	 * @throws Exception 
	 */
	// board/listPage
	@GetMapping("board/listPage")
	public String listPage(HttpSession session,HttpServletRequest request) throws Exception {
		if(request.getParameter("page") == null) {
			session.setAttribute("list",bs.listAll());			
		}else {
			/*
			 * session.setAttribute("list", bs.listCriteria(cri));
			 * session.setAttribute("page", );
			 */
		}
		return "board/listPage";
	}
	
}















