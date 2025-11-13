package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.ReviewVO;

public interface AdminService {
	
	// 일반회원 목록 조회
	List<MemberVO> getAllNormalMembers() throws Exception;
	
	// 기업회원 목록 조회
	List<MemberVO> getAllCorpMembers() throws Exception;
	
	// 기업회원 승인
	int approveCorp(int corpId) throws Exception;

	// 기업회원 거절
	int denyCorp(int corpId) throws Exception;
	
	// 회원 삭제
	int deleteMember(int id) throws Exception;
	
	// 리뷰게시판 리뷰 조회
	List<ReviewVO> getAllReviews() throws Exception;
		
	// 리뷰게시판 리뷰 삭제
	int deleteReview(int reviewId) throws Exception;
}
