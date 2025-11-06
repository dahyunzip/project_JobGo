package com.itwillbs.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.service.EmailVerificationService;
import com.itwillbs.service.MemberService;

@RestController
@RequestMapping(value="/member/email")
public class EmailVerificationController {

	@Inject
	private MemberService mService;
	
	@Inject
	private EmailVerificationService emailService;
	
	@RequestMapping(value="/sendCode", method=RequestMethod.POST)
	public Map<String, Object> sendCode(@RequestParam("email") String email) throws Exception{
		Map<String, Object> result = new HashMap<>();
		
		// 가입 가능한 이메일인지 확인 (이미 존재하는 이메일이면 실패)
		boolean emailExists = mService.isEmailRegistered(email);
		if(emailExists) {
			result.put("success", false);
			result.put("message", "이미 가입된 이메일 입니다.");
			return result;
		}
		
		emailService.sendVerificationCode(email);
		result.put("success", true);
		result.put("message", "인증코드를 이메일로 전송했습니다.");
		return result;
	}
	
	@RequestMapping(value="/verifyCode", method = RequestMethod.POST)
	public Map<String, Object> verifyCode(@RequestParam("email") String email,
										  @RequestParam("code") String code) throws Exception{
		Map<String, Object> result = new HashMap<>();
		boolean ok = emailService.verifyCode(email, code);
		if(ok) {
			result.put("success", true);
			result.put("message", "이메일 인증이 완료되었습니다.");
		}else {
			result.put("success", false);
			result.put("message", "인증번호가 올바르지 않거나 만료되었거나 이미 사용되었습니다.");
		}
		return result;
		
	}
	
}
