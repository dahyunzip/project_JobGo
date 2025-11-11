package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ReplyVO;

public interface ReplyDAO {
	
	// 댓글 작성
	public int insertReply(ReplyVO vo);
	
	// 댓글 목록 조회
	public List<ReplyVO> selectReplyList(int ref_bno);
	
	// 댓글 수정 저장
	public int updateReply(ReplyVO vo);
	
	// 댓글 삭제
	public int deleteReply(int reply_no);

}
