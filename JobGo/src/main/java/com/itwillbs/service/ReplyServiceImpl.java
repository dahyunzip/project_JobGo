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
		
		
		
		logger.debug(" getReplyList() 끝! ");
		return null;
	}

}
