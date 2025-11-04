package com.itwillbs.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.itwillbs.component.FileComponent;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{

    private final FileComponent fileComponent;
	
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Inject
	private MemberDAO mdao;

    MemberServiceImpl(FileComponent fileComponent) {
        this.fileComponent = fileComponent;
    }

	@Override
	public void registerMember(MemberVO vo) throws Exception {
		mdao.insertMember(vo);
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
		
		MemberVO resultVO = new MemberVO();
		resultVO.setOriginalFileName(originalFileName);
		resultVO.setStoredFileName(storedFileName);
		
		mdao.insertPhotoFiles(resultVO);
		
		mdao.updateMemberPhotoFiles(resultVO);
		
		logger.debug("uploadPhoto() 끝! ");
		
		return storedFileName;
	}

	
}
