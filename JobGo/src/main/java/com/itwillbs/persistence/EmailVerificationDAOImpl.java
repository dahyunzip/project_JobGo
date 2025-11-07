package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EmailVerificationVO;

@Repository
public class EmailVerificationDAOImpl implements EmailVerificationDAO {
	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE = "com.itwillbs.mapper.EmailVerificationMapper.";
	
	private static final Logger logger = LoggerFactory.getLogger(EmailVerificationDAOImpl.class);
	
	
	@Override
	public void insertVerification(EmailVerificationVO vo) throws Exception {
		logger.debug("insertVerification(EmailVerificationVO vo) 시작 !");
		sqlSession.insert(NAMESPACE+"insertVerification", vo);
		logger.debug("insertVerification(EmailVerificationVO vo) 종료 !");
	}

	@Override
	public EmailVerificationVO selectLatestByEmail(String email) throws Exception {
		logger.debug("selectLatestByEmail(String email, char memberType) 시작 !");
		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		logger.debug("selectLatestByEmail(String email, char memberType) 종료 !");
		return sqlSession.selectOne(NAMESPACE+"selectLatestByEmail", params);
	}

	@Override
	public void updateVerifiedStatus(Long verificationId, char verified) throws Exception {
		logger.debug("updateVerifiedStatus(Long verificationId, char verified) 시작 !");
		Map<String, Object> params = new HashMap<>();
		params.put("verificationId", verificationId);
		params.put("verified", verified);
		sqlSession.update(NAMESPACE+"updateVerifiedStatus", params);
		logger.debug("updateVerifiedStatus(Long verificationId={}, verified={}) 종료!", verificationId, verified);
	}

	@Override
	public int countVerifiedByEmail(String email, char verified) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		params.put("verified", verified);
		return sqlSession.selectOne(NAMESPACE+"countVerifiedByEmail", params);
	}
	
	

}
