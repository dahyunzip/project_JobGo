package com.itwillbs.persistence;

import com.itwillbs.domain.CorpMemberVO;

public interface CorpMemberDAO {
	// 기업회원 회원가입
	public void insertCorpMember(CorpMemberVO vo) throws Exception;
	
	// 아이디 중복 체크
	public int countByUserid(String corpUserId) throws Exception;
	
	 // 가입 이메일 확인용
    public int countByEmail(String email) throws Exception;
	
	// 기업회원 로그인
	public CorpMemberVO loginCorpMember(String corpUserId, String corpUserPw) throws Exception;
	
	// 아이디로 회원 정보 가져오기
	public CorpMemberVO getCorpMemberByUserid(String corpUserId) throws Exception;
}
