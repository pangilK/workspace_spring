package com.bitc.comment.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.board.util.Criteria;
import com.bitc.board.util.PageMaker;
import com.bitc.comment.dao.CommentDAO;
import com.bitc.comment.vo.CommentVO;

import lombok.RequiredArgsConstructor;

// Service Spring Bean 등록
@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {
	
	// CommentDAO 의존성 주입
	private final CommentDAO dao;
	
	@Override
	public List<CommentVO> commentList(int bno) throws Exception {
		return dao.commentList(bno);
	}
	
	private String getResult(int result) {
		return result == 1 ? "SUCCESS" : "FAILED";
	}
	
	@Override
	public String addComment(CommentVO vo) throws Exception {
		int result = dao.insert(vo);
		return getResult(result);
	}

	@Override
	public String updateComment(CommentVO vo) throws Exception {
		return getResult(dao.update(vo));
	}

	@Override
	public String deleteComment(int cno) throws Exception {
		return getResult(dao.delete(cno));
	}

	@Override
	public List<CommentVO> commentListPage(int bno, Criteria cri) throws Exception {
		return dao.listPage(bno, cri);
	}

	@Override
	public PageMaker getPageMaker(int bno, Criteria cri) throws Exception {
		int totalCount = dao.totalCount(bno);
		PageMaker pm = new PageMaker(cri,totalCount);
		pm.setDisplayPageNum(5);
		return pm;
	}

}
