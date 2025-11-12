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
    void insertResume(ResumeVO resume) throws Exception;
    ResumeVO getResume(int resumeId) throws Exception;
    List<ResumeVO> getResumeList(int memberId) throws Exception;
    void updateResume(ResumeVO resume) throws Exception;
    void updateResumeStatus(ResumeVO resume) throws Exception;
    void deleteResume(int resumeId) throws Exception;

    // 저장 메서드
    void insertResumeTemp(ResumeVO resume) throws Exception;    // 임시저장
    void insertResumeFinal(ResumeVO resume) throws Exception;   // 최종등록
    void updateResumeToFinal(int resumeId) throws Exception;    // 임시저장 → 최종등록 변경

    
    // ===== [2] 학력사항 =====
    void insertEducation(ResumeEducationVO edu) throws Exception;
    List<ResumeEducationVO> getEducationList(int resumeId) throws Exception;
    void deleteEducationByResume(int resumeId) throws Exception;

    // ===== [3] 경력사항 =====
    void insertCareer(ResumeCareerVO career) throws Exception;
    List<ResumeCareerVO> getCareerList(int resumeId) throws Exception;
    void deleteCareerByResume(int resumeId) throws Exception;

    // ===== [4] 교육이력 =====
    void insertTraining(ResumeTrainingVO training) throws Exception;
    List<ResumeTrainingVO> getTrainingList(int resumeId) throws Exception;
    void deleteTrainingByResume(int resumeId) throws Exception;

    // ===== [5] 자격사항 =====
    void insertCertification(ResumeCertificationVO cert) throws Exception;
    List<ResumeCertificationVO> getCertificationList(int resumeId) throws Exception;
    void deleteCertificationByResume(int resumeId) throws Exception;

    // ===== [6] 자기소개서 =====
    void insertSelfIntro(ResumeSelfIntroVO intro) throws Exception;
    ResumeSelfIntroVO getSelfIntro(int resumeId) throws Exception;
    void deleteSelfIntro(int resumeId) throws Exception;
}
