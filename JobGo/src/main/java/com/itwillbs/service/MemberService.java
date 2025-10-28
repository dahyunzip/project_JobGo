package com.itwillbs.service;

import com.itwillbs.domain.MemberVO;

public interface MemberService {
	// 회원가입
	public void memberJoin(MemberVO vo);
	
	// 로그인
	public MemberVO memberLoginCheck(MemberVO loginVO);
}
