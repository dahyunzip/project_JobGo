package com.itwillbs.domain;

import java.sql.Date;
import lombok.Data;

@Data
public class ResumeCertificationVO {
    private int resumeId;              // 이력서 ID (FK)
    private int certSeq;               // 자격 순번 (PK 일부)
    private Date acquiredDate;         // 취득일자
    private String certificationName;  // 자격명
}
