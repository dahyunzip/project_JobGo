package com.itwillbs.domain;

import java.sql.Date;
import lombok.Data;

@Data
public class ResumeEducationVO {
    private int resumeId;       // 이력서 ID (FK)
    private int educationSeq;   // 학력 순번 (PK 일부)
    private Date fromDate;      // 시작일
    private Date toDate;        // 종료일
    private String schoolName;  // 학교명
    private String major;       // 전공
    private String isGraduated; // 졸업여부 (Y/N)
}