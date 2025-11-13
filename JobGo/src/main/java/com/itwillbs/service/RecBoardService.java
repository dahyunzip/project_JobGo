package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.RecBottomCategoryVO;
import com.itwillbs.domain.RecTopCategoryVO;
import com.itwillbs.domain.RecTopLocationVO;

public interface RecBoardService {
	
	// 게시판 리스트
	public List<RecBoardVO> getRecBoardList(Criteria cri, Integer toplct_id, Integer topctg_id, Integer btmctg_id, String search) throws Exception;

	// 메인 페이지 게시판 리스트(최신 등록 순)
	public List<RecBoardVO> getRecMainList() throws Exception;
	
	// 메인 페이지 게시판 리스트(조회수 순)
	public List<RecBoardVO> getRecMainListVIEW() throws Exception;
	
	// 게시판 모든 글 개수 가져오기
	public int getRecTotalCount(Integer toplct_id, Integer topctg_id, Integer btmctg_id, String search) throws Exception;
	
	// 게시글 작성 (대분류 리스트)
	public List<RecTopCategoryVO> getRecTopCategoryList();
	public List<RecTopLocationVO> getRecTopLocationList();
	
	// 게시글 작성 (소분류 리스트)
	public List<RecBottomCategoryVO> getRecBottomCategoryList(int topctg_id);
	
	// 작성한 게시글 업로드
	public void recUploadBoard(RecBoardVO vo) throws Exception;
	
	// 게시글 보기
	public RecBoardVO getRecBoard(int rec_bno) throws Exception;
	
	// 게시글 수정
	public int updateRecBoard(RecBoardVO vo) throws Exception;
	
	// 게시글 삭제
	public int deleteRecBoard(int rec_bno) throws Exception;
	
	// 게시판 특정 글 조회수를 1증가
	public void recIncreseViewCnt(int rec_bno) throws Exception;
}
