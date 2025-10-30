package com.itwillbs.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.persistence.CorpMemberDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
			locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"}
		)
public class CorpMemberTest {
	
	private static final Logger logger = LoggerFactory.getLogger(CorpMemberTest.class);
	
	@Inject
	private CorpMemberDAO cdao;
	
	//@Test
	public void test_insertCorpMember() throws Exception {
		logger.debug(" test_inserCorpMember() 실행 ");
		
		CorpMemberVO vo = new CorpMemberVO();
		vo.setCorpUserId("corp01");
		vo.setCorpUserPw("1234");
		vo.setManagerName("정규태");
		vo.setManagerEmail("corp01@corpname.com");
		vo.setManagerTel("010-1111-2222");
		vo.setCompanyName("이타즈");
		vo.setBusinessRno("111-1111-11111");
		vo.setBusinessLicenseUrl("sdjlsallkwjlktjaklsjsasdlks");
		vo.setCeoName("권영민");
		vo.setCompanyAddress("부산시 금정구 수림로");
		vo.setIndustryType("정보통신");
		vo.setBusinessType("소프트웨어개발");
		vo.setCorpAgreeLocation("Y");
		vo.setCorpAgreeLocation("Y");
		vo.setCorpAgreeLocation("Y");
		
		cdao.insertCorpMember(vo);
		logger.debug(" TEST : insertCorpMember(vo) 실행 완료");
	}
	
	@Test
	public void test_loginCorpMember() throws Exception {
		String corpUserId = "corp01";
		String corpUserPw = "1234";
		logger.info(" corpUserID : " + corpUserId);
		logger.info(" corpUserPw : " + corpUserPw);
		CorpMemberVO result = cdao.loginCorpMember(corpUserId, corpUserPw);
		if(result != null) {
			logger.debug(" 로그인 성공 : {}", result.getManagerName());
			logger.debug(" 회사명: {}", result.getCompanyName());
		}else {
			logger.debug(" 로그인 실패");
		}
	}
}
