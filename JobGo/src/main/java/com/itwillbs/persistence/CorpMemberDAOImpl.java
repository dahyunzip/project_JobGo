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
		Map<String, Object> param = new HashMap<>();
		param.put("corpUserId", corpUserId);
		param.put("corpUserPw", corpUserPw);
		return sqlSession.selectOne(NAMESPACE + "loginCorpMember", param);
	}

	@Override
	public CorpMemberVO getCorpMemberByUserid(String corpUserId) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "getCorpMemberByUserid", corpUserId);
	}

}
