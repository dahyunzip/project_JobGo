package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.RecBottomCategoryVO;
import com.itwillbs.domain.RecTopCategoryVO;
import com.itwillbs.domain.RecTopLocationVO;

@Repository
public class RecBoardDAOImpl implements RecBoardDAO {
	
	
	private static final Logger logger 
		= LoggerFactory.getLogger(RecBoardDAOImpl.class);
	
	@Inject private SqlSession sqlSession;
	
	private static final String NAMESPACE 
		= "com.itwillbs.mapper.recBoardMapper.";

	// 게시판 리스트
	@Override
	public List<RecBoardVO> selectRecBoardList(Criteria cri, Integer toplct_id, Integer topctg_id, Integer btmctg_id, String search) throws Exception {
		logger.debug(" DAO: selectRecBoardList() 실행! ");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("cri", cri);
		paramMap.put("toplct_id", toplct_id);
		paramMap.put("topctg_id", topctg_id);
		paramMap.put("btmctg_id", btmctg_id);
		paramMap.put("search", search);
		List<RecBoardVO> resultRecList 
			= sqlSession.selectList(NAMESPACE + "selectRecBoardList", paramMap);
		
		logger.debug(" DAO: selectRecBoardList() 끝! ");
		return resultRecList;
	}

	// 게시판 모든 글 개수 가져오기
	@Override
	public int selectRecTotalCount(Integer toplct_id, Integer topctg_id, Integer btmctg_id, String search) throws Exception {
		logger.debug(" selectRecTotalCount() 실행! ");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("toplct_id", toplct_id);
		paramMap.put("topctg_id", topctg_id);
		paramMap.put("btmctg_id", btmctg_id);
		paramMap.put("search", search);
		int resultRecCnt 
			= sqlSession.selectOne(NAMESPACE + "selectRecTotalCount", paramMap);
		
		logger.debug(" selectRecTotalCount() 끝! ");
		return resultRecCnt;
	}

	// 게시글 작성 (대분류 리스트)
	@Override
	public List<RecTopCategoryVO> selectTopCategoryList() {
		logger.debug(" selectTopCategoryList() 실행!");
		
		List<RecTopCategoryVO> resultTCL
			= sqlSession.selectList(NAMESPACE + "selectTopCategoryList");
		
		logger.debug(" selectTopCategoryList() 끝!");
		return resultTCL;
	}
	@Override
	public List<RecTopLocationVO> selectTopLocationList() {
		logger.debug(" selectTopLocationList() 실행! ");
		
		List<RecTopLocationVO> resultTLL 
			= sqlSession.selectList(NAMESPACE + "selectTopLocationList");
		
		logger.debug(" selectTopLocationList() 끝! ");
		return resultTLL;
	}

	// 게시글 작성 (소분류 리스트)
	@Override
	public List<RecBottomCategoryVO> selectBottomCategoryList(int topctg_id) {
		logger.debug(" selectBottomCategoryList() 실행! ");
		
		List<RecBottomCategoryVO> resultBCL 
			= sqlSession.selectList(NAMESPACE + "selectBottomCategoryList", topctg_id);
		
		logger.debug(" selectBottomCategoryList() 끝! ");
		return resultBCL;
	}

	// 작성한 게시글 업로드
	@Override
	public void insertRecBoard(RecBoardVO vo) {
		logger.debug(" insertRecBoard() 실행! ");
		
		sqlSession.insert(NAMESPACE + "insertRecBoard", vo);
		
		logger.debug(" insertRecBoard() 끝! ");
	}

	// 게시글 보기
	@Override
	public RecBoardVO selectRecBoardRead(int rec_bno) throws Exception {
		logger.debug(" selectRecBoardRead() 실행! ");
		
		RecBoardVO resultRBR 
			= sqlSession.selectOne(NAMESPACE + "selectRecBoardRead", rec_bno);
		
		logger.debug(" selectRecBoardRead() 끝! ");
		return resultRBR;
	}

	@Override
	public int updateRecBoard(RecBoardVO vo) throws Exception {
		logger.debug(" updateRecBoard() 실행! ");
		
		int resultUpdateRB = sqlSession.update(NAMESPACE + "updateRecBoard", vo);
		
		logger.debug(" updateRecBoard() 끝! ");
		return resultUpdateRB;
	}

	@Override
	public int deleteRecBoard(int rec_bno) throws Exception {
		logger.debug(" deleteRecBoard() 실행! ");
		
		int resultDeleteRB = sqlSession.delete(NAMESPACE + "deleteRecBoard", rec_bno);
		
		logger.debug(" deleteRecBoard() 끝! ");
		return resultDeleteRB;
	}
	

}
