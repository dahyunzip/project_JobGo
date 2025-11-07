package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class EmailVerificationVO {
	private Long verificationId;
	private String email;
	private String verificationCode;
	private LocalDateTime createdAt;
	private LocalDateTime expiresAt;
	private char verified;
}
