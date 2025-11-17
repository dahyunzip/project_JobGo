package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.*;

public interface ResumeService {
    public void createTempResume(ResumeVO resume) throws Exception;  // 임시저장
    public void createFinalResume(ResumeVO resume) throws Exception; // 최초 등록
    public void updateToFinal(int resumeId) throws Exception;         // 임시 -> 최종
    public void updateToTemp(ResumeVO resume) throws Exception;		  // 최종 -> 임시
    public ResumeVO getResume(int resumeId) throws Exception;
    public ResumeVO getResumeWithMember(int resumeId) throws Exception;
    public ResumeVO getResumeWithMemberAndSubTables(int resume_id) throws Exception;
    public List<ResumeVO> getResumeList(int memberId) throws Exception;
    public void updateResumeTemp(ResumeVO resume) throws Exception;
    public void updateResumeFinal(ResumeVO resume) throws Exception;
    public void deleteResume(int resumeId) throws Exception;
    public int getResumeCount(int memberId);
}
