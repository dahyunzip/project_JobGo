package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.RecBoardVO;

@Repository
public class RecBoardDAOImpl implements RecBoardDAO {
	
	
	private static final Logger logger 
		= LoggerFactory.getLogger(RecBoardDAOImpl.class);
	
	@Inject private SqlSession sqlSession;
	
	private static final String NAMESPACE 
		= "com.itwillbs.mapper.recBoardMapper.";

	// 게시판 리스트
	@Override
	public List<RecBoardVO> selectRecBoardList(Criteria cri) throws Exception {
		logger.debug(" DAO: selectRecBoardList() 실행! ");
		
		List<RecBoardVO> resultRecList 
			= sqlSession.selectList(NAMESPACE + "selectRecBoardList", cri);
		
		logger.debug(" DAO: selectRecBoardList() 끝! ");
		return resultRecList;
	}

	// 게시판 모든 글 개수 가져오기
	@Override
	public int selectRecTotalCount() throws Exception {
		logger.debug(" selectRecTotalCount() 실행! ");
		
		int resultRecCnt 
			= sqlSession.selectOne(NAMESPACE + "selectRecTotalCount");
		
		logger.debug(" selectRecTotalCount() 끝! ");
		return resultRecCnt;
	}
	

}
