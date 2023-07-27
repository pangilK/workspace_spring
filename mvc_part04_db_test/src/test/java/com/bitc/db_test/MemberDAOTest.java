package com.bitc.db_test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitc.db_test.dao.MemberDAO;
import com.bitc.db_test.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MemberDAOTest {
	
	@Autowired
	MemberDAO md;
	
	Integer num;
	
	@Before // org.junit.before
	public void init() {
		System.out.println("MemberDAO : " + md);
		num = md.readMax();
		if(num == null) {
			num = 1;
		}else {
			num = num + 1;
		}
	}	
	
	@Test
	public void testInsertMember() {
		MemberVO member = new MemberVO();
		member.setUserid("id00"+num);
		member.setUserpw("pw00"+num);
		member.setUsername("최기근"+num);
		
		int result = md.insertMember(member);
		System.out.println("insertMember result = " + result);
		
	}
	
	@Test 
	public void testReadMember() {
		MemberVO member = md.readMember("id001");
		System.out.println("member :" + member);
		
		MemberVO memberWithPass = md.readMemberWithPass("id002", "pw002");
		System.out.println("memberWithPass : " + memberWithPass);
		
		List<MemberVO> memberList = md.readMemberList();
		for(MemberVO m : memberList) {
			System.out.println(m);
		}
		
		int max = md.readMax();
		System.out.println("maxNumber : " + max);
	}
	
	
}
