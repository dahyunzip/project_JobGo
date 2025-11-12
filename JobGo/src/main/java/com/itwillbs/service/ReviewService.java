package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.ReviewVO;

public interface ReviewService {
	
	// 리뷰 작성
	void insertReview(ReviewVO review) throws Exception;
	
	// 직무 코드 - 대분류
	List<Map<String, Object>> getTopCategoryList() throws Exception;
	
	// 직무 코드 - 소분류
	List<Map<String, Object>> getBottomCategoryList(String topId) throws Exception;
	
	// 리뷰 수정
	void updateReview(ReviewVO review) throws Exception;
	
	// 리뷰 제거
	void deleteReview(int review) throws Exception;
	
	// 리뷰 전체 페이징 목록
	List<ReviewVO> getListPaging(Criteria cri) throws Exception;
	int getTotalCount(Criteria cri) throws Exception;
	
	// 리뷰 상세 조회
	ReviewVO reviewDetail(int reviewId) throws Exception;
	
	// 회원별 페이징 목록
	List<ReviewVO> getListByMemberPaging(int memberId, Criteria cri) throws Exception;
	int getTotalByMember(int memberId) throws Exception;

	// 기업별 페이징 목록
	List<ReviewVO> getListByCorpPaging(int corpId, Criteria cri) throws Exception;
	int getTotalByCorp(int corpId) throws Exception;
	
	// 리뷰 작성자 비밀번호 확인용
	String getMemberPasswordByReviewId(int reviewId) throws Exception;
	
	// 아이디 가져오기
	Integer getMemberIdByUserid(String userid) throws Exception;
	
	// 회사 이름 조회
	String getCompanyNameByCorpId(int corpId) throws Exception;
	
}
