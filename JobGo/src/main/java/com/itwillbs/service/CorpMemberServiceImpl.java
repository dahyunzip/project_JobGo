package com.itwillbs.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.persistence.CorpMemberDAO;
import com.itwillbs.persistence.EmailVerificationDAOImpl;

@Service
public class CorpMemberServiceImpl implements CorpMemberService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(CorpMemberServiceImpl.class);
	
	@Inject
	private CorpMemberDAO cdao;
	
	@Inject
	private EmailVerificationDAOImpl vdao;
	
	//회원가입
	@Override
	public void registerCorpMember(CorpMemberVO vo) throws Exception {
		cdao.insertCorpMember(vo);

	}

	// 아이디 중복 체크
	@Override
	public boolean isUseridAvailable(String corpUserId) throws Exception {
		int count = cdao.countByUserid(corpUserId);
		logger.debug(" corpUserId = {}, count = {}", corpUserId, count);
		return (count == 0);
	}
	
	@Override
	public boolean isEmailVerified(String email) throws Exception {
		int countVer = vdao.countVerifiedByEmail(email, 'Y');
		logger.debug("isEmailVerified: email = [{}], count = {}", email, countVer);
		return countVer > 0;
	}

	@Override
	public boolean isEmailRegistered(String email) throws Exception {
		int count = cdao.countByEmail(email);
		logger.debug("isEmailRegistered: email = [{}], count = {}", email, count);
		return (count > 0);
	}

	// 로그인
	@Override
	public CorpMemberVO login(String corpUserId, String corpUserPw) throws Exception {
		return cdao.loginCorpMember(corpUserId, corpUserPw);
	}

	// 아이디로 회원정보 가져오기
	@Override
	public CorpMemberVO getCorpMember(String corpUserId) throws Exception {
		return cdao.getCorpMemberByUserid(corpUserId);
	}

}
