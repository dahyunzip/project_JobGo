package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.ReviewVO;

@Repository
public class AdminDAOImpl implements AdminDAO{

	private static final String NAMESPACE = "com.itwillbs.mapper.adminMapper";

	@Inject
	private SqlSession sqlSession;
	
	 @Override
	    public List<RecBoardVO> getRecBoardList(Criteria cri) throws Exception {
	        return sqlSession.selectList(NAMESPACE + ".getRecBoardList", cri);
	    }

	    @Override
	    public int getRecTotalCount(String search) throws Exception {
	        return sqlSession.selectOne(NAMESPACE + ".getRecTotalCount", search);
	    }

	    @Override
	    public int deleteRecBoard(int rec_bno) throws Exception {
	        return sqlSession.delete(NAMESPACE + ".deleteRecBoard", rec_bno);
	    }
	
	@Override
	public List<MemberVO> getAllNormalMembers(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getAllNormalMembers", cri);
	}
	
	@Override
	public int getNormalMemberTotalCount() {
		return sqlSession.selectOne(NAMESPACE + ".getNormalMemberTotalCount");
	}

	@Override
	public List<MemberVO> getAllCorpMembers(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getAllCorpMembers", cri);
	}
	
	@Override
	public int approveCorp(int corpId) throws Exception {
	    return sqlSession.update(NAMESPACE + ".approveCorp", corpId);
	}
	
	@Override
	public int getCorpMemberTotalCount() {
		return sqlSession.selectOne(NAMESPACE + ".getCorpMemberTotalCount");
	}

	@Override
	public int denyCorp(int corpId) throws Exception {
	    return sqlSession.update(NAMESPACE + ".denyCorp", corpId);
	}
	
	@Override
	public int deleteCorpMember(int corpId) throws Exception {
		return sqlSession.update(NAMESPACE + ".deleteCorpMember", corpId);
	}

	@Override
	public int deleteMember(int id) throws Exception {
		return sqlSession.delete(NAMESPACE + ".deleteMember", id);
	}
	
	@Override
	public List<ReviewVO> getAllReviews(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getAllReviews", cri);
	}
	
	@Override
	public int getReviewTotalCount() {
		return sqlSession.selectOne(NAMESPACE + ".getReviewTotalCount");
	}

	@Override
	public int deleteReview(int reviewId) throws Exception {
		return sqlSession.delete(NAMESPACE + ".deleteReview", reviewId);
	}
	
}
