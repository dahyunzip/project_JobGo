package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.ReviewVO;

@Repository
public class AdminDAOImpl implements AdminDAO{

	private static final String NAMESPACE = "com.itwillbs.mapper.adminMapper";

	@Inject
	private SqlSession sqlSession;

	@Override
	public List<MemberVO> getAllNormalMembers() throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getAllNormalMembers");
	}

	@Override
	public List<MemberVO> getAllCorpMembers() throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getAllCorpMembers");
	}
	
	@Override
	public int approveCorp(int corpId) throws Exception {
	    return sqlSession.update(NAMESPACE + ".approveCorp", corpId);
	}

	@Override
	public int denyCorp(int corpId) throws Exception {
	    return sqlSession.update(NAMESPACE + ".denyCorp", corpId);
	}

	@Override
	public int deleteMember(int id) throws Exception {
		return sqlSession.delete(NAMESPACE + ".deleteMember", id);
	}
	
	@Override
	public List<ReviewVO> getAllReviews() throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getAllReviews");
	}

	@Override
	public int deleteReview(int reviewId) throws Exception {
		return sqlSession.delete(NAMESPACE + ".deleteReview", reviewId);
	}
	
}
