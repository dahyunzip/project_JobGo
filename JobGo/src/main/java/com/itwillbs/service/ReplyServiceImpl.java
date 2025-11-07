package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ReplyVO;
import com.itwillbs.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	
	private static final Logger logger 
		= LoggerFactory.getLogger(ReplyServiceImpl.class);
	
	@Inject private ReplyDAO replyDAO;

	@Override
	public List<ReplyVO> getReplyList(int ref_bno) {
		logger.debug(" getReplyList() 실행! ");
		
		List<ReplyVO> resultReplyVO = replyDAO.selectReplyList(ref_bno);
		
		logger.debug(" getReplyList() 끝! ");
		return resultReplyVO;
	}

	@Override
	public int writeReply(ReplyVO vo) {
		logger.debug(" writeReply() 실행! ");
		
		int resultInsertRe = replyDAO.insertReply(vo);
		
		logger.debug(" writeReply() 끝! ");
		return resultInsertRe;
	}

	@Override
	public int modifyReply(ReplyVO vo) {
		logger.debug(" modifyReply() 실행! ");
		
		int resultUpdateRe = replyDAO.updateReply(vo);
		
		logger.debug(" modifyReply() 끝! ");
		return resultUpdateRe;
	}

}
