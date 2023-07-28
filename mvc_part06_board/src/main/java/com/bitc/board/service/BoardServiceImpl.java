package com.bitc.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.board.dao.BoardDAO;
import com.bitc.board.util.Criteria;
import com.bitc.board.util.PageMaker;
import com.bitc.board.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@Service("bs")
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardDAO dao;
	
	@Override
	public String regist(BoardVO board) throws Exception {
		int result = dao.create(board);
		if(result > 0) {
			return "redirect:/board/listPage"; 
		}
		return "redirect:/board/register";
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		dao.updateCnt(bno);
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		BoardVO vo = dao.read(bno);
		return vo;
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		List<BoardVO> list = dao.listAll();
		return list;
	}

	@Override
	public String modify(BoardVO board) throws Exception {
		int result = dao.update(board);
		if(result > 1) {
			return "redirect:/board/read?bno="+board.getBno();
		}
		return "redirect:/board/listPage";
	}

	@Override
	public String remove(int bno) throws Exception {
		int result = dao.delete(bno);
		return "redirect:/board/listPage";
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		PageMaker pm = new PageMaker();
		pm.setCri(new Criteria());
		pm.setTotalCount(dao.totalCount());
		
		return dao.listCriteria(cri);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount());
		
		return pm;
	}

}
