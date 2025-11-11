package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO{
	
	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE = "com.itwillbs.mapper.ReviewMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewDAOImpl.class);
	
	// 리뷰 작성
	@Override
	public void insertReview(ReviewVO review) throws Exception{
		
		sqlSession.insert(NAMESPACE + ".insertReview", review);
		logger.debug(" 리뷰 등록 완료 ");
	}
	
	// 직무 코드 - 대분류
	@Override
	public List<Map<String, Object>> getTopCategoryList() throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getTopCategoryList");
	}
	
	// 직무 코드 - 소분류
	@Override
	public List<Map<String, Object>> getBottomCategoryList(String topId) throws Exception{
	    return sqlSession.selectList(NAMESPACE + ".getBottomCategoryList", topId);
	}

	// 리뷰 수정
	@Override
	public void updateReview(ReviewVO review) throws Exception{
		sqlSession.update(NAMESPACE+".updateReview", review);
		logger.debug(" 리뷰 수정 완료 ");
	}
	
	// 리뷰 삭제
	@Override
	public void deleteReview(int reviewId) throws Exception{
		sqlSession.delete(NAMESPACE + ".deleteReview", reviewId);
		logger.debug(" 리뷰 삭제 완료 ");
	}
	
	// 리뷰 목록 조회
	@Override
	public List<ReviewVO> reviewList() throws Exception{
		List<ReviewVO> list = sqlSession.selectList(NAMESPACE+".reviewList");
		logger.debug(" 리뷰 목록 조회 완료 ");
		return list;
	}
	
	// 리뷰 상세 조회
	@Override
	public ReviewVO reviewDetail(int reviewId) throws Exception {
		ReviewVO review = sqlSession.selectOne(NAMESPACE+".reviewDetail", reviewId);
		logger.debug(" 리뷰 상세 조회 완료");
		return review;
	}
	
	// 회원별 리뷰 조회
	@Override
	public List<ReviewVO> selectReviewsByMember(int memberId) throws Exception{
		List<ReviewVO> list = sqlSession.selectList(NAMESPACE+".selectReviewsByMember", memberId);
		logger.debug(" 회원별 리뷰 조회 완료 ");
		return list;
	}
	
	// 기업별 리뷰 조회
	@Override
	public List<ReviewVO> selectReviewsByCorp(int corpId) throws Exception{
		List<ReviewVO> list = sqlSession.selectList(NAMESPACE+".selectReviewsByCorp", corpId);
		logger.debug(" 기업별 리뷰 조회 완료 ");
		return list;
	}
	
	// 리뷰 작성자 비밀번호 확인용
	@Override
	public String getMemberPasswordByReviewId(int reviewId) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".getMemberPasswordByReviewId", reviewId);
	}
	
	// 아이디 가져오기
	@Override
	public Integer getMemberIdByUserid(String userid) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".getMemberIdByUserid", userid);
	}
	
	// 기업이름 조회
	@Override
	public String getCompanyNameByCorpId(int corpId) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getCompanyNameByCorpId", corpId);
	}
	
}
