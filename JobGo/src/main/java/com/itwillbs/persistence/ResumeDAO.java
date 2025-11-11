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
    void insertResume(ResumeVO resume);
    ResumeVO getResume(int resumeId);
    List<ResumeVO> getResumeList(int memberId);
    void updateResume(ResumeVO resume);
    void deleteResume(int resumeId);

    // ===== [2] 학력사항 =====
    void insertEducation(ResumeEducationVO edu);
    List<ResumeEducationVO> getEducationList(int resumeId);
    void deleteEducationByResume(int resumeId);

    // ===== [3] 경력사항 =====
    void insertCareer(ResumeCareerVO career);
    List<ResumeCareerVO> getCareerList(int resumeId);
    void deleteCareerByResume(int resumeId);

    // ===== [4] 교육이력 =====
    void insertTraining(ResumeTrainingVO training);
    List<ResumeTrainingVO> getTrainingList(int resumeId);
    void deleteTrainingByResume(int resumeId);

    // ===== [5] 자격사항 =====
    void insertCertification(ResumeCertificationVO cert);
    List<ResumeCertificationVO> getCertificationList(int resumeId);
    void deleteCertificationByResume(int resumeId);

    // ===== [6] 자기소개서 =====
    void insertSelfIntro(ResumeSelfIntroVO intro);
    ResumeSelfIntroVO getSelfIntro(int resumeId);
    void deleteSelfIntro(int resumeId);
}
