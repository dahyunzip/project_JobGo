package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.RecBottomCategoryVO;
import com.itwillbs.domain.RecTopCategoryVO;
import com.itwillbs.domain.RecTopLocationVO;

public interface RecBoardDAO {
	
	// 게시판 리스트
	public List<RecBoardVO> selectRecBoardList(Criteria cri, Integer toplct_id, Integer topctg_id, Integer btmctg_id, String search) throws Exception;

	// 메인 페이지 게시판 리스트(최신 등록 순)
	public List<RecBoardVO> selectRecMainList() throws Exception;
	
	// 메인 페이지 게시판 리스트(조회수 순)
	public List<RecBoardVO> selectRecMainVIEW() throws Exception;
	
	// 게시판 모든 글 개수 가져오기
	public int selectRecTotalCount(Integer toplct_id, Integer topctg_id, Integer btmctg_id, String search) throws Exception;
	
	// 게시글 작성 (대분류 리스트)
	public List<RecTopCategoryVO> selectTopCategoryList();
	public List<RecTopLocationVO> selectTopLocationList();
	
	// 게시글 작성 (소분류 리스트)
	public List<RecBottomCategoryVO> selectBottomCategoryList(int topctg_id);
	
	// 작성한 게시글 업로드
	public void insertRecBoard(RecBoardVO vo) throws Exception;
	
	// 게시글 보기
	public RecBoardVO selectRecBoardRead(int rec_bno)throws Exception; 
	
	// 게시글 수정 
	public int updateRecBoard(RecBoardVO vo) throws Exception;
	
	// 게시글 삭제
	public int deleteRecBoard(int rec_bno) throws Exception;
	
	// 게시판 특정 글 조회수를 1증가
	public void recUpdateViewCnt(int rec_bno) throws Exception;
}
