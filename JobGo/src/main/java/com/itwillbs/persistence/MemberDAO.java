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
	
	// 회원 프로필 사진 수정
	// 특정 회원의 파일 업로드 여부 조회
	public MemberVO getMemberByFiles(int id);

	// 디비에서 파일 삭제
	public void deleteOldPtFiles(int id);
	// 사진 파일 정보 업로드
	public int insertPhotoFiles(MemberVO vo);
	// 최신 사진파일 조회
	public int selectMaxPhotoFiles();
	// 회원 정보 업데이트
	public int updateMemberPhotoFiles(MemberVO vo);
	
}
