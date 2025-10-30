package com.itwillbs.persistence;

import com.itwillbs.domain.MemberVO;

public interface MemberDAO {
	
	// 회원가입
	public void insertMember(MemberVO vo) throws Exception;
	
	// 로그인
	public MemberVO loginCheck(String userid, String userpw) throws Exception;
	
	// 아이디로 멤버 정보 가져오기
	public MemberVO getMemberByUserid(String userid) throws Exception;
	
	// 회원정보 수정
	public void updateMember(MemberVO vo) throws Exception;
}
