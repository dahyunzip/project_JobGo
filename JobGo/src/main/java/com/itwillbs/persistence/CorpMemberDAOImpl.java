package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CorpMemberVO;

@Repository
public class CorpMemberDAOImpl implements CorpMemberDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE ="com.itwillbs.mapper.CorpMemberMapper.";
	
	private static final Logger logger = LoggerFactory.getLogger(CorpMemberDAOImpl.class);
	
	@Override
	public void insertCorpMember(CorpMemberVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"insertCorpMember", vo);
	}
	
	@Override
	public int countByUserid(String corpUserId) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"countByUserid", corpUserId);
	}

	@Override
	public int countByEmail(String email) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"countByEmail", email);
	}

	@Override
	public CorpMemberVO loginCorpMember(String corpUserId, String corpUserPw) throws Exception {
		logger.debug("loginCorpMember(String corpUserId, String corpUserPw) 시작");
		Map<String, Object> param = new HashMap<>();
		param.put("corpUserId", corpUserId);
		param.put("corpUserPw", corpUserPw);
		logger.debug(" param {} ", param );
		logger.debug("loginCorpMember(String corpUserId, String corpUserPw) 종료");
		return sqlSession.selectOne(NAMESPACE + "loginCorpMember", param);
	}

	@Override
	public CorpMemberVO getCorpMemberByUserid(String corpUserId) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "getCorpMemberByUserid", corpUserId);
	}

	@Override
	public void updateCorp(CorpMemberVO vo) throws Exception {
		sqlSession.update(NAMESPACE + "updateCorpMember", vo);
		
	}

	@Override
	public void deleteCorpProfileImage(int corpId) throws Exception {
	    sqlSession.update(NAMESPACE + "deleteCorpProfileImage", corpId);
	}

	@Override
	public void updateCorpProfileImage(CorpMemberVO vo) throws Exception {
	    sqlSession.update(NAMESPACE + "updateCorpProfileImage", vo);
	}

	@Override
	public void deleteCorpMember(String corpUserId) throws Exception {
	    sqlSession.update(NAMESPACE + "deleteCorpMember", corpUserId);
	    logger.debug("기업회원 탈퇴 완료: corpUserId = {}", corpUserId);
	}
	
	// 이메일로 기업회원 아이디 찾기
	@Override
	public String findCorpUserIdByEmail(String email) throws Exception {
		logger.debug("findCorpUserIdByEmail(email={}) 실행", email);
		return sqlSession.selectOne(NAMESPACE + "findCorpUserIdByEmail", email);
	}

	// 이메일로 기업회원 정보 조회
	@Override
	public CorpMemberVO findCorpMemberByEmail(String email) throws Exception {
		logger.debug("findCorpMemberByEmail(email={}) 실행", email);
		return sqlSession.selectOne(NAMESPACE + "findCorpMemberByEmail", email);
	}

	// 이메일로 비밀번호 업데이트
	@Override
	public void updatePasswordByEmail(CorpMemberVO vo) throws Exception {
		logger.debug("updatePasswordByEmail() 실행, vo = {}", vo);
		sqlSession.update(NAMESPACE + "updatePasswordByEmail", vo);
	}

}
