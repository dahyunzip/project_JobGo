package com.itwillbs.service;

import com.itwillbs.domain.CorpMemberVO;

public interface CorpMemberService {
	public void registerCorpMember(CorpMemberVO vo) throws Exception;
	
	public CorpMemberVO login(String corpUserId, String corpUserPw) throws Exception;
	
	public CorpMemberVO getCorpMember(String corpUserId) throws Exception;
}
