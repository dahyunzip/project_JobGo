package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ResumeCareerVO;
import com.itwillbs.domain.ResumeCertificationVO;
import com.itwillbs.domain.ResumeEducationVO;
import com.itwillbs.domain.ResumeSelfIntroVO;
import com.itwillbs.domain.ResumeTrainingVO;
import com.itwillbs.domain.ResumeVO;

@Repository
public class ResumeDAOImpl implements ResumeDAO {
	
	@Inject
    private SqlSession sqlSession;
    private static final String namespace = "com.itwillbs.mapper.ResumeMapper.";

    // ===== [1] 이력서 =====
    @Override
    public void insertResume(ResumeVO resume) {
        sqlSession.insert(namespace + "insertResume", resume);
    }

    @Override
    public ResumeVO getResume(int resumeId) {
        return sqlSession.selectOne(namespace + "selectResume", resumeId);
    }

    @Override
    public List<ResumeVO> getResumeList(int memberId) {
        return sqlSession.selectList(namespace + "selectResumeList", memberId);
    }

    @Override
    public void updateResume(ResumeVO resume) {
        sqlSession.update(namespace + "updateResume", resume);
    }

    @Override
    public void deleteResume(int resumeId) {
        sqlSession.delete(namespace + "deleteResume", resumeId);
    }

    // ===== [2] 학력사항 =====
    @Override
    public void insertEducation(ResumeEducationVO edu) {
        sqlSession.insert(namespace + "insertEducation", edu);
    }

    @Override
    public List<ResumeEducationVO> getEducationList(int resumeId) {
        return sqlSession.selectList(namespace + "selectEducationList", resumeId);
    }

    @Override
    public void deleteEducationByResume(int resumeId) {
        sqlSession.delete(namespace + "deleteEducationByResume", resumeId);
    }

    // ===== [3] 경력사항 =====
    
    @Override
    public void insertCareer(ResumeCareerVO career) {
        sqlSession.insert(namespace + "insertCareer", career);
    }

    @Override
    public List<ResumeCareerVO> getCareerList(int resumeId) {
        return sqlSession.selectList(namespace + "selectCareerList", resumeId);
    }

    @Override
    public void deleteCareerByResume(int resumeId) {
        sqlSession.delete(namespace + "deleteCareerByResume", resumeId);
    }

    // ===== [4] 교육이력 =====
    
    @Override
    public void insertTraining(ResumeTrainingVO training) {
        sqlSession.insert(namespace + "insertTraining", training);
    }

    @Override
    public List<ResumeTrainingVO> getTrainingList(int resumeId) {
        return sqlSession.selectList(namespace + "selectTrainingList", resumeId);
    }

    @Override
    public void deleteTrainingByResume(int resumeId) {
        sqlSession.delete(namespace + "deleteTrainingByResume", resumeId);
    }
    
    // ===== [5] 자격사항 =====

	@Override
    public void insertCertification(ResumeCertificationVO cert) {
        sqlSession.insert(namespace + "insertCertification", cert);
    }

    @Override
    public List<ResumeCertificationVO> getCertificationList(int resumeId) {
        return sqlSession.selectList(namespace + "selectCertificationList", resumeId);
    }

    @Override
    public void deleteCertificationByResume(int resumeId) {
        sqlSession.delete(namespace + "deleteCertificationByResume", resumeId);
    }

    // ===== [6] 자기소개서 =====
    
    @Override
    public void insertSelfIntro(ResumeSelfIntroVO intro) {
        sqlSession.insert(namespace + "insertSelfIntro", intro);
    }

    @Override
    public ResumeSelfIntroVO getSelfIntro(int resumeId) {
        return sqlSession.selectOne(namespace + "selectSelfIntro", resumeId);
    }

    @Override
    public void deleteSelfIntro(int resumeId) {
        sqlSession.delete(namespace + "deleteSelfIntro", resumeId);
    }

}
