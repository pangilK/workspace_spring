package com.bitc.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bitc.board.util.Criteria;
import com.bitc.board.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@Repository("dao")
@RequiredArgsConstructor
public class BoardDAOImpl implements BoardDAO {

	private final SqlSession session;
	
	@Override
	public int create(BoardVO vo) throws Exception {
		int result = session.insert("boardMapper.create",vo);
		System.out.println("dao : " + result);
		return result;
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		BoardVO vo = session.selectOne("boardMapper.read",bno);
		System.out.println("dao : " + vo);
		return vo;
	}

	@Override
	public int update(BoardVO vo) throws Exception {
		int result = session.update("boardMapper.update",vo);
		return result;
	}

	@Override
	public int delete(int bno) throws Exception {
		int result = session.delete("boardMapper.delete",bno);
		return result;
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		session.update("boardMapper.updateCnt",bno);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		List<BoardVO> listAll = session.selectList("boardMapper.listAll");
		return listAll;
	}

	@Override
	public int totalCount() throws Exception {
		return session.selectOne("boardMapper.totalCount");
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		int startRow = cri.getStartRow();
		List<BoardVO> list = session.selectList("boardMapper.listCri",cri);
		return list;
	}

}
