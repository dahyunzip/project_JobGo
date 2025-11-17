package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ResumeCareerVO;
import com.itwillbs.domain.ResumeCertificationVO;
import com.itwillbs.domain.ResumeEducationVO;
import com.itwillbs.domain.ResumeSelfIntroVO;
import com.itwillbs.domain.ResumeTrainingVO;
import com.itwillbs.domain.ResumeVO;

public interface ResumeDAO {
	// ===== [1] 이력서 =====
    public void insertResume(ResumeVO resume) throws Exception;
    public ResumeVO getResume(int resumeId) throws Exception;
    public ResumeVO getResumeWithMember(int resumeId) throws Exception;
    public List<ResumeVO> getResumeList(int memberId) throws Exception;
    public void updateResume(ResumeVO resume) throws Exception;
    public void updateResumeStatus(ResumeVO resume) throws Exception;
    public void deleteResume(int resumeId) throws Exception;

    // 회원이 작성한 이력서 수
    public int countResumeByMember(int memberId);
    
    // 저장 메서드
    public void insertResumeTemp(ResumeVO resume) throws Exception;    // 임시저장
    public void insertResumeFinal(ResumeVO resume) throws Exception;   // 최종등록
    public void updateResumeToFinal(int resumeId) throws Exception;    // 임시저장 → 최종등록 변경

    
    // ===== [2] 학력사항 =====
    public void insertEducation(ResumeEducationVO edu) throws Exception;
    public List<ResumeEducationVO> getEducationList(int resumeId) throws Exception;
    public void deleteEducationByResume(int resumeId) throws Exception;

    // ===== [3] 경력사항 =====
    public void insertCareer(ResumeCareerVO career) throws Exception;
    public List<ResumeCareerVO> getCareerList(int resumeId) throws Exception;
    public  void deleteCareerByResume(int resumeId) throws Exception;

    // ===== [4] 교육이력 =====
    public void insertTraining(ResumeTrainingVO training) throws Exception;
    public List<ResumeTrainingVO> getTrainingList(int resumeId) throws Exception;
    public void deleteTrainingByResume(int resumeId) throws Exception;

    // ===== [5] 자격사항 =====
    public void insertCertification(ResumeCertificationVO cert) throws Exception;
    public List<ResumeCertificationVO> getCertificationList(int resumeId) throws Exception;
    public void deleteCertificationByResume(int resumeId) throws Exception;

    // ===== [6] 자기소개서 =====
    public void insertSelfIntro(ResumeSelfIntroVO intro) throws Exception;
    public ResumeSelfIntroVO getSelfIntro(int resumeId) throws Exception;
    public void deleteSelfIntro(int resumeId) throws Exception;
}
