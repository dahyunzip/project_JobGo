package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ReviewVO;

public interface ReviewDAO {
	
	// 리뷰 작성
	void insertReview(ReviewVO review);
	
	// 리뷰 수정
	void updateReview(ReviewVO review);
	
	// 리뷰 삭제
	void deleteReview(int review_id);
	
	// 리뷰 목록 조회
	List<ReviewVO> reviewList();
	
	// 리뷰 상세 조회
	ReviewVO reviewDetail(int review_id);
	
	// 회원별 리뷰 조회
	List<ReviewVO> selectReviewsByMember(int member_id);
	
	// 기업별 리뷰 조회
	List<ReviewVO> selectReviewsByCorp(int corp_id);
	
}
