package com.itwillbs.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.itwillbs.service.EmailVerificationService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"}
		)
public class EmailVerificationTest {

	@Inject
	private EmailVerificationService emailService;
	
	@Test
	public void testSendVerificationCode() throws Exception{
		String email = "bydhyun@naver.com";
		emailService.sendVerificationCode(email);
	}
	
}
