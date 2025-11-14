package com.itwillbs.service;

import com.itwillbs.domain.MemberVO;

public interface MemberService {
	// 회원가입
	public void registerMember(MemberVO vo) throws Exception;
	
	//아이디 중복 체크
	public boolean isUseridAvailable(String userid) throws Exception;
	
	// 이메일 인증여부
	public boolean isEmailVerified(String email) throws Exception;
	
	// 이메일 가입여부 확인
	boolean isEmailRegistered(String email) throws Exception;
	
	// 로그인
	public MemberVO login(String userid, String userpw) throws Exception;
	
	// 아이디로 멤버 정보 가져오기
	public MemberVO getMember(String userid) throws Exception;
	
	// 회원 정보 업데이트
	public void modifyMember(MemberVO vo) throws Exception;
	
	// 회원 프로필 사진 업데이트
	public String uploadPhoto(MemberVO vo) throws Exception; 
	
	// 회원 탈퇴 상태 변경
	public void dropMember(String userid) throws Exception;
	
	// 이메일로 아이디 찾기
    public String findUseridByEmail(String email) throws Exception;

    // 이메일로 회원 조회
    public MemberVO findMemberByEmail(String email) throws Exception;

    // 비밀번호 업데이트
    public void updatePasswordByEmail(String email, String newPw) throws Exception;

    // 인증 메일 전송
    public void sendResetMail(String toEmail, String token);
	
    String getEmailByToken(String token);
    void invalidateToken(String token);
	
}

