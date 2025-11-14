package com.itwillbs.service;

public interface EmailVerificationService {
	void sendVerificationCode(String email, char memberType) throws Exception;
	boolean verifyCode(String email, String code, char memberType) throws Exception;
	boolean isEmailVerified(String email, char verified) throws Exception;
}
