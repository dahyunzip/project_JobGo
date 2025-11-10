package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.persistence.RecBoardDAO;

@Service
public class RecBoardServiceImpl implements RecBoardService {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(RecBoardServiceImpl.class);
	
	@Inject private RecBoardDAO rbDAO;

	// 게시판 리스트
	@Override
	public List<RecBoardVO> getRecBoardList(Criteria cri) throws Exception {
		logger.debug(" getRecBoardListPage() 실행! ");
		
		List<RecBoardVO> resultRecList 
			= rbDAO.selectRecBoardList(cri);
		
		logger.debug(" getRecBoardListPage() 끝! ");
		return resultRecList;
	}

	// 게시판 모든 글 개수 가져오기
	@Override
	public int getRecTotalCount() throws Exception {
		logger.debug(" getRecTotalCount() 실행! ");
		
		int resultRecCnt 
			= rbDAO.selectRecTotalCount();
		
		logger.debug(" getRecTotalCount() 끝! ");
		return resultRecCnt;
	}
	
	


}
