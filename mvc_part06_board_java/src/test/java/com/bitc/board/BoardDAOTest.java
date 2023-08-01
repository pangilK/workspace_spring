package com.bitc.board;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitc.board.config.RootConfig;
import com.bitc.board.dao.BoardDAO;
import com.bitc.board.util.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
	classes = {RootConfig.class}
)
public class BoardDAOTest {

	@Autowired
	private BoardDAO dao;
	
	@Test
	public void mapperScanTest() throws Exception {
		System.err.println(dao);
		System.err.println(dao.getClass().getName());
		System.err.println(dao.read(1));
		System.err.println(dao.listCriteria(new Criteria()));
	}
	
}
