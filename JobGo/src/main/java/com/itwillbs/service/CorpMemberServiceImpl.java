package com.itwillbs.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.component.FileComponent;
import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.domain.MemberVO;
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

}
