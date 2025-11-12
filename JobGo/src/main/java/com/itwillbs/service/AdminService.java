package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.MemberVO;

public interface AdminService {
	
	// 일반회원 목록 조회
	List<MemberVO> getAllNormalMembers() throws Exception;
	
	// 기업회원 목록 조회
	List<MemberVO> getAllCorpMembers() throws Exception;
	
	// 회원 삭제
	int deleteMember(int id) throws Exception;
}
