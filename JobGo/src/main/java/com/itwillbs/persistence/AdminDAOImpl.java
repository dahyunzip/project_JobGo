package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MemberVO;

@Repository
public class AdminDAOImpl implements AdminDAO{

	private static final String NAMESPACE = "com.itwillbs.mapper.AdminMapper.";

	@Inject
	private SqlSession sqlSession;

	@Override
	public List<MemberVO> getAllNormalMembers() throws Exception {
		return sqlSession.selectList(NAMESPACE + "getAllNormalMembers");
	}

	@Override
	public List<MemberVO> getAllCorpMembers() throws Exception {
		return sqlSession.selectList(NAMESPACE + "getAllCorpMembers");
	}

	@Override
	public int deleteMember(int id) throws Exception {
		return sqlSession.delete(NAMESPACE + "deleteMember", id);
	}
	
}
