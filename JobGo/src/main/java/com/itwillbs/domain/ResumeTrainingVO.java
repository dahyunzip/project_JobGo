package com.itwillbs.domain;

import java.sql.Date;
import lombok.Data;

@Data
public class ResumeTrainingVO {
    private int resumeId;       // 이력서 ID (FK)
    private int trainingSeq;    // 교육 순번 (PK 일부)
    private Date fromDate;      // 시작일
    private Date toDate;        // 종료일
    private String institution; // 교육기관명
    private String content;     // 교육 내용
}
