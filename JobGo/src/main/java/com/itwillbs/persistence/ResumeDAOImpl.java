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
    private static final String NAMESPACE = "com.itwillbs.mapper.ResumeMapper.";

    // ===== [1] 이력서 =====
    @Override
    public void insertResume(ResumeVO resume) throws Exception {
        sqlSession.insert(NAMESPACE + "insertResume", resume);
    }

    @Override
    public ResumeVO getResume(int resumeId) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "selectResume", resumeId);
    }

    @Override
    public ResumeVO getResumeWithMember(int resumeId) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "selectResumeWithMember", resumeId);
    }
    
    @Override
    public List<ResumeVO> getResumeList(int memberId) throws Exception{
        return sqlSession.selectList(NAMESPACE + "selectResumeList", memberId);
    }
    
    @Override
    public int countResumeByMember(int memberId) {
        return sqlSession.selectOne(NAMESPACE + "countResumeByMember", memberId);
    }

    @Override
    public void updateResume(ResumeVO resume) throws Exception{
        sqlSession.update(NAMESPACE + "updateResume", resume);
    }
    
    @Override
    public void updateResumeStatus(ResumeVO resume) throws Exception {
        sqlSession.update(NAMESPACE + "updateResumeStatus", resume);
    }

    @Override
    public void deleteResume(int resumeId) throws Exception {
        sqlSession.delete(NAMESPACE + "deleteResume", resumeId);
    }

    
    // 저장메서드
    
    @Override
	public void insertResumeTemp(ResumeVO resume) throws Exception {
    	sqlSession.insert(NAMESPACE + "insertResumeTemp", resume);
		
	}

	@Override
	public void insertResumeFinal(ResumeVO resume) throws Exception {
		sqlSession.insert(NAMESPACE + "insertResumeFinal", resume);
		
	}

	@Override
	public void updateResumeToFinal(int resumeId) throws Exception {
		sqlSession.update(NAMESPACE + "updateResumeToFinal", resumeId);
		
	}

	// ===== [2] 학력사항 =====
    @Override
    public void insertEducation(ResumeEducationVO edu) throws Exception {
        sqlSession.insert(NAMESPACE + "insertEducation", edu);
    }

    @Override
    public List<ResumeEducationVO> getEducationList(int resumeId) throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectEducationList", resumeId);
    }

    @Override
    public void deleteEducationByResume(int resumeId) throws Exception {
        sqlSession.delete(NAMESPACE + "deleteEducationByResume", resumeId);
    }

    // ===== [3] 경력사항 =====
    
    @Override
    public void insertCareer(ResumeCareerVO career) throws Exception {
        sqlSession.insert(NAMESPACE + "insertCareer", career);
    }

    @Override
    public List<ResumeCareerVO> getCareerList(int resumeId) throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectCareerList", resumeId);
    }

    @Override
    public void deleteCareerByResume(int resumeId) throws Exception {
        sqlSession.delete(NAMESPACE + "deleteCareerByResume", resumeId);
    }

    // ===== [4] 교육이력 =====
    
    @Override
    public void insertTraining(ResumeTrainingVO training) throws Exception {
        sqlSession.insert(NAMESPACE + "insertTraining", training);
    }

    @Override
    public List<ResumeTrainingVO> getTrainingList(int resumeId) throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectTrainingList", resumeId);
    }

    @Override
    public void deleteTrainingByResume(int resumeId) throws Exception {
        sqlSession.delete(NAMESPACE + "deleteTrainingByResume", resumeId);
    }
    
    // ===== [5] 자격사항 =====

	@Override
    public void insertCertification(ResumeCertificationVO cert) throws Exception {
        sqlSession.insert(NAMESPACE + "insertCertification", cert);
    }

    @Override
    public List<ResumeCertificationVO> getCertificationList(int resumeId) throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectCertificationList", resumeId);
    }

    @Override
    public void deleteCertificationByResume(int resumeId) throws Exception {
        sqlSession.delete(NAMESPACE + "deleteCertificationByResume", resumeId);
    }

    // ===== [6] 자기소개서 =====
    
    @Override
    public void insertSelfIntro(ResumeSelfIntroVO intro) throws Exception {
        sqlSession.insert(NAMESPACE + "insertSelfIntro", intro);
    }

    @Override
    public ResumeSelfIntroVO getSelfIntro(int resumeId) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "selectSelfIntro", resumeId);
    }

    @Override
    public void deleteSelfIntro(int resumeId) throws Exception {
        sqlSession.delete(NAMESPACE + "deleteSelfIntro", resumeId);
    }

}
