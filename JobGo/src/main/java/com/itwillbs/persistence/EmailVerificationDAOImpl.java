package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EmailVerificationVO;

@Repository
public class EmailVerificationDAOImpl implements EmailVerificationDAO {
	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE = "com.itwillbs.mapper.EmailVerificationMapper.";
	
	
	@Override
	public void insertVerification(EmailVerificationVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"insertVerification", vo);
	}

	@Override
	public EmailVerificationVO selectLatestByEmail(String email, char memberType) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		params.put("memberType", String.valueOf(memberType));
		return sqlSession.selectOne(NAMESPACE+"selectLatestByEmail", params);
	}

	@Override
	public void updateVerifiedStatus(Long verificationId, char verified) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("verificationId", verificationId);
		params.put("verified", String.valueOf(verified));
		sqlSession.update(NAMESPACE+"updateVerifiedStatus", params);

	}

}
