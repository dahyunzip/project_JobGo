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
	
	// 회원정보 수정
	public void updateCorp(CorpMemberVO vo) throws Exception;

	// 디비에서 파일 삭제
	public void deleteCorpProfileImage(int corpId) throws Exception;
	
	// 회원 프로필 사진 수정
	public void updateCorpProfileImage(CorpMemberVO vo) throws Exception;
	
	// 탈퇴 회원 상태 변경
	public void deleteCorpMember(String corpUserId) throws Exception;
	
	// 이메일로 아이디 찾기
	public String findCorpUserIdByEmail(String email) throws Exception;

	// 이메일로 회원정보 조회
	public CorpMemberVO findCorpMemberByEmail(String email) throws Exception;

	// 이메일로 비밀번호 재설정
	public void updatePasswordByEmail(CorpMemberVO vo) throws Exception;
}
