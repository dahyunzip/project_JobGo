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
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.component.FileComponent;
import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.persistence.CorpMemberDAO;
import com.itwillbs.persistence.EmailVerificationDAOImpl;

@Service
public class CorpMemberServiceImpl implements CorpMemberService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(CorpMemberServiceImpl.class);
	
	@Inject
	private CorpMemberDAO cdao;
	
	@Inject
	private FileComponent fileComponent;
	
	@Inject
	private JavaMailSender mailSender;
	
	private Map<String, String> tokenStore = new HashMap<>();
	
	@Inject
	private EmailVerificationDAOImpl vdao;
	
	//회원가입
	@Override
	public void registerCorpMember(CorpMemberVO vo) throws Exception {
		// PDF 업로드 처리
		MultipartFile uploadFile = vo.getUpload();
		if(uploadFile != null && !uploadFile.isEmpty()) {
			String[] fileInfo = fileComponent.uploadBusinessLicense(uploadFile);
			vo.setBusinessLicenseUrl(fileInfo[0]); // 저장 파일명
			vo.setOriginalFileName(fileInfo[1]); // 원본 파일명
			logger.debug("파일 업로드 결과: stored = {}, original = {}", fileInfo[0], fileInfo[1]);
		}
		
		// 상태 기본값 = D(비활성화)
		vo.setStatus("D");
		
		cdao.insertCorpMember(vo);
	}

	// 아이디 중복 체크
	@Override
	public boolean isUseridAvailable(String corpUserId) throws Exception {
		int count = cdao.countByUserid(corpUserId);
		logger.debug(" corpUserId = {}, count = {}", corpUserId, count);
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
		int count = cdao.countByEmail(email);
		logger.debug("isEmailRegistered: email = [{}], count = {}", email, count);
		return (count > 0);
	}

	// 로그인
	@Override
	public CorpMemberVO login(String corpUserId, String corpUserPw) throws Exception {
		logger.debug(" login(String corpUserId, String corpUserPw 시작!)");
		return cdao.loginCorpMember(corpUserId, corpUserPw);
	}

	// 아이디로 회원정보 가져오기
	@Override
	public CorpMemberVO getCorpMember(String corpUserId) throws Exception {
		return cdao.getCorpMemberByUserid(corpUserId);
	}

	@Override
	public void modifyCorp(CorpMemberVO vo) throws Exception {
		cdao.updateCorp(vo);
	}

	@Override
	public void updateCorpProfileImage(CorpMemberVO vo) throws Exception {
		MultipartFile logoFile = vo.getCorpProfileUpload();
		if (logoFile != null && !logoFile.isEmpty()) {
	        // 기존 파일 삭제
	        cdao.deleteCorpProfileImage(vo.getCorpId());

	        // 새 파일 업로드
	        String storedFileName = fileComponent.upload(logoFile);
	        vo.setCorpProfileOriginal(logoFile.getOriginalFilename());
	        vo.setCorpProfileStored(storedFileName);

	        cdao.updateCorpProfileImage(vo);
	        logger.debug("기업 프로필 이미지 업로드 완료: {}", storedFileName);
	    }
	}

	@Override
	public void deleteCorpMember(String corpUserId) throws Exception {
	    cdao.deleteCorpMember(corpUserId);
	    logger.debug("탈퇴 완료 (status='D', corp_checkdeleted=1): {}", corpUserId);
	}

	// 이메일로 기업회원 아이디 찾기
	@Override
	public String findCorpUserIdByEmail(String email) throws Exception {
		return cdao.findCorpUserIdByEmail(email);
	}

	// 이메일로 기업회원 정보 조회
	@Override
	public CorpMemberVO findCorpMemberByEmail(String email) throws Exception {
		return cdao.findCorpMemberByEmail(email);
	}

	// 비밀번호 재설정 - 임시비밀번호 생성 후 메일 발송
	@Override
	public void updatePasswordByEmail(String email, String newPw) throws Exception {
		CorpMemberVO vo = new CorpMemberVO();
        vo.setManagerEmail(email);
        vo.setCorpUserPw(newPw);
        cdao.updatePasswordByEmail(vo);
	}
	
	@Async
	@Override
	public void sendResetMail(String toEmail, String token) throws Exception {
		try {
            String resetLink = "http://localhost:8088/corp/resetPw?token=" + token;

            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setTo(toEmail);
            helper.setSubject("[JobGo 기업회원] 비밀번호 재설정 안내");

            String htmlContent = ""
                + "<div style='font-family: Pretendard, sans-serif; max-width: 500px; margin: 0 auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px;'>"
                + "<h2 style='color:#0064FF; text-align:center;'>JobGo 기업회원 비밀번호 재설정 안내</h2>"
                + "<p style='font-size:15px; color:#333;'>안녕하세요, JobGo 기업회원님 👋</p>"
                + "<p style='font-size:15px; color:#333;'>아래 버튼을 클릭하시면 비밀번호 재설정 페이지로 이동합니다.<br>"
                + "보안을 위해 이 링크는 <strong>15분 동안만 유효</strong>합니다.</p>"
                + "<div style='text-align:center; margin:30px 0;'>"
                + "<a href='" + resetLink + "' style='background:#0064FF; color:white; padding:12px 20px; text-decoration:none; border-radius:5px; font-weight:bold;'>비밀번호 재설정하기</a>"
                + "</div>"
                + "<p style='font-size:13px; color:#777;'>버튼이 작동하지 않으면 아래 링크를 복사해 브라우저에 붙여넣으세요.</p>"
                + "<p style='word-break:break-all; font-size:13px; color:#0064FF;'>" + resetLink + "</p>"
                + "<hr style='margin-top:30px;'>"
                + "<p style='font-size:12px; color:#999; text-align:center;'>본 메일은 발신전용입니다. 문의사항은 JobGo 고객센터를 이용해주세요.</p>"
                + "</div>";

            helper.setText(htmlContent, true);
            mailSender.send(mimeMessage);
            tokenStore.put(token, toEmail);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	// 토큰 유효성 관리
	@Override
    public String getEmailByToken(String token) {
        return tokenStore.get(token);
    }

	@Override
    public void invalidateToken(String token) {
        tokenStore.remove(token);
    }

}
