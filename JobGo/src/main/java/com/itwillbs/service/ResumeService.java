package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.*;

public interface ResumeService {
    void createResume(ResumeVO resume);
    ResumeVO getResume(int resumeId);
    List<ResumeVO> getResumeList(int memberId);
    void updateResume(ResumeVO resume);
    void deleteResume(int resumeId);
}
