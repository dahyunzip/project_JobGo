package com.itwillbs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.MemberMapper.";
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Override
	public void insertMember(MemberVO vo) {
		sqlSession.insert(NAMESPACE+"insertMember", vo);
		logger.debug(" DAO : SQL 실행 성공");
		logger.debug(" DAO : 회원가입 성공!");
	}

}
