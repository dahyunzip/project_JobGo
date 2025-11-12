package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.*;

public interface ResumeService {
    void createResume(ResumeVO resume) throws Exception;
    ResumeVO getResume(int resumeId) throws Exception;
    List<ResumeVO> getResumeList(int memberId) throws Exception;
    void updateResume(ResumeVO resume) throws Exception;
    void deleteResume(int resumeId) throws Exception;
}
