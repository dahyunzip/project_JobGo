package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.ComBoardVO;
import com.itwillbs.domain.Criteria;

public interface ComBoardService {
	
	// 게시판의 모든 글정보를 가져오기(페이징)
	public List<ComBoardVO> getComBoardListPage(Criteria cri) throws Exception;

	// 게시판 모든 글 개수를 가져오기
	public int getTotalCount() throws Exception;
}
