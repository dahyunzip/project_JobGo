package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.RecBoardVO;

public interface RecBoardService {
	
	// 게시판 리스트
	public List<RecBoardVO> getRecBoardList(Criteria cri) throws Exception;

	// 게시판 모든 글 개수 가져오기
	public int getRecTotalCount() throws Exception;
}
