package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.itwillbs.controller.ComBoardController;
import com.itwillbs.domain.ComBoardVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.persistence.ComBoardDAO;

@Service
public class ComBoardServiceImpl implements ComBoardService {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(ComBoardServiceImpl.class);
	
	@Inject private ComBoardDAO cbDAO;

	@Override
	public List<ComBoardVO> getComBoardListPage(Criteria cri) throws Exception {
		logger.debug(" getComBoardListPage() 실행! ");
		
		List<ComBoardVO> cboardList
			= cbDAO.selectComBoardListPage(cri);
		
		logger.debug(" getComBoardListPage() 끝! ");
		return cboardList;
	}
	
	@Override
	public int getTotalCount(String search) throws Exception {
		logger.debug(" getTotalCount() 실행! ");
		
		int result = cbDAO.selectTotalCount(search);
		
		logger.debug(" getTotalCount() 끝! ");
		return result;
	}

	@Override
	public void comReistBoard(ComBoardVO vo) throws Exception {
		logger.debug(" comReistBoard() 실행! ");
		
		cbDAO.insertComBoard(vo);
		
		logger.debug(" comReistBoard() 끝! ");
	}

	@Override
	public ComBoardVO getComBoard(int com_bno) throws Exception {
		logger.debug(" getComBoard() 실행! ");
		
		ComBoardVO resultRead = cbDAO.selectComBoardRead(com_bno);
		
		logger.debug(" getComBoard() 끝! ");
		return resultRead;
	}

	@Override
	public void deleteComBoard(int com_bno) throws Exception {
		logger.debug(" deleteComBoard() 실행! ");
		
		cbDAO.deleteComBoard(com_bno);
		
		logger.debug(" deleteComBoard() 끝! ");
	}

	@Override
	public void updateComBoard(ComBoardVO vo) throws Exception {
		logger.debug(" updateComBoard() 실행! ");
		
		cbDAO.updateComBoard(vo);
		
		logger.debug(" updateComBoard() 끝! ");
	}
	
	
	

}
