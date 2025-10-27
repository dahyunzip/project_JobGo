package com.itwillbs.controller;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
			locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"}
		)
public class MemberTest {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberTest.class);
	
	//@Inject
	//private SqlSession sqlSession;
	
	@Inject
	private MemberDAO mdao;
	
	//@Test
	public void test_sqlSession() {
		logger.debug(" test_sqlSession 실행 ");
		//logger.debug(" sqlSession : " + sqlSession);
	}
	
	@Test
	public void test_insertMember() {
		logger.debug(" test_insertMember 실행 ");
		
		MemberVO vo = new MemberVO();
		vo.setUserid("test01");
		vo.setUserpw("1234");
		vo.setEmail("test01@jobgo.itwillbs.com");
		vo.setName("권봄");
		vo.setPhone("01012341234");
		vo.setAddr("부산광역시 금정구 수림로");
		
		mdao.insertMember(vo);
		
		logger.debug(" TEST : insertMember(vo) 실행 완료");
	}
}
