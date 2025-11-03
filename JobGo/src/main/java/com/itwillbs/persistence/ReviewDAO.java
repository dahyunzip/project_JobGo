package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.ReviewVO;

public interface ReviewDAO {
	
	// 리뷰 작성
	void insertReview(ReviewVO review);
	
	// 직무 코드 - 대분류
	List<Map<String,Object>> getTopCategoryList();
	
	// 직무 코드 - 소분류
	List<Map<String, Object>> getBottomCategoryList(int topId);
	
	// 리뷰 수정
	void updateReview(ReviewVO review);
	
	// 리뷰 삭제
	void deleteReview(int reviewId);
	
	// 리뷰 목록 조회
	List<ReviewVO> reviewList();
	
	// 리뷰 상세 조회
	ReviewVO reviewDetail(int reviewId);
	
	// 회원별 리뷰 조회
	List<ReviewVO> selectReviewsByMember(int memberId);
	
	// 기업별 리뷰 조회
	List<ReviewVO> selectReviewsByCorp(int corpId);
	
}
