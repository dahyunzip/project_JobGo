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
	public List<RecBoardVO> selectRecBoardList(Criteria cri) throws Exception;

	// 게시판 모든 글 개수 가져오기
	public int selectRecTotalCount(String search) throws Exception;
	
	// 게시글 작성 (대분류 리스트)
	public List<RecTopCategoryVO> selectTopCategoryList();
	public List<RecTopLocationVO> selectTopLocationList();
	
	// 게시글 작성 (소분류 리스트)
	public List<RecBottomCategoryVO> selectBottomCategoryList(int topctg_id);
	
	// 작성한 게시글 업로드
	public void insertRecBoard(RecBoardVO vo) throws Exception;
	
	// 게시글 보기
	public RecBoardVO selectRecBoardRead(int rec_bno)throws Exception; 
}
