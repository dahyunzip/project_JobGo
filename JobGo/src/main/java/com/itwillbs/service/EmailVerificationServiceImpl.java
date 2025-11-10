package com.itwillbs.service;

import java.time.LocalDateTime;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.itwillbs.component.EmailSenderUtil;
import com.itwillbs.domain.EmailVerificationVO;
import com.itwillbs.persistence.EmailVerificationDAO;
import com.itwillbs.persistence.MemberDAO;

@Service
public class EmailVerificationServiceImpl implements EmailVerificationService {
	
	//@Inject
	//private MemberDAO mdao;
	
	@Inject
	private EmailVerificationDAO verificationDAO;
	
	@Inject
	private EmailSenderUtil emailSender;
	
	@Value("${email.verification.expire.minutes:5}")
	private long expireMinutes;
	
	
	private static final Logger logger = LoggerFactory.getLogger(EmailVerificationServiceImpl.class);
	
	@Override
	public void sendVerificationCode(String email, char memberType) throws Exception {
		logger.debug(" sendVerificationCode(String email) 시작!");
		// 이메일이 이미 존재하면 가입불가 -> 인증코드는 메서드 호출전에 체크
		String code = String.format("%06d", (int)(Math.random() * 1000000));
		EmailVerificationVO vo = new EmailVerificationVO();
		vo.setEmail(email);
		vo.setMemberType(memberType);
		vo.setVerificationCode(code);
		vo.setCreatedAt(LocalDateTime.now());
		vo.setExpiresAt(LocalDateTime.now().plusMinutes(expireMinutes));
		vo.setVerified('N');
		verificationDAO.insertVerification(vo);
		
		String subject = "[잡고] 이메일 인증 코드입니다.";
		String text = "인증번호는 [" + code +"] 입니다. " + expireMinutes + "분 내에 입력해주세요.";
		emailSender.sendEmail(email, subject, text);
		logger.debug("전송된 번호 : {}, type : " , code, memberType);
		logger.debug(" sendVerificationCode(String email, char memberType) 종료!");
	}

	@Override
	public boolean verifyCode(String email, String code, char memberType) throws Exception {
		logger.debug(" verifyCode(String email, String code, char memberType) 시작! ");
		EmailVerificationVO vo = verificationDAO.selectLatestByEmail(email, memberType);
		logger.debug("vo : " + vo);
		if (vo == null) {
			logger.debug("vo == null");
	        return false;
	    }
	    // 이미 인증 완료된 경우
	    if (vo.getVerified() == 'Y') {
	    	logger.debug("이미 인증 완료된 이메일");
	        return false;
	    }
	    String savedCode = vo.getVerificationCode();
	    if (savedCode == null) {
	    	logger.debug("랜덤 난수 코드 없음");
	        return false;
	    }
	    if (!savedCode.equals(code)) {
	    	logger.debug("랜덤 난수 코드와 인증 코드 같지 않음");
	        return false;
	    }
	    if (vo.getExpiresAt() == null || vo.getExpiresAt().isBefore(LocalDateTime.now())) {
	    	logger.debug("vo.getExpiresAt() == null || vo.getExpiresAt().isBefore(LocalDateTime.now()");
	        return false;
	    }
	    verificationDAO.updateVerifiedStatus(vo.getVerificationId(), 'Y');
	    logger.debug(" verifyCode(String email, String code) 종료! ");
	    return true;
	}
	
	
	@Override
	public boolean isEmailVerified(String email, char verified) throws Exception {
		logger.debug("isEmailVerified(String email) 시작! ");
		int count = verificationDAO.countVerifiedByEmail(email, verified);
		logger.debug("isEmailVerified(): email = [{}], memberType = [G], verified = [Y], count = {}", email, count);
		return (count > 0);
	}
	

}
