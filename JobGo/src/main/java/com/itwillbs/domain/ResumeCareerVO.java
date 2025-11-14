package com.itwillbs.domain;

import java.sql.Date;
import lombok.Data;

@Data
public class ResumeCareerVO {
    private int resumeId;         // 이력서 ID (FK)
    private int careerSeq;        // 경력 순번 (PK 일부)
    private Date fromDate;        // 시작일
    private Date toDate;          // 종료일
    private String companyName;   // 회사명
    private String responsibility;// 담당 업무
}
