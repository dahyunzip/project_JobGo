package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.ReplyVO;

public interface ReplyService {
	
	// 댓글 목록 조회
	public List<ReplyVO> getReplyList(int ref_bno);

}
