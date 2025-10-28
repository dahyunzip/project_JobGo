package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ComBoardVO;
import com.itwillbs.domain.Criteria;

public interface ComBoardDAO {
	
	// 게시판의 모든 글정보를 가져오기(페이징)
	public List<ComBoardVO> selectComBoardListPage(Criteria cri) throws Exception;

	// 게시판 총 글의 개수 조회
	public int selectTotalCount() throws Exception;
}
