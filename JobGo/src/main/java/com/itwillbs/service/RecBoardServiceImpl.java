package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.RecBottomCategoryVO;
import com.itwillbs.domain.RecTopCategoryVO;
import com.itwillbs.domain.RecTopLocationVO;
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
	public int getRecTotalCount(String search) throws Exception {
		logger.debug(" getRecTotalCount() 실행! ");
		
		int resultRecCnt 
			= rbDAO.selectRecTotalCount(search);
		
		logger.debug(" getRecTotalCount() 끝! ");
		return resultRecCnt;
	}

	// 게시글 작성 (대분류 리스트)
	@Override
	public List<RecTopCategoryVO> getRecTopCategoryList() {
		logger.debug(" getRecTopCategoryList() 실행! ");
		
		List<RecTopCategoryVO> resultTCL 
			= rbDAO.selectTopCategoryList();
		
		logger.debug(" getRecTopCategoryList() 끝! ");
		return resultTCL;
	}
	@Override
	public List<RecTopLocationVO> getRecTopLocationList() {
		logger.debug(" getRecTopLocationList() 실행! ");
		
		List<RecTopLocationVO> resultTLL
			= rbDAO.selectTopLocationList();
		
		logger.debug(" getRecTopLocationList() 끝! ");
		return resultTLL;
	}

	// 게시글 작성 (소분류 리스트)
	@Override
	public List<RecBottomCategoryVO> getRecBottomCategoryList(int topctg_id) {
		logger.debug(" getRecBottomCategoryList() 실행!");
		
		List<RecBottomCategoryVO> resultBCL 
			= rbDAO.selectBottomCategoryList(topctg_id);
		
		logger.debug(" getRecBottomCategoryList() 끝!");
		return resultBCL;
	}

	// 작성한 게시글 업로드
	@Override
	public void writeRecBoard(RecBoardVO vo) {
		logger.debug(" writeRecBoard() 실행! ");
		
		rbDAO.insertRecBoard(vo);
		
		logger.debug(" writeRecBoard() 끝! ");
	}
	@Override
	public void uploadFiles(int rec_bno, String file_type, String originalFileName, String storedFileName) {
		logger.debug(" uploadFiles() 실행! ");
		
		rbDAO.insertFiles(rec_bno, file_type, originalFileName, storedFileName);
		
		logger.debug(" uploadFiles() 끝! ");		
	}
	
	


}
