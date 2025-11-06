package com.itwillbs.persistence;

import com.itwillbs.domain.MemberVO;

public interface MemberDAO {
	
	// 회원가입
	public void insertMember(MemberVO vo) throws Exception;
	
	// 아이디 중복 체크
	public int countByUserid(String userid) throws Exception;
	
	// 이메일 인증 완료 여부 확인용
    public int countByEmailVerified(String email) throws Exception;
	
    // 가입 이메일 확인용
    public int countByEmail(String email) throws Exception;
    
	// 로그인
	public MemberVO loginCheck(String userid, String userpw) throws Exception;
	
	// 아이디로 멤버 정보 가져오기
	public MemberVO getMemberByUserid(String userid) throws Exception;
	
	// 회원정보 수정
	public void updateMember(MemberVO vo) throws Exception;

	// 디비에서 파일 삭제
	public void deleteOldPtFiles(int id) throws Exception;
	
	// 회원 프로필 사진 수정
	public int updateMemberPhotoFiles(MemberVO vo) throws Exception;
	
	// 탈퇴 회원 상태 변경
	public void updateIsDeleted(String userid) throws Exception;
	
}
