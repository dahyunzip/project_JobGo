package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(ReplyDAOImpl.class);
	
	private static final String NAMESPACE 
		= "com.itwillbs.mapper.ReplyMapper.";

	@Inject private SqlSession sqlSession;

	@Override
	public List<ReplyVO> selectReplyList(int ref_bno) {
		logger.debug(" selectReplyList() 실행! ");
		
		List<ReplyVO> resultReplyList 
			= sqlSession.selectList(NAMESPACE + "selectReplyList", ref_bno);
		
		logger.debug(" selectReplyList() 끝! ");
		logger.debug(resultReplyList+"");
		return resultReplyList;
	}

}
