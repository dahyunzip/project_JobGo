package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.ReviewVO;

public interface ReviewDAO {
	
	// 리뷰 작성
	void insertReview(ReviewVO review) throws Exception;
	
	// 직무 코드 - 대분류
	List<Map<String,Object>> getTopCategoryList() throws Exception;
	
	// 직무 코드 - 소분류
	List<Map<String, Object>> getBottomCategoryList(String topId) throws Exception;
	
	// 리뷰 수정
	void updateReview(ReviewVO review) throws Exception;
	
	// 리뷰 삭제
	void deleteReview(int reviewId) throws Exception;
	
	// 리뷰 목록 조회
	List<ReviewVO> reviewList() throws Exception;
	
	// 리뷰 상세 조회
	ReviewVO reviewDetail(int reviewId) throws Exception;
	
	// 회원별 리뷰 조회
	List<ReviewVO> selectReviewsByMember(int memberId) throws Exception;
	
	// 기업별 리뷰 조회
	List<ReviewVO> selectReviewsByCorp(int corpId) throws Exception;
	
	// 리뷰 작성자 비밀번호 확인용
	String getMemberPasswordByReviewId(int reviewId) throws Exception;
	
	// 아이디 가져오기
	Integer getMemberIdByUserid(String userid) throws Exception;
	
	
	
}
