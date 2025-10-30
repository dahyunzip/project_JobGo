package com.itwillbs.persistence;


import java.util.HashMap;
import java.util.Map;

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
	}
	
	@Override
	public MemberVO loginCheck(String userid, String userpw) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userid", userid);
		param.put("userpw", userpw);
		return sqlSession.selectOne(NAMESPACE+"loginMember", param);
	}

	@Override
    public MemberVO getMemberByUserid(String userid) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "getMemberByUserid", userid);
    }

	@Override
	public void updateMember(MemberVO vo) throws Exception {
		sqlSession.update(NAMESPACE + "updateMember", vo);
	}
	
}
