package com.itwillbs.persistence;

import com.itwillbs.domain.CorpMemberVO;

public interface CorpMemberDAO {
	public void insertCorpMember(CorpMemberVO vo) throws Exception;
	
	public CorpMemberVO loginCorpMember(String corpUserId, String corpUserPw) throws Exception;
	
	public CorpMemberVO getCorpMemberByUserid(String corpUserId) throws Exception;
}
