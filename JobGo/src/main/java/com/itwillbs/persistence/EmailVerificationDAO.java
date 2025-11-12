package com.itwillbs.persistence;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.EmailVerificationVO;

public interface EmailVerificationDAO {
	// 이메일 인증 레코드 저장
	void insertVerification(EmailVerificationVO vo) throws Exception;
	
	// 가장 최신 인증 레코드 조회
	EmailVerificationVO selectLatestByEmail(String email, char memberType) throws Exception;
	
	// 인증 완료 상태 변경
	void updateVerifiedStatus(Long verificationId, char verified) throws Exception;

	// 인증완료 체크용 쿼리
	public int countVerifiedByEmail(@Param("email") String email,
									@Param("verified") char verified) throws Exception;
}
