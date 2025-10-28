package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ComBoardVO;
import com.itwillbs.domain.Criteria;

@Repository
public class ComBoardDAOImpl implements ComBoardDAO {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(ComBoardDAOImpl.class);
	
	@Inject private SqlSession sqlSession;
	
	private static final String NAMESPACE 
		= "com.itwillbs.mapper.BoardMapper.";

	@Override
	public List<ComBoardVO> selectComBoardListPage(Criteria cri) throws Exception {
		logger.debug(" getComBoardListPage() 실행! ");
		
		List<ComBoardVO> cboardList 
			= sqlSession.selectList(NAMESPACE + "selectComBoardListPage", cri);
		
		logger.debug(" getComBoardListPage() 끝! ");
		return cboardList;
	}

	@Override
	public int selectTotalCount() throws Exception {
		logger.debug(" selectTotalCount() 실행! ");
		
		int result 
			= sqlSession.selectOne(NAMESPACE + "selectTotalCount");
		
		logger.debug(" selectTotalCount() 끝! ");
		return result;
	}

}
