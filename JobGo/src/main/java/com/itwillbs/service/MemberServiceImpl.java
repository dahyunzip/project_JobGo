package com.itwillbs.service;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.itwillbs.component.FileComponent;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.EmailVerificationDAOImpl;
import com.itwillbs.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Inject
    private FileComponent fileComponent;
	
	@Inject
	private MemberDAO mdao;
	
	@Inject
	private JavaMailSender mailSender;
	
	private Map<String, String> tokenStore = new HashMap<>();
	
	
	@Inject
	private EmailVerificationDAOImpl vdao;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Override
	public void registerMember(MemberVO vo) throws Exception {
		mdao.insertMember(vo);
	}
	
	@Override
	public boolean isUseridAvailable(String userid) throws Exception {
		int count = mdao.countByUserid(userid);
		logger.debug(" userid = [{}], count = {}", userid, count);
		return (count == 0);
		
	}
	
	@Override
	public boolean isEmailVerified(String email) throws Exception {
		int countVer = vdao.countVerifiedByEmail(email, 'Y');
		logger.debug("isEmailVerified: email = [{}], count = {}", email, countVer);
		return countVer > 0;
	}

	@Override
	public boolean isEmailRegistered(String email) throws Exception {
		int count = mdao.countByEmail(email);
		logger.debug("isEmailRegistered: email = [{}], count = {}", email, count);
		return (count > 0);
	}

	@Override
	public MemberVO login(String userid, String userpw) throws Exception {
		return mdao.loginCheck(userid, userpw);
	}
	
	@Override
    public MemberVO getMember(String userid) throws Exception {
        return mdao.getMemberByUserid(userid);
    }

	@Override
	public void modifyMember(MemberVO vo) throws Exception {
		logger.debug(" modifyMember(MemberVO vo) 시작");
		mdao.updateMember(vo);
		logger.debug(" modifyMember(MemberVO vo) 종료");
	}

	@Override
	public String uploadPhoto(MemberVO vo) throws Exception {
		logger.debug(" uploadPhoto() 실행!");
		
		MemberVO existMember = mdao.getMemberByUserid(vo.getUserid());
		logger.debug(" 전 파일 업로드 정보 : " + existMember);
		
		if(existMember != null && existMember.getStoredFileName() != null) {
			fileComponent.delete(existMember.getStoredFileName());
			mdao.deleteOldPtFiles(existMember.getId());
		}
		
		String originalFileName = vo.getUpload().getOriginalFilename();
		String storedFileName = fileComponent.upload(vo.getUpload());
		
		vo.setId(existMember.getId());
		vo.setOriginalFileName(originalFileName);
		vo.setStoredFileName(storedFileName);
		
		//mdao.insertPhotoFiles(vo);
		
		mdao.updateMemberPhotoFiles(vo);
		
		logger.debug("uploadPhoto() 끝! ");
		
		return storedFileName;
	}

	@Override
	public void dropMember(String userid) throws Exception {
		logger.debug(" dropMember() 실행 ");
		mdao.updateIsDeleted(userid);
	}

	@Override
	public String findUseridByEmail(String email) throws Exception {
		return mdao.findUseridByEmail(email);
	}

	@Override
	public MemberVO findMemberByEmail(String email) throws Exception {
		return mdao.findMemberByEmail(email);
	}

	@Override
	public void updatePasswordByEmail(String email, String newPw) throws Exception {
		MemberVO vo = new MemberVO();
        vo.setEmail(email);
        vo.setUserpw(newPw);
        mdao.updatePasswordByEmail(vo);
		
	}

	@Async
	@Override
	public void sendResetMail(String toEmail, String token) {
		try {
	        String resetLink = "http://localhost:8088/member/resetPw?token=" + token;

	        // MimeMessage를 사용하면 HTML 형식 메일 가능
	        MimeMessage mimeMessage = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

	        helper.setTo(toEmail);
	        helper.setSubject("[JobGo] 비밀번호 재설정 안내");

	        // HTML 본문 작성
	        String htmlContent = ""
	            + "<div style='font-family: Pretendard, sans-serif; max-width: 500px; margin: 0 auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px;'>"
	            + "<h2 style='color:#0064FF; text-align:center;'>JobGo 비밀번호 재설정 안내</h2>"
	            + "<p style='font-size:15px; color:#333;'>안녕하세요, JobGo 회원님 👋</p>"
	            + "<p style='font-size:15px; color:#333;'>아래 버튼을 클릭하시면 비밀번호 재설정 페이지로 이동합니다.<br>"
	            + "보안을 위해 이 링크는 <strong>15분 동안만 유효</strong>합니다.</p>"
	            + "<div style='text-align:center; margin:30px 0;'>"
	            + "<a href='" + resetLink + "' style='background:#0064FF; color:white; padding:12px 20px; text-decoration:none; border-radius:5px; font-weight:bold;'>비밀번호 재설정하기</a>"
	            + "</div>"
	            + "<p style='font-size:13px; color:#777;'>만약 버튼이 작동하지 않는다면 아래 링크를 복사해 브라우저에 붙여넣으세요.</p>"
	            + "<p style='word-break:break-all; font-size:13px; color:#0064FF;'>" + resetLink + "</p>"
	            + "<hr style='margin-top:30px;'>"
	            + "<p style='font-size:12px; color:#999; text-align:center;'>본 메일은 발신전용입니다. 문의사항은 JobGo 고객센터를 이용해주세요.</p>"
	            + "</div>";

	        helper.setText(htmlContent, true); // HTML 사용(true)

	        mailSender.send(mimeMessage);
	        tokenStore.put(token, toEmail);

	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("메일 전송 실패: " + e.getMessage());
	    }
	}
	
	@Override
	public String getEmailByToken(String token) {
        return tokenStore.get(token);
    }

	@Override
    public void invalidateToken(String token) {
        tokenStore.remove(token);
    }
	
}
