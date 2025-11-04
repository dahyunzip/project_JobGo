package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ReplyVO;
import com.itwillbs.service.ReplyService;

@RestController
@RequestMapping("/reply/*")
public class ReplyController {

	private static final Logger logger 
		= LoggerFactory.getLogger(ReplyController.class);
	
	@Inject private ReplyService replyService;
	
	// 댓글 목록 조회
	@GetMapping("/repList")
	public List<ReplyVO> getReplyList(@RequestParam("ref_bno") int ref_bno){
		logger.debug(" /reply/repList -> getReplyList() 실행! ");
		
		List<ReplyVO> resultReplyVO = replyService.getReplyList(ref_bno);
		
		logger.debug(" /reply/repList -> getReplyList() 끝! ");	
		return resultReplyVO;
	}

	
}
