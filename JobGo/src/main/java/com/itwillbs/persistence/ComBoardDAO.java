package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ComBoardVO;
import com.itwillbs.domain.Criteria;

public interface ComBoardDAO {
	
	// 게시글 보기
	public ComBoardVO selectComBoardRead(int com_bno) throws Exception;
	
	// 게시판의 모든 글정보를 가져오기(페이징)
	public List<ComBoardVO> selectComBoardListPage(Criteria cri) throws Exception;

	// 게시판 총 글의 개수 조회
	public int selectTotalCount(String search) throws Exception;
	
	// 게시글 등록
	public void insertComBoard(ComBoardVO vo) throws Exception;
	
	// 게시글 삭제
	public void deleteComBoard(int com_bno) throws Exception;
	
	// 게시글 수정
	public void updateComBoard(ComBoardVO vo) throws Exception;
	
	// 게시판 특정 글 조회수 1증가
	public void updateViewCnt(int com_bno) throws Exception;
	
}
