package com.itwillbs.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.service.CorpMemberService;
import com.itwillbs.service.EmailVerificationService;
import com.itwillbs.service.MemberService;

@RestController
@RequestMapping("/{userType}/email")
public class EmailVerificationController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmailVerificationController.class);

	@Inject
	private MemberService mService;
	
	@Inject
	private CorpMemberService cService;
	
	@Inject
	private EmailVerificationService emailService;
	
	@PostMapping("/sendCode")
	public Map<String, Object> sendCode(@PathVariable("userType") String userType,
			@RequestParam("email") String email) throws Exception{
		Map<String, Object> result = new HashMap<>();
		
		char memberType = userType.equalsIgnoreCase("corp") ? 'C' : 'G';
		
		logger.debug("[sendCode] email = {}, memberType = {}", email, memberType);
		
		// 가입 가능한 이메일인지 확인 (이미 존재하는 이메일이면 실패)
		// 회원 유형별 이메일 존재 여부 확인
		boolean emailExists = (memberType == 'C') ? cService.isEmailRegistered(email) : mService.isEmailRegistered(email) ;
				
		logger.debug("sendCode: emailExists = {}", emailExists);
		
		if(emailExists) {
			result.put("success", false);
			result.put("message", "이미 가입된 이메일 입니다.");
			logger.debug("sendCode() - 가입정보가 있는 이메일. 인증코드 전송 X : {}", email);
			return result;
		}
		
		emailService.sendVerificationCode(email, memberType);
		result.put("success", true);
		result.put("message", "인증코드를 이메일로 전송했습니다.");
		logger.debug("sendCode() - 인증코드 발송 완료 : {}, type : {}", email, memberType);
		return result;
	}
	
	@PostMapping("/verifyCode")
	public Map<String, Object> verifyCode(
										@PathVariable("userType") String userType,
										@RequestParam("email") String email,
										@RequestParam("code") String code) throws Exception{
		Map<String, Object> result = new HashMap<>();
		char memberType = userType.equalsIgnoreCase("corp") ? 'C' : 'G';
		logger.debug(" [verifyCode] email={}, code={}", email, code);
		boolean ok = emailService.verifyCode(email, code, memberType);
		if(ok) {
			result.put("success", true);
			result.put("message", "이메일 인증이 완료되었습니다.");
            logger.debug("verifyCode() — 인증성공: {}", email);
		}else {
			result.put("success", false);
			result.put("message", "인증번호가 올바르지 않거나 만료되었거나 이미 사용되었습니다.");
            logger.debug("verifyCode() — 인증실패: {}", email);
		}
		return result;
		
	}
	
}
