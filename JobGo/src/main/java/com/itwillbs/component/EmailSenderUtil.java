package com.itwillbs.component;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
public class EmailSenderUtil {
	@Autowired
	private JavaMailSender mailSender;
	
	//@Value("${spring.mail.username}")
	private String fromAddress;
	
	private static final Logger logger = LoggerFactory.getLogger(EmailSenderUtil.class);
	/*
	 * to : 수신자 이메일 주소
	 * subject : 이메일 제목
	 * text : 이메일 본문
	 * */
	@Async
	public void sendEmail(String to, String subject, String text) throws Exception{
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setFrom(fromAddress);
			message.setTo(to);
			message.setSubject(subject);
			message.setText(text);
			mailSender.send(message);
			logger.debug(" 메일 전송 시작 : " + to);
			Thread.sleep(3000);
			logger.debug(" 메일 전송 완료 : " + to);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
