package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.RecBottomCategoryVO;
import com.itwillbs.domain.RecTopCategoryVO;
import com.itwillbs.domain.RecTopLocationVO;
import com.itwillbs.domain.ResumeVO;

public interface RecBoardService {
	
	// 게시판 리스트
	public List<RecBoardVO> getRecBoardList(Criteria cri) throws Exception;

	// 게시판 모든 글 개수 가져오기
	public int getRecTotalCount(String search) throws Exception;
	
	// 게시글 작성 (대분류 리스트)
	public List<RecTopCategoryVO> getRecTopCategoryList();
	public List<RecTopLocationVO> getRecTopLocationList();
	
	// 게시글 작성 (소분류 리스트)
	public List<RecBottomCategoryVO> getRecBottomCategoryList(int topctg_id);
	
	// 작성한 게시글 업로드
	public void recUploadBoard(RecBoardVO vo) throws Exception;
	
	// 게시글 보기
	public RecBoardVO getRecBoard(int rec_bno) throws Exception;
	
	// 이력서 정보 가져오기
	public List<ResumeVO> getResumeList(int member_id) throws Exception;
	
	// 지원했는지 체크
	public boolean checkAlreadyApplied(int member_id, int rec_bno) throws Exception;
}
