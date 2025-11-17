package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.ReviewVO;

public interface ReviewDAO {
	
	// 리뷰 작성
	void insertReview(ReviewVO review) throws Exception;
	
	// 직무 코드 - 대분류
	List<Map<String,Object>> getTopCategoryList() throws Exception;
	
	// 직무 코드 - 소분류
	List<Map<String, Object>> getBottomCategoryList(String topId) throws Exception;
	
	Integer getCorpIdByName(String companyName) throws Exception;
	
	// 리뷰 수정
	void updateReview(ReviewVO review) throws Exception;
	
	// 리뷰 삭제
	void deleteReview(int reviewId) throws Exception;
	
	// 리뷰 목록 조회
	List<ReviewVO> getListPaging(Criteria cri) throws Exception;
	int getTotalCount(Criteria cri) throws Exception;
	
	// 리뷰 상세 조회
	ReviewVO reviewDetail(int reviewId) throws Exception;
	
	// 회원별 리뷰 조회
	List<ReviewVO> getListByMemberPaging(Map<String,Object> param) throws Exception;
    int getTotalByMember(Map<String,Object> param) throws Exception;
	
	// 기업별 리뷰 조회
	List<ReviewVO> getListByCorpPaging(Map<String, Object> param) throws Exception;
	int getTotalByCorp(Map<String,Object> param) throws Exception;
	
	// 리뷰 작성자 비밀번호 확인용
	String getMemberPasswordByReviewId(int reviewId) throws Exception;
	
	// 아이디 가져오기
	Integer getMemberIdByUserid(String userid) throws Exception;
	
	// 회사이름 조회
	String getCompanyNameByCorpId(int corpId) throws Exception;
	
	// 조회수 증가
	void updateViewCnt(int reviewId);
	
	public List<ReviewVO> getRecentReviews();
	
	Double getAverageRateByCorp(int corpId) throws Exception;
}
