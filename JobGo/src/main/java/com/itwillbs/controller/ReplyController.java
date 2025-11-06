package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	// 댓글 작성
	@PostMapping("/writeReply/{ref_bno}")
	public ResponseEntity<ReplyVO> insertReply(ReplyVO vo) {
		logger.debug(" /reply/writeReply -> insertReply() 실행! ");
		
		
		
		logger.debug(" /reply/writeReply -> insertReply() 끝! ");
		return null;
	}
	
	// 댓글 목록 조회
	@GetMapping("/repList/{ref_bno}")
	public ResponseEntity<List<ReplyVO>> getReplyList(@PathVariable("ref_bno") int ref_bno){
		logger.debug(" /reply/repList -> getReplyList() 실행! ");
		
		List<ReplyVO> resultReplyVO = replyService.getReplyList(ref_bno);
		
		logger.debug(" /reply/repList -> getReplyList() 끝! ");	
		return new ResponseEntity<List<ReplyVO>>(resultReplyVO, HttpStatus.OK);
	}

	
}
