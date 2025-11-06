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
	
	@Inject
	private MemberDAO mdao;
	
	@Inject
	private EmailVerificationDAO verificationDAO;
	
	@Inject
	private EmailSenderUtil emailSender;
	
	@Value("${email.verification.expire.minutes:10}")
	private long expireMinutes;
	
	
	private static final Logger logger = LoggerFactory.getLogger(EmailVerificationServiceImpl.class);
	
	@Override
	public void sendVerificationCode(String email) throws Exception {
		// 이메일이 이미 존재하면 가입불가 -> 인증코드는 메서드 호출전에 체크
		String code = String.format("%06d", (int)(Math.random() * 1000000));
		EmailVerificationVO vo = new EmailVerificationVO();
		vo.setEmail(email);
		vo.setMemberType('G');
		vo.setVerificationCode(code);
		vo.setCreatedAt(LocalDateTime.now());
		vo.setExpiresAt(LocalDateTime.now().plusMinutes(expireMinutes));
		vo.setVerified('N');
		verificationDAO.insertVerification(vo);
		
		String subject = "[잡고] 이메일 인증 코드입니다.";
		String text = "인증번호는 [" + code +"] 입니다. " + expireMinutes + "분 내에 입력해주세요.";
		emailSender.sendEmail(email, subject, text);
		logger.debug("전송된 번호 : " + code);
	}

	@Override
	public boolean verifyCode(String email, String code) throws Exception {
		EmailVerificationVO vo = verificationDAO.selectLatestByEmail(email, 'G');
		if (vo == null) {
	        return false;
	    }
	    // 이미 인증 완료된 경우
	    if (vo.getVerified() == 'Y') {
	        return false;
	    }
	    String savedCode = vo.getVerificationCode();
	    if (savedCode == null) {
	        return false;
	    }
	    if (!savedCode.equals(code)) {
	        return false;
	    }
	    if (vo.getExpiresAt() == null || vo.getExpiresAt().isBefore(LocalDateTime.now())) {
	        return false;
	    }
	    verificationDAO.updateVerifiedStatus(vo.getVerificationId(), 'Y');
	    return true;
	}

	@Override
	public boolean isEmailVerified(String email) throws Exception {
		int count = mdao.countByUserid(email);
		return (count > 0);
	}

}
