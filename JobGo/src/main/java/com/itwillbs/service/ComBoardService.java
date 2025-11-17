package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.ComBoardVO;
import com.itwillbs.domain.Criteria;

public interface ComBoardService {
	
	// 게시글 보기
	public ComBoardVO getComBoard(int com_bno) throws Exception;
	
	// 게시판의 모든 글정보를 가져오기(페이징)
	public List<ComBoardVO> getComBoardListPage(Criteria cri) throws Exception;

	// 게시판 모든 글 개수를 가져오기
	public int getTotalCount(String search) throws Exception;
	
	// 게시글 등록
	public void comReistBoard(ComBoardVO vo) throws Exception;
	
	// 게시글 삭제
	public void deleteComBoard(int com_bno) throws Exception;
	
	// 게시글 수정
	public void updateComBoard(ComBoardVO vo) throws Exception;
	
	// 게시판 특정 글 조회수 1증가
	public void increseViewCnt(int com_bno) throws Exception;
	
	public List<ComBoardVO> getRecentCommunityPosts();
}
