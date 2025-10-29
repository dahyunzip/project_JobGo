package com.itwillbs.persistence;

import java.util.List;

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
	public void insertReview(ReviewVO review) {
		
		sqlSession.insert(NAMESPACE + ".insertReview", review);
		logger.debug(" 리뷰 등록 완료 ");
	}
	
	// 리뷰 수정
	@Override
	public void updateReview(ReviewVO review) {
		sqlSession.update(NAMESPACE+".updateReview", review);
		logger.debug(" 리뷰 수정 완료 ");
	}
	
	// 리뷰 삭제
	@Override
	public void deleteReview(int review_id) {
		sqlSession.delete(NAMESPACE+".deleteReview", review_id);
		logger.debug(" 리뷰 삭제 완료 ");
	}
	
	// 리뷰 목록 조회
	@Override
	public List<ReviewVO> reviewList(){
		List<ReviewVO> list = sqlSession.selectList(NAMESPACE+".reviewList");
		logger.debug(" 리뷰 목록 조회 완료 ");
		return list;
	}
	
	// 리뷰 상세 조회
	@Override
	public ReviewVO reviewDetail(int review_id) {
		ReviewVO review = sqlSession.selectOne(NAMESPACE+".reviewDetail", review_id);
		logger.debug(" 리뷰 상세 조회 완료");
		return review;
	}
	
	// 회원별 리뷰 조회
	@Override
	public List<ReviewVO> selectReviewsByMember(int member_id){
		List<ReviewVO> list = sqlSession.selectList(NAMESPACE+".selectReviewsByMember", member_id);
		logger.debug(" 회원별 리뷰 조회 완료 ");
		return list;
	}
	
	// 기업별 리뷰 조회
	@Override
	public List<ReviewVO> selectReviewsByCorp(int corp_id){
		List<ReviewVO> list = sqlSession.selectList(NAMESPACE+".selectReviewsByCorp", corp_id);
		logger.debug(" 기업별 리뷰 조회 완료 ");
		return list;
	}
	
	
	
}
