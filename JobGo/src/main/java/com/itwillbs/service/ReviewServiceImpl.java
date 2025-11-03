package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ReviewVO;
import com.itwillbs.persistence.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Inject
	private ReviewDAO reviewDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewServiceImpl.class);

	@Override
	public void insertReview(ReviewVO review) {
		reviewDAO.insertReview(review);
		logger.debug(" 리뷰 작성 완료 - 서비스");
		
	}
	
	@Override
	public List<Map<String, Object>> getTopCategoryList(){
		logger.debug(" 직무 코드 대분류 - 서비스 ");
		return reviewDAO.getTopCategoryList();
	}
	
	@Override
	public List<Map<String, Object>> getBottomCategoryList(int topId) {
		logger.debug(" 직무 코드 소분류 - 서비스 ");
	    return reviewDAO.getBottomCategoryList(topId);
	}
	
	@Override
	public void updateReview(ReviewVO review) {
		reviewDAO.updateReview(review);
		logger.debug(" 리뷰 수정 완료 - 서비스");
		
	}

	@Override
	public void deleteReview(int reviewId) {
		reviewDAO.deleteReview(reviewId);
		logger.debug(" 리뷰 삭제 완료 - 서비스");
		
	}

	@Override
	public List<ReviewVO> reviewList() {
		List<ReviewVO> list = reviewDAO.reviewList();
		logger.debug(" 리뷰 목록 조회 완료 - 서비스");
		
		return list;
	}

	@Override
	public ReviewVO reviewDetail(int reviewId) {
		ReviewVO review = reviewDAO.reviewDetail(reviewId);
		logger.debug(" 리뷰 상세 조회 완료 - 서비스");
		
		return review;
	}

	@Override
	public List<ReviewVO> selectReviewsByMember(int memberId) {
		List<ReviewVO> list = reviewDAO.selectReviewsByMember(memberId);
		logger.debug(" 회원별 리뷰 조회 완료 - 서비스 ");
		
		return list;
	}

	@Override
	public List<ReviewVO> selectReviewsByCorp(int corpId) {
		List<ReviewVO> list = reviewDAO.selectReviewsByCorp(corpId);
		logger.debug(" 기업별 리뷰 조회 완료 - 서비스 ");
		
		return list;
	}
	
	
	
}
