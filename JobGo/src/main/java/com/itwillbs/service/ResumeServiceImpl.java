package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.domain.ResumeCareerVO;
import com.itwillbs.domain.ResumeCertificationVO;
import com.itwillbs.domain.ResumeEducationVO;
import com.itwillbs.domain.ResumeSelfIntroVO;
import com.itwillbs.domain.ResumeTrainingVO;
import com.itwillbs.domain.ResumeVO;
import com.itwillbs.persistence.ResumeDAO;

@Service
public class ResumeServiceImpl implements ResumeService {

	@Inject
    private ResumeDAO resumeDAO;
	
	// ===== [이력서 작성 + 하위항목 등록 트랜잭션 처리] =====
    @Transactional
	@Override
	public void createResume(ResumeVO resume)  throws Exception{
    	// 1. 이력서 본문 등록
        resumeDAO.insertResume(resume);
        int resumeId = resume.getResumeId(); // auto_increment된 PK
        
        // 2. 학력사항 등록
        if (resume.getEducationList() != null) {
            for (ResumeEducationVO edu : resume.getEducationList()) {
                edu.setResumeId(resumeId);
                resumeDAO.insertEducation(edu);
            }
        }
        
        // 3. 경력사항 등록
        if (resume.getCareerList() != null) {
            for (ResumeCareerVO career : resume.getCareerList()) {
                career.setResumeId(resumeId);
                resumeDAO.insertCareer(career);
            }
        }
        
        // 4. 교육이력 등록
        if (resume.getTrainingList() != null) {
            for (ResumeTrainingVO tr : resume.getTrainingList()) {
                tr.setResumeId(resumeId);
                resumeDAO.insertTraining(tr);
            }
        }
        
        // 5. 자격사항 등록
        if (resume.getCertificationList() != null) {
            for (ResumeCertificationVO cert : resume.getCertificationList()) {
                cert.setResumeId(resumeId);
                resumeDAO.insertCertification(cert);
            }
        }
        
        // 6. 자기소개서 등록
        if (resume.getSelfIntro() != null) {
            ResumeSelfIntroVO intro = resume.getSelfIntro();
            intro.setResumeId(resumeId);
            resumeDAO.insertSelfIntro(intro);
        }

	}

	@Override
	public ResumeVO getResume(int resumeId)  throws Exception{
		ResumeVO resume = resumeDAO.getResume(resumeId);
		
		// 하위 항목 모두 조회해서 묶어주기
        resume.setEducationList(resumeDAO.getEducationList(resumeId));
        resume.setCareerList(resumeDAO.getCareerList(resumeId));
        resume.setTrainingList(resumeDAO.getTrainingList(resumeId));
        resume.setCertificationList(resumeDAO.getCertificationList(resumeId));
        resume.setSelfIntro(resumeDAO.getSelfIntro(resumeId));

        return resume;
	}

	@Override
	public List<ResumeVO> getResumeList(int memberId) throws Exception {
        return resumeDAO.getResumeList(memberId);
    }

	@Override
	@Transactional
	public void updateResume(ResumeVO resume) throws Exception{
		// 기본 정보 수정
		resumeDAO.updateResume(resume);

		// 하위 테이블 삭제 후 다시 삽입
		resumeDAO.deleteEducationByResume(resume.getResumeId());
		resumeDAO.deleteCareerByResume(resume.getResumeId());
		resumeDAO.deleteTrainingByResume(resume.getResumeId());
		resumeDAO.deleteCertificationByResume(resume.getResumeId());
		resumeDAO.deleteSelfIntro(resume.getResumeId());

		if (resume.getEducationList() != null) {
			for (var edu : resume.getEducationList()) {
				edu.setResumeId(resume.getResumeId());
				resumeDAO.insertEducation(edu);
			}
		}
		if (resume.getCareerList() != null) {
			for (var c : resume.getCareerList()) {
				c.setResumeId(resume.getResumeId());
				resumeDAO.insertCareer(c);
			}
		}
		if (resume.getTrainingList() != null) {
			for (var t : resume.getTrainingList()) {
				t.setResumeId(resume.getResumeId());
				resumeDAO.insertTraining(t);
			}
		}
		if (resume.getCertificationList() != null) {
			for (var cert : resume.getCertificationList()) {
				cert.setResumeId(resume.getResumeId());
				resumeDAO.insertCertification(cert);
			}
		}
		if (resume.getSelfIntro() != null) {
			resume.getSelfIntro().setResumeId(resume.getResumeId());
			resumeDAO.insertSelfIntro(resume.getSelfIntro());
		}
	}

	@Transactional
	@Override
    public void deleteResume(int resumeId) throws Exception{
        // 하위 데이터 먼저 정리
        resumeDAO.deleteEducationByResume(resumeId);
        resumeDAO.deleteCareerByResume(resumeId);
        resumeDAO.deleteTrainingByResume(resumeId);
        resumeDAO.deleteCertificationByResume(resumeId);
        resumeDAO.deleteSelfIntro(resumeId);

        // 부모 테이블 삭제
        resumeDAO.deleteResume(resumeId);
    }

}
