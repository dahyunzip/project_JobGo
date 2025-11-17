package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NoticeVO;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.ReviewVO;

public interface AdminService {
	
	// 채용공고 조회
    List<RecBoardVO> getRecBoardList(Criteria cri) throws Exception;
    int getRecTotalCount(String search) throws Exception;

    // 채용공고 삭제
    int deleteRecBoard(int com_bno) throws Exception;
	
	// 일반회원 목록 조회
	List<MemberVO> getAllNormalMembers(Criteria cri) throws Exception;
	int getNormalMemberTotalCount() throws Exception;
	
	// 기업회원 목록 조회
	List<CorpMemberVO> getAllCorpMembers(Criteria cri) throws Exception;
	int getCorpMemberTotalCount() throws Exception;
	
	// Id로 기업회원정보 가져오기 
	public CorpMemberVO getCorpMemberById(int corpId) throws Exception;
	
	// 기업회원 승인
	int approveCorp(int corpId) throws Exception;

	// 기업회원 거절
	int denyCorp(int corpId) throws Exception;
	
	// 기업회원 삭제
	public int deleteCorpMember(int corpId) throws Exception;
	
	// 회원 삭제
	int deleteMember(int id) throws Exception;
	
	// 리뷰게시판 리뷰 조회
	List<ReviewVO> getAllReviews(Criteria cri) throws Exception;
	int getReviewTotalCount() throws Exception;
	
	// 리뷰게시판 리뷰 삭제
	int deleteReview(int reviewId) throws Exception;

	// 전체 공지 목록 조회
	List<NoticeVO> getNoticeListAll(Criteria cri) throws Exception;
	int getTotalCountAll(Criteria cri) throws Exception;

	// 공지 상세 조회
	NoticeVO getNotice(int noticeId) throws Exception;
	
	// 공지 작성
	void insertNotice(Map<String, Object> map) throws Exception;
	
	// 공지 수정
	void updateNotice(NoticeVO vo) throws Exception;

	// 공지 삭제
	void deleteNotice(int noticeId) throws Exception;
	
	// (S) 관리자 메인 대시보드
	public int getTotalMembers() throws Exception;
	public int getGeneralMembers() throws Exception;
	public int getCorpMembers() throws Exception;

	public int getTotalRecruits() throws Exception;
	public int getWeeklyRecruits() throws Exception;

	public int getTotalNoticeCount() throws Exception;
	public String getLatestNoticeTitle() throws Exception;

	public int getTotalReviewCount() throws Exception;
	public int getTodayReviewCount() throws Exception;
	// (E) 관리자 메인 대시보드

}
