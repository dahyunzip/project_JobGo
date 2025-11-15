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
	
	// ===== [1] 최종등록 (status='FINAL') =====
    @Transactional
    @Override
    public void createFinalResume(ResumeVO resume) throws Exception {
        // 1. 이력서 본문 등록 (status='FINAL')
        resumeDAO.insertResumeFinal(resume);
        int resumeId = resume.getResumeId();

        // 2. 하위 항목 등록
        insertSubTables(resume, resumeId);
    }

    // ===== [2] 임시저장 (status='TEMP') =====
    @Transactional
    @Override
    public void createTempResume(ResumeVO resume) throws Exception {
    	resume.setStatus("TEMP");
        // 1. 이력서 본문 등록 (status='TEMP')
        resumeDAO.insertResumeTemp(resume);
        // 2. 하위 항목 등록 (원하면 여기선 생략 가능)
        insertSubTables(resume, resume.getResumeId());
    }

    // ===== [3] 임시저장에서 최종등록으로 변경 =====
    @Override
    public void updateToFinal(int resumeId) throws Exception {
        resumeDAO.updateResumeToFinal(resumeId);
    }
    
    // ===== [4] 최종저장에서 임시저장으로 변경 =====
    @Override
    public void updateToTemp(ResumeVO resume) throws Exception {
        resume.setStatus("TEMP");
        resumeDAO.updateResumeStatus(resume);  // status만 TEMP로 변경
        resumeDAO.updateResume(resume);        // 제목 등 수정 반영

        // 하위 테이블 업데이트
        resumeDAO.deleteEducationByResume(resume.getResumeId());
        resumeDAO.deleteCareerByResume(resume.getResumeId());
        resumeDAO.deleteTrainingByResume(resume.getResumeId());
        resumeDAO.deleteCertificationByResume(resume.getResumeId());
        resumeDAO.deleteSelfIntro(resume.getResumeId());

        insertSubTables(resume, resume.getResumeId());
    }

    // ===== [공통: 하위항목 등록 메서드] =====
    private void insertSubTables(ResumeVO resume, int resumeId) throws Exception {
        if (resume.getEducationList() != null) {
        	int seq = 1;
        	for (ResumeEducationVO edu : resume.getEducationList()) {
                edu.setResumeId(resumeId);
                edu.setEducationSeq(seq++);
                resumeDAO.insertEducation(edu);
            }
        }
        if (resume.getCareerList() != null) {
        	int seq = 1;
        	for (ResumeCareerVO career : resume.getCareerList()) {
                career.setResumeId(resumeId);
                career.setCareerSeq(seq++);
                resumeDAO.insertCareer(career);
            }
        }
        if (resume.getTrainingList() != null) {
        	int seq = 1;
        	for (ResumeTrainingVO tr : resume.getTrainingList()) {
                tr.setResumeId(resumeId);
                tr.setTrainingSeq(seq++);
                resumeDAO.insertTraining(tr);
            }
        }
        if (resume.getCertificationList() != null) {
        	int seq = 1;
        	for (ResumeCertificationVO cert : resume.getCertificationList()) {
                cert.setResumeId(resumeId);
                cert.setCertSeq(seq++);
                resumeDAO.insertCertification(cert);
            }
        }
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
	public ResumeVO getResumeWithMember(int resumeId) throws Exception {
	    return resumeDAO.getResumeWithMember(resumeId);
	}
	
	@Override
    public ResumeVO getResumeWithMemberAndSubTables(int resume_id) throws Exception {
        ResumeVO resume = resumeDAO.getResumeWithMember(resume_id);
        if (resume == null) return null;

        // 하위 항목 채워넣기
        resume.setEducationList(resumeDAO.getEducationList(resume_id));
        resume.setCareerList(resumeDAO.getCareerList(resume_id));
        resume.setTrainingList(resumeDAO.getTrainingList(resume_id));
        resume.setCertificationList(resumeDAO.getCertificationList(resume_id));
        resume.setSelfIntro(resumeDAO.getSelfIntro(resume_id));

        return resume;
    }
	
	@Transactional
	@Override
	public void updateResumeTemp(ResumeVO resume) throws Exception {
		// 1. 기본 정보 수정 + status='TEMP'
	    resume.setStatus("TEMP");
	    resumeDAO.updateResumeStatus(resume);
	    
	    // 2. 기본 정보(제목 등) 업데이트
	    resumeDAO.updateResume(resume);
	    
	    // 3. 하위항목 재저장 (기존 delete + insert 구조 유지)
	    resumeDAO.deleteEducationByResume(resume.getResumeId());
	    resumeDAO.deleteCareerByResume(resume.getResumeId());
	    resumeDAO.deleteTrainingByResume(resume.getResumeId());
	    resumeDAO.deleteCertificationByResume(resume.getResumeId());
	    resumeDAO.deleteSelfIntro(resume.getResumeId());

	    insertSubTables(resume, resume.getResumeId());
		
	}
	
	@Transactional
	@Override
	public void updateResumeFinal(ResumeVO resume) throws Exception {
		// 기본 정보 수정 + status='TEMP'
	    resume.setStatus("FINAL");
	    resumeDAO.updateResume(resume);
	    
	    // 하위 테이블은 그대로 둬도 되지만,
	    // 기존 구조 유지 시 삭제 후 재삽입 처리
	    resumeDAO.deleteEducationByResume(resume.getResumeId());
	    resumeDAO.deleteCareerByResume(resume.getResumeId());
	    resumeDAO.deleteTrainingByResume(resume.getResumeId());
	    resumeDAO.deleteCertificationByResume(resume.getResumeId());
	    resumeDAO.deleteSelfIntro(resume.getResumeId());
	    
	    insertSubTables(resume, resume.getResumeId());
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
