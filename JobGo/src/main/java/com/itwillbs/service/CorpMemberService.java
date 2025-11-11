package com.itwillbs.service;

import com.itwillbs.domain.CorpMemberVO;

public interface CorpMemberService {
	// 회원가입
	public void registerCorpMember(CorpMemberVO vo) throws Exception;
	
	//아이디 중복 체크
	public boolean isUseridAvailable(String corpUserId) throws Exception;
	
	// 이메일 인증여부
	public boolean isEmailVerified(String email) throws Exception;
	
	// 이메일 가입여부 확인
	boolean isEmailRegistered(String email) throws Exception;
	
	// 로그인
	public CorpMemberVO login(String corpUserId, String corpUserPw) throws Exception;
	
	// 아이디로 회원정보 가져오기
	public CorpMemberVO getCorpMember(String corpUserId) throws Exception;
	
	// 회원 정보 업데이트
	public void modifyCorp(CorpMemberVO vo) throws Exception;
	
	// 회원 프로필 사진 업데이트
	public void updateCorpProfileImage(CorpMemberVO vo) throws Exception; 

	// 회원탈퇴
	public void deleteCorpMember(String corpUserId) throws Exception;
}
