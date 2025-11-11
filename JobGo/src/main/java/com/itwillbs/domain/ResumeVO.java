package com.itwillbs.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class ResumeVO {
	private int resumeId;          // 이력서 ID (PK)
    private int memberId;          // 회원 ID (FK: member.id)
    private String resumeTitle;    // 이력서 제목
    private Timestamp createdAt;   // 생성일시
    private Timestamp updatedAt;   // 수정일시

    // 하위 항목 포함 (조회 시 사용)
    private List<ResumeEducationVO> educationList;
    private List<ResumeCareerVO> careerList;
    private List<ResumeTrainingVO> trainingList;
    private List<ResumeCertificationVO> certificationList;
    private ResumeSelfIntroVO selfIntro;
}
