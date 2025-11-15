package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.ReviewVO;

public interface AdminDAO {
	
	// 채용게시판 공고 조회
	List<RecBoardVO> getRecBoardList(Criteria cri) throws Exception;
	int getRecTotalCount(String search) throws Exception;
	
	// 채용게시판 공고 삭제
	int deleteRecBoard(int rec_bno) throws Exception;
	
	// 일반회원 목록 조회
	List<MemberVO> getAllNormalMembers(Criteria cri) throws Exception;
	int getNormalMemberTotalCount();
	
	// 기업회원 목록 조회
	List<MemberVO> getAllCorpMembers(Criteria cri) throws Exception;
	int getCorpMemberTotalCount();
	
	public CorpMemberVO getCorpMemberById(int corpId) throws Exception;
	
	// 기업회원 승인
	int approveCorp(int corpId) throws Exception;
	
	// 기업회원 거절
	int denyCorp(int corpId) throws Exception;
	
	// 기업회원 삭제
	int deleteCorpMember(int corpId) throws Exception;

	// 회원 삭제
	int deleteMember(int id) throws Exception;
	
	// 리뷰게시판 리뷰 조회
	List<ReviewVO> getAllReviews(Criteria cri) throws Exception;
	int getReviewTotalCount();
	
	// 리뷰게시판 리뷰 삭제
	int deleteReview(int reviewId) throws Exception;
	
	
}
