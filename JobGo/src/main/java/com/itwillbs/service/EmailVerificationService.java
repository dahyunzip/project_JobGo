package com.itwillbs.service;

public interface EmailVerificationService {
	void sendVerificationCode(String email) throws Exception;
	boolean verifyCode(String email, String code) throws Exception;
	boolean isEmailVerified(String email, char verified) throws Exception;
}
