package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ReplyVO;

public interface ReplyDAO {
	
	// 댓글 목록 조회
	public List<ReplyVO> selectReplyList(int ref_bno);

}
